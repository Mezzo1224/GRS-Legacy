factionVehicle = {}
factionVehicleList = {}
fraktionsNamen = { [1]="SFPD", [2]="Cosa Nostra", [3]="Triaden", [4]="Terroristen", [5]="SAN News", [6]="FBI", [7]="Los Aztecas", [8]="Army", [9]="Angels of Death", [10]="Sanitäter", [11]="Mechaniker", [12]="Ballas", [13]="Grove" }
fraktionsVehs = 0

factionColors = {} 
factionColors[1] = {51,1,1,1, 1}
factionColors[2] = {0, 0, 0, 0, 0}
factionColors[3] = {20, 148, 199, 255}
factionColors[4] = {3, 0, 8, 9}
factionColors[5] = {6, 6, 0, 0}
factionColors[6] = {0, 0, 0, 0}
factionColors[7] = {1, 1, 0, 0}
factionColors[8] = {0, 0, 0, 0}
factionColors[9] = {113, 113, 8, 9}
factionColors[10] = {0, 0, 0, 0}
factionColors[11] = {255, 255, 255, 255}
factionColors[12] = {22, 0, 85, 0}
factionColors[13] = {0, 238, 0}

-- // Costumcolors für bestimmte Fraktionsfahrzeuge
costumFactionColors = {}
costumFactionColors[9] = { 
    [463] = {  9, 119, 1  }, --   c1,c2,c3,c4, paintjob
    [487] = {  113, 113, 8, 9  }, 
    [413] = {  113, 113, 8, 9  },
    [566] = {  113, 113, 8, 9  },
    [422] = {  113, 113, 8, 9  }, 
    [415] = {  113, 113, 8  }
}

-- // Legt automatisch die ´costumFactionColors´ Tabelle an für Fraktionen ohne dieses Feature
for v, table in ipairs(factionColors) do 
	if not costumFactionColors[v] then
        costumFactionColors[v] = {}
    end
end

-- TODO REWORK
SFPD = createColCircle(-1603.8896484375, 675.7958984375, 100 )
SFPD1 = createColCircle(2272.560546875,2440.080078125, 100 )
Mafia = createColCircle(-688.0791015625,939.6416015625, 100 )
Mafia1 = createColCircle(2291.1953125,1725.3330078125, 100 )
Triaden = createColCircle(-2176.9521484375,684.6259765625, 100 )
FBI = createColCircle(-2432.5386, 533.1349, 100 )
AoD = createColCircle(-2207.2216796875,-2341.9423828125, 100 )
AoD1 = createColCircle(2489.853515625, 1568.423828125, 100 )
Medic = createColCircle(-2649.095703125,625.6962890625, 100 )
Terror = createColCircle(-1998.8271484375,-1563.93359375, 100 )
Army = createColCircle(-1340.4794921875,468.98046875, 200 )
Army1 = createColCircle(210.8173828125,1896.7294921875, 200 )
LTR = createColCircle(-2520.8505859375, -611.7421875, 100 )
Aztecas = createColCircle(-1314.8125, 2505.298828125, 100 )
Aztecas1 = createColCircle(693.6572265625,1963.7353515625, 100 )
Grove = createColCircle(2502.4208984375,-1668.2265625, 100 )
Ballas = createColCircle(-2205.6103515625, 49.3369140625, 100 )
Mechaniker = createColCircle(-2391.9763183594,-171.25736999512, 50 )

function getColShapeSpawnArea ( player )
    local faction = getPlayerFaction ( player )
    if faction == 1 then
        sp = SFPD
        sp2 = SFPD1
    elseif faction == 2 then
        sp = Mafia
        sp2 = Mafia1
    elseif faction == 3 then
        sp = Triaden
        sp2 = Triaden
    elseif faction == 4 then
        sp = Terror
        sp2 = Terror
    elseif faction == 5 then
        sp = LTR
        sp2 = LTR
    elseif faction == 6 then
        sp = FBI
        sp2 = FBI
    elseif faction == 7 then
        sp = Aztecas
        sp2 = Aztecas1
    elseif faction == 8 then
        sp = Army
        sp2 = Army1
    elseif faction == 9 then
        sp = AoD
        sp2 = AoD1 
    elseif faction == 10 then
        sp = Medic
        sp2 = Medic
    elseif faction == 11 then
        sp = Mechaniker
        sp2 = Mechaniker
    elseif faction == 12 then
        sp = Grove
        sp2 = Grove
    elseif faction == 13 then
        sp = Ballas
        sp2 = Ballas
    end
    return sp,sp2
