tutorialElements = {}
tutorialElements.vehicles = {}
tutorialElements.peds = {}
tutorialElements.objects = {}
tutorialElements.misc = {}

function startTutorial ()
    
    -- // Kamera setzen
   -- fadeCamera( true, 5)
    --setCameraMatrix( -1104.8774414062, 387.83630371094, 74.671798706055, -1104.2004394531, 388.55194091797, 74.499977111816)
    
   -- startBus()
end

-- // Debug Tutorial Start

tutorialElements.vehicles["bus"] =  createVehicle(431,  -1132.9333496094,1113.9497070312,37.398262023926,-1.6950384378433,0.017058931291103 ,137.26216125488)
tutorialElements.peds["bus_driver"] = createPed(17, 0, 0, 0, 0)
warpPedIntoVehicle ( tutorialElements.peds["bus_driver"], tutorialElements.vehicles["bus"] )
setVehicleLocked ( tutorialElements.vehicles["bus"], false )    
 
--setElementPosition(getLocalPlayer(), -1132.5493164062,1107.9935302734,38.444778442383)

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer, seat)
        if thePlayer == getLocalPlayer()  then
            startBus ()
        end
    end
)

function startBus ()
    print("Starte Bus")
    local cam = getCamera()
    setElementPosition( cam, 0,0,0 )
    attachElements( cam, tutorialElements.vehicles["bus"], 0, -20,3, 0,0,0 )

    setPedControlState ( tutorialElements.peds["bus_driver"], "accelerate", true )

    -- // Fahrende Autos
    tutorialElements.vehicles["dVeh1"] =  createVehicle(482,-1326.8225097656,887.81158447266,47.011299133301, 1.1215782165527,0.00036589533556253 ,316.28143310547)
    tutorialElements.vehicles["dVeh2"] =  createVehicle(466,-1360.4674072266,860.68341064453,47.486419677734,  1.0763922929764,0.012065635994077 ,315.76385498047)
    tutorialElements.peds["dDriver1"] = createPed(17, 0, 0, 0, 0)
    tutorialElements.peds["dDriver2"] = createPed(17, 0, 0, 0, 0)
    warpPedIntoVehicle ( tutorialElements.peds["dDriver1"], tutorialElements.vehicles["dVeh1"] )
    setPedControlState ( tutorialElements.peds["dDriver1"], "accelerate", true )
    warpPedIntoVehicle ( tutorialElements.peds["dDriver2"], tutorialElements.vehicles["dVeh2"] )
    setPedControlState ( tutorialElements.peds["dDriver2"], "accelerate", true )



    -- // Verzögert
  
    setTimer ( function()
        print("Delayed Spawn")
        tutorialElements.vehicles["dVeh3"] =  createVehicle(455, -1132.7689208984,1122.5333251953,37.212032318115,-1.7063131332397,-0.060129038989544 ,135.92816162109)
        tutorialElements.peds["dDriver3"] = createPed(17, 0, 0, 0, 0)
        warpPedIntoVehicle ( tutorialElements.peds["dDriver3"], tutorialElements.vehicles["dVeh3"] )
        setPedControlState ( tutorialElements.peds["dDriver3"], "accelerate", true )

        -- // Nährt sich den Unfall, also stoppen!
        tutorialElements.misc["stopVehicleCol"] =  createColCircle(-1302.7318115234,943.36370849609, 3 )
        addEventHandler("onClientElementColShapeHit", root, stopVehicleNearCollison)
        


	end, 2400, 1 )


    

    -- // Auto stehen geblieben
    tutorialElements.vehicles["dVeh_crashed"] =  createVehicle(402, -1344.2550048828,903.30792236328,46.28787612915,-0.63017475605011,6.3463091850281 ,135.99142456055)
    tutorialElements.vehicles["dVeh_mechanic"] =  createVehicle(525, -1349.0748291016,898.44598388672,46.911964416504,1.217257142067,5.3603515625 ,135.33229064941)
    setVehicleLightState ( tutorialElements.vehicles["dVeh_crashed"], 0, 1 )
    setVehicleLightState ( tutorialElements.vehicles["dVeh_crashed"], 1, 1 )

    setVehicleSirensOn ( tutorialElements.vehicles["dVeh_mechanic"], true )
    setVehicleEngineState(tutorialElements.vehicles["dVeh_mechanic"], true)
    setVehicleEngineState(tutorialElements.vehicles["dVeh_crashed"], false)
    setVehicleDoorOpenRatio(tutorialElements.vehicles["dVeh_crashed"], 0, 0.3)
    setElementHealth(tutorialElements.vehicles["dVeh_crashed"], 400)

    tutorialElements.peds["dPed_mechanic"] = createPed(50,  -1342.1281738281,906.51678466797,46.527835845947,226.90046691895)
    tutorialElements.peds["dPed_guyWithCrashedCar"] = createPed(98, -1341.2185058594,905.68658447266,46.527477264404,45.020458221436)
    setPedAnimation(tutorialElements.peds["dPed_mechanic"], "ped", "idle_armed")
    setPedAnimation(tutorialElements.peds["dPed_guyWithCrashedCar"], "ped", "IDLE_chat")

    -- // Polizeihelikopter
    tutorialElements.vehicles["policeHelicopter"] =  createVehicle(497, -1356.6311035156,783.0009765625,98.454208374023,-0,0 ,37.037628173828)
    tutorialElements.peds["policeHelicopter_pilot"] = createPed(281,  0,0,0)
    warpPedIntoVehicle (  tutorialElements.peds["policeHelicopter_pilot"], tutorialElements.vehicles["policeHelicopter"] )
    setPedControlState (  tutorialElements.peds["policeHelicopter_pilot"], "accelerate", true )
    setPedControlState (  tutorialElements.peds["policeHelicopter_pilot"], "steer_forward", true )
    setElementVelocity(tutorialElements.vehicles["policeHelicopter"], 0, 0, 1.05)
