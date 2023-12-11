SWEP.Tools.RBag = {}

SWEP.Tools.RBag.PrintName = "R-Bag"
SWEP.Tools.RBag.FullName = "Resource Bag"
SWEP.Tools.RBag.SortOrder = 4
SWEP.Tools.RBag.Icon = Material("entities/weapon_stunstick.png")
SWEP.Tools.RBag.Description = [[A small bag to carry some resources with you.

LMB: Collect resource
RMB: Open bag menu]]

SWEP.Tools.RBag.ViewModel = "models/weapons/c_grenade.mdl"
SWEP.Tools.RBag.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.Tools.RBag.HoldType = "slam"

SWEP.Tools.RBag.DeployAnim = ACT_VM_DRAW
SWEP.Tools.RBag.DeployGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM

SWEP.Tools.RBag.PrimaryAttack = function(self)
end

SWEP.Tools.RBag.SecondaryAttack = function(self)
end

SWEP.Tools.RBag.Think = function(self)
end