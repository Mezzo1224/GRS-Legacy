local function removeHex (s)
    if type (s) == "string" then
        while (s ~= s:gsub ("#%x%x%x%x%x%x", "")) do
            s = s:gsub ("#%x%x%x%x%x%x", "")
        end
    end
    return s or false
end

ServerConfig = {}
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

function addShopDescription (rank)
    local description = ServerConfig["premium"]["ranks"][rank].shopConfig.description
    ServerConfig["premium"]["ranks"][rank].shopConfig.description = [[ Mit der Stufe ]]..removeHex (ServerConfig["premium"]["ranks"][rank].name)..[[ erhältst du folgende Boni:
- Sozialer-Status alle ]]..(ServerConfig["premium"]["ranks"][rank].changeSocial/86400)..[[ Tage änderbar
- Telefonnummer alle ]]..(ServerConfig["premium"]["ranks"][rank].changeNumber/86400)..[[ Tage änderbar
- Zivilzeit um ]]..ServerConfig["premium"]["ranks"][rank].civTimeReduction..[[% reduziert
- ]]..ServerConfig["premium"]["ranks"][rank].increasedPayday..[[% Prozent mehr Geld beim Payday
- Falls du das Maximal Level erreich hast, wird ein EP in ]]..ServerConfig["premium"]["ranks"][rank].xpToMoneyRate..[[$ umgewandelt
]]

    if ServerConfig["premium"]["ranks"][rank].freePremiumCar > 0 then
        ServerConfig["premium"]["ranks"][rank].shopConfig.description = ServerConfig["premium"]["ranks"][rank].shopConfig.description .. "- Alle "..(ServerConfig["premium"]["ranks"][rank].freePremiumCar/86400).." Tage ein gratis Fahrzeug-Token."

    end
end
addShopDescription (1)
addShopDescription (2)
addShopDescription (3)
addShopDescription (4)

ServerConfig["shop"] = {
    canSendPaysafecard = true,
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
            image = "gotPremiumVehToken/vehicle.png",
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


local function compare(a, b)
    return a.sortOrder < b.sortOrder
end
table.sort(ServerConfig["shop"].packages, compare)

function getPackages ()
    print("getPackages")
    for k, v in pairs( ServerConfig["shop"].packages ) do
        triggerClientEvent ( source, "addPackageToTab", source, k, v.name, v.label, v.price, v.image  )
    end 
end
addEvent ( "getPackages", true)
addEventHandler ( "getPackages", root,  getPackages)

function getVIPLevels ()
    for k, v in ipairs( ServerConfig["premium"]["ranks"] ) do
        if v.shopConfig ~= nil then
            triggerClientEvent ( source, "addVIPLevelToGrid", source, k, v.name, v.shopConfig.price.money, v.shopConfig.price.coins, v.shopConfig.description )
        end
    end 
end
addEvent ( "getVIPLevels", true)
addEventHandler ( "getVIPLevels", root,  getVIPLevels)

