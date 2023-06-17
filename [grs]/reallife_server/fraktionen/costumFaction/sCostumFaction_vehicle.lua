

local function giveTuningLevelFeatures ( veh, coopID )
    local tuningLevel = cooperation[coopID].coopTuningLevel
    if tuningLevel > 0 then
        vioSetElementData ( veh, "sportmotor", tuningLevel )
        vioSetElementData ( veh, "bremse", tuningLevel )
    end
    if tuningLevel > 1 then
        vioSetElementData ( veh, "smokeable", true )
    end
    if tuningLevel > 2 then
        vioSetElementData ( veh, "wheelrefreshable", true )
    end
    if tuningLevel > 3 then
        vioSetElementData ( veh, "wheelrefreshable", true )
    end
end

local function setCoopVehicleColor ( veh, color ) 
    local c1 = tonumber ( gettok ( color, 1, string.byte( '|' ) ))
    local c2 = tonumber ( gettok ( color, 2, string.byte( '|' ) ))
    local c3 = tonumber ( gettok ( color, 3, string.byte( '|' ) ))
    local c4 = tonumber ( gettok ( color, 4, string.byte( '|' ) ))

    setVehicleColor ( veh, c1, c2, c3, c4 )

end

function createCooperationVehicle  (id, coopID, model, x,y,z, rx,ry,rz,rang, fuel, color, paintjob)
    local veh = createVehicle(model, x,y,z,rx,ry,rz, cooperation[coopID].nameShort)
    cooperationVehicle[veh] = {
        id = id,
        coopID = coopID,
        veh = veh,
        rang = rang,

    }
    cooperationVehicleList[coopID][id] = veh
    cooperation[coopID].vehicles = cooperation[coopID].vehicles + 1
    -- // Farben
    setCoopVehicleColor ( veh, color )
    if not paintjob then
        paintjob = 1
    end
    setVehiclePaintjob(veh, paintjob )
    -- // Upgrades
    giveTuningLevelFeatures ( veh, coopID )

    -- // Spawn
    setVehicleRespawnPosition(veh,x,y,z,rx,ry,rz)
    toggleVehicleRespawn ( veh, true )
	setVehicleRespawnDelay ( veh, FCarDestroyRespawn * 1000 * 60 )
	setVehicleIdleRespawnDelay ( veh, FCarIdleRespawn * 1000 * 60 )
    -- // anderes
    if not fuel then
        fuel = 100
    end
    vioSetElementData ( veh, "fuelstate", fuel )
    addEventHandler ( "onVehicleEnter", veh, checkCoopOnEnter )

    return veh
end


function checkCoopOnEnter ( player, seat )
    local coopID, coopRang = getPlayerCoopData ( player )
    local veh = source
    if cooperationVehicle[veh] and seat == 0 then
        local coopIDFromVeh, coopCarRang = cooperationVehicle[veh].coopID, cooperationVehicle[veh].rang
        if isElementFrozen(veh) then
            outputChatBox ( "Nutze /cbreak um die Handbremse zu lösen.", player, 125, 0, 0 )
       end
        if coopID ==  coopIDFromVeh then
            if coopRang < coopCarRang  then
                triggerClientEvent ( player, "infobox_start", getRootElement(), "Dein Rang ist zu niedrig.", 5000, 125, 0, 0 )
                opticExitVehicle ( player )
            end
        else
            local coopName = cooperation[coopIDFromVeh].name
            triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht im Unternehmen "..coopName, 5000, 125, 0, 0 )
            opticExitVehicle ( player )
        end
    end
end

-- // Unternehmens Menü von
function setCooperationVehicleRang (vehicle, rang)
    local id =  cooperationVehicle[vehicle].id
    cooperationVehicle[vehicle].rang = rang

    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ?? = ?", "cooperations_vehicles", "Rang", rang,  "ID", id )
    newInfobox(client,"Rang geändert.", 4)

end
addEvent ( "setCooperationVehicleRang", true )
addEventHandler ( "setCooperationVehicleRang", getRootElement(), setCooperationVehicleRang  )