end
function loadFactionCars ()
    local result =  dbQuery(handler,"SELECT * FROM fraktionen_vehicle")
    if result and devMode < 2 then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                local id = rows.ID
                local model = rows.Modell
                local FactionID = tonumber(rows.OwnerID)
                local Rang = tonumber(rows.Rang)
                local Level = tonumber(rows.Aufwertung)
                local SX = tonumber(rows.X)
                local SY = tonumber(rows.Y)
                local SZ = tonumber(rows.Z)
                local SXR = tonumber(rows.RX)
                local SYR = tonumber(rows.RY)
                local SZR = tonumber(rows.RZ)
                fraktionsVehs = fraktionsVehs+1
                local veh = createFactionVehicle (id,model,SX,SY,SZ,SXR,SYR,SZR,FactionID,Rang,Level)
				setTimer(setElementFrozen, 3000, 1, veh, true)
            end
            printDebug(fraktionsVehs.." Fraktionsfahrzeuge geladen.")
        end
    else
        printDebug("Der Laden der Fraktionsfahrzeuge wurde unterbunden.")
    end
end
addEventHandler("onResourceStart", resourceRoot, loadFactionCars )


-- // Werte für Fraktionsfahrzeuge
local function applyVehicleLevel (veh)
    local vehicleLevel = factionVehicle[veh].level
    if vehicleLevel == 0 then
        setElementHealth(veh, 1000)
    elseif vehicleLevel == 1 then
        setElementHealth(veh, 1500)
        setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh) + 10)
    elseif vehicleLevel == 2 then
        setElementHealth(veh, 2000)
        setVehicleHandling(veh, "maxVelocity", getVehicleHandling(veh) + 20)
    end
end

local function addFactionVehicleUpgrades(veh) 
    local faction =  factionVehicle[veh].faction
    local model =  getVehicleModelFromName(getVehicleName(veh))
	vioSetElementData ( veh, "sportmotor", ( faction == 10 and 3 or 2 ) )
	vioSetElementData ( veh, "bremse", ( faction == 10 and 3 or 2 ) )
	vioSetElementData ( veh, "antrieb", "awd" )
	if model == 552 then 
		setVehicleHandling(veh, "engineAcceleration", 19) 
		setVehicleHandling(veh, "maxVelocity", 250)
	elseif model == 456 then 
		setVehicleHandling(veh, "engineAcceleration", 20) 
		setVehicleHandling(veh, "maxVelocity", 250)
	end 
end 

