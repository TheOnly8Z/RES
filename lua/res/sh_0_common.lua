RES.Resource = {

    ["power"] = {
        Name = "Power",
        SubCategory = "Special Resource",
        Model = "models/items/car_battery01.mdl",
    },

    -----------------------------------
    -- Crude
    -----------------------------------
    ["wood"] = {
        Name = "Wood",
        SubCategory = "Crude Resource",
        Material = "phoenix_storms/wood",
        SurfaceProp = "wood",
        ScaleModel = true,
    },
    ["scrap"] = {
        Name = "Scrap",
        SubCategory = "Crude Resource",
        Material = "models/props_pipes/pipesystem01a_skin2",
        SurfaceProp = "metal",
        ScaleModel = true,
    },
    ["oil"] = {
        Name = "Crude Oil",
        SubCategory = "Crude Resource",
        Model = "models/props_junk/plasticbucket001a.mdl",
    },
    ["detritus"] = {
        Name = "Detritus",
        SubCategory = "Crude Resource",
        Material = "models/props_wasteland/dirtwall001a",
        SurfaceProp = "dirt",
        ScaleModel = true,
    },
    ["ore"] = {
        Name = "Ore",
        SubCategory = "Crude Resource",
        Material = "models/props_wasteland/rockgranite02a",
        SurfaceProp = "rock",
        ScaleModel = true,
    },

    -----------------------------------
    -- Reclaimed
    -----------------------------------
    ["coal"] = {
        Name = "Coal",
        SubCategory = "Reclaimed Resource",
        Material = "phoenix_storms/road",
        SurfaceProp = "dirt",
        ScaleModel = true,
    },
    ["metal"] = {
        Name = "Metal",
        SubCategory = "Reclaimed Resource",
        Material = "models/props_rooftop/rooftopcluster01a",
        SurfaceProp = "metal",
        ScaleModel = true,
    },
    ["fuel"] = {
        Name = "Fuel",
        SubCategory = "Reclaimed Resource",
        Model = "models/props_junk/metalgascan.mdl",
        SurfaceProp = "metal",
    },
    ["glass"] = {
        Name = "Glass",
        SubCategory = "Reclaimed Resource",
        Material = "phoenix_storms/glass",
        SurfaceProp = "glass",
        ScaleModel = true,
    },
    ["polymer"] = {
        Name = "Polymer",
        SubCategory = "Reclaimed Resource",
        Material = "hunter/myplastic",
        ScaleModel = true,
    },
    ["cement"] = {
        Name = "Cement",
        SubCategory = "Reclaimed Resource",
        Material = "phoenix_storms/concrete0",
        SurfaceProp = "concrete",
        ScaleModel = true,
    },

    -----------------------------------
    -- Refined
    -----------------------------------
    ["metal_2"] = {
        Name = "Refined Metal",
        SubCategory = "Refined Resource",
        Material = "phoenix_storms/dome",
        SurfaceProp = "metal",
        ScaleModel = true,
    },
    ["polymer_2"] = {
        Name = "Refined Polymer",
        SubCategory = "Refined Resource",
        Material = "phoenix_storms/plastic",
        ScaleModel = true,
    },
}
RES.ResourceBoxMaximum = 100
RES.ResourceBoxSpawnAmount = 100

