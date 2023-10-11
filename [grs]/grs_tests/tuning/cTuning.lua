currentTuningshop = nil
tuningVehicle = nil

function tuningTest ()
    local x,y,z = getElementPosition(getLocalPlayer ( ))
    local veh = createVehicle(551, x, y, z)
    warpPedIntoVehicle(getLocalPlayer ( ), veh)
    testColor ()
end
addCommandHandler("tt", tuningTest)


setElementPosition(getLocalPlayer(), -1945.0153808594,233.08157348633,33.853248596191)
if  getPedOccupiedVehicle(localPlayer) then
    setElementPosition(getPedOccupiedVehicle(localPlayer), -1945.0153808594,233.08157348633,33.853248596191)
    setElementFrozen(getPedOccupiedVehicle(localPlayer), false)
end
function toggleLight ()
    if isElement(light) then
        destroyElement(light)
    else
        local x, y, z = getElementPosition(tuningVehicle)
        light = createLight(0, x, y, z, 30)
    end
end

function copyVehicle ()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    local newDimension = math.random(1, 9999)
    -- // Orginal
    setElementPosition(vehicle, 0, 0, 0)
    setElementRotation(vehicle, 0, 0, 0)
    setElementDimension(vehicle, newDimension)
    setElementFrozen(vehicle, true)
    local vehiclePaintjob = getVehiclePaintjob(vehicle)
    local vehicleColors = {getVehicleColor(vehicle, true)}
    local vehiclePlate = getVehiclePlateText(vehicle)
    -- // Kopieren
    local newVehicle = createVehicle(getElementModel(vehicle), 0, 0, 0 )
    setVehiclePaintjob(newVehicle, vehiclePaintjob)
    setVehicleColor(newVehicle, unpack(vehicleColors))
    setVehiclePlateText(newVehicle, vehiclePlate)

    return newVehicle

end

function unfocusVehicle ()
    local vehicle = getPedOccupiedVehicle(localPlayer)

    removeEventHandler ( "onClientRender", root, rotateVehicle )
    setCameraTarget( getLocalPlayer() )
    destroyElement(tuningVehicle)
    unbindKey( "e", "down", unfocusVehicle ) 
    destroyTuningUI ()
    toggleHUD (true)
    -- // 
    local leavePos = tuningShops[currentTuningshop].position["leave"]
    setElementPosition(vehicle, leavePos[1], leavePos[2], leavePos[3])
    setElementRotation(vehicle, leavePos[4], leavePos[5], leavePos[6])
    setElementFrozen(vehicle, false)

end



function focusVehicle (shopName)

    if isElement(getPedOccupiedVehicle(localPlayer)) then
        tuningVehicle = copyVehicle ()
        local newDimension = math.random(1, 9999)
        local newX, newY, newZ =  -2054.3376464844,141.76748657227,28.645620727539

        setElementDimension(tuningVehicle, newDimension)
        setElementPosition(tuningVehicle, newX, newY, newZ)
        setElementFrozen(tuningVehicle, true)
        currentTuningshop = shopName
        toggleLight ()
        createTuningUI ()
        toggleHUD (false)
        --// Kamera auf das Fahrzeug ausrichten
        outputChatBox(shopName)
        setCameraTarget(tuningVehicle)
        addEventHandler ( "onClientRender", root, rotateVehicle )
        bindKey( "e", "down", unfocusVehicle ) 
        

    else
        outputChatBox("Du bist nicht in einem Fahrzeug.", 255, 0, 0)
    end
end
addEvent ( "focusVehicle", true )
addEventHandler ( "focusVehicle", getRootElement(), focusVehicle )

function toggleHUD (state)

    setPlayerHudComponentVisible("ammo", state)
    setPlayerHudComponentVisible("health", state)
    setPlayerHudComponentVisible("clock", state)
    setPlayerHudComponentVisible("money", state)
    setPlayerHudComponentVisible("wanted", state)
    setPlayerHudComponentVisible("weapon", state)
    setPlayerHudComponentVisible("radar", state)
end

function rotateVehicle()

    if isElement(tuningVehicle) then
        -- Drehgeschwindigkeit (in Grad pro Frame)
        local rotationSpeed = 0.6

        local rx, ry, rz = getElementRotation(tuningVehicle)
        print( rx )
        
        local newYaw = rz + tonumber(rotationSpeed)

        if newYaw >= 360 then
            newYaw = newYaw - 360
        end
        setElementRotation(tuningVehicle, rx, ry, newYaw)
    end
end