local function addSirens(veh) 
    local faction =  factionVehicle[veh].faction
    local model = getVehicleModelFromName(getVehicleName(veh))
	-- Polizei --
	if faction == 1 then 
		if model == 426 then 
			addVehicleSirens( veh, 2, 2 )
			setVehicleSirens( veh, 2, -0.4, 0, 0.9, 0, 0, 200 )
		elseif model == 411 then 
			addVehicleSirens( veh, 2, 2 )
			setVehicleSirens( veh, 1, 0.3, 0, 0.7, 200, 0, 0 )
			setVehicleSirens( veh, 2, -0.3, 0, 0.7, 0, 0, 200 )
		end 
	-- Medic --
	elseif faction == 10 then 
		if model == 489 then 
			addVehicleSirens(veh, 2, 2)
			setVehicleSirens(veh, 1, 0.3, 1, 0.6, 200, 0, 0)
			setVehicleSirens(veh, 2, -0.3, 1, 0.6, 200, 0, 0)
		elseif model == 490 then 
			removeVehicleSirens(veh)
			addVehicleSirens(veh, 2, 2)
			setVehicleSirens(veh, 1, 0.3, 1, 0.6, 200, 0, 0)
			setVehicleSirens(veh, 2, -0.3, 1, 0.6, 200, 0, 0)	
		elseif model == 416 then 
			addVehicleSirens(veh, 5, 5, false, true, true, false)
			setVehicleSirens(veh, 1, 0, 0.9, 1.3, 255, 255, 255, 200, 200)
			setVehicleSirens(veh, 2, 0.4, 0.9, 1.3, 255, 0, 0, 200, 200)
			setVehicleSirens(veh, 3, -0.4, 0.9, 1.3, 255, 0, 0, 200, 200)
			setVehicleSirens(veh, 4, -1, -3.7, 1.45, 255, 0, 0, 200, 200)
			setVehicleSirens(veh, 5, 1, -3.7, 1.45, 255, 0,0, 200, 200)
		elseif model == 407 then 
			addVehicleSirens(veh, 4, 2, true, true, true, false)
			setVehicleSirens(veh, 1, 0.8, -4.4, -0.5, 255, 0, 0, 255, 255)
			setVehicleSirens(veh, 2, -0.8, -4.4, -0.5, 255, 0, 0, 255, 255)
			setVehicleSirens(veh, 3, -0.8, -3.9, 1.5, 255, 255, 0, 255, 255)
			setVehicleSirens(veh, 4, 0.8, -3.9, 1.5, 255, 255, 0, 255, 255)
		elseif model == 400 then 
			removeVehicleSirens(veh)
			addVehicleSirens(veh, 4, 2, true, true, true, false)
			setVehicleSirens(veh, 1, 0.8, 3.1, 1.8, 0, 0, 255, 255, 255)
			setVehicleSirens(veh, 2, -0.8, 3.1, 1.8, 0, 0, 255, 255, 255)
			setVehicleSirens(veh, 3, 0.8, -3.7, 1.3, 0, 0, 255, 255, 255)
			setVehicleSirens(veh, 4, -0.8, -3.7, 1.3, 0, 0, 255, 255, 255)
		end 
	-- Mechaniker oder Feuerwehr --
	elseif faction == 11 then 
		if model == 525 then
			addVehicleSirens(veh, 3, 2, false, true, true, true)
			setVehicleSirens(veh, 1, 0.55, -0.5, 1.5, 255, 0, 0, 200, 200)
			setVehicleSirens(veh, 2, -0.55, -0.5, 1.5, 255, 0, 0, 255, 200)
			setVehicleSirens(veh, 3, 0, -0.5, 1.5, 255, 255, 0, 255, 200)
		elseif model == 552 then 
			removeVehicleSirens(veh)
			addVehicleSirens(veh, 6, 2, true, true, true, false)
			setVehicleSirens(veh, 1, 1, -3.9, -0.5, 255, 0, 0, 255, 255)
			setVehicleSirens(veh, 2, -1, -3.9, -0.5, 255, 0, 0, 255, 255)
			setVehicleSirens(veh, 3, -1, -3.9, 0.8, 0, 0, 255, 255, 255)
			setVehicleSirens(veh, 4, 1, -3.9, 0.8, 0, 0, 255, 255, 255)
			setVehicleSirens(veh, 5, 0.8, 3.3, -0.1, 0, 0, 255, 255, 255)
			setVehicleSirens(veh, 6, -0.7, 3.3, -0.1, 0, 0, 255, 255, 255)
		end
	end 
end 

