local ENTITY = FindMetaTable("Entity")

function ENTITY:RES_CanSalvage()
    if self:GetClass() == "prop_physics" then return true end
    return false
end

function ENTITY:RES_GetSalvageInfo()
    if self.RES_SalvageInfo == nil then
        if not self:RES_CanSalvage() then
            self.RES_SalvageInfo = false
            return false
        end
        if CLIENT then
            -- Request from server, as it is reliant on server-only physics info
            if not self.RES_SalvageInfoRequested then
                self.RES_SalvageInfoRequested = true
                net.Start("res_salvageinfo")
                    net.WriteEntity(self)
                net.SendToServer()
            end
            return
        end

        local phys = self:GetPhysicsObject()
        if not IsValid(phys) then return false end

        self.RES_SalvageInfo = {} -- strength, output

        local strfrommass = math.Clamp((phys:GetMass() ^ 0.75) / 5, 0, 50)
        local strfrombound = math.Clamp(self:GetModelRadius() ^ 0.5 - 4, 0, 15)
        self.RES_SalvageInfo[1] = strfrommass + strfrombound

        local res = {}
        if RES.SpecialSalvageLookup[self:GetModel()] then
            res = RES.SpecialSalvage[RES.SpecialSalvageLookup[self:GetModel()]].Resource
        else
            local mat = phys:GetMaterial()
            res = RES.MaterialSalvage[mat] or res
        end
        self.RES_SalvageInfo[2] = table.Copy(res)

        local amtfrommass = math.Clamp((phys:GetMass() ^ 0.75) / 3, 0, 100)
        local amtfrombound = math.Clamp(self:GetModelRadius() ^ 0.75, 1, 100)
        for k, v in pairs(self.RES_SalvageInfo[2]) do
            self.RES_SalvageInfo[2][k] = math.ceil(v * (amtfrommass + amtfrombound))
        end
    end
    return self.RES_SalvageInfo
end

function ENTITY:RES_Salvage(pos)
    local info = self:RES_GetSalvageInfo()
    RES.CreateResources(info[2], pos or self:WorldSpaceCenter())
    self:Remove()
end