
-- // Checkt beim Serverstart ob Warns Expired sind, kann unter both_settings.lua ausgeschaltet werden
function checkForExpiredWarns ()
    print("[Warnsystem] Warns werden gecheckt...")
    local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ?? WHERE ??=?", "warns", "isExpired", 0  ), -1 )
    for i=1, #result do
        local id = tonumber ( result[i]["ID"])
        local uid  = tonumber ( result[i]["UID"])
        local rt = getRealTime ()
        local timesamp = rt.timestamp
        local warnTimesamp = tonumber ( result[i]["ExpiryDate"])
        local date =  tostring ( result[i]["creationDate"] )
        if warnTimesamp < timesamp then
            print("[Warnsystem] Abgelaufen", id, uid)
            dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "warns", "isExpired", 1, "ID", id )
            local pname = playerUIDName[uid]
            if getPlayerFromName(pname) then
                local target = getPlayerFromName(pname)
                outputChatBox ( "Dein Warn vom "..date.." ist abgelaufen.", target, 255, 0, 0 )
            else
                offlinemsg ( "Dein Warn vom "..date.." ist abgelaufen.", "Server", pname )
            end
        else
            print("[Warnsystem] "..id.." ist nicht abgelaufen")
        end
    end
end
checkForExpiredWarns ()
setTimer ( checkForExpiredWarns, 1000*60*30, 0)

function calculateWarnTime (time, timeType )
-- // Stunden
    if timeType == "h" then
        warnTime = (60*time)
        if tonumber(time)  > 1 then
            prefix = "Stunden"
        else
            prefix = "Stunde"
        end
        trueBanTime = time.." "..prefix.."."
        return tonumber(warnTime), tostring(trueBanTime)
-- // Tage
    elseif timeType == "d" or not timeType then
        warnTime = (86400*time)
        if tonumber(time) > 1 then
            prefix = "Tage"
        else
            prefix = "Tag"
        end
        trueBanTime = time.." "..prefix.."."
        return tonumber(warnTime), tostring(trueBanTime)
-- // Wochen
    elseif timeType == "w" then
        warnTime = (86400*7*time)
        if tonumber(time) > 1 then
            prefix = "Wochen"
        else
            prefix = "Woche"
        end
        trueBanTime = time.." "..prefix.."."
        return tonumber(warnTime), tostring(trueBanTime)
-- // Monate
    elseif timeType == "mo" then
        warnTime = (86400*7*4*time)
        if tonumber(time) > 1 then
            prefix = "Monate"
        else
            prefix = "Monat"
        end
        trueBanTime = time.." "..prefix.."."
        return tonumber(warnTime), tostring(trueBanTime)
-- // Jahre
    elseif timeType == "y" then
        warnTime = (86400*7*4*12*time)
        if tonumber(time) > 1 then
            prefix = "Jahre"
        else
            prefix = "Jahr"
        end
        trueBanTime = time.." "..prefix.."."
        return tonumber(warnTime), tostring(trueBanTime)
-- // Perma
    elseif timeType == "p" or timeType == "perma" then
        warnTime = 0
        trueBanTime = "Permanent"
        return tonumber(warnTime), tostring(trueBanTime)
    else
        print("Fehler bei der Berechnung der Warnzeit.")
        return false
    end
end


function openWarnUI (player,cmd, target)
    --getWarnsFromMySQL(getPlayerName(player))
    if vioGetElementData ( player, "loggedin" ) == 1 then
        if getElementClicked ( player ) == false then
          --  setElementClicked(player, true)
            if isAdminLevel ( player, 2 ) then	  
                if target then
                    triggerClientEvent ( player, "createWarnWindow", getRootElement(), target, searchedPlayers, true )
                else
                    triggerClientEvent ( player, "createWarnWindow", getRootElement(), nil, searchedPlayers, true )
                    
                end
            else
                triggerClientEvent ( player, "createPlayerWarnWindow", getRootElement() )
            end
          
        end
       
    end
end
addCommandHandler("warns", openWarnUI )
addCommandHandler("warn", openWarnUI )

searchedPlayers = {}

