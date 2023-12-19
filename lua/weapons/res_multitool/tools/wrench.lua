SWEP.Tools.Wrench = {}

SWEP.Tools.Wrench.PrintName = "Wrench"
SWEP.Tools.Wrench.SortOrder = 3
SWEP.Tools.Wrench.Icon = nil --Material("entities/weapon_stunstick.png")
SWEP.Tools.Wrench.Description = [[Engineering tool for making and maintaining machines.

LMB: Build/repair machines]]

SWEP.Tools.Wrench.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.Tools.Wrench.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.Tools.Wrench.HoldType = "slam"

SWEP.Tools.Wrench.DeployAnim = ACT_VM_DRAW
SWEP.Tools.Wrench.DeployGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM

SWEP.Tools.Wrench.PrimaryAttack = function(self)
    local owner = self:GetOwner()
    local tr = owner:GetEyeTrace()

    local ent = tr.Entity
    if IsValid(ent) and ent.RESBuildable and ent:CanConstruct() and tr.HitPos:DistToSqr(owner:EyePos()) <= 72 * 72 then
        ent:Construct(10)
        self:SetWeaponAnim(ACT_VM_HITCENTER)
        self:SetNextPrimaryFire(CurTime() + 1)
        owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)
    end
end

SWEP.Tools.Wrench.SecondaryAttack = function(self)
end

SWEP.Tools.Wrench.Think = function(self)
end