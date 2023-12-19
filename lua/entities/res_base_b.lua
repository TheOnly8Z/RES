AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = nil

ENT.PrintName = "RES Buildable"
ENT.Spawnable = false

ENT.RenderGroup = RENDERGROUP_BOTH

ENT.RESBuildable = true

----------------------------- Fields
ENT.BuildableType = nil -- for showing in menu
ENT.BuildableSubType = nil
ENT.BaseModel = "models/hunter/blocks/cube05x05x05.mdl"
ENT.BaseHealth = 100
ENT.BaseMaterial = nil -- RES.BuildableMaterial, not the engine material
ENT.Mass = nil

ENT.HasBlueprint = true

ENT.ResourceCost = nil -- used for building and salvaging

ENT.WorkCost = 1

ENT.PropertyBlacklist = {
    ["bodygroups"] = true,
    ["skin"] = true,
    ["drive"] = true,
    ["bone_manipulate"] = true,
}

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "IsBlueprint")
    self:NetworkVar("Int", 0, "WorkProgress")
end

function ENT:CanConstruct(ply, ent)
    return self:GetIsBlueprint()
end

function ENT:GetBuildableMaterial()
    return RES.BuildableMaterial[self.BaseMaterial or ""]
end

if SERVER then
    function ENT:Initialize()
        self:SetModel(self.BaseModel)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        if self.HasBlueprint then
            self:SetIsBlueprint(true)
            self:SetRenderMode(RENDERMODE_TRANSALPHA)
            self:SetColor(Color(120, 150, 255, 200))
            self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)

            self:SetMaxHealth(100)
            self:SetHealth(self:GetMaxHealth())
        else
            self:SetIsBlueprint(false)
            self:SetRenderMode(RENDERMODE_NORMAL)
            self:SetColor(Color(255, 255, 255, 255))
            self:SetCollisionGroup(COLLISION_GROUP_NONE)

            self:SetMaxHealth(self.BaseHealth)
            self:SetHealth(self:GetMaxHealth())
        end

        local phys = self:GetPhysicsObject()
        if not IsValid(phys) then self:Remove() return end
        if self.Mass then
            phys:SetMass(self.Mass)
        end
        phys:EnableMotion(false)
    end

    function ENT:DeployBlueprint()
        if not self:GetIsBlueprint() then return end
        self:SetIsBlueprint(false)
        self:SetColor(Color(255, 255, 255, 255))
        self:SetCollisionGroup(COLLISION_GROUP_NONE)
        self:SetRenderMode(RENDERMODE_NORMAL)

        self:SetMaxHealth(self.BaseHealth)
        self:SetHealth(self:GetMaxHealth())

        local phys = self:GetPhysicsObject()
        if not IsValid(phys) then self:Remove() return end
        phys:Wake()
        phys:EnableMotion(false)
    end

    function ENT:Construct(amt)
        if not self:GetIsBlueprint() then return end
        self:SetWorkProgress(self:GetWorkProgress() + (amt or 1))

        if self:GetWorkProgress() >= self.WorkCost then
            self:DeployBlueprint()
        end
    end

    function ENT:Destroy(dmginfo)
        self:Remove()
    end

    function ENT:OnTakeDamage(dmginfo)
        local dmgtype = dmginfo:GetDamageType()
        local info = self:GetBuildableMaterial()

        -- Never take damage from these types
        if bit.band(RES.BuildableImmuneDamageTypes, dmgtype) > 0 then
            return 0
        end

        -- low damage LVS bullets
        if dmgtype == DMG_AIRBOAT and dmginfo:GetDamage() < 100 then
            dmginfo:SetDamageType(DMG_BULLET)
        end

        -- hack against tacrp thermite
        if IsValid(dmginfo:GetInflictor()) and dmginfo:GetInflictor():GetClass() == "tacrp_fire_cloud" and dmgtype == DMG_DIRECT then
            dmginfo:SetDamageType(DMG_SLOWBURN)
        end

        if not self:GetIsBlueprint() and istable(info.Multipliers) then
            for k, v in pairs(info.Multipliers) do
                if dmginfo:IsDamageType(k) then
                    dmginfo:ScaleDamage(v)
                    if dmginfo:GetDamage() == 0 then return 0 end
                end
            end
        end

        local health = self:Health()
        self:SetHealth(health - dmginfo:GetDamage())
        self.LastHit = CurTime()

        if self:Health() <= 0 then
            self:Destroy(dmginfo)
        end

        local attacker = dmginfo:GetAttacker()
        if attacker.LVS or attacker:IsVehicle() then
            attacker = attacker:GetDriver()
        end
        if attacker:IsPlayer() then
            net.Start("res_entdamage")
                net.WriteEntity(self)
                net.WriteFloat(health)
            net.Send(attacker)
        end

        return dmginfo:GetDamage()
    end
end

function ENT:CanProperty(ply, prop)
    if self.PropertyBlacklist[prop] then return false end
    return true
end

hook.Add("PhysgunPickup", "res_buildables", function(ply, ent)
    if ent.RESBuildable then return false end
end)