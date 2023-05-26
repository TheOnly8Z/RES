AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = nil

ENT.PrintName = "RES Resource"
ENT.Spawnable = false

ENT.Resource = ""

ENT.PropertyBlacklist = {
    ["bodygroups"] = true,
    ["skin"] = true,
    ["drive"] = true,
    ["bone_manipulate"] = true,
}

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Amount")
end

if SERVER then

    ENT.Dying = false

    function ENT:Initialize()

        local resTbl = RES.Resource[self.Resource]
        if not resTbl then self:Remove() return end

        self:SetModel(resTbl.Model or "models/hunter/blocks/cube05x05x05.mdl")

        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self:SetCollisionGroup(COLLISION_GROUP_NONE)

        if resTbl.Material then
            self:SetMaterial(resTbl.Material)
        end
        if resTbl.Bodygroups then
            self:SetBodyGroups(resTbl.Bodygroups)
        end

        local phys = self:GetPhysicsObject()
        if not phys then self:Remove() return end

        phys:SetMass(25)
        phys:Wake()
    end

    function ENT:PhysicsCollide(colData, collider)
        -- https://github.com/ValveSoftware/source-sdk-2013/blob/master/sp/src/game/server/physics.cpp
        if colData.DeltaTime >= 0.05 and colData.Speed >= 70 then
            -- can't use EmitSound since volume is not controllable with soundscripts
            local surfdata = util.GetSurfaceData(colData.OurSurfaceProps)
            if self.ImpactSound then self.ImpactSound:Stop() end
            self.ImpactSound = CreateSound(self, colData.Speed > 200 and surfdata.impactHardSound or surfdata.impactSoftSound)
            self.ImpactSound:PlayEx(math.Clamp(colData.Speed / 320, 0, 1), 100)
        end
    end

    function ENT:OnRemove()
        if self.ImpactSound then
            self.ImpactSound:Stop()
            self.ImpactSound = nil
        end
    end

    function ENT:FadeAndRemove()
        if self.Dying then return end
        self.Dying = true
        self:SetRenderMode(RENDERMODE_TRANSADD)
        self:SetRenderFX(kRenderFxFadeFast)
        self:DrawShadow(false)
        SafeRemoveEntityDelayed(self, 2)
    end

    function ENT:Use(ply)
        ply:PickupObject(self)
    end
end

function ENT:CanProperty(ply, prop)
    if self.PropertyBlacklist[prop] then return false end
    return true
end