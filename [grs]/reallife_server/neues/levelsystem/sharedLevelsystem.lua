levelTable = { -- Momentanes Level (im Kopf immer +1 rechnen), XP
    [0] = 100,
    [1] = 150, 
    [2] = 250,
    [3] = 300,
    [4] = 350,
    [5] = 500,
    [6] = 550,
    [7] = 700,
    [8] = 850,
    [9] = 900,
    [10] = 1000,
    [11] = 1050,
    [12] = 1100,
    [13] = 1150,
    [14] = 1200,
    [15] = 1250,
    [16] = 1300,
    [17] = 1400,
    [18] = 1450,
    [19] = 1500,
    [20] = 2000
}
maxLevel = #levelTable

function calculateLevelProgress ( player )
    local xp =  tonumber(getElementData ( player, "MainXP"))
    local level = tonumber(getElementData ( player, "MainLevel"))
    local nextLevelXP = levelTable[level]
    local progress = (xp/nextLevelXP)
    if maxLevel == level or progress > 1 then
        progress = 1
    end
    return (progress)
end

function getPlayerLevel (player)
    local level = tonumber(getElementData ( player, "MainLevel"))
    return level
end

function getPlayerXP (player)
    local xp =  tonumber(getElementData ( player, "MainXP"))
    return xp
end