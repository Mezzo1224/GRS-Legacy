paysafecard = {}

shopPackage = {}

-- Beispiel
shopPackage[1] = {          -- Definiert das Paket, den namen, den Coinpreis ,die Tabelle elementDatas und die Tabelle addElementDatas, die beim addieren benutzt wird
    name = "Premium Paket I",        -- d.h für z.B Geld oder Premiumcars
    price = 15,
    desc = "Erhalte folgendes\n-Premium Stufe Silber (60 Tage)\n-2 Premiumfahrzeuge\n\nErfahre mehr über Silber mit /phelp 2",
    elementDatas = {},
    addElementDatas = {},
    expire = 60 -- // Die Länge des ggf. enthaltenen Ranges, für eine Automatische verlängerung

}
shopPackage[1].addElementDatas["PremiumCars"] = 2  -- //  addElementData: Es wird etwas hinzugefügt
shopPackage[1].elementDatas["premium"] = true  --// elementDatas: Es wird etwas gesetzt
shopPackage[1].elementDatas["PremiumData"] = 60
shopPackage[1].elementDatas["Paket"] = 2


shopPackage[2] = {          
    name = "Premium Paket II",        
    price = 20,
    desc = "Erhalte folgendes\n-Premium Stufe Gold (60 Tage)\n-3 Premiumfahrzeuge\n\nErfahre mehr über Gold mit /phelp 3",
    elementDatas = {},
    addElementDatas = {},
    expire = 60
}
shopPackage[2].addElementDatas["PremiumCars"] = 3
shopPackage[2].elementDatas["premium"] = true  
shopPackage[2].elementDatas["PremiumData"] = 60
shopPackage[2].elementDatas["Paket"] = 3


shopPackage[3] = {          
    name = "Premium Paket III",       
    price = 30,
    desc = "Erhalte folgendes:\n-Premium Stufe Platin (45 Tage)\n-5 Premiumfahrzeuge\n\nErfahre mehr über Platin mit /phelp 4",
    elementDatas = {},
    addElementDatas = {},
    expire = 45

}
shopPackage[3].addElementDatas["PremiumCars"] = 5 
shopPackage[3].elementDatas["premium"] = true 
shopPackage[3].elementDatas["PremiumData"] = 45
shopPackage[3].elementDatas["Paket"] = 4


shopPackage[4] = {          
    name = "Wie der Zufall es will",       
    price = 25,
    desc = "Erhalte eine Premium Stufe von Bronze bis Platin (30 Tage)\nAußerdem erzähltst du 1-3 Premiumfahrzeuge\n\nErfahre mehr über alle Stufen mit /phelp [1-4]",
    elementDatas = {},
    addElementDatas = {},
    expire = 30
}

shopPackage[5] = {          
    name = "Premiumfahrzeug",       
    price = 4,
    desc = "Erhalte ein Premiumfahrzeug.\nBenutze /phelp [1] für Infos.",
    elementDatas = {},
    addElementDatas = {},
    expire = 0
}
shopPackage[5].addElementDatas["PremiumCars"] = 1 


shopPackage[6] = {          
    name = "Premium Bronze",       
    price = 5,
    desc = "Erhalte die Premium Stufe Bronze (30 Tage)\n\nErfahre mehr über Bronze mit /phelp 1",
    elementDatas = {},
    addElementDatas = {},
    ableToRebuy = true,
    expire = 30
}
shopPackage[6].elementDatas["premium"] = true 
shopPackage[6].elementDatas["PremiumData"] = 30
shopPackage[6].elementDatas["Paket"] = 1

function listShopItems(player)

    for var, item in ipairs(shopPackage) do
        triggerClientEvent ( player, "fillShopItems", getRootElement(), var, item.name, item.price, item.desc)
    end
end
addEvent ( "listShopItems", true )
addEventHandler ( "listShopItems", getRootElement(),  listShopItems )

function buyShopItem (player, id, shouldRenew)
    local coins = tonumber ( vioGetElementData( player, "coins" ) )
    local rt = getRealTime ()
    local timesamp = rt.timestamp
    local id = tonumber (id)
    if client == player and shopPackage[id] then
        if coins >=  tonumber(shopPackage[id].price) then
            newInfobox (player, "Erfolgreich erworben!\nDie Abarbeitung der Transaktion kann bis zu 10 Sekunden dauern.", 4)
            vioSetElementData( player, "coins", coins - tonumber(shopPackage[id].price)  )
            print(tostring(shouldRenew).. " TONEW")
            if shouldRenew == true then
                triggerClientEvent ( player, "setIDforAutorenew", getRootElement(), player, id, tonumber(shopPackage[id].price))
            end

            -- Randomat
            if id == 4 then
                winPcars =  math.random(1,3)
                shopPackage[id].addElementDatas["PremiumCars"] = winPcars
                shopPackage[id].elementDatas["premium"] = true 
                shopPackage[id].elementDatas["PremiumData"] = 30
                local premiumChance = math.random(1,100)
                if premiumChance <= 5  then
                    winPackage = 4
                elseif premiumChance > 5 and premiumChance <= 25 then
                    winPackage = 3
                elseif premiumChance > 25 and premiumChance <= 45 then
                    winPackage = 2
                elseif premiumChance > 45 and premiumChance <= 100 then
                    winPackage = 1
                end
                shopPackage[id].elementDatas["Paket"] = winPackage
                outputChatBox("Du hast "..winPcars.." Premiumfahrzeug erhalten und die Stufe "..winPackage, player, 125, 0, 0, true)
            end
            -- Setzten
            for element, data in pairs(shopPackage[id].elementDatas) do
                local element = tostring ( element )
                    
                -- Premium ?
                if element == "premium" then
                    setTimer(checkPremium, 5000, 1, player)
                    vioSetElementData ( player, "premium", true )
                elseif element == "PremiumData" then
                    vioSetElementData ( player, "PremiumData", timesamp+86400*data )
                    -- Sonst
                else
                    vioSetElementData ( player, element, data )
                end
            end

            -- Hinzufügen
            for element, data in pairs(shopPackage[id].addElementDatas) do
                local element = tostring ( element )

                vioSetElementData ( player, element, vioGetElementData ( player, element ) + data )
            end
        else
            newInfobox (player, "Du hast nicht genug Coins.\nDu kannst sie beim Spenden mit PSC (oben) oder beim Spenden\nim CP erhalten.", 3)
        end
    else
        newInfobox (player, "Manipulation?!", 3)
    end