-- // Fraktionsfahrzeug erstellung
function createFactionVehicle (id, model, x, y, z, rx, ry, rz, faction, rang, level)
	if not dbExist ( "fraktionen_buy_vehicle", "Modell LIKE '"..model.."' AND OwnerID LIKE '"..faction.."'") then
		price = carprices[model]	
		if not price then
			price = 200000
		end
		dbExec ( handler, "INSERT INTO fraktionen_buy_vehicle (Modell, Preis, OwnerID) VALUES (?, ?, ?)", model, price, faction  )   
	end
    local vehicle = createVehicle (  model,  x, y, z, rx, ry, rz, fraktionNames[faction].." - "..rang)
    factionVehicle[vehicle] = {
        id = id, 
        faction = faction, 
        rang = rang,
        level = level,
        vehicle = vehicle
    }
    factionVehicleList[id] = factionVehicle[vehicle]
    -- // Koordinaten
	setElementPosition(vehicle, x, y, z)
	setVehicleRotation (vehicle, rx, ry, rz )
    setElementDimension(vehicle,0)
    setElementInterior(vehicle,0)
    -- // Funktionen
    applyVehicleLevel(vehicle)
    addFactionVehicleUpgrades(vehicle)
    addSirens(vehicle)
    addEventHandler ( "onVehicleEnter", vehicle, checkFactionCarOnEnter )

    -- // Spawn einstellen
    setVehicleRespawnPosition(vehicle,x,y,z,rx,ry,rz)
    toggleVehicleRespawn ( vehicle, true )
    setVehicleRespawnDelay ( vehicle, FCarDestroyRespawn * 1000 * 60 )
	setVehicleIdleRespawnDelay ( vehicle, FCarIdleRespawn * 1000 * 60 )

    --// Farben festlegen
    if factionColors[faction] and not costumFactionColors[faction][model] then
        c1, c2,c3,c4, paintjob = factionColors[faction][1], factionColors[faction][2],factionColors[faction][3],factionColors[faction][4], factionColors[faction][5]
    else
        c1, c2,c3,c4, paintjob = costumFactionColors[faction][model][1],costumFactionColors[faction][model][2],costumFactionColors[faction][model][3],costumFactionColors[faction][model][4],costumFactionColors[faction][model][5]
    end
    if paintjob then
        setVehiclePaintjob ( vehicle, paintjob )
    end
    if not c4 then
        c4 = 0
    end
    setVehicleColor ( vehicle, c1, c2,c3, c4 )
    if faction == 11 then
        setVehicleColor(vehicle, 255, 255, 255, 0, 255, 0, 0, 0, 0)
    end
    return vehicle
end

-- // Ab einer bestimmten FPS Anzahl gehen Siren net mehr an
-- // Das ist ein Workaround
function toggleSirens(player, key, keyState)
    local vehicle = getPedOccupiedVehicle(player)
    if not getVehicleSirensOn ( vehicle ) then
        setVehicleSirensOn ( vehicle, true ) 
    else
        setVehicleSirensOn ( vehicle, false ) 
    end
end

function checkFactionCarOnEnter ( player, seat )
    local faction = getPlayerFaction ( player )
    local rank = getPlayerRank ( player )
	local veh = source
    if factionVehicle[veh] and seat == 0 then
        if not isKeyBound ( player, "sub_mission", "down", policeComputer ) and isStateFaction(player) then
            bindKey ( player, "sub_mission", "down", policeComputer )
        end
		if isElementFrozen(veh) then
			 outputChatBox ( "Nutze /fbreak um die Handbremse zu lösen.", player, 125, 0, 0 )
		end
        if not isKeyBound ( player, "j", "down", toggleSirens ) and isStateFaction(player) or faction == 11 or faction == 10 then
            bindKey ( player, "j", "down", toggleSirens)
            if getFPSLimit(player) >= 50 then
                newInfobox (player, "Dein FPS Limit ist 50+, dadurch kann eventuell die Sirene\n nicht getätigt werden.\nDu kannst sie jedoch immer durch ´J´ de-/aktivieren.", 3)
            end
        end
           
        -- nix
        if faction == 8 then
            if getElementModel ( veh ) == 433 then

                setElementHealth ( player, 100 )
                setPedArmor ( player, 100 )
                setElementHunger ( player, 100 )

            elseif getElementModel ( veh ) == 432 then

                if vioGetElementData ( player, "job" ) ~= "tankcommander" then
                    opticExitVehicle ( player )
                    outputChatBox ( "Du hast nicht die erforderliche Klasse!", player, 125, 0, 0 )
                end

            elseif getElementModel ( veh ) == 425 or getElementModel ( veh ) == 520 then

                if vioGetElementData ( player, "job" ) ~= "air" then
                    opticExitVehicle ( player )
                    outputChatBox ( "Du hast nicht die erforderliche Klasse!", player, 125, 0, 0 )
                end

            elseif getElementModel ( veh ) == 563 or getElementModel ( veh ) == 595 then

                if vioGetElementData ( player, "job" ) ~= "marine" and seat == 0 then
                    opticExitVehicle ( player )
                    outputChatBox ( "Du hast nicht die erforderliche Klasse!", player, 125, 0, 0 )
                else
                    giveWeapon ( player, 46, 3, true )
                end
            end
        end
        local carRang = factionVehicle[veh].rang
        local factionID = factionVehicle[veh].faction
        if factionID ==  faction then
            if rank < carRang  then
                triggerClientEvent ( player, "infobox_start", getRootElement(), "Dein Rang ist zu niedrig.", 5000, 125, 0, 0 )
                opticExitVehicle ( player )
            end
        else
            local factionID = factionVehicle[veh].faction
            triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht in der Fraktion "..fraktionNames[factionID], 5000, 125, 0, 0 )
            opticExitVehicle ( player )
        end
    end
