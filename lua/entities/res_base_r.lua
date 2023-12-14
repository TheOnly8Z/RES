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

function ENT:GetMaxAmount()
    return RES.Resource[self.Resource].Maximum or RES.ResourceBoxMaximum
end

if SERVER then

    ENT.Dying = false

    function ENT:AddAmount(add)
        add = math.min(add, self:GetMaxAmount() - self:GetAmount())
        if add > 0 then
            self:SetAmount(self:GetAmount() + add)
            self:SizeToAmount()
        end
        return add
    end

    function ENT:SizeToAmount()
        if RES.Resource[self.Resource].ScaleModel then
            self:SetModelScale(Lerp(math.Clamp(self:GetAmount() / self:GetMaxAmount(), 0, 1), 0.25, 1), 0)
            self:Activate()
        end
    end

    function ENT:SpawnFunction(ply, tr, class)
        if not tr.Hit then return end
        local pos = tr.HitPos + tr.HitNormal * 16
        local ang = Angle(0, ply:EyeAngles().y, 0)
        local ent = ents.Create(class)
        ent:SetPos(pos)
        ent:SetAngles(ang)
        ent:SetAmount(RES.ResourceBoxSpawnAmount)
        ent:Spawn()
    end

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

        phys:SetMaterial("gmod_silent")
        phys:SetMass(25)
        phys:Wake()

        self:SizeToAmount()

        self.CacheIndex = table.insert(RES.ResourceEntityCache, self)
    end

    function ENT:PhysicsCollide(colData, collider)

        local ent = colData.HitEntity
        if ent:GetClass() == self:GetClass() and not ent.Dying and self:GetAmount() >= ent:GetAmount()
                and self:GetAmount() < self:GetMaxAmount() then

            local take = self:AddAmount(ent:GetAmount())
            ent:SetAmount(ent:GetAmount() - take)
            if ent:GetAmount() <= 0 then
                ent.Dying = true
                SafeRemoveEntity(ent)
            else
                ent:SizeToAmount()
            end

            self:SizeToAmount()
        end

        -- https://github.com/ValveSoftware/source-sdk-2013/blob/master/sp/src/game/server/physics.cpp
        if colData.DeltaTime >= 0.05 and colData.Speed >= 70 then
            local resTbl = RES.Resource[self.Resource]

            -- can't use EmitSound since volume is not controllable with soundscripts
            local surfdata = resTbl.SurfaceData or util.GetSurfaceData(util.GetSurfaceIndex(resTbl.SurfaceProp or "plastic"))
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
        if self.CacheIndex and RES.ResourceEntityCache[self.CacheIndex] == self then
            table.remove(RES.ResourceEntityCache, self.CacheIndex)
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

else
    -- This may be called on a full update. Does this check work?
    function ENT:Initialize()
        if not self.CacheIndex then
            self.CacheIndex = table.insert(RES.ResourceEntityCache, self)
        end
    end

    function ENT:OnRemove(fullUpdate)
        if not fullUpdate and self.CacheIndex and RES.ResourceEntityCache[self.CacheIndex] == self then
            table.remove(RES.ResourceEntityCache, self.CacheIndex)
        end
    end
end

function ENT:CanProperty(ply, prop)
    if self.PropertyBlacklist[prop] then return false end
    return true
end