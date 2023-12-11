net.Receive("res_salvageinfo", function()
    local ent = net.ReadEntity()

    ent.RES_SalvageInfo = {}

    ent.RES_SalvageInfo[1] = net.ReadFloat()
    ent.RES_SalvageInfo[2] = {}
    local rescount = net.ReadUInt(4)
    for i = 1, rescount do
        ent.RES_SalvageInfo[2][net.ReadString()] = net.ReadFloat()
    end
end)