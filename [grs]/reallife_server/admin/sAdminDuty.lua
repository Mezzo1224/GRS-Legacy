local zOffsetPlayer, zOffsetVehicle = 1.55, 1.8
local sizePlayerMarker, sizeVehicleMarker = 0.5, 0.8
function enableAdminDuty (player)
    if hasPermission ( player, "canUseSuppmode" ) then
        local pName = getPlayerName(player)
        if aDuty[pName] then
            -- // Deaktivieren
            setElementHealth(player,  aDuty[pName].statsBefore.health)
            setPedArmor(player, aDuty[pName].statsBefore.armor)
            setElementModel ( player, aDuty[pName].statsBefore.model )
            infobox (player, "Du hast den Adminmodus verlassen.", "info", 10)
            destroyElement(aDuty[pName].arrowMarker)
            aDuty[pName] = nil

            removeEventHandler ( "onVehicleEnter", getRootElement(), enterVehicle_aDuty )
            removeEventHandler ( "onVehicleExit", getRootElement(), exitVehicle_aDuty  )
        else
            -- // Aktivieren

            aDuty[pName] = {
                arrowMarker = createMarker ( 0, 0, 0, "arrow", 0.5, 3, 111, 252, 230 ),
                statsBefore = {
                    health = getElementHealth(player), 
                    armor = getPedArmor(player),
                    model = getElementModel(player)
                }
            }
            setMarkerSize ( aDuty[pName].arrowMarker, sizePlayerMarker  )    
            attachElements ( aDuty[pName].arrowMarker, player, 0, 0, zOffsetPlayer )
            setElementModel ( player, ServerConfig["admin"].aDutyModel )
            infobox (player, "Du hast den Adminmodus betreten.", "info", 10)
        
            -- // Fahrzeuge
            addEventHandler ( "onVehicleEnter", getRootElement(), enterVehicle_aDuty )
            addEventHandler ( "onVehicleExit", getRootElement(), exitVehicle_aDuty)
        end
    end
end
addCommandHandler ( "smode", enableAdminDuty )
addCommandHandler ( "aduty", enableAdminDuty )




function enterVehicle_aDuty (player, seat, jacked)
    local pName = getPlayerName(player)
    print(" pre Fahrzeug drin ", seat)
    if isInAdminDuty (player) then
        if seat == 0 then
            print(" Fahrzeug drin ")
            detachElements ( aDuty[pName].arrowMarker, player)
            attachElements ( aDuty[pName].arrowMarker, source, 0, 0, zOffsetVehicle )
            setMarkerSize ( aDuty[pName].arrowMarker, sizeVehicleMarker  )
        end
    end
end


function exitVehicle_aDuty (player, seat, jacked)
    local pName = getPlayerName(player)
    if isInAdminDuty (player) then
        if isElementAttached(player) == true then
            detachElements ( aDuty[pName].arrowMarker, source)
            attachElements ( aDuty[pName].arrowMarker, player, 0, 0, zOffsetPlayer )
            setMarkerSize ( aDuty[pName].arrowMarker, sizePlayerMarker  )
        end
    end
end