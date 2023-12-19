SWEP.Tools.PDA = {}

SWEP.Tools.PDA.PrintName = "PDA"
SWEP.Tools.PDA.FullName = "PDA"
SWEP.Tools.PDA.SortOrder = 5
SWEP.Tools.PDA.Icon = nil --Material("entities/weapon_stunstick.png")
SWEP.Tools.PDA.Description = [[A device for construction planning.

LMB: Open build menu
RMB: Haul buildings]]

SWEP.Tools.PDA.ViewModel = "models/weapons/c_toolgun.mdl"
SWEP.Tools.PDA.WorldModel = "models/weapons/w_toolgun.mdl"
SWEP.Tools.PDA.HoldType = "slam"

SWEP.Tools.PDA.DeployAnim = ACT_VM_DRAW
SWEP.Tools.PDA.DeployGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_SLAM

local function snap_pos(self, pos)
    pos.x = math.Round(pos.x / 4) * 4
    pos.y = math.Round(pos.y / 4) * 4
    return pos
end
local function snap_ang(self, ang)
    ang.y = math.NormalizeAngle(math.Round(ang.y / 45) * 45)
    return ang
end


SWEP.Tools.PDA.PrimaryAttack = function(self)
    if self:GetSelectedBuildable() == "" then return end
    local owner = self:GetOwner()
    local tr = owner:GetEyeTrace()

    if not tr.HitWorld or tr.HitPos:DistToSqr(owner:EyePos()) > 128 * 128 then
        return
    end
    self:SetNextPrimaryFire(CurTime() + 0.1)

    local pos = snap_pos(self, tr.HitPos)
    local ang = snap_ang(self, Angle(0, tr.Normal:Angle().y, 0))

    if RES.TraceBuildable(self:GetSelectedBuildable(), pos, ang, nil) then
        if CLIENT then return end
        local ent = ents.Create(self:GetSelectedBuildable())
        ent:SetPos(pos)
        ent:SetAngles(ang)
        ent:Spawn()
        self:SetSelectedBuildable("")
    end
end

local buildlist = {
    "res_b_concrete_barrier",
    "res_b_sandbag_line1",
}

SWEP.Tools.PDA.SecondaryAttack = function(self)
    self:SetSelectedBuildable("res_b_concrete_barrier")
    self:SetNextSecondaryFire(CurTime() + 1)
end

local clrbad, clrgood = Color(255, 128, 0, 100), Color(100, 255, 100, 100)
SWEP.Tools.PDA.Think = function(self)
    if CLIENT then
        if IsValid(self.PreviewModel) and self:GetSelectedBuildable() == "" then
            self.PreviewModel:Remove()
        elseif self:GetSelectedBuildable() ~= "" and not IsValid(self.PreviewModel) then
            local tbl = scripted_ents.Get(self:GetSelectedBuildable())
            if not tbl then return end

            self.PreviewModel = ClientsideModel(tbl.BaseModel)
            self.PreviewModel:SetRenderMode(RENDERMODE_TRANSALPHA)
            self.PreviewModel:SetColor(Color(255, 255, 255, 100))
        elseif IsValid(self.PreviewModel) then
            local owner = self:GetOwner()
            local tr = owner:GetEyeTrace()
            local pos = snap_pos(self, tr.HitPos)
            local ang = snap_ang(self, Angle(0, tr.Normal:Angle().y, 0))

            if pos ~= self.LastPos or ang ~= self.LastAng then
                local can = tr.HitWorld and tr.HitPos:DistToSqr(owner:EyePos()) <= 128 * 128
                if can then
                    can = RES.TraceBuildable(self:GetSelectedBuildable(), pos, ang, nil)
                end
                self.PreviewModel:SetColor(can and clrgood or clrbad)
            end

            self.PreviewModel:SetPos(pos)
            self.PreviewModel:SetAngles(ang)

            self.LastPos = pos
            self.LastAng = ang
        end
    end
end

SWEP.Tools.PDA.OnToolSwitchOut = function(self, i)
    if CLIENT and IsValid(self.PreviewModel) then
        self.PreviewModel:Remove()
    end
end
SWEP.Tools.PDA.OnToolSwitchIn = function(self, i)
    self:SetSelectedBuildable("")
end

SWEP.Tools.PDA.OnRemove = function(self)
    if CLIENT and IsValid(self.PreviewModel) then
        self.PreviewModel:Remove()
    end
end

SWEP.Tools.PDA.Holster = function(self)
    self:SetSelectedBuildable("")
    if CLIENT and IsValid(self.PreviewModel) then
        self.PreviewModel:Remove()
    end
end