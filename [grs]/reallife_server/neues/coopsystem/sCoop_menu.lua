function getCoopMenuData (player, coopID)
    triggerClientEvent ( player, "setCoopMenuData", getRootElement(), formNumberToMoneyString (cooperation[coopID].storedMoney),cooperation[coopID].storedDrugs,cooperation[coopID].storedMats,cooperation[coopID].coopLevel,cooperation[coopID].coopTuningLevel,cooperation[coopID].coopMaxVehicles   )
    
    -- Fahrzeuge 
    if getCooperationCurrentVehicles(coopID) > 0 then
        for i, veh in pairs(cooperationVehicleList[coopID]) do 
            local x,y,z = getElementPosition(veh)
            local location = getZoneName ( x, y, z )..", "..getZoneName ( x, y, z, true )
            local rang, fuel =  cooperationVehicle[veh].rang ,vioGetElementData ( veh, "fuelstate")
            triggerClientEvent ( player, "addToCoopGridlist", getRootElement(),"vehicles", veh, location, rang, fuel  )	
        end
    end
    -- Ränge
    local p1, p2,p3,p4 = getRankPaydays ( coopID )
    for rank, name in pairs(cooperationRanks[coopID]) do 
        if rank ~= "payday" then
            triggerClientEvent ( player, "addToCoopGridlist", getRootElement(),"ranks", name, rank  )	
        end
    end
    -- Member
    for name, state in pairs(cooperation[coopID].members) do 
        triggerClientEvent ( player, "addToCoopGridlist", getRootElement(),"members", name, state  )	
    end
end
addEvent ( "getCoopMenuData", true)
addEventHandler ( "getCoopMenuData", getRootElement(),  getCoopMenuData)

function openCoopMenu ( player )
    local coopID, coopRang = getPlayerCoopData ( player )
    if coopID > 0 then
        if not cooperation[coopID].picture or checkImageForUsage ( cooperation[coopID].picture ) == false then
            pic = false
        else
            pic = cooperation[coopID].picture
        end
        triggerClientEvent ( player, "openCoopMenu", player, coopID, cooperation[coopID].coopType, pic )
    else
        newInfobox(player,"Du bist in keiner Firma/Gang.", 3)
    end
end
addCommandHandler("unternehmen",openCoopMenu )
addCommandHandler("gang",openCoopMenu )
addCommandHandler("firma",openCoopMenu )

function setCoopRankName ( player, rank, newRankName)
    local coopID, coopRang = getPlayerCoopData ( player )
    if coopID > 0 and coopRang == 4 then
        if string.len(newRankName) >= 3 then
            cooperationRanks[coopID][rank] = newRankName
            dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "cooperations", "Rang"..rank.."", newRankName, "ID", coopID )
            sendMessageToCooperation ( getPlayerName(player).." hat den Rang "..rank.."  zu "..newRankName.." geändert.", coopID)
        else
            newInfobox(player,"Mindestens 3 Zeichen.", 3)    
        end
    else
        newInfobox(player,"Du bist in keiner Firma/Gang oder nicht befugt.", 3)
    end
end
addEvent ( "setCoopRankName", true )
addEventHandler ( "setCoopRankName", getRootElement(), setCoopRankName  )
-- // Fahrzeuge
coopVehBlip = {}
coopVehBlipTimer = {}
function findCoopVehicle(veh)
    local pName = getPlayerName(client)
    if coopVehBlip[pName] then
        destroyElement(coopVehBlip[pName])
    end
    if isTimer(coopVehBlipTimer[pName]) then
        killTimer(coopVehBlipTimer[pName])
        coopVehBlipTimer[pName] = nil
    end
    coopVehBlip[pName]  = createBlipAttachedTo(veh, 0, 3 )
    coopVehBlipTimer[pName] = setTimer(destroyElement,10000, 1,coopVehBlip[pName]  )
    setElementVisibleTo ( coopVehBlip[pName], root, false )
    setElementVisibleTo(coopVehBlip[pName], client, true)

end
addEvent ( "findCoopVehicle", true )
addEventHandler ( "findCoopVehicle", getRootElement(), findCoopVehicle  )


function sellCoopVehicle (veh)
    local coopID, coopRang = getPlayerCoopData ( client ) 
    local player = client
    if coopRang == 4 then
        if not getVehicleOccupant ( veh ) then
            local id = cooperationVehicle[veh].id
            local model = getVehicleModelFromName(getVehicleName(veh))
            -- // Geld zurückgeben
            local price = (carprices[model] / 100) * 50
			if not price then
				price = 0
			end
            newInfobox(player,"Du hast das Fahrzeug für  "..formNumberToMoneyString (price).." verkauft.", 4)
            sendMessageToCooperation ( getPlayerName(player).." hat das Fahrzeug ("..getVehicleName(veh)..") für "..formNumberToMoneyString (price).." verkauft.", coopID)
            vioSetElementData ( player, "money", vioGetElementData ( player, "money") + price )
            -- // Aus SQL entfernen
            dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "cooperations_vehicles", "ID", id )
            -- // Serverseitig
            destroyElement(veh)
            cooperationVehicleList[coopID][id] = nil
            cooperationVehicle[veh] = nil
            cooperation[coopID].vehicles = cooperation[coopID].vehicles - 1
            -- // Refresh
            triggerClientEvent ( player, "refreshCoopData", player, coopID )
        else
            newInfobox(player,"Fahrzeug muss leer sein.", 3)    
        end
    else
        newInfobox(player,"Nicht befugt.", 3)    
    end
end
addEvent ( "sellCoopVehicle", true )
addEventHandler ( "sellCoopVehicle", getRootElement(), sellCoopVehicle  )