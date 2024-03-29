﻿------------------------------
-------- Urheberrecht --------
------- by [LA]Leyynen -------
-------- 2012 - 2013 ---------
------------------------------
---- Script by Noneatme ------

--local tuningmarker1 = createMarker(-2407.48, -99.55, 34.3, "cylinder", 1.2, 0, 0, 255, 100)
local tuningmarker2 = createMarker(-2385.77294, -99.72, 34.3, "cylinder", 1.2, 0, 0, 255, 100)
--local rampencol1 = createColCuboid(-2409.02954, -98.7626, 30, 9.7, 17, 12)
local rampencol2 = createColCuboid(-2393.0585, -98.916, 30, 9, 17, 10)
local haus_col = createColCuboid(-2411.545, -116.556, 30, 30, 37, 10)

addEvent("onVioOAmtCarTuning", true)

local veh_tuningtimer = {}

--[[addEventHandler("onMarkerHit", tuningmarker1, function(hitElement)
	if(getElementType(hitElement) == "player") and (isPedInVehicle(hitElement) == false) and (isMechaniker(hitElement) and isEmergencyOnDuty(hitElement)) then
		local car = getElementsWithinColShape(rampencol1, "vehicle")
		triggerClientEvent(hitElement, "onVioOrdnungsamtTuningGuiStart1", hitElement, car)
	end
end)]]

addEventHandler("onMarkerHit", tuningmarker2, function(hitElement)
	if(getElementType(hitElement) == "player") and (isPedInVehicle(hitElement) == false) and (isMechaniker(hitElement) and isEmergencyOnDuty(hitElement)) then
		local car = getElementsWithinColShape(rampencol2, "vehicle")
		triggerClientEvent(hitElement, "onVioOrdnungsamtTuningGuiStart2", hitElement, car)
	end
end)

local function sendMessageForAllInGarage(text)
	local players = getElementsWithinColShape(haus_col, "player")
	for i=1, #players do
		outputChatBox("[INFO]: "..text.."", players[i], 200, 200, 0)
	end
end


