
ServerConfig = {}

ServerConfig["mysql"] = {
    host = "89.58.19.163",
    user = "grs",
    password = "lollol12",
    database = "grs",
    port = "3306"
 }
 
ServerConfig["main"] = {
    -- // Fraktionen
    enableChangeFactionCMD = true,

    -- // Sonstiges
    enableBetasystem = true,
    enableAlternateDatabaseForBeta = true,
    allowInfinityAccounts = true,
    enableMapextensions = true,
    FPSLimit = setFPSLimit ( 60 ),
    startMoney = {bank = 500000, money = 100000},
    -- // Nicht ändern!
    compatibleDgsVersion = "3.521",
}

if ServerConfig["main"].enableBetasystem == true and ServerConfig["main"].enableAlternateDatabaseForBeta == true then
    ServerConfig["mysql"] = {
        host = "localhost",
        user = "root",
        password = "",
        database = "grs",
        port = "3306"
    }     
    print("Alternative Datanbank für den Betaserver aktiviert.")
end

-- // Updater - Erklärung
-- // "repository" - Überprüft die komplette GitHub Datei nach änderung d.h man bekommst nach jeder Änderung eine Nachricht, dass es ein Update gibt (Kurz: Bei jeder Änderung = Nachricht)
-- // "meta" - Bekommt eine Versions-Zahl aus der 'meta.xml' von 'reallife_server', sollte diese anders sein als die installierte, gibt es eine Nachricht, dass es ein Update gibt (Kurz: Bei erwähnenswerten Updates = Nachricht)
-- // false - schaltet den Updater aus
ServerConfig["updater"] = {
    versionsChecker = "meta",
    frequentUpdateReminder = false, --// Soll die Erinnerung, dass es ein Update gibt jede Stunde (true) oder nur bei jedem Gamemode-Start kommen (false)
    githubRespoLink = "https://api.github.com/repos/Mezzo1224/GRS-Legacy", 
    githubRawMeta = "https://raw.githubusercontent.com/Mezzo1224/GRS-Legacy/main/%5Bgrs%5D/reallife_server/meta.xml"
}

