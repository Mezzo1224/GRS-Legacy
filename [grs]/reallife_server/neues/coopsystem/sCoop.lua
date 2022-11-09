function createNewCooperation (player, name, nameShort, coopType, r, g, b)
    local leaderUID = playerUID[getPlayerName(player)]
    local result, num_affected_rows, id =  dbPoll ( dbQuery( handler, "INSERT INTO cooperations (name,leaderUID, nameShort,coopType, maxVehicles, R, G, B) VALUES(?,?,?,?,?, ?, ?, ?)",  name, leaderUID,nameShort, coopType, 2, r,g,b), -1)
    local housePickup = houses["pickup"][playerUIDName[leaderUID]]
    local Rang1, Rang2, Rang3, Rang4 = "Rang1", "Rang2", "Rang3", "Rang4"
    local houseID = houses["id"][housePickup]
    local houseX, houseY, houseZ = getElementPosition ( housePickup )
    vioSetElementData(housePickup, "cooperationOwner", id)
    if type == 1 then
        vioSetElementData(housePickup, "cooperationName", "der Gang\n "..name )
    elseif type == 2 then
        vioSetElementData(housePickup, "cooperationName", "der Firma\n "..name )
    end 
    cooperationVehicleList[id] = {} -- // Um Fahrzeuge zuzuordnen 
    cooperation[id] = {
        name = name,
        leaderUID = leaderUID,
        nameShort = nameShort,
        coopType = coopType,
        storedMoney = 0,
        storedDrugs = 0,
        storedMats = 0,
        coopLevel = 0,
        coopTuningLevel = 0, -- // Alle Fahrzeuge erhalten einen Sportmotor ( bis Stufe 3 )
        coopMaxVehicles = 2,
        payday = setTimer(coopPayday, coopPaydayTimer , 0, id ),
        payDayTogether = 0,
        members = {},
        -- // Hausmarker
        houseID = houseID,
        -- // Spawnarea
        SpawnX = houseX,
        SpawnY = houseY,
        SpawnZ = houseZ,
        SpawnRadius = 20,
        SpawnCol = createColCircle(houseX, houseY, SpawnRadius ),
        -- // Stocks
        isStockCoop = false, -- // MySQL
        stockPenalty = 0,
        -- // Farbe
        r = r,
        g = g,
        b = b
    }
    cooperation[id].members[getPlayerName(player)] = "on"
    -- // Ränge setzen
    cooperationRanks[id] = {
        [1] = Rang1,
        [2] = Rang2,
        [3] = Rang3,
        [4] = Rang4
    }


    -- // Payday
    cooperationRanks[id]["payday"] = {}
    local p1, p2,p3,p4 = getRankPaydays ( id )
    cooperationRanks[id]["payday"][1] = p1
    cooperationRanks[id]["payday"][2] = p2
    cooperationRanks[id]["payday"][3] = p3
    cooperationRanks[id]["payday"][4] = p4
    -- // für den Leader
    vioSetElementData ( player, "coopRang", 4 )
    vioSetElementData ( player, "coopID", id )
    for theKey, playerOnServer in ipairs(getElementsByType ( "player" ) ) do
        getServerCoopDataForClient ( playerOnServer )
    end
    
end

function isNameAvailable (player, name, nameShort)
    if dbExist ( "cooperations", "name LIKE '"..name.."'") then
        newInfobox(player,"Dieser Name ist vergeben.", 3)
        return false
    elseif dbExist ( "cooperations", "nameShort LIKE '"..nameShort.."'") then
        newInfobox(player,"Diese Abkürzung ist vergeben.", 3)
        return false
    else
        return true
    end
end