end


function findFactionVehicleByID (id)
    local id = tonumber(id)
    for i, var in pairs(factionVehicleList) do
        if tonumber(var.id) == id then
            local vehicle = var.vehicle
            return vehicle
        end
    end
end


function fCarBreak ( player )
    local faction = getPlayerFaction ( player )
    local veh = getPedOccupiedVehicle ( player )
    if veh then
         if factionVehicle[veh] and factionVehicle[veh].faction == faction then
            if getPedOccupiedVehicleSeat( player ) == 0 then
                if isElementFrozen(veh) then
                    setElementFrozen ( veh, false )
                    outputChatBox ( "Die Handbremse wurde gelöst.", player, 0, 125, 0 )
                else
                    setElementFrozen ( veh, true )
                    outputChatBox ( "Die Handbremse wurde angezogen.", player, 0, 125, 0 )
                end
			else
					triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht der Fahrer,", 5000, 125, 0, 0 )
			end
        else
            triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist\nnicht in der\nFraktion.", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nim Fahrzeug!", 5000, 125, 0, 0 )
    end
end
addEvent ( "fCarBreak", true )
addEventHandler ( "fCarBreak", getRootElement(),  fCarBreak )
addCommandHandler( "fbreak", fCarBreak)



function deleteBuyableCar ( player, id )
	
	local faction = getPlayerFaction ( player )
	triggerClientEvent ( player, "infobox_start", getRootElement(), "Fahrzeug gelöscht.", 5000, 125, 0, 0 )
	dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "fraktionen_buy_vehicle", "ID", id )
	
end
addEvent ( "deleteBuyableCar", true )
addEventHandler ( "deleteBuyableCar", getRootElement(),  deleteBuyableCar )

function parkFacCar ( player )
    local faction = getPlayerFaction ( player )
    local sp,sp2 = getColShapeSpawnArea ( player )
    local rank = getPlayerRank ( player )
    local veh = getPedOccupiedVehicle ( player )
    if veh then
        if factionVehicle[veh] then
            if rank >= 4 then
                if faction == factionVehicle[veh].faction then
                    if isElementWithinColShape (player, sp ) or isElementWithinColShape (player, sp2 ) then
						if getPedOccupiedVehicleSeat( player ) == 0 then
							local id = factionVehicle[veh].id
                            local x,y,z = getElementPosition(veh)
							local rx,ry,rz = getElementRotation(veh)
							setVehicleRespawnPosition(veh,x,y,z,rx,ry,rz)
							dbExec ( handler, "UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=?", "fraktionen_vehicle", "X", x,"Y", y,"Z", z,"RX", rx,"RY", ry,"RZ", rz, "ID", id  )
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Fahrzeug geparkt.", 5000, 255, 0, 0)
						else
							triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nicht der Fahrer,", 5000, 125, 0, 0 )
						end
                    else
                        triggerClientEvent ( player, "infobox_start", getRootElement(), "Ungültiges Gebiet.", 5000, 125, 0, 0 )
                    end
                else
                    triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist\nnicht in der\nFraktion.", 5000, 125, 0, 0 )
                end
            else
                triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nbefugt!", 5000, 125, 0, 0 )
            end
        end
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nim Fahrzeug!", 5000, 125, 0, 0 )
    end