ServerConfig["admin"] = {
    hasPermissionsFromPrevRanks = true, -- // Sollte dieses Einstellung auf false sein, werden Vorherige Rechte nicht übernommen!
    enableSensetiveCMDs = false,
    aDutyModel = 16,
    -- Adminränge
    ["ranks"] = {
        [0] = {
            name = "User",
            hexColor = "",
            permissions = {},
            hasVIP = false,
        },
        [1] = {
            name = "Clanmember",
            hexColor = "#9A2EFE",
            permissions = {},
            hasVIP = false,
        },
        [2] = {
            name = "Ticketbeauftragter",
            hexColor = "#01DFD7",
            permissions = { 
                ["canKick"] = true,
                ["canTeleport"] = true,
                ["checkUser"] = true,
                ["respawnVehicles"] = true,
                ["canStartEngine"] = true,
                ["canTPinVehicle"] = true,
                ["canMute"] = true,
                ["canArrest"] = true,
                ["canUseSuppmode"] = true
            },
            hasVIP = false,
        },
        [3] = {
            name = "Supporter",
            hexColor = "#04B404",
            permissions = {
                ["canWarn"] = true,
                ["canTimeban"] = true,
            },
            hasVIP = false,
        },
        [4] = {
            name = "Moderator",
            hexColor = "#0000FF",
            permissions = {
                ["canChangePassword"] = true,
                ["canBan"] = true,
                ["canFactionBan"] = true,
                ["canFreeze"] = true,
                ["canSetLeader"] = true,
                ["canSkydrive"] = true,
            },
            hasVIP = false,
        },
        [5] = {
            name = "Administrator",
            hexColor = "#FF8000",
            permissions = {
                ["canSpawnAdminVeh"] = true,
                ["tuneCar"] = true,
                ["canUnban"] = true,
                ["canDeleteFactionBan"] = true,
            },
            hasVIP = true,
        },
        [6] = {
            name = "Administrator m.V.",
            hexColor = "#B40404",
            permissions = {
                ["canChangeNickname"] = true,
                ["canRestartServer"] = true,
                ["canSetRank"] = true,
                ["canTuneVehToMax"] = true,
                ["canChangeNumber"] = true,
                ["canChangeSocialState"] = true,
            },
            hasVIP = true,
        },
        [7] = {
            name = "Stellv. Projektleiter",
            hexColor = "#B40404",
            permissions = { ["isOwner"] = true },
            hasVIP = true,
        },
        [8] = {
            name = "Projektleiter",
            hexColor = "#B40404",
            permissions = { ["isOwner"] = true },
            hasVIP = true,
        },
    },
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


ServerConfig["bonuscodes"] = {
    ["grsfb"] = {onlyRegistration = true, redeemCode = function (player)
        local bankmoney = vioGetElementData ( player, "bankmoney" )
        vioSetElementData ( player, "bankmoney", bankmoney + 100000 )
        setPlayerPremium (player, "3d", 1, false)
    end},
    ["grsad"] =  {onlyRegistration = true, redeemCode = function (player)
        local bankmoney = vioGetElementData ( player, "bankmoney" )
        vioSetElementData ( player, "bankmoney", bankmoney + 100000 )
        setPlayerPremium (player, "3d", 1, false)
    end},
    ["grsbeta"] =  {onlyRegistration = true, redeemCode = function (player)
        local bankmoney = vioGetElementData ( player, "bankmoney" )
        vioSetElementData ( player, "bankmoney", bankmoney + 500000 )
        setPlayerPremium (player, "3d", 1, false)
    end}
}

ServerConfig["premium"] = {
    vehicleBlacklist = {
        [432] = true,
        [476] = true,
        [447] = true,
        [464] = true, 
        [425] = true
    },
    ["ranks"] = {
        [1] = {
            name = "#8A2908Bronze",
            changeSocial = (604800*4),
            changeNumber = (604800*4),
            freePremiumCar = 0, -- Höher als 0 = Ja
            civTimeReduction = 0,
            increasedPayday = 2,
            xpToMoneyRate = 4,
            shopConfig = {
                price = {money = 1000000, coins = 5},
                duration = "30d",
                description = [[ Du erähltst mit dieser Stufe folgende Boni:
                
                Sozialer-Status alle  ]] .. tostring(civTimeReduction) .. [[ änderbar.
                
                ]]
            }
        },
        [2] = {
            name = "#A4A4A4Silber",
            changeSocial = (604800*2),
            changeNumber = (604800*2),
            freePremiumCar = 0, -- Höher als 0 = Ja
            civTimeReduction = 2,
            increasedPayday = 5,
            xpToMoneyRate = 6,
            shopConfig = {
                price = {money = 0, coins = 5},
                duration = "30d",
                description = "[[ Du ]]"
            }
        },
        [3] = {
            name = "#AEB404Gold",
            changeSocial = (604800*4),
            changeNumber = (604800*4),
            freePremiumCar = 0, -- Höher als 0 = Ja
            civTimeReduction = 5,
            increasedPayday = 10,
            xpToMoneyRate = 4,
            shopConfig = {
                price = {money = 0, coins = 5},
                duration = "30d",
                description = "[[ Du ]]"
            }
        },
        [4] = {
            name = "#D8D8D8Platin",
            changeSocial = (604800*4),
            changeNumber = (604800*4),
            freePremiumCar = 604800, -- Höher als 0 = Ja
            civTimeReduction = 7,
            increasedPayday = 16,
            xpToMoneyRate = 2,
            shopConfig = {
                price = {money = 0, coins = 5},
                duration = "30d",
                description = "[[ Du ]]"
            }
        },
        [5] = {
            name = "#848484Titan",
            changeSocial = (604800*4),
            changeNumber = (604800*4),
            freePremiumCar = 604800/2, -- Höher als 0 = Ja
            civTimeReduction = 10,
            increasedPayday = 20,
            xpToMoneyRate = 1,
            shopConfig = nil
        }
    }
}

ServerConfig["shop"] = {
    canSendPaysafecard = true,
    defaultPackageImage = "images/self/shop/placeholder.png",
    packages = {
        -- Hier werden Item Pakete hinzugefügt
        [1] = {
            name = "Fahrzeug-Token",
            label = "Unikate!",
            description = [[]],
            image = nil,
            price = 3,
            sortOrder = 1,
            onBuy = function ( target ) 
                print(target, "hat es gekauft")
            end,
        },
        [2] = {
            name = "Starter-Paket",
            label = "Starhilfe gefällig?",
            description = [[]],
            image = "images/self/shop/placeholder.png",
            price = 15,
            sortOrder = 1,
            onBuy = function ( target ) 
                print(target, "hat es gekauft")
            end,
        },
        [3] = {
            name = "Test-Paket",
            label = "TEST3",
            description = [[]],
            image = nil,
            price = 20,
            sortOrder = 1,
            onBuy = function ( target ) 
                print(target, "hat es gekauft")
            end,
        },
        [4] = {
            name = "Test-Paket",
            label = "TEST 4",
            description = [[]],
            image = nil,
            price = 20,
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

