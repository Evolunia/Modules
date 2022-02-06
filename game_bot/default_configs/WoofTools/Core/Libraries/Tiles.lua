--------------------------------------------------------------------------------
Libraries.Tiles = {}
--------------------------------------------------------------------------------
-- Tiles Library
--------------------------------------------------------------------------------
-- function to search if item of given ID can be found on certain tile
-- first argument is always ID
-- the rest of aguments can be:
-- - tile
-- - position
-- - or x,y,z coordinates as p1, p2 and p3
-- returns boolean
Libraries.Tiles.isOnTile = function(id, p1, p2, p3)
    if not id then return end
    local tile
    if type(p1) == "table" then
        tile = g_map.getTile(p1)
    elseif type(p1) ~= "number" then
        tile = p1
    else
        local p = getPos(p1, p2, p3)
        tile = g_map.getTile(p)
    end
    if not tile then return end

    local item = false
    if #tile:getItems() ~= 0 then
        for i, v in ipairs(tile:getItems()) do
            if v:getId() == id then item = true end
        end
    else
        return false
    end

    return item
end
--------------------------------------------------------------------------------
-- position is a special table, impossible to compare with normal one
-- this is translator from x,y,z to proper position value
-- returns position table
Libraries.Tiles.getPos = function(x, y, z)
    if not x or not y or not z then return nil end
    local pos = pos()
    pos.x = x
    pos.y = y
    pos.z = z

    return pos
