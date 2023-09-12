--[[
    // Hier sind sämtliche Funktionen, die keine Angaben zu Spielern benötigen.
    // Also Funktionen wie Fraktions-Fahrzeuge respawnen oder Teammitglieder auflisten
]]

-- // Tabellen
aDuty = {}

function getAdminlvlName (lvl, withHex)
    if withHex == true then
        return ServerConfig["admin"]["ranks"][lvl].hexColor..""..ServerConfig["admin"]["ranks"][lvl].name
    else
        return ServerConfig["admin"]["ranks"][lvl].name
    end
end
function listAdmins ( player )
    if vioGetElementData ( player, "loggedin" ) == 1 then
        outputChatBox ( "Momentan online:", player, 0, 100, 255 )
        for key, index in pairs(adminsIngame) do
            outputChatBox ( getPlayerName(key).." | "..ServerConfig["admin"]["ranks"][index].hexColor..""..ServerConfig["admin"]["ranks"][index].name, player, 255, 255, 255,true )
        end
    end
end
addCommandHandler ( "admins", listAdmins )

-- // TODO fertig machen
function enableAdminDuty (player)
    if hasPermission ( player, "canUseSuppmode" ) then
        local pName = getPlayerName(player)
        aDuty[pName] = {
            arrowMarker = nil,
            statsBefore = {
                health = getElementHealth(player), 
                getPedArmor = getPedArmor(player),
                model = getElementModel(player)
            }
        }
        -- aDuty[pName].arrowMarker
    end
end
addCommandHandler ( "smode", listAdmins )
addCommandHandler ( "aduty", listAdmins )