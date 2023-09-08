function tuningTest ()
    local x,y,z = getElementPosition(getLocalPlayer ( ))
    local veh = createVehicle(551, x, y, z)
    warpPedIntoVehicle(getLocalPlayer ( ), veh)
    testColor ()
end
addCommandHandler("tt", tuningTest)