end
addEvent ( "buyShopItem", true )
addEventHandler ( "buyShopItem", getRootElement(),  buyShopItem )


function buyShopItemplayer (player, cmd, id)
    buyShopItem (player, tonumber(id))
    local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ?? WHERE ??=? LIMIT ?", "logs", "type", searchType, maxLogs ), -1 )
	for i=1, #result do
     --   if tonumber (#logsForClient) < maxLogs then
            logsForClient[i] = {tonumber ( result[i]["faction"] ),  tonumber (  result[i]["type"] ),  tonumber (result[i]["Timestamp"] ), string.lower(result[i]["Text"]) }
    --    else
     --       break;
    --    end
    end
end


function listPaysafecards ()
    local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ?? WHERE ?? NOT LIKE ?", "coins", "psc", "" ), -1 )
	for i=1, #result do
        paysafecard[tonumber ( result[i]["UID"] )] ={
            uid = tonumber ( result[i]["UID"] ),
            psc = tostring ( result[i]["psc"] ),
            value =  tonumber ( result[i]["pscValue"] )
        }
    end
end
listPaysafecards ()


function sendPaysafecard (player, code_1,code_2,code_3,code_4, value )
    if player == client then
        local code = code_1.."-"..code_2.."-"..code_3.."-"..code_4
      --  local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "psc", "coins", "UID", playerUID[getPlayerName(player)] ), -1 )
      --  local psc = result[1]["psc"]
	--	if result and result[1] then
        if not paysafecard[playerUID[getPlayerName(player)]] then
            dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "coins", "psc", code, "pscValue",value,  "UID", playerUID[getPlayerName(player)] )
            newInfobox (player, "Paysafecard erfolgreich abgeschickt.\nDie Bearbeitung kann bis zu 48h dauern.", 4)
            paysafecard[playerUID[getPlayerName(player)]] = {
                uid = playerUID[getPlayerName(player)],
                psc = code,
                value =  value
            }
            for playeritem, index in pairs(adminsIngame) do 			
                if index >= 2 then
                    outputChatBox ( getPlayerName(player).." hat eine Paysafecard mit "..value.."€ eingeschickt.", playeritem,200, 200, 0)
                end				
            end	
        else
            newInfobox (player, "Du hast bereits eine offene Anfrage.", 3)
        end 
    else
        newInfobox (player, "Manipulation?!", 3)
    end
end
addEvent ( "sendPaysafecard", true )
addEventHandler ( "sendPaysafecard", getRootElement(),  sendPaysafecard )

function givePlayerCoins (player, uid)
    local uid = tonumber(uid)
    local target = playerUIDName[uid]
    local targetpl = getPlayerFromName(target)
    local value = (paysafecard[uid].value * 1)
    paysafecard[uid] = nil
    newInfobox (player, "Erfolgreich gegeben.", 3)
    -- Online
    if targetpl then
        vioSetElementData ( targetpl, "coins", vioGetElementData ( targetpl, "coins") + value )
        newInfobox (targetpl, "Deine Paysafecard wurde angenommen. Du hast "..value.." Coins erhalten.\nUnter /self kannst du sie ausgeben.", 4)
    -- Offline
    else
        offlinemsg ( "Deine Paysafecard wurde angenommen. Du hast "..value.." Coins erhalten.\nUnter /self kannst du sie ausgeben.", "Server", target )
        local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "Coins", "coins", "UID", uid ), -1 )
        if result and result[1] then
           local coins = result[1]["Coins"]
           dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "coins", "Coins", coins + value,  "UID", uid )
        end
    end
    dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "coins", "psc", "", "pscValue","0",  "UID", uid )
    outputAdminLog ( getPlayerName(player).." hat "..target.." "..value.." Coins gegeben." )	
    sendMsgToAdmins(getPlayerName(player).." hat "..target.." "..value.." Coins gegeben.", 2)		
end
addEvent ( "givePlayerCoins", true )
addEventHandler ( "givePlayerCoins", getRootElement(),  givePlayerCoins )

function deletePsc (player, uid )
    local uid = tonumber(uid) 
    local targetpl = getPlayerFromName(target)
    paysafecard[uid] = nil
    newInfobox (player, "Erfolgreich gelöscht.", 3)
    if targetpl then
        newInfobox (targetpl, "Deine Paysafecard wurde gelöscht.", 3)
    else
        offlinemsg ( "Deine Paysafecard wurde gelöscht.", "Server", target )
    end
    dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "coins", "psc", "", "pscValue","",  "UID", uid )
    outputAdminLog ( getPlayerName(player).." hat "..target.."´s Anfrage gelöscht." )		
    sendMsgToAdmins(getPlayerName(player).." hat "..target.."´s Anfrage gelöscht.", 2)		
end
addEvent ( "deletePsc", true )
addEventHandler ( "deletePsc", getRootElement(),  deletePsc )