SharedConfig = {}

SharedConfig["main"] = {
    -- // Server-Name
    serverName = "GRS-Reallife", --// Name + Gamemode (Roleplay, Reallife etc.)
    serverShort = "GRS",
    serverClantag = "[GRS]",
    -- // Server-Details
    maxPlayers = 100,
    version = "1.2b",
    
   -- // Event
    enableAutomaticEvents = true,
    hasOneEventRunning = false, -- // Immer auf false lassen
    events = {
      testEvent = {startDate = {16, 6}, endDate = {1, 9}, isRunning = false, eventName = "Test-Event" }, --// 16 steht für den Tag und 6 für den Monat (hier 16.6), zu aktivieren: isRunning = true
      halloween = {startDate = {1, 10}, endDate = {1, 11}, isRunning = false, eventName = "Halloween-Event" },
      chrismas =  {startDate = {1, 12}, endDate = {1, 1}, isRunning = false, eventName = "Weihnachts-Event" },
      easter =  {startDate = {1, 3}, endDate = {1, 4}, isRunning = false, eventName = "Oster-Event" },
    }
}

SharedConfig["intro"] = {
   introMusicURL = "",
   introLocation = {}
}

SharedConfig["network"] = {
    ip = "127.0.0.1",
    ts3 = "127.0.0.1",
    discordInviteURL = "https://discord.gg/RMKHHanaeq",
    websiteURL = "LINK",
    forumURL = "LINK",
    twitterURL = "LINK",
    facebookURL = "LINK",
    instagramURL = "LINK",
}

SharedConfig["costumFactions"] = {
   creationCost = 1000,
   nameshortMaxLengh = 5,
   nameshortMinLengh = 2,
   nameMaxLengh = 10,
   nameMinLengh = 4
}

SharedConfig["levelsystem"] = { 
   vipMultiplier = 2,
   globalMultiplier = 1,
   calculateBonus = function ( player, xp )
       local xp = (isPremium(player)) and (xp*SharedConfig["levelsystem"].vipMultiplier)*SharedConfig["levelsystem"].globalMultiplier or xp*SharedConfig["levelsystem"].globalMultiplier
       return xp 
   end,
   levels = {
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
   },
   maxLevel = 20
}

--[[
SharedConfig["factions"] = {
    [1] = {
       name = "Polizei",
       shortName = "LSPD",
       factionCategory = "good",
       locations = {
          ["San Fierro"] = {},
          ["Los Santos"] = {}
       },
       joinConditions = {
          level = 5,
          neededVIPPackage =  0
       }
    },
    [2] = {
       name = "Cosa Nostra",
       shortName = "Cosa Nostra",
       factionCategory = "evil",
       locations = {},
       joinConditions = {
          level = 0,
          neededVIPPackage = 0
       }
    },
    [3] = {
       name = "Triaden",
       shortName = "Triaden",
       factionCategory = "evil",
       locations = {},
       joinConditions = {
          level = 0,
          neededVIPPackage = 0
       }
    },
    [4] = {
       name = "Polizei",
       shortName = "Terror",
       factionCategory = "evil",
       locations = {},
       joinConditions = {
          level = 0,
          neededVIPPackage = 0
       }
    },
    [5] = {
       name = "Liberty Tree Reaction",
       shortName = "LTR",
       factionCategory = "neutral",
       locations = {},
       joinConditions = {}
    },
    [6] = {
       name = "Federal Bureau of Investigation",
       shortName = "FBI",
       factionCategory = "good",
       locations = {},
       joinConditions = {}
    },
    [7] = {
       name = "Los Aztecas",
       shortName = "Aztecas",
       factionCategory = "evil",
       locations = {},
       joinConditions = {}
    },
    [8] = {
       name = "Army",
       shortName = "Army",
       factionCategory = "good",
       locations = {},
       joinConditions = {}
    },
    [9] = {
       name = "Angels of Death",
       shortName = "AoD",
       factionCategory = "evil",
       locations = {},
       joinConditions = {}
    },
    [10] = {
       name = "Sanitäter",
       shortName = "Sanitäter",
       factionCategory = "neutral",
       locations = {},
       joinConditions = {}
    },
    [11] = {
       name = "Mechaniker",
       shortName = "Mechaniker",
       factionCategory = "neutral",
       locations = {},
       joinConditions = {}
    },
    [12] = {
       name = "Ballas",
       shortName = "Ballas",
       factionCategory = "evil",
       locations = {},
       joinConditions = {}
    },
    [13] = {
       name = "Grove",
       shortName = "Grove",
       factionCategory = "evil",
       locations = {},
       joinConditions = {}
    }
 }
 

 SharedConfig["factionsByName"] = {}

 for id, v in pairs(SharedConfig["factions"]) do
    SharedConfig["factionsByName"][v.name] = id
    print(SharedConfig["factionsByName"][v.name])
end
--]]


