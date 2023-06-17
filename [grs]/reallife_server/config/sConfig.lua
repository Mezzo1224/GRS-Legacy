
ServerConfig = {}

ServerConfig["main"] = {
    -- // Fraktionen
    enableChangeFactionCMD = true,

    -- // Sonstiges
    debugServerConfig = true,
    enableBetasystem = true,
    VIPXPBoost = 2, 
    globalXPBoost = 1, 
    calculateBonus = function ( player, xp )
        local xp = (isPremium(player)) and (xp*ServerConfig["main"].VIPXPBoost)*ServerConfig["main"].globalXPBoost or xp*ServerConfig["main"].globalXPBoostglobalXPBoost
        return xp -- // nicht entfernen!
    end,
    -- // Nicht ändern!
    compatibleDgsVersion = "3.511",
}


ServerConfig["bonuscodes"] = {
    ["grsfb"] = {onlyRegistration = true, redeemCode = function (player)
        -- // Geld
          print("Code GRSFB")
    end},
    ["grsad"] =  {onlyRegistration = true, redeemCode = function (player)
        -- // Premium
        print("Code GRSAD")
    end}
}

-- // Testing
function giveBonuscodeReward (target, code, isRegistration)
    if ServerConfig["bonuscodes"][code] then
        if ServerConfig["bonuscodes"][code].onlyRegistration == true and isRegistration == true then
            print ( code, "Code gibt es",  ServerConfig["bonuscodes"][code].onlyRegistration )
            ServerConfig["bonuscodes"][code].redeemCode(target)
        else
            print ( "Code nur gültig für die Registration.")
        end
    else
        print ( "Code gibt es nicht")
    end
end


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


if ServerConfig["main"].debugServerConfig == true then
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

