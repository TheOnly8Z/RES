AddCSLuaFile()

AddCSLuaFile("sh_tools.lua")
include("sh_tools.lua")

AddCSLuaFile("cl_toolwheel.lua")
AddCSLuaFile("cl_hud.lua")

if CLIENT then
    include("cl_toolwheel.lua")
    include("cl_hud.lua")
end


DEFINE_BASECLASS(SWEP.Base)

SWEP.PrintName = "Resource Multitool"
SWEP.Spawnable = true

SWEP.Purpose = "Salvage and construct."
SWEP.Instructions = "Hold RELOAD to select tool mode."

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
    self:NetworkVar("Int", 0, "ToolIndex")
    self:NetworkVar("Float", 0, "WeaponIdleTime")
end

function SWEP:Initialize()
    -- engine deploy blocks weapon from thinking and doing most stuff
    -- self.m_WeaponDeploySpeed = 255
    self:SetCurrentTool(1)
end

function SWEP:Deploy()
    local owner = self:GetOwner()
    if not owner or not owner:IsPlayer() then return end

    self:ApplyCurrentTool()

    local tool = self:GetCurrentTool()

    if tool.DeployAnim then
        self:SetWeaponAnim(tool.DeployAnim, self:GetDeploySpeed(), true)
    end
    if tool.DeployGesture then
        owner:DoAnimationEvent(tool.DeployGesture)
    end

    if isfunction(tool.Deploy) then
        return tool.Deploy(self)
    end

    return true
end

function SWEP:SetWeaponAnim(idealAct, flPlaybackRate, wait)
    flPlaybackRate = isnumber(flPlaybackRate) and flPlaybackRate or 1
    local owner = self:GetOwner()
    if not IsValid(owner) then return end

    local dur = 0

    local vm = owner:GetViewModel()
    if IsValid(vm) then
        local idealSequence = vm:SelectWeightedSequence(idealAct)
        if idealSequence ~= -1 then
            vm:SendViewModelMatchingSequence(idealSequence)
            vm:SetPlaybackRate(flPlaybackRate)
            dur = vm:SequenceDuration()
        end
    end

    -- Set the next time the weapon will idle
    self:SetWeaponIdleTime(CurTime() + dur / flPlaybackRate)

    if wait then
        self:SetNextPrimaryFire(CurTime() + dur / flPlaybackRate)
    end

    return true
end