local ENTITY = FindMetaTable("Entity")

function ENTITY:RES_CanSalvage()
    if self:GetClass() == "prop_physics" then return true end
    return false
end

function ENTITY:RES_GetSalvageStrength()
    local phys = self:GetPhysicsObject()
    if not IsValid(phys) then return -1 end
    if self.RES_SalvageStrength == nil then
        local strfrommass = math.Clamp((phys:GetMass() ^ 0.5) / 5, 0, 20)
        local strfrombound = math.Clamp(self:GetModelRadius() ^ 0.5 - 4, 0, 15)

        -- print(self:GetModel(), strfrommass, strfrombound)
        self.RES_SalvageStrength = 1 / (strfrommass + strfrombound)
    end

    return self.RES_SalvageStrength
end

function ENTITY:RES_GetSalvageAmount()
    local phys = self:GetPhysicsObject()
    if not IsValid(phys) then return 0 end
    if self.RES_SalvageAmount == nil then
        local strfrommass = math.Clamp((phys:GetMass() ^ 0.5) / 4, 0, 30)
        local strfrombound = math.Clamp(self:GetModelRadius() ^ 0.5, 0, 20)
        self.RES_SalvageAmount = strfrommass + strfrombound
    end
    return self.RES_SalvageAmount
end

function ENTITY:RES_Salvage()
    local phys = self:GetPhysicsObject()
    local res = {}

    if RES.SpecialSalvageLookup[self:GetModel()] then
        res = RES.SpecialSalvage[RES.SpecialSalvageLookup[self:GetModel()]].Resource
    else
        local mat = phys:GetMaterial()
        print(mat)
        res = RES.MaterialSalvage[mat] or res
    end

    local str = self:RES_GetSalvageAmount()
    local pos = self:WorldSpaceCenter()
    for restype, amt in pairs(res) do
        print(restype, math.ceil(amt * str))
        RES.CreateResource(pos, restype, math.ceil(amt * str))
        pos = pos + Vector(0, 0, 24)
    end

    self:Remove()
end