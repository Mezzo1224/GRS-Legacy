-- TODO Fertigstellen
sharedFactionConfig = {}
sharedFactionConfig["factions"] = {}


-- // Fraktionseinstellungen
sharedFactionConfig["factionMain"] = {
    isEvil = {[2] = true, [3] = true, [4] = true, [7] = true, [9] = true, [12] = true, [13] = true},
    isGood = {[1] = true, [6] = true, [8] = true},
    isNeural = {[5] = true, [10] = true, [11] = true},
    leaveFactionBanTime = 86400, -- // 0 = deaktiviert
}


-- // SFPD
sharedFactionConfig["factions"][1] = {
        name = "Los Santos Police Department",
        nameShortcut = "LSPD",
        color = {125, 125, 125},
        spawnLocations = {
            ["SFPD"] = {228.71, 126.83 , 1009.85, 180, 10, 0},
            ["LSPD"] = {0, 0, 0, 0, 0, 0},
            ["LVPD"] = {0, 0, 0, 0, 0, 0}
        },
        vehicleAreas = {
            ["SFPD"] =  createColPolygon ( -1624.466796875, 682.2216796875, -1641.109375, 646.44921875, -1618.08203125, 754.626953125, -1568.4228515625, 755.978515625, -1567.8857421875, 688.97265625, -1619.103515625, 647.8828125, -1644.515625, 647.8818359375, -1645.0771484375, 698.05859375,-1572.3212890625, 646.5419921875 ),
        },
        joinRequirments = {
            level = 3,
            prestigeLevel = 0,
            vipLevel = 0,
            costumCheck = function ( player )
                return true
            end,
        },
}


-- Gänige Permissions für Ränge:
-- canInvite, canSetRank, canUninvite
sharedFactionConfig["factionRanks"] = {
    [1] = {  
        [0] = {
            name = "Rang 0",
        },
        [1] = {
            name = "Rang 1",
        },
        [2] = {
            name = "Rang 2",
        },
        [3] = {
            name = "Rang 3",
        },
        [4] = {
            name = "Second Chief",
            canInvite = true,
            canSetRank = true, 
        },
        [5] = {
            name = "Chief",
            isLeader = true,
            
        }
    }
}

sharedFactionConfig["factionsByName"] = {}

--[[
setTimer ( function()
    for k, v in pairs(sharedFactionConfig["factions"]) do
        print ( toJSON ( v, false, "tabs" ) )
    end
end, 3000, 1 )--]]