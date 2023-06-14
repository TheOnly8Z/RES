AddCSLuaFile()

DEFINE_BASECLASS(SWEP.Base)

SWEP.PrintName = "Resource Multitool"
SWEP.Spawnable = true

SWEP.Purpose = "Salvage and construct."
SWEP.Instructions = "Left click on a prop to salvage."

SWEP.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

SWEP.UseHands = true

SWEP.Primary.Automatic = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.Ammo = ""
SWEP.Primary.DefaultClip = 1

SWEP.Secondary.Automatic = true
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Ammo = ""

SWEP.HoldType = "slam"

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "WeaponIdleTime")
end

function SWEP:Initialize()
    -- engine deploy blocks weapon from thinking and doing most stuff
    self.m_WeaponDeploySpeed = 255
    self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
    local owner = self:GetOwner()
    if not owner or not owner:IsPlayer() then return end

    self:SetHoldType(self.HoldType)
    self:SetWeaponAnim(ACT_VM_DEPLOY)

    local vm = owner:GetViewModel(self:ViewModelIndex())
    local rate = 1
    if vm:IsValid() then
        vm:SetPlaybackRate(rate)
        self:SetWeaponIdleTime(CurTime() + (self:SequenceDuration() * (1 / rate)))
    end
    self:SetNextPrimaryFire(CurTime() + self:SequenceDuration() * (1 / rate) * 0.9)

    return true
end

function SWEP:SetWeaponAnim(idealAct, flPlaybackRate)
    local idealSequence = self:SelectWeightedSequence(idealAct)
    if idealSequence == -1 then return false end
    flPlaybackRate = isnumber(flPlaybackRate) and flPlaybackRate or 1

    self:SendWeaponAnim(idealAct)
    self:SendViewModelMatchingSequence(idealSequence)

    local owner = self:GetOwner()
    if owner:IsValid() then
        local vm = owner:GetViewModel()
        if vm:IsValid() and idealSequence then
            vm:SendViewModelMatchingSequence(idealSequence)
            vm:SetPlaybackRate(flPlaybackRate)
        end
    end

    -- Set the next time the weapon will idle
    self:SetWeaponIdleTime(CurTime() + (self:SequenceDuration() * flPlaybackRate))
    return true
end

function SWEP:Think()
    self:WeaponIdle()
end

function SWEP:WeaponIdle()
    if self:GetWeaponIdleTime() > CurTime() then return end

    self:SetWeaponIdleTime(math.huge) -- it's looping anyways
    self:SetWeaponAnim(ACT_VM_IDLE)
end

function SWEP:PrimaryAttack()
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 72,
        filter = {self, self:GetOwner()},
        mask = MASK_SHOT_HULL,
        mins = Vector(-8, -8, -8),
        maxs = Vector(8, 8, 8),
    })
    local ent = tr.Entity
    if IsValid(ent) and ent:RES_CanSalvage() then

        ent:SetNWFloat("RES.Salvage", ent:GetNWFloat("RES.Salvage", 0) + ent:RES_GetSalvageStrength())
        self:SetWeaponAnim(ACT_VM_HITCENTER)
        self:SetNextPrimaryFire(CurTime() + 0.5)

        print(ent:GetNWFloat("RES.Salvage", 0))
        if ent:GetNWFloat("RES.Salvage", 0) >= 1 then
            ent:RES_Salvage()
        end
    end
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end