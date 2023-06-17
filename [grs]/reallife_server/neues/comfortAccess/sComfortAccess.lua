




vehiclesWithComfort = {}
vehiclesFromCol = {}

local function testGiveCV (player)
    local veh = getPedOccupiedVehicle ( player )
    giveVehicleComfortAccess (player, veh, true, true, true )
end
addCommandHandler("tcv", testGiveCV)

function giveVehicleComfortAccess (player, vehicle, enableWelcome, enableEnginetoggle, enableLockWhenEntered )

    local owner = vioGetElementData ( vehicle, "owner")
    local ownerID = playerUID[owner]
    local carslot = vioGetElementData ( vehicle, "carslotnr_owner" )
    if owner == getPlayerName(player) then
        if dbExist ( "vehicles", "UID LIKE '"..ownerID.."' AND Slot LIKE '"..carslot.."'") then
            local data = {
                enableWelcome = enableWelcome,
                enableEnginetoggle = enableEnginetoggle,
                enableLockWhenEntered = enableLockWhenEntered
            }
            dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=?", "vehicles", "comfortAccess", toJSON(data),"UID", ownerID, "Slot", carslot )
            print("Das Fahrzeug hat CA bekommen")
        end
    end
end

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

   local owner = vioGetElementData ( veh, "owner")
   local ownerID = playerUID[owner]
   local carslot = vioGetElementData ( veh, "carslotnr_owner" )

   print(owner, ownerID, carslot)
end


function  cv (player)
   -- local veh = createVehicle ( 560, x, y, z, 0, 0, rotZ )
  --  warpPedIntoVehicle(player,veh)
    enableComfortAccess (source, player, true, true, true)
end
addEventHandler ( "onVehicleEnter", getRootElement(), cv )


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