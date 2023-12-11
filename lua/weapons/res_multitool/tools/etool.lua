SWEP.Tools.ETool = {}

SWEP.Tools.ETool.PrintName = "E-Tool"
SWEP.Tools.ETool.FullName = "Entrenching Tool"

SWEP.Tools.ETool.SortOrder = 2
SWEP.Tools.ETool.Icon = Material("entities/weapon_stunstick.png")
SWEP.Tools.ETool.Description = [[Multirole military tool that can be used as a hammer, shovel and pickaxe.

LMB: Harvest resources from the world
RMB: Build defenses]]

SWEP.Tools.ETool.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.Tools.ETool.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.Tools.ETool.HoldType = "slam"

SWEP.Tools.ETool.DeployAnim = ACT_VM_DRAW
SWEP.Tools.ETool.DeployGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM

SWEP.Tools.ETool.PrimaryAttack = function(self)
end

SWEP.Tools.ETool.SecondaryAttack = function(self)
end

SWEP.Tools.ETool.Think = function(self)
end