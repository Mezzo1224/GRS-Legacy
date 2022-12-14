------------------------------
-------- Urheberrecht --------
------- by [LA]Leyynen -------
------------ 2012 ------------
------------------------------
---- Script by Noneatme ------

local debugmodus = false

createBlip(-2397.2683, -134.9355, 35.28888, 27, 2, 255, 0, 0, 255, 0, 200)

local duty_marker = createMarker(-2391.3823, -189.9117, 34.28888, "cylinder", 1.5, 255, 0, 0, 150)

addEventHandler("onMarkerHit", duty_marker, function(hitElement)
	if(isMechaniker(hitElement) or isMedic(hitElement)) then
		outputChatBox("[INFO]: Nutze /duty um in Dienst zu gehen/den Dienst zu verlassen!", hitElement, 200, 200, 0)
	else
		outputChatBox("Nur für Mechaniker!", hitElement, 175, 0, 0)
	end
end)

addCommandHandler("duty", function(thePlayer)
	if(isMechaniker(thePlayer) or isMedic(thePlayer)) and (isElementWithinMarker(thePlayer, duty_marker)) then
		local duty = isEmergencyOnDuty ( thePlayer )
		if(duty == true) then
			outputChatBox("[INFO]: Du bist nun nicht mehr als Mechaniker im Dienst!", thePlayer, 200, 200, 0)
			takeWeapon(thePlayer, 41)
			setElementModel ( thePlayer, vioGetElementData ( thePlayer, "skinid" ) )
		else
			if isMedic(thePlayer) then
				vioSetElementData (thePlayer, "fraktion", 11)
			end
			outputChatBox("[INFO]: Du bist nun als Mechaniker im Dienst!", thePlayer, 200, 200, 0)
			outputChatBox("[INFO]: Ausserdem hast du 5 Reparaturkits erhalten, /repaircar!", thePlayer, 200, 200, 0)
			local thezahl = math.random (1, 5)
			setElementModel ( thePlayer, factionSkins[11][thezahl] )
			giveWeapon(thePlayer, 41, 1000, true)
			vioSetElementData(thePlayer, "repairkits", 5)
		end
	end
end)

local mechanik_blip = {}


function delete_mech_blip (player, thePlayer)
	setElementVisibleTo ( mechanik_blip[player], thePlayer, false )
	vioSetElementData (player, "needMech", false)
end


local marker = {}

marker[1] = createMarker(-2687.9560546875, 449.61956787109, 4.3559375, "corona", 1.5, 255, 0, 0, 150) -- Garage draussen
-- Davor: -2689.8493652344, 449.50695800781, 4.3359375
marker[2] = createMarker(-2685.9626464844, 449.09289550781, 4.3559375, "corona", 1.5, 255, 0, 0, 150) -- Garage drinnen
-- Davor: -2684.2702636719, 449.08560180664, 4.3359375

addEventHandler("onMarkerHit", marker[1], function(hitElement, dim)
	if getElementType(hitElement) == "player" and (dim) then
		if isPedInVehicle ( hitElement ) == false then
			if isMechaniker(hitElement) then
				setElementPosition(hitElement, -2684.2702636719, 449.08560180664, 4.3359375)
				infobox ( hitElement, "Willkommen Mechaniker!", 5000, 0, 125, 0 )
			else
				outputChatBox("Nur für Mechaniker!", hitElement, 175, 0, 0)
			end
		end
	end
end)
	
addEventHandler("onMarkerHit", marker[2], function(hitElement, dim)
	if getElementType(hitElement) == "player" and (dim) then
		if isPedInVehicle ( hitElement ) == false then
			-- isMechaniker(hitElement) then
				setElementPosition(hitElement, -2689.8493652344, 449.50695800781, 4.3359375)
			--else
			--	outputChatBox("Nur für Mechaniker!", hitElement, 175, 0, 0)
			--end
		end
	end
end)
	

addCommandHandler("repaircar", function(thePlayer, cmd)
		if(isMechaniker(thePlayer)) and (isEmergencyOnDuty(thePlayer)) then
			local vehicle = getPedOccupiedVehicle(thePlayer)
			local kits = tonumber(vioGetElementData(thePlayer, "repairkits"))
			if not(kits) or (kits < 1) then
				outputChatBox("Du hast keine Repairkits bei dir! Lade in der Garage in SF welche auf.", thePlayer, 150, 0, 0)
				return
			end
			if vehicle then
				local vx, vy, vz = getElementVelocity ( getPedOccupiedVehicle ( player ) )
				local speed = math.sqrt ( vx ^ 2 + vy ^ 2 + vz ^ 2 )
				local kmh = speed * 180
				if kmh < 20 then
					setElementFrozen(vehicle, true)
					if getVehicleOccupant(vehicle) ~= thePlayer then
						local targeta = getVehicleOccupant(vehicle)
						outputChatBox("[INFO]: Dein Fahrzeug wird repariert!", targeta, 0, 150, 0)
						outputChatBox("[INFO]: Du hast die Reparatur begonnen.", thePlayer, 0, 150, 0)
					else
						outputChatBox("[INFO]: Du hast die Reparatur begonnen.", thePlayer, 0, 150, 0)
					end
					setTimer(function(thePlayer, vehicle)
						setElementFrozen(vehicle, false)
						vioSetElementData(thePlayer, "repairkits", kits-1)
						fixVehicle(vehicle)
						if getVehicleOccupant(vehicle) ~= thePlayer then
							local target = getVehicleOccupant(vehicle)
							outputChatBox("[INFO]: Mechaniker "..getPlayerName(thePlayer).." hat dein Fahrzeug repariert!", target, 0, 150, 0)
							outputChatBox("[INFO]: Du hast das Fahrzeug von "..getPlayerName(target).." repariert! Verbleibene Kits: "..(kits-1), thePlayer, 0, 150, 0)
						else
							outputChatBox("[INFO]: Du hast das Fahrzeug repariert! Verbleibene Kits: "..(kits-1), thePlayer, 0, 150, 0)
						end
					end, 5000, 1, thePlayer, vehicle)
				else
					outputChatBox("Das Fahrzeug steht nicht still!", thePlayer, 150, 0, 0)
				end
			else
				outputChatBox("Du bist in keinem Fahrzeug!", thePlayer, 150, 0, 0)
			end
		else
			outputChatBox("Du bist kein Mechaniker/Nicht im Dienst!", thePlayer, 150, 0, 0)
		end
end)