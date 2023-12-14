local function filledcircle(x, y, radius, seg)
    local cir = {}

    table.insert(cir, {
        x = x,
        y = y,
        u = 0.5,
        v = 0.5
    })

    for i = 0, seg do
        local a = math.rad((i / seg) * -360)

        table.insert(cir, {
            x = x + math.sin(a) * radius,
            y = y + math.cos(a) * radius,
            u = math.sin(a) / 2 + 0.5,
            v = math.cos(a) / 2 + 0.5
        })
    end

    local a = math.rad(0)

    table.insert(cir, {
        x = x + math.sin(a) * radius,
        y = y + math.cos(a) * radius,
        u = math.sin(a) / 2 + 0.5,
        v = math.cos(a) / 2 + 0.5
    })

    surface.DrawPoly(cir)
end

local function slicedcircle(x, y, radius, seg, ang0, ang1)
    local cir = {}

    ang0 = ang0 + 90
    ang1 = ang1 + 90

    local arcseg = math.Round(360 / math.abs(ang1 - ang0) * seg)

    table.insert(cir, {
        x = x,
        y = y,
        u = 0.5,
        v = 0.5
    })

    for i = 0, arcseg do
        local a = math.rad((i / arcseg) * -math.abs(ang1 - ang0) + ang0)

        table.insert(cir, {
            x = x + math.sin(a) * radius,
            y = y + math.cos(a) * radius,
            u = math.sin(a) / 2 + 0.5,
            v = math.cos(a) / 2 + 0.5
        })
    end

    surface.DrawPoly(cir)
end

SWEP.MenuAlpha = 0
SWEP.MenuKey = IN_RELOAD

