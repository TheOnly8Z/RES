RES.Resource = {

    -----------------------------------
    -- Crude
    -----------------------------------
    ["wood"] = {
        Name = "Wood",
        SubCategory = "Crude Resource",
        Material = "phoenix_storms/wood",
    },
    ["scrap"] = {
        Name = "Scrap",
        SubCategory = "Crude Resource",
        Material = "models/props_pipes/pipesystem01a_skin2",
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
    },
    ["ore"] = {
        Name = "Ore",
        SubCategory = "Crude Resource",
        Material = "models/props_wasteland/rockgranite02a",
    },

    -----------------------------------
    -- Reclaimed
    -----------------------------------
    ["coal"] = {
        Name = "Coal",
        SubCategory = "Reclaimed Resource",
        Material = "phoenix_storms/road",
    },
    ["metal"] = {
        Name = "Metal",
        SubCategory = "Reclaimed Resource",
        Material = "models/props_rooftop/rooftopcluster01a",
    },
    ["fuel"] = {
        Name = "Fuel",
        SubCategory = "Reclaimed Resource",
        Model = "models/props_junk/metalgascan.mdl",
    },
    ["glass"] = {
        Name = "Glass",
        SubCategory = "Reclaimed Resource",
        Material = "phoenix_storms/glass",
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
    },

    -----------------------------------
    -- Refined
    -----------------------------------
    ["metal_2"] = {
        Name = "Refined Metal",
        SubCategory = "Refined Resource",
        Material = "phoenix_storms/dome",
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