addEventHandler("onVioOAmtCarTuning", getRootElement(), function(vehicle, tuning, preis)
	if(isTimer(veh_tuningtimer[vehicle])) then
		outputChatBox("Dieses Fahrzeug wird bereits bearbeitet!", client, 150, 0, 0)
		return
	end
	local money = vioGetElementData (client, "money")
	if money >= preis then
		if tuning == "Kleine Reparatur" then	
			sendMessageForAllInGarage ( "Das Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wird bearbeitet!" )
			setElementFrozen ( vehicle, true )
			vioSetElementData ( client, "money", money - preis )
			veh_tuningtimer[vehicle] = setTimer(function(vehicle)
				fixVehicle(vehicle)
				setElementFrozen(vehicle, false)
				sendMessageForAllInGarage("Die kleine Reparatur von Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wurde erledigt!")
			end, 5000, 1,vehicle)
		elseif(tuning == "Nitro") then
			sendMessageForAllInGarage("Das Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wird bearbeitet!")
			setElementFrozen(vehicle, true)
			vioSetElementData (client, "money", money - preis)
			veh_tuningtimer[vehicle] = setTimer(function(vehicle)
				addVehicleUpgrade(vehicle, 1010)
				setElementFrozen(vehicle, false)
				sendMessageForAllInGarage("In dem Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wurde Nitro eingebaut!")
			end, 5000, 1,vehicle)
		elseif string.find ( tuning, "Sportmotor" ) or string.find ( tuning, "Bremse" ) then
			local stufe = tonumber ( gettok ( tuning, 2, 32 ) )
			local data = gettok ( tuning, 1, 32 )
			if ( vioGetElementData ( vehicle, string.lower(data) ) or 0 ) > stufe then
				outputChatBox("Das Fahrzeug hat es bereits eingebaut!", client, 255, 0, 0)
				return
			elseif ( vioGetElementData ( vehicle, string.lower(data) ) or 0 ) + 1 ~= stufe then
				outputChatBox("Das Fahrzeug braucht erst Stufe ".. ( stufe-1 ), client, 255, 0, 0)
				return
			elseif getPlayerRank ( client ) < 2 then
				outputChatBox("Nur ab Rang 2 erlaubt!", client, 255, 0, 0)
				return
			else
				if vioGetElementData (vehicle, "owner") then
					sendMessageForAllInGarage("Das Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wird bearbeitet!")
					setElementFrozen(vehicle, true)
					vioSetElementData (client, "money", money - preis)
					veh_tuningtimer[vehicle] = setTimer(function(vehicle, data, stufe)
						vioSetElementData ( vehicle, string.lower(data), stufe )
						giveSportmotorUpgrade ( vehicle )
						local Besitzer = vioGetElementData (vehicle, "owner")
						local Slot = vioGetElementData ( vehicle, "carslotnr_owner" )
						dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=?", "vehicles", data, stufe, "UID", playerUID[Besitzer], "Slot", Slot )
						setElementFrozen(vehicle, false)
						sendMessageForAllInGarage("Der neue Motor wurde erfolgreich in Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." eingebaut!")
					end, 5000, 1, vehicle, data, stufe )
				else
					outputChatBox ( "Fahrzeuge ohne Besitzer können kein Sportmotor besitzen!", client, 255, 0, 0 )
					return
				end
			end
			local gewinn = preis <= 500 and preis or preis <= 5000 and math.floor ( preis/5 ) or preis <= 50000 and math.floor ( preis/5 ) or preis <= 100000 and math.floor ( preis/10 ) or math.floor ( preis/20 )
			vioSetElementData ( client, "money", vioGetElementData ( client, "money" ) + gewinn )
			outputChatBox ( "Du bekommst dafür "..gewinn.."$", client, 0, 200, 0 )
		elseif tuning == "Frontantrieb" then
			sendMessageForAllInGarage("Das Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wird bearbeitet!")
			setElementFrozen(vehicle, true)
			vioSetElementData (client, "money", money - preis)
			vioSetElementData ( vehicle, "antrieb", "fwd" )
			setVehicleHandling ( vehicle, "driveType", "fwd" )
			local Besitzer = vioGetElementData (vehicle, "owner")
			local Slot = vioGetElementData ( vehicle, "carslotnr_owner" )
			dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=?", "vehicles", "Antrieb", "fwd", "UID", playerUID[Besitzer], "Slot", Slot )
			veh_tuningtimer[vehicle] = setTimer(function(vehicle)
				setElementFrozen(vehicle, false)
				sendMessageForAllInGarage("Der Antrieb vom Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wurde verändert!")
			end, 5000, 1, vehicle)
		elseif tuning == "Heckantrieb" then
			sendMessageForAllInGarage("Das Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wird bearbeitet!")
			setElementFrozen(vehicle, true)
			vioSetElementData (client, "money", money - preis)
			vioSetElementData ( vehicle, "antrieb", "rwd" )
			setVehicleHandling ( vehicle, "driveType", "rwd" )
			local Besitzer = vioGetElementData (vehicle, "owner")
			local Slot = vioGetElementData ( vehicle, "carslotnr_owner" )
			dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=?", "vehicles", "Antrieb", "rwd", "UID", playerUID[Besitzer], "Slot", Slot )
			veh_tuningtimer[vehicle] = setTimer(function(vehicle)
				setElementFrozen(vehicle, false)
				sendMessageForAllInGarage("Der Antrieb vom Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wurde verändert!")
			end, 5000, 1, vehicle)
		elseif tuning == "Allradantrieb" then
			sendMessageForAllInGarage("Das Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wird bearbeitet!")
			setElementFrozen(vehicle, true)
			vioSetElementData (client, "money", money - preis)
			vioSetElementData ( vehicle, "antrieb", "awd" )
			setVehicleHandling ( vehicle, "driveType", "awd" )
			local Besitzer = vioGetElementData (vehicle, "owner")
			local Slot = vioGetElementData ( vehicle, "carslotnr_owner" )
			dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=?", "vehicles", "Antrieb", "awd", "UID", playerUID[Besitzer], "Slot", Slot )
			veh_tuningtimer[vehicle] = setTimer(function(vehicle)
				setElementFrozen(vehicle, false)
				sendMessageForAllInGarage("Der Antrieb vom Fahrzeug "..getVehicleNameFromModel(getElementModel(vehicle)).." wurde verändert!")
			end, 5000, 1, vehicle)
		end
	else
		outputChatBox ( "Du musst das Geld auf der Hand haben!", client, 255, 0, 0 )
	end
end)

function MechanikerMagnetExplode()
	setElementData( source, "magnet", false)
end

function Mechaniker_magnet (car)
	if getElementData (car, "magnet") == false then
		setVehicleAsMagnetHelicopter(car)
	end
end