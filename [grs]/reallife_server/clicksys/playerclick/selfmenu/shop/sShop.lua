
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


local function compare(a, b)
    return a.sortOrder < b.sortOrder
end
table.sort(ServerConfig["shop"].packages, compare)

function getPackages ()
    print("getPackages")
    for k, v in pairs( ServerConfig["shop"].packages ) do
        local image = v.image ~= nil and v.image or ServerConfig["shop"].defaultPackageImage
        print(image.." Bild")
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

function addHistoryEntry (player, item, price, currency)
    local pName = getPlayerName(player)
	dbExec ( handler,"INSERT INTO  shop_history (UID, item, price, currency) VALUES (?,?,?, ?)", playerUID[pName], item, price, currency )
end

function getShopHistory ()
    local uid = playerUID[getPlayerName(source)]
    local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ?? WHERE ??=? ORDER BY `date` DESC", "shop_history", "UID", uid  ), -1 )
    for i=1, #result do
        local currency = (tonumber ( result[i]["currency"]) == 1) and "Geld" or "Coins"
        data = {
            item = tostring ( result[i]["item"]),
            price = tostring ( result[i]["price"]),
            currency = currency,
            date = tostring ( result[i]["date"])
        }
        triggerClientEvent ( source, "addHistoryEntry", source, data )
    end

    -- // VIP Stufe senden
    local vipData = getPremiumData ()
    if vipData.hasPremium == true then
        vipText = "VIP-Stufe: "..vipData.packageName.." bis "..vipData.premTimeAsText
    else
        vipText = "VIP-Stufe: Nicht aktiv."
    end
    triggerClientEvent ( source, "refreshShopPremiumInfo", source, vipText )
end
addEvent ( "getShopHistory", true)
addEventHandler ( "getShopHistory", root,  getShopHistory)


function buyVIPLevel (player, vipLevel, buyWith )
    if player == player then
        if ServerConfig["premium"]["ranks"][vipLevel].shopConfig then
            local vipLevelConfig = ServerConfig["premium"]["ranks"][vipLevel].shopConfig
          
            if (buyWith == "coins" and vipLevelConfig.price.coins > 0) or (buyWith == "money" and vipLevelConfig.price.money > 0) then
                local coins, money = tonumber( vioGetElementData ( player, "coins") ),  tonumber(vioGetElementData(player, "bankmoney"))
                if  isPremium(player) then
                    
                    -- // Genug Geld/Coins ?
                    if buyWith == "coins" then
                        cost = vipLevelConfig.price.coins
                        if coins < cost then
                            infobox (player, "Du hast nicht genug Coins.", "error", 15)
                            return false
                        else
                            vioSetElementData ( player, "coins", coins - cost )
                        end
                    else
                        cost = vipLevelConfig.price.money
                        if money < cost then
                            infobox (player, "Du hast nicht genug Geld.", "error", 15)
                            return false
                        else
                            vioSetElementData ( player, "bankmoney", money - coins )
                        end
                    end
                    -- // Geben
                    setPlayerPremium (player, vipLevelConfig.duration, vipLevel, false)
                    local currencyNumber = (buyWith == "Coins") and 0 or 1
                    addHistoryEntry (player, "VIP-Level "..removeHex (ServerConfig["premium"]["ranks"][vipLevel].name), cost, currencyNumber)

                else
                    print("Hast VIP schon")
                end
            else
                print("Ungültige währung")
            end
        else
            print("VIP ERROR")
        end
    else
        print("Manipulation")
    end
end
addEvent ( "buyVIPLevel", true)
addEventHandler ( "buyVIPLevel", root,  buyVIPLevel)

function testbv (player)
   -- buyVIPLevel (player, 1, "money")
end
addCommandHandler("tbv", testbv)