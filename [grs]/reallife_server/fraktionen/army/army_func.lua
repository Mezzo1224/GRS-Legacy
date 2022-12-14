function armyClassSpawn ( player )

	if not isKeyBound ( player, "1", "down", tazer_func ) then
		bindKey ( player, "1", "down", tazer_func )
	end
	
	giveWeapon ( player, 22, 170, true )
	if vioGetElementData ( player, "job" ) == "soldat" then
		giveWeapon ( player, 22, 102*2*2, true )
		giveWeapon ( player, 31, 150, true )
	elseif vioGetElementData ( player, "job" ) == "pionier" then
		giveWeapon ( player, 6, 1, true )
		giveWeapon ( player, 16, 3, true )
	elseif vioGetElementData ( player, "job" ) == "marine" then
		giveWeapon ( player, 24, 90, true )
		giveWeapon ( player, 25, 50, true )
	elseif vioGetElementData ( player, "job" ) == "air" then
		giveWeapon ( player, 29, 250, true )
		giveWeapon ( player, 46, 3, true )
	elseif vioGetElementData ( player, "job" ) == "tankcommander" then
		giveWeapon ( player, 36, 3, true )
	elseif vioGetElementData ( player, "job" ) == "spaeher" then
		giveWeapon ( player, 23, 90, true )
		giveWeapon ( player, 34, 20, true )
	end
	
	
	setPedArmor ( player, 100 )
	giveWeapon ( player, 31, 300, true )
end

explosiveCount = 0

function explosive_func ( player )
	if vioGetElementData ( player, "job" ) == "pionier" and isArmy ( player ) then
		if not vioGetElementData ( player, "expTimer" ) then
			vioSetElementData ( player, "expTimer", true )
			setTimer ( vioSetElementData, 30000, 1, player, "expTimer", false )
			local x, y, z = getElementPosition ( player )
			local z = z - 0.73
			local x = x + 0.3
			local y = y + 0.3
			_G["explosive"..explosiveCount] = createObject ( 1654, x, y, z )
			setTimer ( explodeExplosive, 10000, 1, _G["explosive"..explosiveCount], player )
			outputChatBox ( "Sprengladung ist scharf, du hast 10 Sekunden!", player, 125, 0, 0 )
			explosiveCount = explosiveCount + 1
		else
			outputChatBox ( "Du kannst nur alle 30 Sekunden eine Sprengladung legen!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Du bist nicht befugt!", player, 125, 0, 0 )
	end
end
addCommandHandler ( "explosive", explosive_func )

function explodeExplosive ( explosive, player )

	local x, y, z = getElementPosition ( explosive )
	createExplosion ( x, y, z, 0, player )
	destroyElement ( explosive )
end

function setpermission_func ( player, cmd, target, perm, bool )
	
	local target = findPlayerByName( target )
	if target then
		if isArmy ( player ) then
			if getPlayerRank ( player ) == 5 then
				local perm = tonumber ( perm )
				if perm then
					if perm > 0 and perm < 11 then
						if perm == 10 then
							bool = tonumber ( bool )
							if bool then
								vioSetElementData ( target, "armyperm10", bool )
								saveArmyPermissions ( target )
								outputChatBox ( "Du hast "..getPlayerName ( target ).." die GWD-Note "..bool.." gegeben!", player, 0, 125, 0 )
								outputChatBox ( getPlayerName ( player ).." hat dir die GWD-Note "..bool.." gegeben!", target, 0, 125, 0 )
							end
						else
							if bool == "1" then
								fix = "gegeben"
								vioSetElementData ( target, "armyperm"..perm, 1 )
							else
								fix = "genommen"
								vioSetElementData ( target, "job", "none" )
								vioSetElementData ( target, "armyperm"..perm, 0 )
							end
							saveArmyPermissions ( target )
							outputChatBox ( "Du hast "..getPlayerName ( target ).." "..permNames[perm].." "..fix..".", player, 0, 125, 0 )
							outputChatBox ( getPlayerName ( player ).." hat dir "..permNames[perm].." "..fix..".", target, 0, 125, 0 )
						end
					else
						outputChatBox ( "Gebrauch: /setpermission [Name] [Permission 1-10] [1 oder 0]", player, 125, 0, 0 )
					end
				else
					outputChatBox ( "Gebrauch: /setpermission [Name] [Permission 1-10] [1 oder 0]", player, 125, 0, 0 )
				end
			else
				outputChatBox ( "Gebrauch: /setpermission [Name] [Permission 1-10] [1 oder 0]", player, 125, 0, 0 )
			end
		else
			outputChatBox ( "Du bist kein Soldat!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Gebrauch: /setpermission [Name] [Permission 1-10] [1 oder 0]", player, 125, 0, 0 )
		outputChatBox ( "Permissions: 1=Soldat,2=Pionier,3=Marine,4=Luftwaffe,5=Panzerkommandoer,6=Spaeher,7=Ehrenm.,8=Luftwaffenm.,9=Verdienstm.,10=GWD", player, 125, 125, 0 )
	end
