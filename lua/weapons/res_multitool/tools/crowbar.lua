SWEP.Tools.Crowbar = {}

SWEP.Tools.Crowbar.PrintName = "Crowbar"
SWEP.Tools.Crowbar.SortOrder = 1
SWEP.Tools.Crowbar.Icon = nil --Material("entities/weapon_crowbar.png")
SWEP.Tools.Crowbar.Description = [[Iconic tool for breaking things apart.

LMB: Salvage props]]

SWEP.Tools.Crowbar.ViewModel = "models/weapons/c_crowbar.mdl"
SWEP.Tools.Crowbar.WorldModel = "models/weapons/w_crowbar.mdl"
SWEP.Tools.Crowbar.HoldType = "slam"

SWEP.Tools.Crowbar.DeployAnim = ACT_VM_DRAW
SWEP.Tools.Crowbar.DeployGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM

SWEP.Tools.Crowbar.Highlight = function(self, ent)
    if IsValid(ent) and ent:RES_CanSalvage() then
        local info = ent:RES_GetSalvageInfo()
        if not info then return end -- pending or not valid
        local lines = {}
        for k, v in pairs(info[2]) do
            table.insert(lines, RES.Resource[k].Name .. ": " .. v)
        end

        local prog = ent:GetNWFloat("RES.Salvage", 0)

        return {
            Glow = true,
            Hint = prog > 0 and (math.floor(prog * 100) .. "%") or "Salvagable",
            Progress = prog > 0 and prog or nil,
            Lines = #lines > 0 and lines or nil,
        }
    end
end

SWEP.Tools.Crowbar.PrimaryAttack = function(self)
    local owner = self:GetOwner()
    local tr = owner:GetEyeTrace()

    -- local tr = util.TraceHull({
    --     start = owner:GetShootPos(),
    --     endpos = owner:GetShootPos() + owner:GetAimVector() * 128,
    --     filter = {self, owner},
    --     mask = MASK_SOLID,
    --     mins = Vector(-8, -8, -8),
    --     maxs = Vector(8, 8, 8),
    -- })
    local ent = tr.Entity
    if IsValid(ent) and tr.HitPos:DistToSqr(owner:EyePos()) <= 128 * 128 and ent:RES_CanSalvage() then
        local info = ent:RES_GetSalvageInfo()
        if not info then return end
        ent:SetNWFloat("RES.Salvage", ent:GetNWFloat("RES.Salvage", 0) + 1 / info[1])
        self:SetWeaponAnim(ACT_VM_HITCENTER)
        self:SetNextPrimaryFire(CurTime() + 0.5)
        owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)

        if ent:GetNWFloat("RES.Salvage", 0) >= 1 then
            ent:RES_Salvage(tr.HitPos)
        else
            ent:GetPhysicsObject():ApplyForceCenter(tr.Normal * 2000 + VectorRand() * 1000)
        end
    end
end

SWEP.Tools.Crowbar.SecondaryAttack = function(self)
end

SWEP.Tools.Crowbar.Think = function(self)
end