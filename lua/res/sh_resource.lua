RES.ResourceEntityCache = {}

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

function RES.CreateResources(tbl, p, mult, no_merge)
    tbl = table.Copy(tbl)

    if mult then
        for k, v in pairs(tbl) do
            tbl[k] = math.Round(v * mult)
        end
    end

    local pos = Vector(p)

    if not no_merge then
        for _, ent in pairs(RES.ResourceEntityCache) do
            if tbl[ent.Resource] and ent:GetAmount() < ent:GetMaxAmount()
                    and ent:GetPos():DistToSqr(pos) <= 72 * 72 then
                local add = ent:AddAmount(tbl[ent.Resource])
                tbl[ent.Resource] = tbl[ent.Resource] - add
            end
        end
    end

    for restype, amt in pairs(tbl) do
        if amt <= 0 then continue end
        for i = math.ceil(amt / RES.ResourceBoxMaximum), 1, -1 do
            RES.CreateResource(pos, restype, i == 1 and (amt % RES.ResourceBoxMaximum) or RES.ResourceBoxMaximum)
        end
        pos = pos + Vector(0, 0, 24)
    end
end