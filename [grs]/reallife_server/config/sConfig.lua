
ServerConfig = {}

ServerConfig["mysql"] = {
    host = "localhost",
    user = "root",
    password = "",
    database = "grs",
    port = "3306"
 }
 
ServerConfig["main"] = {
    -- // Fraktionen
    enableChangeFactionCMD = true,

    -- // Sonstiges
    enableBetasystem = true,
    startMoney = {bank = 500000, money = 100000},
    -- // Nicht ändern!
    compatibleDgsVersion = "3.511",
}




ServerConfig["debugging"] = {
    debugServerConfig = false,
    debugSqlStats = {
        sqlConnection = false,
        carhouse =  false,
        cars =  false,
        mails = false,
        prestige =  false,
        highscores =    false,
        objects =   false,
        warns = false,
    }
}
ServerConfig["PremiumRanks"] = {
    [1] = {
        name = "#8A2908Bronze",
        changeSocial = (604800*4),
        changeNumber = (604800*4),
        freePremiumCar = 0, -- Höher als 0 = Ja
        civTimeReduction = 0,
        increasedPayday = 2,
        xpToMoneyRate = 4
    },
    [2] = {
        name = "#A4A4A4Silber",
        changeSocial = (604800*2),
        changeNumber = (604800*2),
        freePremiumCar = 0, -- Höher als 0 = Ja
        civTimeReduction = 2,
        increasedPayday = 5,
        xpToMoneyRate = 6
    },
    [3] = {
        name = "#AEB404Gold",
        changeSocial = (604800*4),
        changeNumber = (604800*4),
        freePremiumCar = 0, -- Höher als 0 = Ja
        civTimeReduction = 5,
        increasedPayday = 10,
        xpToMoneyRate = 4
    },
    [4] = {
        name = "#D8D8D8Platin",
        changeSocial = (604800*4),
        changeNumber = (604800*4),
        freePremiumCar = 604800, -- Höher als 0 = Ja
        civTimeReduction = 7,
        increasedPayday = 16,
        xpToMoneyRate = 2
    },
    [5] = {
        name = "#848484Titan",
        changeSocial = (604800*4),
        changeNumber = (604800*4),
        freePremiumCar = 604800/2, -- Höher als 0 = Ja
        civTimeReduction = 10,
        increasedPayday = 20,
        xpToMoneyRate = 1
    }
}


ServerConfig["bonuscodes"] = {
    ["grsfb"] = {onlyRegistration = true, redeemCode = function (player)
        local bankmoney = vioGetElementData ( player, "bankmoney" )
        vioSetElementData ( player, "bankmoney", bankmoney + 100000 )
        setPremiumData (player, 3,1)
    end},
    ["grsad"] =  {onlyRegistration = true, redeemCode = function (player)
        local bankmoney = vioGetElementData ( player, "bankmoney" )
        vioSetElementData ( player, "bankmoney", bankmoney + 100000 )
        setPremiumData (player, 3,1)
    end},
    ["grsbeta"] =  {onlyRegistration = true, redeemCode = function (player)
        local bankmoney = vioGetElementData ( player, "bankmoney" )
        vioSetElementData ( player, "bankmoney", bankmoney + 500000 )
        setPremiumData (player, 28, 4)
    end}
}



ServerConfig["shop"] = {
    canSendPaysafecard = true,
    packages = {
        -- Hier werden Item Pakete hinzugefügt
        ["VIP-Paket (7 Tage)"] = {
            creditCosts = 0,
            moneyCosts = 500000,
            imagePath = "",
            description = [[Test]],
            isVIPIncluded = true,
            category = "VIP-Pakete",
            sortOrder = 3,
            onBuy = function ( target ) 
                print(target, "hat es gekauft")
            end,
        },
        ["VIP-Paket (30 Tage)"] = {
            creditCosts = 10,
            moneyCosts = 0,
            imagePath = "",
            description = [[Test]],
            isVIPIncluded = true,
            category = "VIP-Pakete",
            sortOrder = 2,
            onBuy = function ( target ) 
                print(target, "hat es gekauft")
            end,
        },
        ["VIP-Paket (90 Tage)"] = {
            creditCosts = 20,
            moneyCosts = 0,
            imagePath = "",
            description = "Du erhältest VIP für 90 Tage",
            isVIPIncluded = true,
            category = "VIP-Pakete",
            sortOrder = 1,
            onBuy = function ( target ) 
                print(target, "hat es gekauft")
            end,
        }
    }
}

-- // Tabellen nach "sortOrder" sortieren
local function compare(a, b)
  return a.sortOrder < b.sortOrder
end

table.sort(ServerConfig["shop"].packages, compare)

ServerConfig["forum"] = { 
    enableForumsynchronization = false,

    VIPID = 13, 
    teamID = 12, -- ID der Teammitglieder Gruppe"
    betaGroupe = 14,
    adminForumRank = { -- Adminlevel, Gruppenid im Forum
        [8] = 4, 
        [7] = 5,
        [6] = 6,
        [5] = 7,
        [4] = 8,
        [3] = 9,
        [2] = 10,
        [1] = 11
    },
    adminForumView = { -- Aussehen bzw. Benutzerrang (unnötig)
        [8] = 1, 
        [7] = 9, 
        [6] = 10, 
        [5] = 11, 
        [4] = 12, 
        [3] = 13, 
        [2] = 14, 
        [1] = 15
    },
}


if ServerConfig["debugging"].debugServerConfig == true then
    setTimer ( function()
        for k, v in pairs(ServerConfig) do
            print("--- Server-Config-Tabelle "..k.." ---")
            if type(v) == "table" then
                print ( toJSON ( v, false, "tabs" ) )
            else
                print ( v )
            end
        end
        if  SharedConfig["main"].enableAutomaticEvents == true then
            enableEventsAutomatically ()
        end
    end, 3000, 1 )
end