function makeNewCooperation(player, name, nameShort, type, r, g, b)
    local coopID, coopRang = getPlayerCoopData ( player )
    local housekey = vioGetElementData ( player, "housekey" )
    local money = vioGetElementData ( player, "money" )
    if getPlayerFaction ( player ) == 0 then
        if not isInCoop(player) then
            if housekey > 0 then
                -- formNumberToMoneyString ( cooperationCreateCosts ) zum konverten
                local houseID = vioGetElementData ( player, "housekey" )
                local housePickup = houses["pickup"][houseID]
                if not vioGetElementData(housePickup, "cooperationOwner") then
                    if not dbExist ( "cooperations", "leaderUID LIKE '"..playerUID[getPlayerName(player)].."'") then
                        if isNameAvailable(player, name, nameShort) then
                            if money >= cooperationCreateCosts then  
                                if not vioGetElementData(player, "coopInCreation") then
                                    vioSetElementData ( player, "coopInCreation", true )
                                    newInfobox(player,"Dein Unternehmen wird "..formNumberToMoneyString ( cooperationCreateCosts ).." kosten.\nBist du dir sicher ?", 4)
                                else
                                    
                                    triggerClientEvent ( player, "closeCoopCreateMenu", getRootElement())		
                                    vioSetElementData ( player, "coopInCreation", false )
                                    createNewCooperation (player, name,nameShort, type, playerUID[getPlayerName(player)], r, g, b)
                                    outputChatBox ( "Du hast erfolgreich deine Firma/Gang "..name.." gegründet.", player, 200, 200, 0 )
                                    outputChatBox ( formNumberToMoneyString ( cooperationCreateCosts ).." wurden dir von deinem Konto abgezogen." , player, 200, 200, 0 )
                                    outputChatBox ( "Viel Glück!", player, 200, 200, 0 )
                                    unbindKey ( player, "y", "down", "chatbox" )
                                    bindKey ( player, "y", "down", "chatbox", "t" ) 
                                end
                            else
                                newInfobox(player,"Du hast nicht genug Geld.", 3)
                            end
                        end
                    else
                        newInfobox(player,"Du hast bereits ein Unternehmen, dieses ist aber deaktiviert.", 3)
                    end
                else
                    newInfobox(player,"Dein Haus gehört bereits einer Firma.", 3)
                end
            else
                newInfobox(player,"Du hast kein Haus.", 3)
            end
        else
            newInfobox(player,"Du bist selbst in einem Unternehmen.", 3)
        end
    else
        newInfobox(player,"Du bist in einer Fraktion.", 3)
    end
end
addEvent ( "makeNewCooperation", true )
addEventHandler ( "makeNewCooperation", getRootElement(),  makeNewCooperation )