local cur_tool
local cur_ind
local lastmenu
function SWEP:DrawToolWheel()
    local ft = FrameTime()
    local scrw = ScrW()
    local scrh = ScrH()
    local r = ScreenScale(128)
    local r2 = ScreenScale(40)
    local sg = ScreenScale(32)
    local ri = r * 0.667
    local s = 18 - 72

    local arcdegrees = 360 / math.max(1, #self.ToolsIndex)
    local d = 360 - s

    local cursorx, cursory = input.GetCursorPos()
    local mouseangle = math.deg(math.atan2(cursorx - scrw / 2, cursory - scrh / 2))
    local mousedist = math.sqrt(math.pow(cursorx - scrw / 2, 2) + math.pow(cursory - scrh / 2, 2))
    mouseangle = math.NormalizeAngle(-mouseangle + arcdegrees)
    if mouseangle < 0 then
        mouseangle = mouseangle + 360
    end

    if self:GetOwner():KeyDown(self.MenuKey) then
        self.MenuAlpha = math.Approach(self.MenuAlpha, 1, 15 * ft)
        if !lastmenu then
            gui.EnableScreenClicker(true)
            lastmenu = true
        end

        if mousedist > r2 then
            local i = (math.floor( (mouseangle - s) / arcdegrees ) % #self.ToolsIndex) + 1
            cur_tool = self.ToolsIndex[i]
            cur_ind = i
        else
            cur_tool = self:GetCurrentTool()
            cur_ind = nil
        end
        self.MenuHighlighted = cur_ind
    else
        self.MenuAlpha = math.Approach(self.MenuAlpha, 0, -10 * ft)
        if lastmenu then
            gui.EnableScreenClicker(false)
            if cur_tool then
                net.Start("res_switchtool")
                    net.WriteUInt(cur_tool.Index, 4)
                net.SendToServer()
            end
            lastmenu = false
        end
    end

    if self.MenuAlpha <= 0 then
        return
    end

    local a = self.MenuAlpha
    local col = Color(255, 255, 255, 255 * a)

    surface.DrawCircle(scrw / 2, scrh / 2, r, 255, 255, 255, a * 255)

    surface.SetDrawColor(0, 0, 0, a * 200)
    draw.NoTexture()
    filledcircle(scrw / 2, scrh / 2, r, 32)

    surface.SetDrawColor(150, 150, 150, a * 100)
    draw.NoTexture()
    if cur_ind then
        local d0 = -s -arcdegrees * (cur_ind - 1)
        slicedcircle(scrw / 2, scrh / 2, r, 32, d0, d0 + arcdegrees)
    else
        filledcircle(scrw / 2, scrh / 2, r2, 32)
    end

    surface.SetDrawColor(0, 0, 0, a * 255)
    surface.DrawCircle(scrw / 2, scrh / 2, r2, 255, 255, 255, a * 255)

    for i = 1, self.ToolsCount do
        local rad = math.rad( d - arcdegrees * 0.5 )

        surface.SetDrawColor(255, 255, 255, a * 255)
        surface.DrawLine(
            scrw / 2 + math.cos(math.rad(d)) * r2,
            scrh / 2 - math.sin(math.rad(d)) * r2,
            scrw / 2 + math.cos(math.rad(d)) * r,
            scrh / 2 - math.sin(math.rad(d)) * r)

        local nadex, nadey = scrw / 2 + math.cos(rad) * ri, scrh / 2 - math.sin(rad) * ri

        surface.SetDrawColor(255, 255, 255, a * 255)
        surface.SetTextColor(255, 255, 255, a * 255)

        local tool = self.ToolsIndex[i]

        if tool.Icon then
            surface.SetMaterial(tool.Icon)
            surface.DrawTexturedRect(nadex - sg * 0.5, nadey - sg * 0.5 - ScreenScale(8), sg, sg)
        end
        local nadetext = tool.PrintName
        surface.SetFont("TacRP_HD44780A00_5x8_8")
        local nadetextw = surface.GetTextSize(nadetext)
        surface.SetTextPos(nadex - nadetextw * 0.5, nadey + ScreenScale(6))
        surface.DrawText(nadetext)

        d = d - arcdegrees
    end

    local tool = self:GetCurrentTool()

    if tool.Icon then
        surface.SetMaterial(tool.Icon)
        surface.SetDrawColor(255, 255, 255, a * 255)
        surface.DrawTexturedRect(scrw / 2 - sg * 0.5, scrh / 2 - sg * 0.5 - ScreenScale(8), sg, sg)
    end

    local nadetext = tool.PrintName
    surface.SetFont("TacRP_HD44780A00_5x8_8")
    local nadetextw = surface.GetTextSize(nadetext)
    surface.SetTextPos(scrw / 2 - nadetextw * 0.5, scrh / 2 + ScreenScale(6))
    surface.SetTextColor(255, 255, 255, a * 255)
    surface.DrawText(nadetext)

    local w, h = ScreenScale(96), ScreenScale(128)
    local tx, ty = scrw / 2 + r + ScreenScale(16), scrh / 2

    local desctool = cur_tool or tool

    -- full name
    surface.SetDrawColor(0, 0, 0, 200 * a)
    TacRP.DrawCorneredBox(tx, ty - h * 0.5 - ScreenScale(28), w, ScreenScale(24), col)
    surface.SetTextColor(255, 255, 255, a * 255)

    local name = desctool.FullName or desctool.PrintName
    surface.SetFont("TacRP_Myriad_Pro_16")
    local name_w, name_h = surface.GetTextSize(name)
    if name_w > w then
        surface.SetFont("TacRP_Myriad_Pro_14")
        name_w, name_h = surface.GetTextSize(name)
    end
    surface.SetTextPos(tx + w / 2 - name_w / 2, ty - h * 0.5 - ScreenScale(28) + ScreenScale(12) - name_h / 2)
    surface.DrawText(name)


    -- Description
    surface.SetDrawColor(0, 0, 0, 200 * a)
    TacRP.DrawCorneredBox(tx, ty - h * 0.5, w, h, col)

    surface.SetFont("TacRP_Myriad_Pro_8")
    surface.SetTextPos(tx + ScreenScale(4), ty - h / 2 + ScreenScale(2))
    surface.DrawText("DESCRIPTION:")

    surface.SetFont("TacRP_Myriad_Pro_8")

    if desctool.Description then
        desctool.DescriptionMultiLine = TacRP.MultiLineText(desctool.Description or "", w - ScreenScale(7), "TacRP_Myriad_Pro_8")
    end

    surface.SetTextColor(255, 255, 255, a * 255)
    for i, text in ipairs(desctool.DescriptionMultiLine) do
        surface.SetTextPos(tx + ScreenScale(4), ty - h / 2 + ScreenScale(10) + (i - 1) * ScreenScale(8))
        surface.DrawText(text)
    end

    surface.SetFont("TacRP_Myriad_Pro_8")
    surface.SetDrawColor(0, 0, 0, 200 * a)

    -- if TacRP.ConVars["nademenu_click"]:GetBool() then

    --     local binded = input.LookupBinding("grenade1")

    --     TacRP.DrawCorneredBox(tx, ty + h * 0.5 + ScreenScale(2), w, ScreenScale(binded and 36 or 28), col)

    --     surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(4))
    --     surface.DrawText("[LMB] - Throw Overhand")
    --     surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(12))
    --     surface.DrawText("[RMB] - Throw Underhand")
    --     if binded then
    --         surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(20))
    --         surface.DrawText("Hold/Tap [" .. TacRP.GetBind("grenade1") .. "] - Over/Under")
    --     end
    --     if TacRP.AreTheGrenadeAnimsReadyYet then
    --         surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(28))
    --         surface.DrawText("[MMB] - Pull Out Grenade")
    --     end
    -- else

    --     TacRP.DrawCorneredBox(tx, ty + h * 0.5 + ScreenScale(2), w, ScreenScale(28), col)

    --     surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(4))
    --     surface.DrawText("Hold [" .. TacRP.GetBind("grenade1") .. "] - Throw Overhand")
    --     surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(12))
    --     surface.DrawText("Tap [" .. TacRP.GetBind("grenade1") .. "] - Throw Underhand")

    --     if TacRP.AreTheGrenadeAnimsReadyYet then
    --         surface.SetTextPos(tx + ScreenScale(4), ty + h / 2 + ScreenScale(20))
    --         surface.DrawText("[MMB] - Pull Out Grenade")
    --     end
    -- end
end