end
--------------------------------------------------------------------------------
-- Landmark Tiles (Format: Y, X, Z)
Libraries.Tiles.Landmarks = {
  ["Temple"] = { ["y"] = 1042, ["x"] = 1032, ["z"] = 7 },
  ["Teleport Room"] = { ["y"] = 985, ["x"] = 1168, ["z"] = 7 },
  ["Depot"] = { ["y"] = 1042, ["x"] = 1050, ["z"] = 7 },
  ["Dungeon Room"] = { ["y"] = 825, ["x"] = 1166, ["z"] = 7 },
  ["Shops"] = { ["y"] = 1032, ["x"] = 1026, ["z"] = 7 },
  ["Quest Room One"] = { ["y"] = 1156, ["x"] = 985, ["z"] = 7 },
  ["Magical Forest Dungeon One"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 1 },
  ["Magical Forest Dungeon Two"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 2 },
  ["Magical Forest Dungeon Three"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 3 },
  ["Magical Forest Dungeon Four"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 4 },
  ["Magical Forest Dungeon Five"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 5 },
  ["Magical Forest Dungeon Six"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 6 },
  ["Magical Forest Dungeon Seven"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 7 },
  ["Magical Forest Dungeon Eight"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 8 },
  ["Magical Forest Dungeon Nine"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 9 },
  ["Magical Forest Dungeon Ten"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 10 },
  ["Magical Forest Dungeon Eleven"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 11 },
  ["Magical Forest Dungeon Twelve"] = { ["y"] = 2442, ["x"] = 1408, ["z"] = 12 },
  ["Desert Dungeon One"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 1 },
  ["Desert Dungeon Two"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 2 },
  ["Desert Dungeon Three"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 3 },
  ["Desert Dungeon Four"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 4 },
  ["Desert Dungeon Five"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 5 },
  ["Desert Dungeon Six"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 6 },
  ["Desert Dungeon Seven"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 7 },
  ["Desert Dungeon Eight"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 8 },
  ["Desert Dungeon Nine"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 9 },
  ["Desert Dungeon Ten"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 10 },
  ["Desert Dungeon Eleven"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 11 },
  ["Desert Dungeon Twelve"] = { ["y"] = 2526, ["x"] = 1551, ["z"] = 12 },
  ["Undead Dungeon One"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 1 },
  ["Undead Dungeon Two"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 2 },
  ["Undead Dungeon Three"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 3 },
  ["Undead Dungeon Four"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 4 },
  ["Undead Dungeon Five"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 5 },
  ["Undead Dungeon Six"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 6 },
  ["Undead Dungeon Seven"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 7 },
  ["Undead Dungeon Eight"] ={ ["y"] = 1628, ["x"] = 2480, ["z"] = 8 },
  ["Undead Dungeon Nine"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 9 },
  ["Undead Dungeon Ten"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 10 },
  ["Undead Dungeon Eleven"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 11 },
  ["Undead Dungeon Twelve"] = { ["y"] = 1628, ["x"] = 2480, ["z"] = 12 },
  ["Toxic Dungeon One"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 1 },
  ["Toxic Dungeon Two"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 2 },
  ["Toxic Dungeon Three"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 3 },
  ["Toxic Dungeon Four"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 4 },
  ["Toxic Dungeon Five"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 5 },
  ["Toxic Dungeon Six"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 6 },
  ["Toxic Dungeon Seven"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 7 },
  ["Toxic Dungeon Eight"] ={ ["y"] = 1454, ["x"] = 2611, ["z"] = 8 },
  ["Toxic Dungeon Nine"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 9 },
  ["Toxic Dungeon Ten"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 10 },
  ["Toxic Dungeon Eleven"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 11 },
  ["Toxic Dungeon Twelve"] = { ["y"] = 1454, ["x"] = 2611, ["z"] = 12 },
  ["Winter Dungeon One"] = { ["y"] = 0, ["x"] = 0, ["z"] = 1 },
  ["Winter Dungeon Two"] = { ["y"] = 0, ["x"] = 0, ["z"] = 2 },
  ["Winter Dungeon Three"] = { ["y"] = 0, ["x"] = 0, ["z"] = 3 },
  ["Winter Dungeon Four"] = { ["y"] = 0, ["x"] = 0, ["z"] = 4 },
  ["Winter Dungeon Five"] = { ["y"] = 0, ["x"] = 0, ["z"] = 5 },
  ["Winter Dungeon Six"] = { ["y"] = 0, ["x"] = 0, ["z"] = 6 },
  ["Winter Dungeon Seven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 7 },
  ["Winter Dungeon Eight"] ={ ["y"] = 0, ["x"] = 0, ["z"] = 8 },
  ["Winter Dungeon Nine"] = { ["y"] = 0, ["x"] = 0, ["z"] = 9 },
  ["Winter Dungeon Ten"] = { ["y"] = 0, ["x"] = 0, ["z"] = 10 },
  ["Winter Dungeon Eleven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 11 },
  ["Winter Dungeon Twelve"] = { ["y"] = 0, ["x"] = 0, ["z"] = 12 },
  ["Demonic Dungeon One"] = { ["y"] = 0, ["x"] = 0, ["z"] = 1 },
  ["Demonic Dungeon Two"] = { ["y"] = 0, ["x"] = 0, ["z"] = 2 },
  ["Demonic Dungeon Three"] = { ["y"] = 0, ["x"] = 0, ["z"] = 3 },
  ["Demonic Dungeon Four"] = { ["y"] = 0, ["x"] = 0, ["z"] = 4 },
  ["Demonic Dungeon Five"] = { ["y"] = 0, ["x"] = 0, ["z"] = 5 },
  ["Demonic Dungeon Six"] = { ["y"] = 0, ["x"] = 0, ["z"] = 6 },
  ["Demonic Dungeon Seven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 7 },
  ["Demonic Dungeon Eight"] ={ ["y"] = 0, ["x"] = 0, ["z"] = 8 },
  ["Demonic Dungeon Nine"] = { ["y"] = 0, ["x"] = 0, ["z"] = 9 },
  ["Demonic Dungeon Ten"] = { ["y"] = 0, ["x"] = 0, ["z"] = 10 },
  ["Demonic Dungeon Eleven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 11 },
  ["Demonic Dungeon Twelve"] = { ["y"] = 0, ["x"] = 0, ["z"] = 12 },
  ["Blood Dungeon One"] = { ["y"] = 0, ["x"] = 0, ["z"] = 1 },
  ["Blood Dungeon Two"] = { ["y"] = 0, ["x"] = 0, ["z"] = 2 },
  ["Blood Dungeon Three"] = { ["y"] = 0, ["x"] = 0, ["z"] = 3 },
  ["Blood Dungeon Four"] = { ["y"] = 0, ["x"] = 0, ["z"] = 4 },
  ["Blood Dungeon Five"] = { ["y"] = 0, ["x"] = 0, ["z"] = 5 },
  ["Blood Dungeon Six"] = { ["y"] = 0, ["x"] = 0, ["z"] = 6 },
  ["Blood Dungeon Seven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 7 },
  ["Blood Dungeon Eight"] ={ ["y"] = 0, ["x"] = 0, ["z"] = 8 },
  ["Blood Dungeon Nine"] = { ["y"] = 0, ["x"] = 0, ["z"] = 9 },
  ["Blood Dungeon Ten"] = { ["y"] = 0, ["x"] = 0, ["z"] = 10 },
  ["Blood Dungeon Eleven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 11 },
  ["Blood Dungeon Twelve"] = { ["y"] = 0, ["x"] = 0, ["z"] = 12 },
  ["Wasteland Dungeon One"] = { ["y"] = 0, ["x"] = 0, ["z"] = 1 },
  ["Wasteland Dungeon Two"] = { ["y"] = 0, ["x"] = 0, ["z"] = 2 },
  ["Wasteland Dungeon Three"] = { ["y"] = 0, ["x"] = 0, ["z"] = 3 },
  ["Wasteland Dungeon Four"] = { ["y"] = 0, ["x"] = 0, ["z"] = 4 },
  ["Wasteland Dungeon Five"] = { ["y"] = 0, ["x"] = 0, ["z"] = 5 },
  ["Wasteland Dungeon Six"] = { ["y"] = 0, ["x"] = 0, ["z"] = 6 },
  ["Wasteland Dungeon Seven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 7 },
  ["Wasteland Dungeon Eight"] ={ ["y"] = 0, ["x"] = 0, ["z"] = 8 },
  ["Wasteland Dungeon Nine"] = { ["y"] = 0, ["x"] = 0, ["z"] = 9 },
  ["Wasteland Dungeon Ten"] = { ["y"] = 0, ["x"] = 0, ["z"] = 10 },
  ["Wasteland Dungeon Eleven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 11 },
  ["Wasteland Dungeon Twelve"] = { ["y"] = 0, ["x"] = 0, ["z"] = 12 },
  ["Aquatic Dungeon One"] = { ["y"] = 0, ["x"] = 0, ["z"] = 1 },
  ["Aquatic Dungeon Two"] = { ["y"] = 0, ["x"] = 0, ["z"] = 2 },
  ["Aquatic Dungeon Three"] = { ["y"] = 0, ["x"] = 0, ["z"] = 3 },
  ["Aquatic Dungeon Four"] = { ["y"] = 0, ["x"] = 0, ["z"] = 4 },
  ["Aquatic Dungeon Five"] = { ["y"] = 0, ["x"] = 0, ["z"] = 5 },
  ["Aquatic Dungeon Six"] = { ["y"] = 0, ["x"] = 0, ["z"] = 6 },
  ["Aquatic Dungeon Seven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 7 },
  ["Aquatic Dungeon Eight"] ={ ["y"] = 0, ["x"] = 0, ["z"] = 8 },
  ["Aquatic Dungeon Nine"] = { ["y"] = 0, ["x"] = 0, ["z"] = 9 },
  ["Aquatic Dungeon Ten"] = { ["y"] = 0, ["x"] = 0, ["z"] = 10 },
  ["Aquatic Dungeon Eleven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 11 },
  ["Aquatic Dungeon Twelve"] = { ["y"] = 0, ["x"] = 0, ["z"] = 12 },
  ["Void Dungeon One"] = { ["y"] = 0, ["x"] = 0, ["z"] = 1 },
  ["Void Dungeon Two"] = { ["y"] = 0, ["x"] = 0, ["z"] = 2 },
  ["Void Dungeon Three"] = { ["y"] = 0, ["x"] = 0, ["z"] = 3 },
  ["Void Dungeon Four"] = { ["y"] = 0, ["x"] = 0, ["z"] = 4 },
  ["Void Dungeon Five"] = { ["y"] = 0, ["x"] = 0, ["z"] = 5 },
  ["Void Dungeon Six"] = { ["y"] = 0, ["x"] = 0, ["z"] = 6 },
  ["Void Dungeon Seven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 7 },
  ["Void Dungeon Eight"] ={ ["y"] = 0, ["x"] = 0, ["z"] = 8 },
  ["Void Dungeon Nine"] = { ["y"] = 0, ["x"] = 0, ["z"] = 9 },
  ["Void Dungeon Ten"] = { ["y"] = 0, ["x"] = 0, ["z"] = 10 },
  ["Void Dungeon Eleven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 11 },
  ["Void Dungeon Twelve"] = { ["y"] = 0, ["x"] = 0, ["z"] = 12 },
  ["Ruins Dungeon One"] = { ["y"] = 0, ["x"] = 0, ["z"] = 1 },
  ["Ruins Dungeon Two"] = { ["y"] = 0, ["x"] = 0, ["z"] = 2 },
  ["Ruins Dungeon Three"] = { ["y"] = 0, ["x"] = 0, ["z"] = 3 },
  ["Ruins Dungeon Four"] = { ["y"] = 0, ["x"] = 0, ["z"] = 4 },
  ["Ruins Dungeon Five"] = { ["y"] = 0, ["x"] = 0, ["z"] = 5 },
  ["Ruins Dungeon Six"] = { ["y"] = 0, ["x"] = 0, ["z"] = 6 },
  ["Ruins Dungeon Seven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 7 },
  ["Ruins Dungeon Eight"] ={ ["y"] = 0, ["x"] = 0, ["z"] = 8 },
  ["Ruins Dungeon Nine"] = { ["y"] = 0, ["x"] = 0, ["z"] = 9 },
  ["Ruins Dungeon Ten"] = { ["y"] = 0, ["x"] = 0, ["z"] = 10 },
  ["Ruins Dungeon Eleven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 11 },
  ["Ruins Dungeon Twelve"] = { ["y"] = 0, ["x"] = 0, ["z"] = 12 },
  ["Crystal Caverns Dungeon One"] = { ["y"] = 0, ["x"] = 0, ["z"] = 1 },
  ["Crystal Caverns Dungeon Two"] = { ["y"] = 0, ["x"] = 0, ["z"] = 2 },
  ["Crystal Caverns Dungeon Three"] = { ["y"] = 0, ["x"] = 0, ["z"] = 3 },
  ["Crystal Caverns Dungeon Four"] = { ["y"] = 0, ["x"] = 0, ["z"] = 4 },
  ["Crystal Caverns Dungeon Five"] = { ["y"] = 0, ["x"] = 0, ["z"] = 5 },
  ["Crystal Caverns Dungeon Six"] = { ["y"] = 0, ["x"] = 0, ["z"] = 6 },
  ["Crystal Caverns Dungeon Seven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 7 },
  ["Crystal Caverns Dungeon Eight"] ={ ["y"] = 0, ["x"] = 0, ["z"] = 8 },
  ["Crystal Caverns Dungeon Nine"] = { ["y"] = 0, ["x"] = 0, ["z"] = 9 },
  ["Crystal Caverns Dungeon Ten"] = { ["y"] = 0, ["x"] = 0, ["z"] = 10 },
  ["Crystal Caverns Dungeon Eleven"] = { ["y"] = 0, ["x"] = 0, ["z"] = 11 },
  ["Crystal Caverns Dungeon Twelve"] = { ["y"] = 0, ["x"] = 0, ["z"] = 12 },
}
--------------------------------------------------------------------------------
-- Portal Tiles (Format: Y, X, Z)
Libraries.Tiles.Portals = {
  ["Teleports Portal"] = { ["y"] = 1038, ["x"] = 1034, ["z"] = 7 },
  ["Trainers Portal"] = { ["y"] = 1037, ["x"] = 1034, ["z"] = 7 },
  ["Depot Portal"] = { ["y"] = 1036, ["x"] = 1034, ["z"] = 7 },
  ["Quests Portal"] = { ["y"] = 1030, ["x"] = 1036, ["z"] = 7 },
  ["Shops Portal"] = { ["y"] = 1030, ["x"] = 1038, ["z"] = 7 },
}
