AddCSLuaFile()

ENT.Base = "res_base_b"

ENT.PrintName = "Concrete Barrier"
ENT.Spawnable = true
ENT.Category = "RES - Buildables"

----------------------------- Fields
ENT.BaseModel = "models/props_c17/concrete_barrier001a.mdl"
ENT.BaseHealth = 400
ENT.Mass = 150
ENT.BaseMaterial = "concrete"

ENT.PlaceBoundsMin = Vector(-10.5, -56, 4)
ENT.PlaceBoundsMax = Vector(10.5, 56, 48)

-----------------------------
ENT.BuildableType = "Defense"
ENT.BuildableSubType = "Wall"
ENT.Description = "A waist-high wall made of concrete.\nQuick to deploy, but not the most durable."

ENT.ResourceCost = {
    ["cement"] = 20
}

ENT.WorkCost = 30