-- // Unternehmens Funktionen (Spielerbasiert)
-- Depot
function cDepot (player, cmd, take, item, value)
    local coopID, coopRang = getPlayerCoopData ( player )
    if coopID > 0 then
        if take then
            if take == "store" then
                if item then
                    if tonumber(value) then
                        if tonumber(value) > 0 then
                            local pMoney, pMats, pDrugs =  tonumber(vioGetElementData ( player, "money" )), tonumber(vioGetElementData ( player, "mats" )), tonumber(vioGetElementData ( player, "drugs" ))
                            local value = tonumber(value)
                            if item == "Geld" then
                                if pMoney >= value then
                                    cooperation[coopID].storedMoney = cooperation[coopID].storedMoney + value
                                    vioSetElementData ( player, "money", pMoney - value )
                                    sendMessageToCooperation ( getPlayerName(player).." hat "..formNumberToMoneyString (value).." eingezahlt.", coopID)
                                else
                                    newInfobox(player,"Du hast nicht Genug Geld.", 3)
                                end
                            elseif item == "Drogen" then
                                if isGang(coopID) then
                                    if pDrugs >= value then
                                        cooperation[coopID].storedDrugs = cooperation[coopID].storedDrugs + value
                                        vioSetElementData ( player, "drugs", pDrugs - value )
                                        sendMessageToCooperation ( getPlayerName(player).." hat "..value.." Drogen eingezahlt.", coopID)
                                    else
                                        newInfobox(player,"Du hast nicht Genug Drogen.", 3)
                                    end
                                else
                                    newInfobox(player,"Nur für Gangs.", 3)
                                end
                            elseif item == "Mats" then
                                if isGang(coopID) then
                                    if pMats >= value then
                                        cooperation[coopID].storedMats = cooperation[coopID].storedMats + value
                                        vioSetElementData ( player, "mats", pMats - value )
                                        sendMessageToCooperation ( getPlayerName(player).." hat "..value.." Mats eingezahlt.", coopID)
                                    else
                                        newInfobox(player,"Du hast nicht Genug Mats.", 3)
                                    end
                                else
                                    newInfobox(player,"Nur für Gangs.", 3)
                                end
                            else
                                newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
                            end
                        else
                            newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
                        end
                    else
                        newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
                    end
                else
                    newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
                end
            elseif take == "take" then
                if item then
                    if tonumber(value) then
                        if tonumber(value) > 0 then
                            local pMoney, pMats, pDrugs =  tonumber(vioGetElementData ( player, "money" )), tonumber(vioGetElementData ( player, "mats" )), tonumber(vioGetElementData ( player, "drugs" ))
                            local value = tonumber(value)
                            if item == "Geld" then
                                if cooperation[coopID].storedMoney >= value then
                                    cooperation[coopID].storedMoney = cooperation[coopID].storedMoney - value
                                    vioSetElementData ( player, "money", pMoney + value )
                                    sendMessageToCooperation ( getPlayerName(player).." hat "..formNumberToMoneyString (value).." abgehoben.", coopID)
                                else
                                    newInfobox(player,"Dein Unternehmen hat nicht Genug Geld.", 3)
                                end
                            elseif item == "Drogen" then
                                if isGang(coopID) then
                                    if cooperation[coopID].storedDrugs >= value then
                                        cooperation[coopID].storedDrugs = cooperation[coopID].storedDrugs - value
                                        vioSetElementData ( player, "drugs", pDrugs + value )
                                        sendMessageToCooperation ( getPlayerName(player).." hat "..value.." Drogen abgehoben.", coopID)
                                    else
                                        newInfobox(player,"Dein Unternehmen hat nicht Genug Drogen.", 3)
                                    end
                                else
                                    newInfobox(player,"Nur für Gangs.", 3)
                                end
                            elseif item == "Mats" then
                                if isGang(coopID) then
                                    if cooperation[coopID].storedMats >= value then
                                        cooperation[coopID].storedMats = cooperation[coopID].storedMats - value
                                        vioSetElementData ( player, "mats", pMats + value )
                                        sendMessageToCooperation ( getPlayerName(player).." hat "..value.." Mats abgehoben.", coopID)
                                    else
                                        newInfobox(player,"Dein Unternehmen hat nicht Genug Mats.", 3)
                                    end
                                else
                                    newInfobox(player,"Nur für Gangs.", 3)
                                end
                            else
                                newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
                            end
                        else
                            newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
                        end
                    else
                        newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
                    end
                else
                    newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
                end

            -- Wenn take nicht richtig ist
            else
                newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
            end
        else
            newInfobox(player,"Benutzt /cdepot [take|store] [Geld|Drogen|Mats] [Anzahl]", 3)
        end
    else
        newInfobox(player,"Du bist in keinem Unternehmen.", 3)
    end
end
addCommandHandler("cdepot", cDepot)

function cState (player)
    local coopID, coopRang = getPlayerCoopData ( player )
    if coopID > 0 then
      --  cooperation[coopID].storedMoney = cooperation[coopID].storedMoney + 10000000
        if isGang(coopID) then
            outputChatBox ( "Deine Gang "..cooperation[coopID].name.." (kurz "..cooperation[coopID].nameShort..") hat:" , player, 200, 200, 0 )
            outputChatBox ( formNumberToMoneyString (cooperation[coopID].storedMoney)..", "..cooperation[coopID].storedDrugs.." Drogen und  "..cooperation[coopID].storedMats.." Mats im Lager." , player, 200, 200, 0 )
        elseif isCompany(coopID) then
            outputChatBox ( "Deine Unternehmen "..cooperation[coopID].name.." (kurz "..cooperation[coopID].nameShort..") hat:" , player, 200, 200, 0 )
            outputChatBox (  formNumberToMoneyString (cooperation[coopID].storedMoney).." im Lager." , player, 200, 200, 0 )
        end
        outputChatBox ( "Dein Rang: "..cooperationRanks[coopID][coopRang]..", Dein Gehalt: "..formNumberToMoneyString ( cooperationRanks[coopID]["payday"][coopRang] ) , player, 200, 200, 0 )
    else
        newInfobox(player,"Du bist in keinem Unternehmen oder keiner Gang.", 3)
    end
