function RES.GenerateEntities()
    for k, v in pairs(RES.Resource) do
        local tbl = {}
        tbl.Base = "res_base_r"
        tbl.PrintName = v.Name
        tbl.Resource = k
        tbl.Spawnable = true
        tbl.Category = "RES"

        scripted_ents.Register(tbl, "res_r_" .. k)
    end
end

RES.GenerateEntities()
hook.Add("InitPostEntity", "res_resource", RES.GenerateEntities)

function RES.CreateResource(pos, restype, amt)
    local ent = ents.Create("res_r_" .. restype)
    ent:SetAmount(amt or 1)
    ent:SetPos(pos)
    ent:SetAngles(Angle(0, math.Rand(-180, 180), 0))
    ent:Spawn()
end