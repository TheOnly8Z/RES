SWEP.Tools.PDA = {}

SWEP.Tools.PDA.PrintName = "PDA"
SWEP.Tools.PDA.FullName = "PDA"
SWEP.Tools.PDA.SortOrder = 5
SWEP.Tools.PDA.Icon = nil --Material("entities/weapon_stunstick.png")
SWEP.Tools.PDA.Description = [[A device for construction planning.

LMB: Open build menu
RMB: Haul buildings]]

SWEP.Tools.PDA.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.Tools.PDA.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.Tools.PDA.HoldType = "slam"

SWEP.Tools.PDA.DeployAnim = ACT_VM_DRAW
SWEP.Tools.PDA.DeployGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM

SWEP.Tools.PDA.PrimaryAttack = function(self)
end

SWEP.Tools.PDA.SecondaryAttack = function(self)
end

SWEP.Tools.PDA.Think = function(self)
end