end
addCommandHandler("cstate", cState)

inviteTimer = {}
function cInvite (player, cmd, target)
    local coopID, coopRang = getPlayerCoopData ( player )
    local target = getPlayerFromName ( target )
    local faction = getPlayerFaction ( target )
    if coopID > 0 and coopRang >= 4 then
        if target then
            local tCoopID, tCoopRang = getPlayerCoopData ( target )
            if tCoopID == 0 then
                if faction == 0 then
                    newInfobox(player,"Einladung verschickt.", 4)
                    vioSetElementData ( target, "coopInvited", coopID )
                    inviteTimer[getPlayerName(target)] =  setTimer ( function()
                        vioSetElementData ( target, "coopInvited", 0 )
                        newInfobox(target,"Einladung abgelaufen.", 2)
                    end, 10000, 1 )
                    outputChatBox ( "Du hast eine Einladung in das Unternehmen "..cooperation[coopID].name.." erhalten.", target, 0, 125, 0 )
                    outputChatBox ( "Tippe /caccept um sie anzunehmen.", target, 0, 125, 0 )
                else
                    newInfobox(player,"Der Spieler ist in einer Fraktion.", 3)
                end
            else
                newInfobox(player,"Der Spieler ist bereits in einem Unternehmen.", 3)
            end
        else
            newInfobox(player,"Spieler existiert nicht.", 3)
        end
    else
        newInfobox(player,"Du bist in keinem Unternehmen oder nicht befugt.", 3)
    end
end
addCommandHandler("cinvite",cInvite )

function cAccept (player)
    local inviteID = vioGetElementData(player,"coopInvited")
    if inviteID then
        if tonumber(inviteID) > 0 then
            vioSetElementData ( player, "coopID", inviteID )
            vioSetElementData ( player, "coopRang", 1 )
            outputChatBox ( "Du bist nun der Firma/Gang "..cooperation[inviteID].name..".", player, 0, 125, 0 )
            vioSetElementData ( player, "coopInvited", 0 )
            killTimer(inviteTimer[getPlayerName(player)])
            cooperation[coopID].members[getPlayerName(player)] = "on"
            removeCommandHandler("caccept", cAccept)
            unbindKey ( player, "y", "down", "chatbox" )
            bindKey ( player, "y", "down", "chatbox", "t" ) 
        else
            newInfobox(player,"Du hast keine Einladung.", 3)
        end
    else
        newInfobox(player,"Du hast keine Einladung.", 3)
    end
end
addCommandHandler("caccept", cAccept)