function parkCooperationVehicle (vehicle)

    local id =  cooperationVehicle[vehicle].id
    local x,y,z = getElementPosition(vehicle)
    local rz,ry,rx = getElementRotation(vehicle, "ZYX")
    local coopID, coopRang = getPlayerCoopData ( client )
    if isElementWithinColShape(vehicle, cooperation[coopID].SpawnCol) then
        dbExec ( handler, "UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=? WHERE ?? = ?", "cooperations_vehicles", "X", x, "Y", y,"Z", z,"RX", rx,"RY", ry,"RZ", rz, "ID", id )
        newInfobox(client,"Erfolgreich geparkt.", 4)
        setVehicleRespawnPosition(vehicle ,x,y,z,rx,ry,rz)
    else
        newInfobox(client,"Du musst das Fahrzeug in der nähe des\nHauptquartieres parken.", 3)
    end
end
addEvent ( "parkCooperationVehicle", true )
addEventHandler ( "parkCooperationVehicle", getRootElement(), parkCooperationVehicle  )

function respawnCooperationVehicles_func ( coopID  )
    sendMessageToCooperation ( "Die Unternehmensfahrzeuge respawnen", coopID )
    for i, veh in pairs(cooperationVehicle) do 
        if not getVehicleOccupant ( veh.veh ) then
            if veh.coopID == coopID then
                respawnVehicle(veh.veh)
            end
        end
    end
    if coopRespawnTimer[coopID] then
        coopRespawnTimer[coopID] = nil
    end
    sendMessageToCooperation ( "Die Unternehmensfahrzeuge sind gerespawnt.", coopID )
end

function toggleBreakCoopVeh ( vehicle )
    if isElementFrozen(vehicle) then
        setElementFrozen(vehicle, false)
        newInfobox(client,"Handbremse gelöst.", 4)
    else
        setElementFrozen(vehicle, true)
        newInfobox(client,"Handbremse angezogen.", 4)
    end
end
addEvent ( "toggleBreakCoopVeh", true )
addEventHandler ( "toggleBreakCoopVeh", getRootElement(), toggleBreakCoopVeh  )

coopRespawnTimer = {}
function respawnCooperationVehicles ( player )
    local coopID, coopRang = getPlayerCoopData ( player )
    if tonumber(coopID) > 0 then
        if tonumber(coopRang) >= 3 then
            if not coopRespawnTimer[coopID] then
                newInfobox(player,"Breche den Respawn mit /cancelrespawn ab.", 4)
                sendMessageToCooperation ( "Die Unternehmensfahrzeuge respawnen in 15 Sekunden.", coopID )
                coopRespawnTimer[coopID] = setTimer(respawnCooperationVehicles_func, 1000*15, 1, coopID)
                addCommandHandler("cancelrespawn", cancelCooperationVehicleRespawn)
            else
                newInfobox(player,"Wird bereits gerespawnt.", 3)
            end
        else
            newInfobox(player,"Nicht befugt.", 3)
        end
    else
        newInfobox(player,"Du bist in keinem Unternehmen.", 3)
    end
end
addCommandHandler("corespawn", respawnCooperationVehicles)
addCommandHandler("grespawn", respawnCooperationVehicles)
addCommandHandler("frespawn", respawnCooperationVehicles)

function cancelCooperationVehicleRespawn ( player )
    local coopID, coopRang = getPlayerCoopData ( player )
    newInfobox(player,"Abgebrochen.", 3)
    sendMessageToCooperation ( "Der Respawn wurde abgebrochen.", coopID )
    killTimer( coopRespawnTimer[coopID] )
    coopRespawnTimer[coopID] = nil
    removeCommandHandler("cancelrespawn", cancelCooperationVehicleRespawn)
end

function changeVehicleColorDatabase ( player, veh, color )
    local id =  cooperationVehicle[veh].id
    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ?? = ?", "cooperations_vehicles", "color", color,  "ID", id )
    setCoopVehicleColor ( veh, color ) 
end
addEvent ( "changeVehicleColorDatabase", true )
addEventHandler ( "changeVehicleColorDatabase", getRootElement(), changeVehicleColorDatabase  )

function getCooperationCurrentVehicles (coopID)
    local vehs = tonumber(cooperation[coopID].vehicles)
    return vehs
end