function cacheSearchedPlayers (name)
    if not searchedPlayers[name] then
        searchedPlayers[name] = true
    end
end
addEvent ( "cacheSearchedPlayers", true )
addEventHandler ( "cacheSearchedPlayers", getRootElement(), cacheSearchedPlayers )

playerWarns = {}

function getWarnsFromMySQL (name)
    local uid = playerUID[name]
    if uid then
        -- // Warns werden gelöscht um sie neu zu laden.
        if playerWarns[uid] then
            playerWarns[uid] = nil
        end
        -- // Warns werden geladen
        playerWarns[uid] = {
            warns = {},
            allPenaltyPoints = 0,
            allActiveWarns = 0,
            allWarns = 0,
            
        }
        -- // Das ORDER BY macht zuerst die Aktiven Verwarnungen, dann die Inaktiven
        local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ?? WHERE ??=? ORDER BY `ExpiryDate` DESC", "warns", "UID", uid  ), -1 )
        for i=1, #result do
           
            playerWarns[uid].allWarns = (playerWarns[uid].allWarns + 1)
            playerWarns[uid].warns[playerWarns[uid].allWarns] = {
                id = tonumber ( result[i]["ID"]),
                uid = tonumber ( result[i]["UID"]),
                AdminUID = tonumber ( result[i]["UID"]),
                reason = tostring ( result[i]["reason"]),
                time = tostring ( result[i]["time"]),
                penaltyPoints = tonumber ( result[i]["penaltyPoints"]),
                ExpiryDate =  getDateForAdminpanel (tonumber ( result[i]["ExpiryDate"]),true),
                creationDate = tostring ( result[i]["creationDate"]),
                -- // Klare Daten
                nameFromUID =name,
                nameFromAdminUID = playerUIDName[tonumber ( result[i]["UID"])],
                isExpired =  tonumber ( result[i]["isExpired"])
            }
           
            -- // Checken ob es abgelaufen ist
            if tonumber ( result[i]["isExpired"]) == 0 then
                local rt = getRealTime ()
                local timesamp = rt.timestamp
                local warnTimesamp = tonumber ( result[i]["ExpiryDate"])
                playerWarns[uid].allPenaltyPoints =  (playerWarns[uid].allPenaltyPoints + tonumber ( result[i]["penaltyPoints"]))
                playerWarns[uid].allActiveWarns = (playerWarns[uid].allActiveWarns + 1)
                if warnTimesamp < timesamp then
                    print(warnTimesamp, timesamp)
                    print(tonumber ( result[i]["ID"]))
                    playerWarns[uid].warns[playerWarns[uid].allWarns].isExpired = 1
                    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "warns", "isExpired", 1, "ID", tonumber ( result[i]["ID"]) )
                    playerWarns[uid].allPenaltyPoints =  (playerWarns[uid].allPenaltyPoints - tonumber ( result[i]["penaltyPoints"]))
                    playerWarns[uid].allActiveWarns = (playerWarns[uid].allActiveWarns - 1)
                    local pname = playerUIDName[uid]
                    if getPlayerFromName(pname) then
                        local target = getPlayerFromName(pname)
                        outputChatBox ( "Dein Warn vom "..tostring ( result[i]["creationDate"]).." ist abgelaufen.", target, 255, 0, 0 )
                    else
                        offlinemsg ( "Dein Warn vom "..tostring ( result[i]["creationDate"]).." ist abgelaufen.", "Server", target )
                    end
                end
            end
            --playerWarns[uid].allWarns = (playerWarns[uid].allWarns + 1)
        end
        -- // LastLogin
        local result2 = dbPoll ( dbQuery ( handler, "SELECT ??,?? FROM ?? WHERE ?? LIKE ?", "Last_login", "adminNote", "players", "UID", uid ), -1 )
		local lastlogin = tostring ( result2[1]["Last_login"] )
        local adminnote = tostring ( result2[1]["adminNote"] )
       
        if isAdminLevel(client, 2) then
            playerWarns[uid].lastlogin = lastlogin
            playerWarns[uid].adminnote = adminnote
            triggerClientEvent ( client, "updateWarnUI", getRootElement(),  name, playerWarns[uid] )
        else
            -- // Diese Daten sollen nicht an den Client gehen (weil Spieler)
            playerWarns[uid].warns[playerWarns[uid].allWarns].uid = nil
            playerWarns[uid].warns[playerWarns[uid].allWarns].AdminUID = nil
            triggerClientEvent ( client, "addPlayerWarnClient", getRootElement(), playerWarns[uid] )
        end
    end