function cUninvite (player, cmd, target)
    local coopID, coopRang = getPlayerCoopData ( player )
    local targetpl = getPlayerFromName ( target )
    if coopID > 0 and coopRang == 4 then
        if isElement ( targetpl ) then
            local tcoopID, tcoopRang = getPlayerCoopData ( targetpl )
            if tcoopID == coopID then
                vioSetElementData ( targetpl, "coopID", 0 )
                vioSetElementData ( targetpl, "coopRang", 0 )
                cooperation[coopID].members[target] = nil
                outputChatBox ( "Du wurdest von "..getPlayerName(player).." aus der Fraktion geworfen.", targetpl, 125, 0, 0 )
                outputChatBox ( "Du hast den Spieler "..target.." aus deinem Unternehmen entfernt.", player, 0, 150, 0 )
            end
        -- // Offline uninviten
        elseif playerUID[target] then
            local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "coopID", "coopRang", "userdata", "UID", playerUID[target] ), -1 )
            if result and result[1] and tonumber ( result[1]["coopID"] ) == coopID then
                if tonumber ( result[1]["coopRang"] ) < coopRang then
                    dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "coopID", 0,"coopRang", 0, "UID", playerUID[target] )
                    outputChatBox ( "Du hast den Spieler "..target.." offline aus deinem Unternehmen entfernt", player, 0, 150, 0 )
                    cooperation[coopID].members[target] = nil
                    offlinemsg ( getPlayerName(player).." hat dich aus seinem Unternehmen entfernt", "Server", target )
                else
                    newInfobox(player,"Dein Rang ist zu niedrig", 3)
                end
            else
                newInfobox(player,"Der Spieler ist nicht in deinem Unternehmen.", 3)
            end
        else
            newInfobox(player,"Der Spieler existiert nicht oder ist nicht\nin deinem Unternehmen.", 3)
        end
    end
end
addCommandHandler("cuninvite",cUninvite )

function cSetrang (player, cmd, target, rang)
    local coopID, coopRang = getPlayerCoopData ( player )
    local targetpl = getPlayerFromName ( target )
    if coopID > 0 and coopRang == 4 then
        if tonumber(rang) then
            if tonumber(rang) > 0 and  tonumber(rang) < 4 then
                local rang = tonumber(rang)
                local coopID = tonumber(coopID)
                if isElement ( targetpl ) then
                    local tcoopID, tcoopRang = getPlayerCoopData ( targetpl )
                    if tcoopID == coopID then
                        vioSetElementData ( targetpl, "coopRang", rang )
                        outputChatBox ( "Du wurdest von "..getPlayerName(player).." auf den Rang "..cooperationRanks[coopID][rang].." ("..rang..") gesetzt.", targetpl, 125, 0, 0 )
                        outputChatBox ( "Du hast den Spieler "..target.." auf den Rang "..cooperationRanks[coopID][rang].." ("..rang..") gesetzt.", player, 0, 150, 0 )
                    end
                -- // Offline uninviten
                elseif playerUID[target] then
                    local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "coopID", "coopRang", "userdata", "UID", playerUID[target] ), -1 )
                    if result and result[1] and tonumber ( result[1]["coopID"] ) == coopID then
                        if tonumber ( result[1]["coopRang"] ) < coopRang then
                            dbExec ( handler, "UPDATE ?? SET  ??=? WHERE ??=?", "userdata", "coopRang", rang, "UID", playerUID[target] )
                            outputChatBox ( "Du hast den Spieler "..target.." auf den Rang "..cooperationRanks[coopID][rang].." ("..rang..") gesetzt.", player, 0, 150, 0 )
                            offlinemsg ( "Du wurdest von "..getPlayerName(player).." auf den Rang "..cooperationRanks[coopID][rang].." ("..rang..") gesetzt.", "Server", target )
                        else
                            newInfobox(player,"Dein Rang ist zu niedrig", 3)
                        end
                    else
                        newInfobox(player,"Der Spieler ist nicht in deinem Unternehmen.", 3)
                    end
                else
                    newInfobox(player,"Der Spieler existiert nicht oder ist nicht\nin deinem Unternehmen.", 3)
                end
            else
                newInfobox(player,"Ungültiger Rang.", 3)
            end
        else
            newInfobox(player,"Benutze /csetrang [NAME] [RANG]", 3)
        end
    end
end
addCommandHandler("csetrang",cSetrang )

