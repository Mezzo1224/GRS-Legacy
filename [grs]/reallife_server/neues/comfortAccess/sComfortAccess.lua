-- comfort access

vehiclesWithComfort = {}
vehiclesFromCol = {}



function enableComfortAccess (vehicle, owner, enableWelcome, enableEnginetoggle, enableLockWhenEntered)
    local x, y, z = getElementPosition ( vehicle ) 
    local rotZ = getElementRotation ( vehicle )
    local veh = vehicle
    vehiclesWithComfort[veh] = {
        owner = owner,
        enableWelcome = enableWelcome,
        enableEnginetoggle = enableEnginetoggle,
        enableLockWhenEntered = enableLockWhenEntered,
        col = createColSphere ( x, y, z, 6 )
    }
    local col = vehiclesWithComfort[veh].col
    attachElements(col, veh)
    vioSetElementData(col, "isComfortCol", true)
    -- // Events
    vehiclesFromCol[col] = veh
    addEventHandler ( "onColShapeHit", col, colHitUnlockVeh )
    addEventHandler ( "onColShapeLeave", col, colHitLockVeh )

    -- // Zweiter Test
    addEventHandler ( "onVehicleEnter", getRootElement(), closeWhenEnterOrExit ) -- // Wenn er reingegangen ist wird das Auto verschlossen
   addEventHandler ( "onVehicleExit", getRootElement(), closeWhenEnterOrExit ) -- // Wenn er rausgeht wird es auch verschlossen

end

function  cv (player)
   -- local veh = createVehicle ( 560, x, y, z, 0, 0, rotZ )
  --  warpPedIntoVehicle(player,veh)
    enableComfortAccess (source, player, true, true, true)
end
addEventHandler ( "onVehicleEnter", getRootElement(), cv )

--[[
function cv (player)
    local x, y, z = getElementPosition ( player ) 

    local rotZ = getElementRotation ( player )
    id = id + 1
    local veh = createVehicle ( 560, x, y, z, 0, 0, rotZ )
    warpPedIntoVehicle(player,veh)

    vehicles[veh] = {
        id = id,
        comfortAccess = true,
        comfortAccessExpanted = true,
        col = createColSphere ( x, y, z, 7 )
    }
    local col = vehicles[veh].col
    attachElementToElement(col, veh)

    -- // Events
    vehiclesFromCol[col] = veh
    addEventHandler ( "onColShapeHit", col, OpenVeh )
    addEventHandler ( "onColShapeLeave", col, CloseVeh )

    -- // Zweiter Test
    addEventHandler ( "onVehicleEnter", getRootElement(), closeveh2 ) -- // Wenn er reingegangen ist wird das Auto verschlossen
   addEventHandler ( "onVehicleExit", getRootElement(), closeveh2 ) -- // Wenn er rausgeht wird es auch verschlossen

end
addCommandHandler("cv", cv)--]]

function closeWhenEnterOrExit (player)
    setVehicleLocked(source, true)

    setVehicleOverrideLights ( source, 1 )
    vioSetElementData ( source, "light", false)
end




function colHitLockVeh (player)
    
    local veh = vehiclesFromCol[source]
    if vehiclesWithComfort[veh].col == source then
        setVehicleOverrideLights ( veh, 2 )
        vioSetElementData ( veh, "light", true)
        setVehicleLocked(veh, true)
        setVehicleEngineState ( veh, false )
        setVehicleDoorState(veh, 2, 0 )
        playLockSound(player, veh)
        print(  tostring(vioGetElementData(source, "isComfortCol", true)) )
    end
end

function colHitUnlockVeh (player)

    local veh = vehiclesFromCol[source]
    if vehiclesWithComfort[veh].col == source then
        setVehicleOverrideLights ( veh, 2 )
        vioSetElementData ( veh, "light", true)
        setVehicleLocked(veh, false)
        setVehicleEngineState ( veh, true )
        setVehicleDoorState(veh, 2, 1 )
        playLockSound(player, veh)
        print(  tostring(vioGetElementData(source, "isComfortCol", true)) )
    end
end


function playLockSound(player, veh)
    local x, y, z = getElementPosition ( veh ) 
    local players = getElementsWithinRange(x, y, z, 50, "player")
	for i,v in ipairs(players) do
		if v and isElement(v) then
            triggerClientEvent ( player, "sound", player, x,y,z )
		end
	end   
end