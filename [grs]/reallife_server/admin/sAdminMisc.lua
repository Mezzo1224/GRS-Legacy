--[[
    // Hier sind sämtliche Funktionen, die keine Angaben zu Spielern benötigen.
    // Also Funktionen wie Fraktions-Fahrzeuge respawnen oder Teammitglieder auflisten
]]


function listAdmins ( player )
    if vioGetElementData ( player, "loggedin" ) == 1 then
        outputChatBox ( "Momentan online:", player, 0, 100, 255 )
        for key, index in pairs(adminsIngame) do
            outputChatBox ( getPlayerName(key).." | "..ServerConfig["admin"]["ranks"][index].hexColor..""..ServerConfig["admin"]["ranks"][index].name, player, 255, 255, 255,true )
        end
    end
end
addCommandHandler ( "admins", listAdmins )