-- https://developer.valvesoftware.com/wiki/Material_surface_properties
RES.MaterialSalvage = {

    -----------------------------------
    -- Concrete / Rock
    -----------------------------------
    ["concrete"] = {
        ["cement"] = 1,
    },
    ["boulder"] = {
        ["cement"] = 0.5,
        ["ore"] = 0.5,
        ["detritus"] = 1,
    },
    ["concrete_block"] = {
        ["cement"] = 1,
    },
    ["rock"] = {
        ["ore"] = 1,
        ["detritus"] = 1,
    },
    ["cavern_rock"] = {
        ["ore"] = 1,
        ["detritus"] = 1,
    },

    -----------------------------------
    -- Metal
    -----------------------------------
    ["metal"] = {
        ["scrap"] = 1,
    },
    ["metalpanel"] = {
        ["scrap"] = 0.75,
        ["metal"] = 0.25,
    },
    ["combine_metal"] = {
        ["metal"] = 0.5,
        ["glass"] = 1,
    },
    ["canister"] = {
        ["scrap"] = 1,
    },
    ["chain"] = {
        ["scrap"] = 1,
    },
    ["chainlink"] = {
        ["scrap"] = 1,
    },
    ["crowbar"] = {
        ["metal"] = 1,
    },
    ["floating_metal_barrel"] = {
        ["scrap"] = 1,
        ["oil"] = 1,
    },
    ["grenade"] = {
        ["metal"] = 1,
    },
    ["gunship"] = {
        ["scrap"] = 1,
    },
    ["metal_barrel"] = {
        ["scrap"] = 1,
        ["oil"] = 1,
    },
    ["metal_bouncy"] = {
        ["scrap"] = 1,
    },
    ["metal_box"] = {
        ["scrap"] = 1,
    },
    ["metal_seafloorcar"] = {
        ["scrap"] = 1,
    },
    ["metalgrate"] = {
        ["scrap"] = 1,
    },
    ["metalvent"] = {
        ["scrap"] = 1,
    },
    ["popcan"] = {
        ["scrap"] = 1,
    },
    ["metalvehicle"] = {
        ["scrap"] = 1,
    },
    ["roller"] = {
        ["metal"] = 1,
    },
    ["paintcan"] = {
        ["scrap"] = 1,
    },
    ["solidmetal"] = {
        ["metal"] = 1,
    },
    ["strider"] = {
        ["metal"] = 1,
    },
    -----------------------------------
    -- Wood
    -----------------------------------
    ["wood"] = {
        ["wood"] = 1,
    },
    ["wood_crate"] = {
        ["wood"] = 1,
    },
    ["wood_box"] = {
        ["wood"] = 1,
    },
    ["wood_furniture"] = {
        ["wood"] = 1,
    },
    ["wood_plank"] = {
        ["wood"] = 1.5,
    },
    ["wood_panel"] = {
        ["wood"] = 2,
    },
    ["wood_solid"] = {
        ["wood"] = 2,
    },

    -----------------------------------
    -- Terrain
    -----------------------------------
    ["dirt"] = { -- also used for sofas?
        ["detritus"] = 2,
    },
    ["grass"] = {
        ["ore"] = 0.1,
        ["detritus"] = 2,
    },
    ["gravel"] = {
        ["ore"] = 0.5,
        ["detritus"] = 1.5,
    },
    ["mud"] = {
        ["detritus"] = 2,
    },
    ["quicksand"] = {
        ["detritus"] = 2,
    },
    ["sand"] = {
        ["detritus"] = 2.5,
    },
    ["antlionsand"] = {
        ["detritus"] = 2.5,
    },
    ["slipperyslime"] = {
        ["detritus"] = 2,
    },
    ["ice"] = {
        ["detritus"] = 1,
    },
    ["snow"] = {
        ["detritus"] = 1,
    },

    -----------------------------------
    -- Manufactured
    -----------------------------------
    ["default"] = {
        ["wood"] = 0.4,
        ["scrap"] = 0.4,
        ["polymer"] = 0.3,
    },
    ["advisor_shield"] = {
        ["metal"] = 0.5,
        ["glass"] = 0.5,
    },
    ["asphalt"] = {
        ["detritus"] = 1,
        ["cement"] = 1,
    },
    ["glass"] = {
        ["glass"] = 2,
    },
    ["glassbottle"] = {
        ["glass"] = 1,
    },
    ["combine_glass"] = {
        ["metal"] = 0.5,
        ["glass"] = 2,
    },
    ["tile"] = {
        ["polymer"] = 0.5,
        ["wood"] = 0.5,
    },
    ["paper"] = {
        ["wood"] = 0.5,
    },
    ["papercup"] = {
        ["wood"] = 0.5,
    },
    ["cardboard"] = {
        ["wood"] = 0.5,
    },
    ["plaster"] = {
        ["polymer"] = 0.5,
        ["wood"] = 0.5,
    },
    ["plastic_barrel"] = {
        ["polymer"] = 1,
    },
    ["plastic_barrel_buoyant"] = {
        ["polymer"] = 1,
    },
    ["plastic_box"] = {
        ["polymer"] = 1,
    },
    ["plastic"] = {
        ["polymer"] = 1,
    },
    ["rubber"] = {
        ["polymer"] = 1,
    },
    ["rubbertire"] = {
        ["polymer"] = 1,
    },
    ["plastic"] = {
        ["polymer"] = 1,
    },
    ["porcelain"] = {
        ["cement"] = 0.5,
        ["glass"] = 0.5,
    },
    ["carpet"] = {
        ["wood"] = 1,
    },
    ["ceiling_tile"] = {
        ["polymer"] = 0.5,
        ["wood"] = 0.5,
    },
    ["computer"] = {
        ["metal"] = 0.5,
        ["polymer"] = 0.5,
    },
    ["pottery"] = {
        ["glass"] = 0.5,
        ["polymer"] = 0.5,
    },
    ["weapon"] = {
        ["metal"] = 0.5,
        ["polymer"] = 0.5,
    },
    ["item"] = {
        ["metal"] = 0.5,
        ["polymer"] = 0.5,
    },
}

RES.SpecialSalvage = {
    -- ["oildrum"] = {
    --     Whitelist = {
    --         "models/props_c17/oildrum001.mdl",
    --         "models/props_c17/oildrum001_explosive.mdl",
    --         "models/props_phx/oildrum001.mdl",
    --         "models/props_phx/facepunch_barrel.mdl",
    --         "models/props_phx/oildrum001_explosive.mdl",
    --     },
    --     Resource = {
    --         ["oil"] = 0.5,
    --         ["scrap"] = 1,
    --     },
    -- }
}

RES.SpecialSalvageLookup = {}
for k, v in pairs(RES.SpecialSalvage) do
    for _, mdl in pairs(v.Whitelist or {}) do
        RES.SpecialSalvageLookup[mdl] = k
    end
end