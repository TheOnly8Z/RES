SWEP.Tools = {}

SWEP.ToolsIndex = {}
SWEP.ToolsName = {}
SWEP.ToolsCount = 0

local searchdir = "weapons/res_multitool/tools"
local function includetools(dir)
    local files = file.Find(searchdir .. "/*.lua", "LUA")
    for _, filename in pairs(files) do
        AddCSLuaFile(dir .. "/" .. filename)
        include(dir .. "/" .. filename)
    end

    local i = 0
    for k, v in SortedPairsByMemberValue(SWEP.Tools, "SortOrder") do
        i = i + 1
        SWEP.ToolsName[i] = k
        SWEP.ToolsIndex[i] = v
        SWEP.Tools[k].Index = i
    end
    SWEP.ToolsCount = i
end
includetools(searchdir)

function SWEP:GetCurrentTool()
    return self.ToolsIndex[self:GetToolIndex()]
end

function SWEP:ApplyCurrentTool()
    local tool = self:GetCurrentTool()
    self.ViewModel = tool.ViewModel
    self.WorldModel = tool.WorldModel
    self:SetHoldType(tool.HoldType)
    local vm = IsValid(self:GetOwner()) and self:GetOwner():GetViewModel()
    if IsValid(vm) then vm:SetModel(self.ViewModel) end
    self:SetModel(self.WorldModel)
end

function SWEP:SetCurrentTool(i)
    if i == self:GetToolIndex() then return end
    if isstring(i) then i = tonumber(i) or (self.Tools[i] or {}).Index end
    assert(i ~= nil and self.ToolsIndex[i] ~= nil, "Tried to set invalid tool index \"" .. tostring(i) .. "\"!")

    self:SetToolIndex(i)
    self:ApplyCurrentTool()

    local tool = self:GetCurrentTool()
    if tool.DeployAnim then
        self:SetWeaponAnim(tool.DeployAnim, self:GetDeploySpeed(), true)
    end
    if IsValid(self:GetOwner()) and tool.DeployGesture then
        self:GetOwner():DoAnimationEvent(tool.DeployGesture)
    end

    if isfunction(tool.Deploy) then
        return tool.Deploy(self)
    end

    if SERVER then
        self:CallOnClient("SetCurrentTool", tostring(i))
    end
end

function SWEP:WeaponIdle()
    if self:GetWeaponIdleTime() > CurTime() then return end

    self:SetWeaponAnim(ACT_VM_IDLE)
    self:SetWeaponIdleTime(math.huge) -- it's looping anyways
end

function SWEP:PrimaryAttack()
    local tool = self:GetCurrentTool()
    if isfunction(tool.PrimaryAttack) then
        return tool.PrimaryAttack(self)
    end
end

function SWEP:SecondaryAttack()
    local tool = self:GetCurrentTool()
    if isfunction(tool.SecondaryAttack) then
        return tool.SecondaryAttack(self)
    end
end

function SWEP:Reload()
    local tool = self:GetCurrentTool()
    if isfunction(tool.Reload) then
        return tool.Reload(self)
    end
end

function SWEP:Think()
    self:WeaponIdle()

    local tool = self:GetCurrentTool()
    if isfunction(tool.Think) then
        return tool.Think(self)
    end
end