end
addCommandHandler ( "setpermission", setpermission_func )

permNames = {}
	permNames[1] = "Soldat"
	permNames[2] = "Pionier"
	permNames[3] = "Marine"
	permNames[4] = "Luftwaffe"
	permNames[5] = "Panzerkommandoer"
	permNames[6] = "Spaeher"
	permNames[7] = "Ehrenmedallie"
	permNames[8] = "Luftwaffen Orden"
	permNames[9] = "Verdienstkreuz"
	permNames[10] = "Zeugnis"
	
validClasses = {}
validClasses = { ["soldat"]=true, ["pionier"]=true, ["marine"]=true, ["air"]=true, ["tankcommander"]=true, ["spaeher"]=true }

function class_func ( player, cmd, class )

	if validClasses[class] then
		suc = false
		if vioGetElementData ( player, "armyperm6" ) == 1 and class == "spaeher" then
			suc = true
		elseif vioGetElementData ( player, "armyperm5" ) == 1 and class == "tankcommander" then
			suc = true
		elseif vioGetElementData ( player, "armyperm4" ) == 1 and class == "air" then
			suc = true
		elseif vioGetElementData ( player, "armyperm3" ) == 1 and class == "marine" then
			suc = true
		elseif vioGetElementData ( player, "armyperm2" ) == 1 and class == "pionier" then
			suc = true
		elseif vioGetElementData ( player, "armyperm1" ) == 1 and class == "soldat" then
			suc = true
		end
		if suc then
			vioSetElementData ( player, "job", class )
			outputChatBox ( "Klasse geaendert!", player, 125, 0, 0 )
		else
			outputChatBox ( "Du darfst diese Klasse nicht benutzen!", player, 125, 0, 0 )
		end
	else
		outputChatBox ( "Gebrauch: /class [soldat|pionier|marine|air|tankcommander]", player, 125, 0, 0 )
	end
end
addCommandHandler ( "class", class_func )

