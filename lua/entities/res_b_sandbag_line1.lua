AddCSLuaFile()

ENT.Base = "res_base_b"

ENT.PrintName = "Sandbags (Line)"
ENT.Spawnable = true
ENT.Category = "RES - Buildables"

----------------------------- Fields
ENT.BaseModel = "models/props_fortifications/sandbags_line1.mdl"
ENT.BaseHealth = 500
ENT.Mass = 400
ENT.BaseMaterial = "sandbag"

ENT.PlaceBoundsMin = Vector(-12, -72, 4)
ENT.PlaceBoundsMax = Vector(15, 72, 48)

-----------------------------
ENT.BuildableType = "Defense"
ENT.BuildableSubType = "Wall"
ENT.Description = "A waist-high stack of sandbags.\nLiterally dirt cheap, but takes some effort to deploy."

ENT.ResourceCost = {
    ["detritus"] = 25
}

ENT.WorkCost = 100