end
addEvent ( "parkFacCar", true )
addEventHandler ( "parkFacCar", getRootElement(),  parkFacCar )
addCommandHandler( "fpark", parkFacCar)

function makeNewBuyableCar ( player, model, price, faction )
    dbExec ( handler, "INSERT INTO fraktionen_buy_vehicle (Modell, Preis, OwnerID) VALUES (?, ?, ?)", model, price, faction  )
    local fraktion = getPlayerFaction ( player )
    if tonumber(model) then
        if getVehicleNameFromModel(model) then
            if tonumber(price) then
                if tonumber(faction) then
                    if fraktionsNamen[faction] then
                        dbExec ( handler, "INSERT INTO fraktionen_buy_vehicle (Modell, Preis, OwnerID) VALUES (?, ?, ?)", model, price, faction  )
                    end
                end
            end
        end

    end
end
addEvent ( "makeNewBuyableCar", true )
addEventHandler ( "makeNewBuyableCar", getRootElement(),  makeNewBuyableCar )

function buyNewFactionCar ( player, model, price )
    local faction = getPlayerFaction ( player )
    local sp,sp2 = getColShapeSpawnArea ( player )

    if faction == 1 or faction == 6 or faction == 8 then
        depotFaction = 1
    elseif faction == 10 or faction == 11 then
        depotFaction = 10
    else
        depotFaction = faction
    end
    if factionDepotData["money"][depotFaction] >= tonumber(price) then
        if isElementWithinColShape (player, sp ) or isElementWithinColShape (player, sp2 ) then
            local model = getVehicleModelFromName(model)
            local x,y,z = getElementPosition(player)
            local rx,ry,rz = getElementPosition(player)
            local result, num_affected_rows, id =  dbPoll ( dbQuery( handler, "INSERT INTO fraktionen_vehicle (Modell, OwnerID, Rang, Aufwertung, X, Y, Z, RX, RY, RZ) VALUES(?,?,?,?,?,?,?,?,?,?)",  model, faction, 0, 0, x,y,z,rx,ry,rz), -1)
            local veh = createFactionVehicle (id ,model,x,y,z+0.3,rx,ry,rz,faction,0,0 )
            warpPedIntoVehicle(player, veh )
            factionDepotData["money"][depotFaction] = factionDepotData["money"][depotFaction] - price
			sendMSGForFaction ( getPlayerName(player).." hat einen "..getVehicleNameFromModel(model).." für "..price.."$ die Frakion gekauft.", faction ,0,255,0)
			outputLog ( "[CAR-BUY] "..getPlayerName(player).." hat einen "..getVehicleNameFromModel(model).." für "..price.."$ die Frakion gekauft.", "fraktion"..faction )
        else
            triggerClientEvent ( player, "infobox_start", getRootElement(), "Ungültiges Gebiet.", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "Zuwenig Geld\nIhr habt "..factionDepotData["money"][depotFaction].."$", 5000, 125, 0, 0 )
    end
end
addEvent ( "buyNewFactionCar", true )
addEventHandler ( "buyNewFactionCar", getRootElement(),  buyNewFactionCar )




function loadBuyableCars ( player )

    local fraktion = getPlayerFaction ( player )
   
    local result = dbQuery ( handler, "SELECT * FROM fraktionen_buy_vehicle WHERE ??=?", "OwnerID", fraktion )
    if result then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                local id = rows.ID
                local model = rows.Modell
                local price = rows.Preis



               
                triggerClientEvent ( player, "loadBuyableCars", getRootElement(), id,model, price)

            end
        end
    end
end
addEvent ( "loadBuyableCars", true )
addEventHandler ( "loadBuyableCars", getRootElement(),  loadBuyableCars )
