AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = nil

ENT.PrintName = "RES Building"
ENT.Spawnable = false

----------------------------- Fields
ENT.StartHealth = 100

function ENT:SetupDataTables()
end

function ENT:CanProperty(ply, prop)
    if self.PropertyBlacklist[prop] then return false end
    return true
end

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/hunter/blocks/cube05x05x05.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self:SetCollisionGroup(COLLISION_GROUP_NONE)

        self:SetMaxHealth(self.StartHealth)
        self:SetHealth(self:GetMaxHealth())

        local phys = self:GetPhysicsObject()
        if not phys then self:Remove() return end
        phys:Wake()
    end
end