end
addEvent ( "getWarnsFromMySQL", true )
addEventHandler ( "getWarnsFromMySQL", getRootElement(), getWarnsFromMySQL )

function saveAdminNoticeInMysql (player, name, text)
   
    local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ?? LIKE ?", "adminNote", "players", "UID", uid ), -1 )
    local adminnote = tostring ( result[1]["adminNote"] )
    if text ~= adminnote then
        -- (D) macht automatisch das Datum hin
        if string.find(text, "(D)") then
            local rt = getRealTime ()
            local timesamp = rt.timestamp
            text = string.gsub(text, "%(D%)", getDateForAdminpanel(timesamp, true).." | ")
        end
        -- (N) macht automatisch deinen Namen hin
        if string.find(text, "(N)") then
            text = string.gsub(text, "%(N%)", "| @"..getPlayerName(player))
        end
         -- (M) macht automatisch eine Verwarnung also mündlich
         if string.find(text, "(M)") then
            local rt = getRealTime ()
            local timesamp = rt.timestamp
            text = string.gsub(text, "%(M%)",  getDateForAdminpanel(timesamp, true).." | Mündl. Verwarnung wegen GRUND | @"..getPlayerName(player))
        end
        dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "players", "adminNote", text, "UID", uid )
        newInfobox (player, "Notiz von "..name.." wurde gespeichert.", 4)
    end
end
addEvent ( "saveAdminNoticeInMysql", true )
addEventHandler ( "saveAdminNoticeInMysql", getRootElement(), saveAdminNoticeInMysql )


