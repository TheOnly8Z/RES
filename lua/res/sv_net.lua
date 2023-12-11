util.AddNetworkString("res_switchtool")

net.Receive("res_switchtool", function(len, ply)
    local wep = ply:GetActiveWeapon()
    if wep:GetClass() ~= "res_multitool" then return end
    local mode = net.ReadUInt(4)
    if not wep.ToolsIndex[mode] then return end

    wep:SetCurrentTool(mode)
end)