-- // Funktionen allgemein
--[[
Willst du dein Unternehmen deaktvieren oder löschen ?
Bei einer Löschung wird das Unternehmen deaktiviert und nach
7 Tagen automatisch beim nächsten Serverstart komplett vom Server gelöscht ink. Fahrzeuge. 
Das Reaktivieren der Firma kostet dich in diesem Fall 10% des Unternehmenswertes.

Du kannst aber auch dein Unternehmen nur deaktivieren, dabei fallen keine kosten jeglicher
Art an. Du kannst Sie jederzeit reaktivieren. 
Die Deaktivierung sowie die Aktivierung tritt beim nächsten Serverstart in Kraft.

Unter einer Deaktivierung versteht man:
- Zugriff auf jegliche Administrative Funktion inkl. das Unternehmensmenü, ist deaktiviert.
- Jedes Mitglied wird beim Login automatisch aus dem Unternehmen entfernt.
- Jegliche Daten des Unternehmens bleiben erhalten inkl. die Unternehmens-Kasse.
- Fahrzeuge werden nicht mehr geladen, bleiben aber im System.
- Einstellungen d.h z.B Ränge, Farbe oder Löhne, bleiben erhalten.
- Der Name deines Unternehmens und dessen Kürzel bleibt geschützt, so das es niemand stehlen kann.
]]
function deactivateCoop (coopID, deleteTime)
    if deleteTime == 0 then
        price = 0
    else
        price = calculateCoopValue (coopID)
    end
end




function coopPayday ( coopID )
    sendMessageToCooperation ( "---- Zahltag ----", coopID )
    sendMessageToCooperation ( "Money bitch", coopID )
    local interest = (cooperation[coopID].storedMoney/100)*companyInterestPerc
    sendMessageToCooperation ( "Geld: "..interest, coopID )
end

function sendMessageToCooperation ( msg, coopID, r,g,b )
    if not r then
        r = 200
    end
    if not g then
        g = 200
    end
    if not b then
        b = 0
    end
    for name, state in pairs(cooperation[coopID].members) do 
        local thePlayer = getPlayerFromName(name)
        if thePlayer then
            outputChatBox ( msg, thePlayer, r,g,b )
        end
    end
end



function getServerCoopDataForClient ( player )
    for i, coop in pairs(cooperation) do 
        local r, g, b =  coop.r, coop.g, coop.b
        triggerClientEvent ( player, "sendCoopDataToClient", getRootElement(), i, coop.name, r, g, b )		
    end
end

function calculateCoopValue ( coopID )
    local coopLevel = cooperation[coopID].coopLevel
    local stockValueByLeader = 1000
    local coopValue = 0
    for i, var in pairs (cooperationLevelCosts) do
        if i <= coopLevel then
            coopValue = coopValue + var
        end
    end
    local coopValue = coopValue + cooperationCreateCosts
    return coopValue
end
-- // Abfragen
function isGang ( coopID )
    if cooperation[coopID].coopType ~= 1 then
        return false
    else
        return true
    end
end

function isCompany ( coopID )
    if cooperation[coopID].coopType ~= 2 then
        return false
    else
        return true
    end
end

function isInCoop ( player )
    if tonumber(vioGetElementData ( player, "coopID" )) > 0 then
        return true
    else
        return false
    end
end

function getCoopLevel ( coopID )

    return cooperation[coopID].coopLevel, cooperation[coopID].coopTuningLevel
end

function checkImageForUsage ( image )
    if tostring ( image ) then
        if string.find(image, "imgur")  then
            if string.find(image, "png") or string.find(image, "jpeg") then
                return true
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end

function getPlayerCoopData ( player )
    return tonumber(vioGetElementData ( player, "coopID" )), tonumber(vioGetElementData ( player, "coopRang" ))
end

function getRankPaydays ( coopID ) 
    local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "RangPay", "cooperations", "ID", coopID ), -1 )
     if result and result[1] then
        local rankPayday = result[1]["RangPay"]
        local p1 = tonumber ( gettok ( rankPayday, 1, string.byte( '|' ) ))
        local p2 = tonumber ( gettok ( rankPayday, 2, string.byte( '|' ) ))
        local p3 = tonumber ( gettok ( rankPayday, 3, string.byte( '|' ) ))
        local p4 = tonumber ( gettok ( rankPayday, 4, string.byte( '|' ) ))

        return p1, p2, p3, p4
    end
end