function givePlayerWarn (player, target, points, warnTime, reason)
    print("givePlayerWarn")
    local adminlvl = getAdminLevel ( player )
   -- if target == getPlayerName(player) then
        if target and playerUID[target] then --// Ob Spieler angeben und ob er exestiert
            local uid = playerUID[target]
            if points then --// Ob Punkte da sind und diese größer oder gleich 0 sind
                if tonumber(points) >= 0 then --// Ob Punkte da sind und diese größer oder gleich 0 sind
                    if warnTime and tostring(warnTime) then --// Ob die Zeit (ZEIT UND EINHEIT) vorhanden ist
                        -- // Zeitberechnung
                        local time = string.match (warnTime, "%d+")
                        local timeUnit = string.match (warnTime, "%a+")
                        local DefWarnTime, trueWarnTime =  calculateWarnTime (time, timeUnit )

                        if tonumber(DefWarnTime) then
                            print( DefWarnTime, trueWarnTime )
                            if string.len(reason) > 0 then
                                local rt = getRealTime ()
                                local timesamp = rt.timestamp
                                local time = (timesamp+DefWarnTime)
                                giveAutomaticPenalty(player, target, reason)
                                -- // Wenn Online
                                for playeritem, key in pairs(adminsIngame) do
                                    outputChatBox ( getPlayerName ( player ).." hat "..target.." wegen ´"..reason.."´ einen Warn für "..trueWarnTime.." mit "..points.." Punkten gegeben.", playeritem, 200, 200, 0, true )
                                end
                                if getPlayerFromName(target) then
                                    local taget = getPlayerFromName(target)
                                    if adminlvl >= getAdminLevel ( target ) then
                                        dbExec ( handler, "INSERT INTO ?? ( ??,??,??,??,??,??) VALUES (?,?,?,?,?,?)", "warns", "UID", "AdminUID", "reason", "time","penaltyPoints", "ExpiryDate", playerUID[target], playerUID[getPlayerName(player)], reason, warnTime, points , time )
                                        -- // Nachrichten
                                        outputChatBox ( "------------------------------------\nDu wurdest von "..getPlayerName(player).." verwarnt.\nGrund: "..reason.."\nAblaufzeit: "..trueWarnTime.."\nStrafpunkte: "..points.."\nFür weitere Informationen gebe /warns ein.\n------------------------------------", getPlayerFromName(target), 255, 0, 0 )
                                    else
                                        newInfobox (player, target.." ist ein höherer Admin als du.", 3)
                                        newInfobox (target, getPlayerName(player).." hat versucht dich zu verwarnen.", 2)
                                    end
                                -- // Wenn Offline
                                else
                                    local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ?? LIKE ?", "Adminlevel", "userdata", "UID", uid ), -1 )
                                    local targetAdminlevel =  tonumber ( result[1]["Adminlevel"] )
                                    if adminlvl >= targetAdminlevel then
                                        dbExec ( handler, "INSERT INTO ?? ( ??,??,??,??,??,??) VALUES (?,?,?,?,?,?)", "warns", "UID", "AdminUID", "reason", "time","penaltyPoints", "ExpiryDate", playerUID[target], playerUID[getPlayerName(player)], reason, warnTime, points , time )
                                        -- // Nachrichten
                                        offlinemsg ( "------------------------------------\nDu wurdest von "..getPlayerName(player).." verwarnt.\nGrund: "..reason.."\nAblaufzeit: "..trueWarnTime.."\nStrafpunkte: "..points.."\nFür weitere Informationen gebe /warns ein.\n------------------------------------", "Server", target )
                                    else    
                                        newInfobox (player, target.." ist ein höherer Admin als du.", 3)
                                    end
                                end
                               
                                    
                            else
                                newInfobox (player, "Kein gültiger Grund.", 3)
                            end
                        else
                            newInfobox (player, "Keine gültige Zeit.\nBeispiel: 12d, 2w oder 1m", 3)
                        end
                    else
                        newInfobox (player, "Keine gültige Zeit.\nBeispiel: 12d, 2w oder 1m", 3)
                    end
                else
                    newInfobox (player, "Gebe 0 oder mehr Strafpunkte an.", 3)
                end
            else
                newInfobox (player, "Gebe 0 oder mehr Strafpunkte an.", 3)
            end
        else
            newInfobox (player, "Den Spieler gibt es nicht.", 3)
        end
   -- else
   --     newInfobox (player, "Warum solltest du?", 3)
   -- end
end
addEvent ( "givePlayerWarn", true )
addEventHandler ( "givePlayerWarn", getRootElement(), givePlayerWarn )


function giveAutomaticPenalty (player, target, reason)
    if predefinedWarns[tostring(reason)] then

        print("gibt es ein predef")
    else
        print("gibt es keinen predef")
    end
end

-- // Warns Löschen

function isPermittedFordeleteWarn (player, id,adminUID, uid)
    local adminlvl = getAdminLevel ( player )
    local playerUID = playerUID[getPlayerName(player)]
    if adminlvl >= 7 then
        return true
    elseif adminUID == playerUID then
        return true
    else
        newInfobox (player, "Du drafst nur deine eigenen Warns löschen\noder dein Rang ist zu niedrig.", 3)
        triggerClientEvent ( player, "disableYes_deleteWarnQuery", getRootElement(), playerWarns[uid] )
        return false
    end
end
addEvent ( "isPermittedFordeleteWarn", true )
addEventHandler ( "isPermittedFordeleteWarn", getRootElement(), isPermittedFordeleteWarn )

function deleteWarn (player, id,adminUID, uid)
    
    newInfobox (player, "Erfolgreich gelöscht.",4)
    outputAdminLog ( getPlayerName ( player ).." hat den Warn von "..playerUIDName[adminUID].." an "..playerUIDName[uid].." mit der ID "..id.." gelöscht" )
    dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "warns", "ID", id )
    for playeritem, key in pairs(adminsIngame) do
        outputChatBox ( getPlayerName ( player ).." hat den Warn von "..playerUIDName[adminUID].." an "..playerUIDName[uid].." mit der ID "..id.." gelöscht", playeritem, 200, 200, 0, true )
    end
end
addEvent ( "deleteWarn", true )
addEventHandler ( "deleteWarn", getRootElement(), deleteWarn )