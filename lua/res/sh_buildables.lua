RES.BuildableImmuneDamageTypes = DMG_NERVEGAS + DMG_POISON + DMG_RADIATION + DMG_FALL

RES.BuildableMaterial = {
    ["concrete"] = {
        Name = "Concrete",
        Description = "A generally durable material resistant to all damage types except explosives.",
        Multipliers = {
            [DMG_GENERIC] = 0.1,
            [DMG_SLASH] = 0.1,
            [DMG_CLUB] = 0.1,

            [DMG_BULLET] = 0.05,
            [DMG_BUCKSHOT] = 0.05,
            [DMG_AIRBOAT] = 0.15,
            -- [DMG_BLAST] = 1,
            -- [DMG_BLAST_SURFACE] = 1,

            [DMG_CRUSH] = 0.5,
            [DMG_VEHICLE] = 0.5,

            [DMG_BURN] = 0.1,
            [DMG_SLOWBURN] = 0.1,
            [DMG_SHOCK] = 0.1,
        }
    },
    ["metal"] = {
        Name = "Metal",
        Description = "Solid metal.\nImmune to melee attacks, but not to small arms fire and heat.",
        Multipliers = {
            [DMG_GENERIC] = 0,
            [DMG_SLASH] = 0,
            [DMG_CLUB] = 0,

            [DMG_BULLET] = 0.1,
            [DMG_BUCKSHOT] = 0.1,
            [DMG_AIRBOAT] = 0.25,
            -- [DMG_BLAST] = 1,
            -- [DMG_BLAST_SURFACE] = 1,

            [DMG_CRUSH] = 0.15,
            [DMG_VEHICLE] = 0.15,

            [DMG_BURN] = 0.15,
            [DMG_SLOWBURN] = 0.15,
            [DMG_SHOCK] = 0.15,
        }
    },
    ["sandbag"] = {
        Name = "Sandbag",
        Description = "Cloth bags filled with detritus.\nImmune to small arms fire, but not to melee attacks and heat.",
        Multipliers = {
            [DMG_GENERIC] = 0.05,
            [DMG_SLASH] = 0.1,
            [DMG_CLUB] = 0.05,

            [DMG_BULLET] = 0,
            [DMG_BUCKSHOT] = 0,
            [DMG_AIRBOAT] = 0.15,
            -- [DMG_BLAST] = 1,
            -- [DMG_BLAST_SURFACE] = 1,

            [DMG_CRUSH] = 0.25,
            [DMG_VEHICLE] = 0.25,

            [DMG_BURN] = 0.15,
            [DMG_SLOWBURN] = 0.15,
            [DMG_SHOCK] = 0.15,
        }
    },
}

local traces = {
    {{0, 0, 0}, {1, 1, 1}},
    {{1, 0, 0}, {0, 1, 1}},
    {{0, 1, 0}, {1, 0, 1}},
    {{1, 1, 0}, {0, 0, 1}},
}

local ang_zero = Angle()
local clrbad, clrgood = Color(255, 0, 0), Color(255, 255, 255)
function RES.TraceBuildable(class, pos, ang, filter)
    local tbl = scripted_ents.Get(class)
    if not tbl then return end
    if not tbl.PlaceBoundsMin or not tbl.PlaceBoundsMax then return end

    if SERVER then debugoverlay.BoxAngles(pos, tbl.PlaceBoundsMin, tbl.PlaceBoundsMax, ang, 10, Color(0, 255, 255, 0)) end

    -- local min = LocalToWorld(tbl.PlaceBoundsMin, ang_zero, pos, ang)
    -- local max = LocalToWorld(tbl.PlaceBoundsMax, ang_zero, pos, ang)

    local x = {[0] = tbl.PlaceBoundsMin.x, [1] = tbl.PlaceBoundsMax.x}
    local y = {[0] = tbl.PlaceBoundsMin.y, [1] = tbl.PlaceBoundsMax.y}
    local z = {[0] = tbl.PlaceBoundsMin.z, [1] = tbl.PlaceBoundsMax.z}

    for i, v in ipairs(traces) do
        local min = LocalToWorld(Vector(x[v[1][1]], y[v[1][2]], z[v[1][3]]), ang_zero, pos, ang)
        local max = LocalToWorld(Vector(x[v[2][1]], y[v[2][2]], z[v[2][3]]), ang_zero, pos, ang)
        local tr = util.TraceLine({
            start = min,
            endpos = max,
            filter = filter,
            mask = MASK_SOLID,
        })
        if SERVER then debugoverlay.Line(tr.StartPos, tr.HitPos, i * 3, tr.Hit and clrbad or clrgood, true) end
        if tr.Hit then return false end
    end

    return true
end