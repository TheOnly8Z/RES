SWEP.Tools.Crowbar = {}

SWEP.Tools.Crowbar.PrintName = "Crowbar"
SWEP.Tools.Crowbar.SortOrder = 1
SWEP.Tools.Crowbar.Icon = Material("entities/weapon_crowbar.png")
SWEP.Tools.Crowbar.Description = [[Common tool used to break things apart.

LMB: Salvage props
RMB: Dismantle machines]]

SWEP.Tools.Crowbar.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.Tools.Crowbar.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.Tools.Crowbar.HoldType = "slam"

SWEP.Tools.Crowbar.DeployAnim = ACT_VM_DRAW
SWEP.Tools.Crowbar.DeployGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM

SWEP.Tools.Crowbar.Deploy = function(self)
    return true
end

SWEP.Tools.Crowbar.PrimaryAttack = function(self)
    local owner = self:GetOwner()
    local tr = util.TraceHull({
        start = owner:GetShootPos(),
        endpos = owner:GetShootPos() + owner:GetAimVector() * 72,
        filter = {self, owner},
        mask = MASK_SHOT_HULL,
        mins = Vector(-8, -8, -8),
        maxs = Vector(8, 8, 8),
    })
    local ent = tr.Entity
    if IsValid(ent) and ent:RES_CanSalvage() then

        ent:SetNWFloat("RES.Salvage", ent:GetNWFloat("RES.Salvage", 0) + ent:RES_GetSalvageStrength())
        self:SetWeaponAnim(ACT_VM_HITCENTER)
        self:SetNextPrimaryFire(CurTime() + 0.5)
        owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)


        print(ent:GetNWFloat("RES.Salvage", 0))
        if ent:GetNWFloat("RES.Salvage", 0) >= 1 then
            ent:RES_Salvage()
        end
    end
end

SWEP.Tools.Crowbar.SecondaryAttack = function(self)

end

SWEP.Tools.Crowbar.Think = function(self)

end