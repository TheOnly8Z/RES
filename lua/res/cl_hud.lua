
local damaged = {}
local ammouse = {}
local hint = nil
net.Receive("res_entdamage", function()
    local ent = net.ReadEntity()
    local health = net.ReadFloat()

    if not IsValid(ent) then return end

    if damaged[ent] then
        damaged[ent][1] = CurTime()
        damaged[ent][3] = math.Clamp((damaged[ent][2] - ent:Health()) / ent:GetMaxHealth(), 0.15, 0.6)
    else
        damaged[ent] = {CurTime(), health, math.Clamp((health - ent:Health()) / ent:GetMaxHealth(), 0.15, 0.6)}
    end
end)

hook.Add("HUDPaint", "res_ent_health", function()
    local pos2d = {}
    -- local poshint
    cam.Start3D()
    for k, v in pairs(damaged) do
        if not IsValid(k) or v[1] + 3 <= CurTime() or k:Health() <= 0 then damaged[k] = nil continue end
        pos2d[k] = (k.Center and k:LocalToWorld(k.Center) or k:WorldSpaceCenter()):ToScreen()
    end
    for k, v in pairs(ammouse) do
        if not IsValid(k) or v[1] + 2 <= CurTime() then ammouse[k] = nil continue end
        pos2d[k] = (k.Center and k:LocalToWorld(k.Center) or k:WorldSpaceCenter()):ToScreen()
    end
    if hint and ((hint[1] or 0) + 5 <= CurTime() or (hint[3] ~= false and not IsValid(hint[3]))) then
        hint = nil
    elseif hint and hint[3] ~= false and IsValid(hint[3]) then
        poshint = (hint[3].Center and hint[3]:LocalToWorld(hint[3].Center) or hint[3]:WorldSpaceCenter()):ToScreen()
    end
    cam.End3D()

    -- if hint then
    --     local x, y = ScrW() * 0.5, ScrH() * 0.7
    --     local a = math.Clamp((hint[1] + 5 - CurTime()) / 1, 0, 1)
    --     local c = 255
    --     if DZ_ENTS.Hints[hint[2]][2] and  hint[1] + 0.5 > CurTime() then
    --         local flash = (math.sin(CurTime() * math.pi * 10) + 1) / 2
    --         a = flash * 0.4 + 0.6
    --         c = flash * 100 + 155
    --     end
    --     if poshint then
    --         x, y = poshint.x, poshint.y
    --     end
    --     draw.SimpleTextOutlined(DZ_ENTS.Hints[hint[2]][1], "TacR_Myriad_Pro_10", x, y, Color(c, c, c, 255 * a), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 100 * a))
    -- end

    for k, v in pairs(damaged) do
        local s = math.Clamp(1 - (k:GetPos():DistToSqr(EyePos()) / 4194304), 0.25, 1)
        local w, h = 128 * s, 10 * s
        local edge = 2 * s
        local a = math.Clamp((v[1] + 3 - CurTime()) / 0.5, 0, 1)
        surface.SetDrawColor(0, 0, 0, a * 200)
        surface.DrawRect(pos2d[k].x - w / 2 - edge, pos2d[k].y - h / 2 - edge, w + edge * 2, h + edge * 2)

        local d1 = math.Clamp(v[2] / k:GetMaxHealth(), 0, 1)
        local d2 = math.Clamp(k:Health() / k:GetMaxHealth(), 0, 1)
        local w_diff = math.floor(w * d2)

        surface.SetDrawColor(240, 35, 20, a * 255)
        surface.DrawRect(pos2d[k].x - w / 2 + w_diff, pos2d[k].y - h / 2, w * math.max(0, d1 - d2), h)

        surface.SetDrawColor(155, 200, 75, a * 255)
        surface.DrawRect(pos2d[k].x - w / 2, pos2d[k].y - h / 2, w_diff, h)

        v[2] = math.Approach(v[2], k:Health(), FrameTime() * v[3] * 250)
    end
end)