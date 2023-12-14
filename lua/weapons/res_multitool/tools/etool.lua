SWEP.Tools.ETool = {}

SWEP.Tools.ETool.PrintName = "E-Tool"
SWEP.Tools.ETool.FullName = "Entrenching Tool"

SWEP.Tools.ETool.SortOrder = 2
SWEP.Tools.ETool.Icon = nil --Material("entities/weapon_stunstick.png")
SWEP.Tools.ETool.Description = [[Adjustable tool for digging and mining.

LMB: Harvest resources from the world]]

SWEP.Tools.ETool.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.Tools.ETool.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.Tools.ETool.HoldType = "slam"

SWEP.Tools.ETool.DeployAnim = ACT_VM_DRAW
SWEP.Tools.ETool.DeployGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM

SWEP.Tools.ETool.Highlight = function(self, ent)
    local owner = self:GetOwner()
    local tr = owner:GetEyeTrace()
    local surfaceprop = util.GetSurfacePropName(tr.SurfaceProps)
    if tr.HitWorld and tr.HitPos:DistToSqr(owner:EyePos()) <= 96 * 96 and RES.SurfaceHarvest[surfaceprop] then
        local info = RES.SurfaceHarvest[surfaceprop]
        if not info then return end -- pending or not valid
        local lines = {}
        for k, v in pairs(info[2]) do
            table.insert(lines, RES.Resource[k].Name .. ": " .. math.Round(v * 100) .. "%")
        end

        local prog = 0
        local last_pos = self:GetNWVector("RES_LastDigPos")
        local last_surf = self:GetNWString("RES_LastDigSurface")
        if last_pos and last_pos:DistToSqr(tr.HitPos) <= 96 * 96 and last_surf == surfaceprop then
            prog = self:GetNWFloat("RES_DigAmount", 0)
        end

        return {
            Glow = true,
            Hint = prog > 0 and (math.floor(prog * 100) .. "%") or "Harvestable",
            Progress = prog > 0 and prog or nil,
            Lines = #lines > 0 and lines or nil,
        }
    end
end

SWEP.Tools.ETool.PrimaryAttack = function(self)
    local owner = self:GetOwner()
    local tr = owner:GetEyeTrace()
    local surfaceprop = util.GetSurfacePropName(tr.SurfaceProps)

    if tr.HitWorld and tr.HitPos:DistToSqr(owner:EyePos()) <= 96 * 96 and RES.SurfaceHarvest[surfaceprop] then
        self:SetWeaponAnim(ACT_VM_HITCENTER)
        self:SetNextPrimaryFire(CurTime() + 0.5)
        owner:DoAnimationEvent(ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE)

        local last_pos = self:GetNWVector("RES_LastDigPos")
        local last_surf = self:GetNWString("RES_LastDigSurface")
        if not last_pos or last_pos:DistToSqr(tr.HitPos) >= 96 * 96 or last_surf ~= surfaceprop then
            self:SetNWVector("RES_LastDigPos", tr.HitPos)
            self:SetNWFloat("RES_DigAmount", 0)
            self:SetNWString("RES_LastDigSurface", surfaceprop)
        end

        self:SetNWFloat("RES_DigAmount", self:GetNWFloat("RES_DigAmount", 0) + 1 / RES.SurfaceHarvest[surfaceprop][1])

        if self:GetNWFloat("RES_DigAmount", 0) >= 1 then
            self:SetNWVector("RES_LastDigPos", nil)
            self:SetNWFloat("RES_DigAmount", 0)
            self:SetNWString("RES_LastDigSurface", nil)

            local mult = math.Rand(5, 15)

            RES.CreateResources(RES.SurfaceHarvest[surfaceprop][2], tr.HitPos + tr.HitNormal * 8, mult)
        end
    end
end

SWEP.Tools.ETool.SecondaryAttack = function(self)
end

SWEP.Tools.ETool.Think = function(self)
end