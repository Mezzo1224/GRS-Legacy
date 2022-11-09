function checkForAdvertiser (player)
    local level	= tonumber(vioGetElementData ( player, "MainLevel" ))
    if dbExist ( "advertisedplayers", "geworbenerUID LIKE '".. playerUID[getPlayerName(player)].."'") then
        local pname = getPlayerName(player)
        local werberDB = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "werberUID", "advertisedplayers", "geworbenerUID", playerUID[pname] ), -1 )
        werber = playerUIDName[werberDB[1]["werberUID"]]
    
        local werbeData = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "PremiumCars","Bankgeld", "userdata", "UID", playerUID[werber] ), -1 )
        if not werbeData then

        end
        if level == 10 then
            outputChatBox("[Werbesystem] Du hast soeben 50.000$ erhalten, da du von "..werber.."  geworben wurdest und Level 10 erreicht hast.",player,58,223,0,true)
            vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney") + 50000)
            if getPlayerFromName (werber) then
                outputChatBox ( "[Werbesystem] Da "..getPlayerName(player).." Level 10 erreicht hast, erhältst du 100.000$.", getPlayerFromName (werber), 125, 0, 0 )
                vioSetElementData ( getPlayerFromName (werber), "bankmoney", vioGetElementData ( getPlayerFromName (werber), "bankmoney") + 50000)
            else
                offlinemsg ( "[Werbesystem] Da "..getPlayerName(player).." Level 10 erreicht hast, erhältst du 100.000$.", "Werbesystem",werber )
                dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Bankgeld", tonumber(werbeData[1]["Bankgeld"]) + 100000, "UID", werberDB[1]["werberUID"] )
            end
        elseif level == 20 then
            outputChatBox("[Werbesystem] Du hast soeben 100.000$ erhalten, da du von "..werber.."  geworben wurdest und Level 20 erreicht hast.",player,58,223,0,true)
            vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney") + 100000)
            if getPlayerFromName (werber) then
                outputChatBox ( "[Werbesystem] Da "..getPlayerName(player).." Level 20 erreicht hast, erhältst du eine Premium Fahrzeug Setzung.", getPlayerFromName (werber), 125, 0, 0 )
                vioSetElementData ( getPlayerFromName (werber), "PremiumCars", vioGetElementData ( getPlayerFromName (werber), "PremiumCars") + 1)
            else
                offlinemsg ( "[Werbesystem] Da "..getPlayerName(player).." Level 20 erreicht hast, erhältst du eine Premium Fahrzeug Setzung.", "Werbesystem",werber )
                dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "PremiumCars",  tonumber(werbeData[1]["PremiumCars"]) + 1, "UID", werberDB[1]["werberUID"] )
            end
        elseif level == 30 then
            if getPlayerFromName (werber) then
                outputChatBox ( "[Werbesystem] Da "..getPlayerName(player).." Level 30 erreicht hast, erhältst du zwei Premium Fahrzeug Setzung.", getPlayerFromName (werber), 125, 0, 0 )
                vioSetElementData ( getPlayerFromName (werber), "PremiumCars", vioGetElementData ( getPlayerFromName (werber), "PremiumCars") + 2)
            else
                offlinemsg ( "[Werbesystem] Da "..getPlayerName(player).." Level 30 erreicht hast, du zwei Premium Fahrzeug Setzung.", "Werbesystem",werber )
                dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "PremiumCars",  tonumber(werbeData[1]["PremiumCars"]) +2, "UID", werberDB[1]["werberUID"] )
            end
        end
    end
end