function rearm_func ( player )

	if isArmy ( player ) then
		local veh = getPedOccupiedVehicle ( player )
		
		if veh then
			if getElementModel ( veh ) == 433 then
				takeAllWeapons ( player )
				setElementHunger ( player, 100 )
				armyClassSpawn ( player )
				return nil
			end
		end
				
	end
	
	if isCop(player) or isFBI(player) then
		local x, y, z = getElementPosition ( player )
		local px, py, pz = 258.57006835938, 109.79203033447, 1002.7518310547
		local px2, py2, pz2 = getElementPosition ( FBIDutyIcon )
		local px3, py3, pz3 = getElementPosition ( dutyIconGarage )
		local px4, py4, pz4 = getElementPosition ( FBIDutyIcon2 )
		if getDistanceBetweenPoints3D ( x, y, z, px3, py3, pz3 ) <= 5 or getDistanceBetweenPoints3D ( x, y, z, px, py, pz ) <= 5 or ( isNearLVPDDutyIcon ( player ) and not isFBI ( player ) ) then
			if isOnDuty(player) then
				setElementHunger ( player, 100 )
				setElementHealth ( player, 100 )
				takeAllWeapons ( player )
				-- Schlagstock
				local weapon = 3		
				local ammo = 1
				giveWeapon ( player, weapon, ammo, true )
				
				if vioGetElementData ( player, "rang" ) == 0 then				
					-- Pistol ( 9mm )
					local weapon = 22
					local ammo = 102*2*2
					giveWeapon ( player, weapon, ammo, true )
					setElementModel ( player, 284)
					
				elseif vioGetElementData ( player, "rang" ) == 1 then				
					-- Eagle
					local weapon = 24
					local ammo = 49+7
					giveWeapon ( player, weapon, ammo, true )		
					-- Schrotflinte
					local weapon = 25
					local ammo = 50
					giveWeapon ( player, weapon, ammo, true )
					setElementModel ( player, 280)	
					-- MP5
					local weapon = 29
					local ammo = 120
					giveWeapon ( player, weapon, ammo, true )
					setElementModel ( player, 281)	
				
				elseif vioGetElementData ( player, "rang" ) == 2 then
					-- Eagle
					local weapon = 24
					local ammo = 98*2
					giveWeapon ( player, weapon, ammo, true )		
					-- Schrotflinte
					local weapon = 25
					local ammo = 100
					giveWeapon ( player, weapon, ammo, true )
					-- MP5
					local weapon = 29
					local ammo = 120
					giveWeapon ( player, weapon, ammo, true )
					setElementModel ( player, 281)	
					
				elseif vioGetElementData ( player, "rang" ) == 3 then
					-- Eagle
					local weapon = 24
					local ammo = 98*2
					giveWeapon ( player, weapon, ammo, true )		
					-- Schrotflinte
					local weapon = 25
					local ammo = 100
					giveWeapon ( player, weapon, ammo, true )
					-- MP5
					local weapon = 29
					local ammo = 150
					giveWeapon ( player, weapon, ammo, true )
					-- M4
					local weapon = 31
					local ammo = 200
					giveWeapon ( player, weapon, ammo, true )		
					setElementModel ( player, 282)	
					
				elseif vioGetElementData ( player, "rang" ) == 4 then
					-- Eagle
					local weapon = 24
					local ammo = 98*2
					giveWeapon ( player, weapon, ammo, true )		
					-- Schrotflinte
					local weapon = 25
					local ammo = 100
					giveWeapon ( player, weapon, ammo, true )
					-- MP5
					local weapon = 29
					local ammo = 150
					giveWeapon ( player, weapon, ammo, true )
					-- M4
					local weapon = 31
					local ammo = 200
					giveWeapon ( player, weapon, ammo, true )
					-- Sniper
					local weapon = 34
					local ammo = 5
					giveWeapon ( player, weapon, ammo, true )
					setElementModel ( player, 288)
					
				elseif vioGetElementData ( player, "rang" ) == 5 then
					-- Eagle
					local weapon = 24
					local ammo = 196*2
					giveWeapon ( player, weapon, ammo, true )		
					-- Schrotflinte
					local weapon = 25
					local ammo = 200
					giveWeapon ( player, weapon, ammo, true )
					-- MP5
					local weapon = 29
					local ammo = 450
					giveWeapon ( player, weapon, ammo, true )
					-- M4
					local weapon = 31
					local ammo = 600
					giveWeapon ( player, weapon, ammo, true )
					-- Sniper
					local weapon = 34
					local ammo = 20
					giveWeapon ( player, weapon, ammo, true )
					setElementModel ( player, 283)
				end
				local armor = 100
				setPedArmor ( player, armor )
				bindKey ( player, "1", "down", tazer_func )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist nicht\nim Dienst!", 7500, 125, 0, 0 )
			end
		elseif ( getDistanceBetweenPoints3D ( x, y, z, px2, py2, pz2 ) <= 5 or getDistanceBetweenPoints3D ( x, y, z, px4, py4, pz4 ) <= 5 or isNearLVPDDutyIcon ( player ) ) and isFBI ( player ) then
			setElementHunger ( player, 100 )
			setElementHealth ( player, 100 )
			if isOnDuty(player) then
				local rang = vioGetElementData ( player, "rang" )
				if rang < 1 then
					giveWeapon ( player, 23, 102*2*2 )		-- Silenced
				else
					giveWeapon ( player, 29, 300 )		-- MP5
					if rang >= 2 then
						giveWeapon ( player, 24, 49*2 )	-- Deagle
					end
					if rang >= 3 then
						giveWeapon ( player, 31, 450 )	-- M4
					end
					if rang >= 4 then
						giveWeapon ( player, 34, 11 )	-- Sniper
					end
				end
				local armor = 100
				setPedArmor ( player, armor )
				triggerClientEvent ( player, "sec_armor_give", getRootElement(), armor )
				bindKey ( player, "1", "down", tazer_func )
			else
				triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu bist bereits\nim Dienst!", 7500, 125, 0, 0 )
			end
		else
			triggerClientEvent ( player, "infobox_start", getRootElement(), "\nDu bist nicht\nan der Richtigen\nStelle", 7500, 125, 0, 0 )
		end
	end	
end
addCommandHandler ( "rearm", rearm_func )