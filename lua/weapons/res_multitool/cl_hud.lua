function SWEP:DoDrawCrosshair(x, y)

    if self.MenuAlpha > 0 then return end

    local tool = self:GetCurrentTool()

    local tr = self:GetOwner():GetEyeTrace()
    local ent = tr.Entity

    local highlight = nil
    if not IsValid(ent) or tr.HitPos:DistToSqr(self:GetOwner():EyePos()) > 128 * 128 then
        ent = nil
    end

    if isfunction(tool.Highlight) then
        highlight = tool.Highlight(self, ent)
    end

    if highlight then
        if highlight.Progress then
            surface.SetDrawColor(255, 255, 255, 100)
            surface.DrawRect(x - ScreenScale(32), y + ScreenScale(6), ScreenScale(64) * highlight.Progress, ScreenScale(8))
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawOutlinedRect(x - ScreenScale(32), y + ScreenScale(6), ScreenScale(64), ScreenScale(8), 2)
        end
        if highlight.Hint then
            draw.SimpleTextOutlined(highlight.Hint, "TacRP_Myriad_Pro_8", x, y + ScreenScale(6), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 150))
        end

        if highlight.Lines then
            for i = 1, #highlight.Lines do
                draw.SimpleTextOutlined(highlight.Lines[i], "TacRP_Myriad_Pro_6", x, y + ScreenScale(14) + (i - 1) * ScreenScale(6), color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 150))
            end
        end
    else
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawRect(x - 2.5, y - 2.5, 5, 5)
    end
end

function SWEP:DrawHUDBackground()
    self:DrawToolWheel()
end