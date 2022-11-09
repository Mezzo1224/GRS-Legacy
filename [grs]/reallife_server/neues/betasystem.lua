function newBetaKey (player, cmd, prefix, secondPrefix)
    if not prefix then
        prefix = "add"
    end
    if not secondPrefix or tonumber(secondPrefix) > 1 then
        secondPrefix = 3
    end
    if isAdminLevel(player, 7) then
        if prefix == "add" then
            local key1 = generateString ( 5 )
            local key2 = generateString ( 5 )
            local key3 = generateString ( 5 )
            local key = key1.."-"..key2.."-"..key3
            outputChatBox("Neuer Betakey: "..key,player,200, 200, 0)
            dbExec ( handler, "INSERT INTO betakeys (betakey) VALUES (?)", key )
        elseif prefix == "list" then
            outputChatBox("Betakeys:",player,200, 200, 0)
            local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ??", "betakeys" ), -1 )
            for i=1, #result do
                local key = tostring ( result[i]["betakey"])

                if result[i]["serial"] then
                    serial = tostring ( result[i]["serial"])
                    keyOwner = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "Name", "players", "Serial",serial ), -1 )[1]["Name"]
                else
                    serial = "N.a"
                    keyOwner = "N.a"
                end
                if tonumber(#result) == 0 then
                    outputChatBox("Keine Keys gefunden.",player,200, 200, 0)
                end
                if tonumber(secondPrefix) == 0 and tostring(keyOwner) == "N.a" or tonumber(secondPrefix) == 3 then
                    outputChatBox(key.." - "..serial.." - "..keyOwner,player,200, 200, 0)
                elseif tonumber(secondPrefix) == 1 and tostring(keyOwner) ~= "N.a"  then
                    outputChatBox(key.." - "..serial.." - "..keyOwner,player,200, 200, 0)
                end
            end
        end
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht berechtigt.", 5000, 125, 0, 0 )
    end
end
addCommandHandler("betakey", newBetaKey)
addCommandHandler("beta", newBetaKey)


function submitBetaKey (betakey)
    local player = client 
    print(betakey)
    if dbExist ( "betakeys", "betakey LIKE '"..betakey.."'") then
        if dbExist ( "betakeys", "serial LIKE ''") then
            dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "betakeys", "serial", getPlayerSerial(player), "betakey", betakey )
            triggerClientEvent ( player, "infobox_start", getRootElement(), "Erfolgreich!\nDu wirst in 5 Sekunden\n vom Server geworfen.", 5000, 56, 217, 28 )
            setTimer ( kickPlayer, 5000, 1, player, "Server","Betaverifizierung" )
        else
            triggerClientEvent ( player, "infobox_start", getRootElement(), "Der Key ist bereits vergeben.", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "Key existiert nicht.", 5000, 125, 0, 0 )
    end
end
addEvent ( "submitBetaKey", true )
addEventHandler ( "submitBetaKey", getRootElement(), submitBetaKey )


function isBeta ()
    return betasystem
end