end


function enableAllLights (vehicle)
    setVehicleLightState ( vehicle, 1, 0 )
    setVehicleLightState ( vehicle, 2, 0 )
    setVehicleLightState ( vehicle, 3, 0 )
    setVehicleLightState ( vehicle, 4, 0 )
end

function stopVehicleNearCollison ( )
    if source == tutorialElements.vehicles["dVeh3"] then
        print("STOP")
        setPedControlState ( tutorialElements.peds["dDriver3"], "accelerate", false )
        setPedControlState ( tutorialElements.peds["dDriver3"], "handbrake", true )
    else
        print("Nicht richtiges Veh.")
    end
end
--startBus ()
--startTutorial ()
-- // Dev Utility
function showPlayerInfoInConsole()
    local player = getLocalPlayer()

    -- Hole die Spielerkoordinaten, Rotation, Dimension und Interior
    local x, y, z = getElementPosition(player)
    local rx, ry, rz = getElementRotation(player)
    local dimension = getElementDimension(player)
    local interior = getElementInterior(player)
    local Cx, Cy, Cz, lx, ly, lz = getCameraMatrix ()
    -- Gib die Informationen in die Konsole aus
    outputConsole("Spieler-Informationen:")
    outputConsole("Koordinaten: " .. x .. "," .. y .. "," .. z)
    outputConsole("Rotation: X: " .. rx .. "," .. ry .. " ," .. rz)
    outputConsole("Beides Einzeilig: " .. x .. "," .. y .. "," .. z.."," .. rx .. "," .. ry .. " ," .. rz)
    outputConsole("Kamera: "..Cx .. ", "..Cy .. ", "..Cz .. ", "..lx .. ", "..ly .. ", "..lz)
    outputConsole("Dimension: " .. dimension)
    outputConsole("Interior: " .. interior)
end

-- Füge einen Befehl hinzu, um Spielerinformationen in der Konsole anzuzeigen (z.B., /playerinfo)
addCommandHandler("coords", showPlayerInfoInConsole)


-- // Kamera
