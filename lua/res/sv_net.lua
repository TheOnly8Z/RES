util.AddNetworkString("res_switchtool")
util.AddNetworkString("res_salvageinfo")
util.AddNetworkString("res_entdamage")

net.Receive("res_switchtool", function(len, ply)
    local wep = ply:GetActiveWeapon()
    if wep:GetClass() ~= "res_multitool" then return end
    local mode = net.ReadUInt(4)
    if not wep.ToolsIndex[mode] then return end

    wep:SetCurrentTool(mode)
end)

net.Receive("res_salvageinfo", function(len, ply)
    local ent = net.ReadEntity()
    if not IsValid(ent) or not ply:TestPVS(ent) or not ent:RES_CanSalvage() then return end

    local info = ent:RES_GetSalvageInfo()
    net.Start("res_salvageinfo")
        net.WriteEntity(ent)
        net.WriteFloat(info[1])
        net.WriteUInt(table.Count(info[2]), 4)
        for k, v in pairs(info[2]) do
            net.WriteString(k)
            net.WriteFloat(v)
        end
    net.Send(ply)
end)