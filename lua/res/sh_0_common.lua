RES.Resource = {

    -----------------------------------
    -- Crude
    -----------------------------------
    ["wood"] = {
        Name = "Wood",
        SubCategory = "Crude Resource",
        Material = "phoenix_storms/wood",
        SurfaceProp = "wood",
    },
    ["scrap"] = {
        Name = "Scrap",
        SubCategory = "Crude Resource",
        Material = "models/props_pipes/pipesystem01a_skin2",
        SurfaceProp = "metal",
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
    },
    ["ore"] = {
        Name = "Ore",
        SubCategory = "Crude Resource",
        Material = "models/props_wasteland/rockgranite02a",
        SurfaceProp = "rock",
    },

    -----------------------------------
    -- Reclaimed
    -----------------------------------
    ["coal"] = {
        Name = "Coal",
        SubCategory = "Reclaimed Resource",
        Material = "phoenix_storms/road",
        SurfaceProp = "dirt",
    },
    ["metal"] = {
        Name = "Metal",
        SubCategory = "Reclaimed Resource",
        Material = "models/props_rooftop/rooftopcluster01a",
        SurfaceProp = "metal",
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
    },
    ["polymer"] = {
        Name = "Polymer",
        SubCategory = "Reclaimed Resource",
        Material = "hunter/myplastic",
    },
    ["cement"] = {
        Name = "Cement",
        SubCategory = "Reclaimed Resource",
        Material = "phoenix_storms/concrete0",
        SurfaceProp = "concrete",
    },

    -----------------------------------
    -- Refined
    -----------------------------------
    ["metal_2"] = {
        Name = "Refined Metal",
        SubCategory = "Refined Resource",
        Material = "phoenix_storms/dome",
        SurfaceProp = "metal",
    },
    ["polymer_2"] = {
        Name = "Refined Polymer",
        SubCategory = "Refined Resource",
        Material = "phoenix_storms/plastic",
    },
}

RES.SpecialSalvage = {
    ["oildrum"] = {
        Whitelist = {
            "models/props_c17/oildrum001.mdl",
            "models/props_c17/oildrum001_explosive.mdl",
            "models/props_phx/oildrum001.mdl",
            "models/props_phx/facepunch_barrel.mdl",
            "models/props_phx/oildrum001_explosive.mdl",
        },
        Resource = {
            ["oil"] = 1,
            ["scrap"] = 0.25,
        },
    }
}