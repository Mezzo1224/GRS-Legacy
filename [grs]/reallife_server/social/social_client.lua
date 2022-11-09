-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

--socialStateCount = 24
availableSocialStates = {}
reachableSocialStates = {}
socialStateGroups = {}
-- Anfaengerraenge --
socialStateGroups[1] = { [1]=true, [2]=true, [3]=true, [4]=true, [5]=true }
-- Fraktionsraenge --
socialStateGroups[2] = { [6]=true, [7]=true, [14]=true }
-- Job Raenge --
socialStateGroups[3] = { [8]=true }
-- Achievment Raenge --
socialStateGroups[4] = { [9]=true, [19]=true, [23]=true, [24]=true, [27]=true }
-- Geld Raenge --
socialStateGroups[5] = { [11]=true, [12]=true, [13]=true }
-- Besitz Raenge --
socialStateGroups[6] = { [10]=true, [15]=true, [16]=true, [17]=true, [18]=true }
-- Sucht Raenge --
socialStateGroups[7] = { [20]=true, [21]=true, [22]=true }
-- Hobby Raenge --
socialStateGroups[8] = { [25]=true, [26]=true }

socialStates = {
 [1]="Flüchtling",
 [2]="Illegaler Immigrant",
 [3]="Immigrant",
 [4]="Bürger",
 [5]="Arbeiter",
 [6]="Neuling",
 [7]="Aufsteiger",
 [8]="Dealer",
 [9]="Waffenschieber",
 [10]="Hausbesitzer",
 [11]="Finanzhai",
 [12]="Millionär",
 [13]="Multimillionär",
 [14]="Fädenzieher",
 [15]="Geschäftsmann",
 [16]="Wirtschaftsboss",
 [17]="Reich & Schön",
 [18]="God of Ultimate",
 [19]="Rentner",
 [20]="Kettenraucher",
 [21]="Saufbruder",
 [22]="Junkie",
 [23]="Glücksschmied",
 [24]="Hasadeur",
 [25]="Blumenkind",
 [26]="Ferngesteuert",
 [27]="Silent Assasin"
}

socialStateCount = 0
for key, index in pairs ( socialStates ) do
	socialStateCount = socialStateCount + 1
end

function stringToSocID ( id )

	for key, index in pairs ( socialStates ) do
		if index == id then
			return key
		end
	end
end

function getPlayerSocialAvailableStates ()

	local spielzeit = tonumber(getElementData ( lp, "playingtime" ))
	local totalMoney = mymoney + vioClientGetElementData ( "bankmoney" )
	availableSocialStates = nil
	availableSocialStates = {}
	reachableSocialStates = nil
	reachableSocialStates = {}
	for i = 1, socialStateCount do
		reachableSocialStates[i] = false
		availableSocialStates[i] = false
	end
	
	-- **Gruppe 1 - Anfaengerraenge ** --
		if spielzeit <= 180 and vioClientGetElementData ( "perso" ) ~= 1 then
			-- Flüchtling
			availableSocialStates[1] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 1 )
			reachableSocialStates[2] = true
		elseif spielzeit >= 300 and vioClientGetElementData ( "curcars" ) >= 1 and vioClientGetElementData ( "job" ) ~= "none" then
			-- Arbeiter
			availableSocialStates[5] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 5 )
			reachableSocialStates[6] = true
			reachableSocialStates[8] = true
			reachableSocialStates[10] = true
			reachableSocialStates[11] = true
			reachableSocialStates[15] = true
		elseif spielzeit >= 180 and vioClientGetElementData ( "perso" ) == 1 then 
			-- Buerger
			availableSocialStates[4] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 4 )
			reachableSocialStates[5] = true
		elseif spielzeit >= 45 and vioClientGetElementData ( "perso" ) == 1 then
			-- Immigrant
			availableSocialStates[3] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 3 )
			reachableSocialStates[4] = true
		else
			-- Illegaler Immigrant
			availableSocialStates[2] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 2 )
			reachableSocialStates[3] = true
		end
	-- **Gruppe 2 - Fraktionsbasiert** --
		if getElementData ( lp, "fraktion" ) >= 1 then
			if vioClientGetElementData ( "rang" ) >= 4 and spielzeit >= 15000 then
				-- Faedenzieher --
				availableSocialStates[14] = true
				triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 14 )
			elseif vioClientGetElementData ( "rang" ) >= 2 and spielzeit >= 4500 then
				-- Aufsteiger --
				availableSocialStates[7] = true
				triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 7 )
				reachableSocialStates[14] = true
			elseif spielzeit >= 1200 then
				-- Neuling --
				availableSocialStates[6] = true
				triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 6 )
				reachableSocialStates[7] = true
			else
				reachableSocialStates[6] = true
			end
		end
	-- **Gruppe 3 - Jobbasiert** --
		if vioClientGetElementData ( "job" ) == "dealer" then
			-- Dealer --
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 8 )
			availableSocialStates[8] = true
		end
	-- **Gruppe 4 - Achievmentbasiert** --
		if vioClientGetElementData ( "gunloads" ) == "done" then
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 9 )
			availableSocialStates[9] = true
		end
		if vioClientGetElementData ( "totalHorseShoes" ) == 25 then
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 24 )
			availableSocialStates[23] = true
		end
		if vioClientGetElementData ( "chickendinner_achiev" ) == 1 and vioClientGetElementData ( "nichtsgehtmehr_achiev" ) == 1 then
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 25 )
			availableSocialStates[24] = true
		end
		if vioClientGetElementData ( "silentassasin_achiev" ) == "done" then
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 28 )
			availableSocialStates[28] = true
		end
		if vioClientGetElementData ( "job" ) == "none" then
			if getElementData ( lp, "fraktion" ) == 0 then
				if getElementData ( lp, "playingtime" ) >= 45000 then
					triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 20 )
					availableSocialStates[20] = true
				end
			end
		else
			reachableSocialStates[20] = true
		end
	-- **Gruppe 5 - Geldbasiert** --
		if totalMoney >= 3000000 then
			availableSocialStates[13] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 13 )
		elseif totalMoney >= 1000000 then
			availableSocialStates[12] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 12 )
			reachableSocialStates[13] = true
		elseif totalMoney >= 500000 then
			availableSocialStates[11] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 11 )
			reachableSocialStates[12] = true
		else
			reachableSocialStates[11] = true
		end
	-- **Gruppe 6 - Besitzbasiert** --
		if spielzeit >= 30000 and vioClientGetElementData ( "housekey" ) > 0 and vioClientGetElementData ( "collectr_achiev" ) == "done" and vioClientGetElementData ( "yachtImBesitz" ) then
			availableSocialStates[18] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 18 )
		elseif spielzeit >= 30000 and vioClientGetElementData ( "housekey" ) > 0 and vioClientGetElementData ( "yachtImBesitz" ) then
			availableSocialStates[17] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 17 )
			reachableSocialStates[18] = true
		elseif spielzeit >= 30000 and totalMoney >= 500000 and vioClientGetElementData ( "bizkey" ) >= 1 then
			availableSocialStates[16] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 16 )
			reachableSocialStates[17] = true
		elseif vioClientGetElementData ( "bizkey" ) >= 1 then
			availableSocialStates[15] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 15 )
			reachableSocialStates[16] = true
		elseif vioClientGetElementData ( "housekey" ) > 0 then
			availableSocialStates[10] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 10 )
			reachableSocialStates[15] = true
		else
			reachableSocialStates[10] = true
		end
	-- **Gruppe 7 - Suchtbasiert** --
		if vioClientGetElementData ( "drugAddictPoints" ) and vioClientGetElementData ( "alcoholAddictPoints" ) and vioClientGetElementData ( "cigarettAddictPoints" ) then
			if math.floor ( vioClientGetElementData ( "cigarettAddictPoints" ) / addictLevelDivisors[1] ) >= 3 then
				availableSocialStates[20] = true
				triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 20 )
			elseif math.floor ( vioClientGetElementData ( "alcoholAddictPoints" ) / addictLevelDivisors[2] ) >= 3 then
				availableSocialStates[21] = true
				triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 21 )
			elseif math.floor ( vioClientGetElementData ( "drugAddictPoints" ) / addictLevelDivisors[3] ) >= 3 then
				triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 22 )
				availableSocialStates[22] = true
			end
		end
	-- **Gruppe 8 - Hobbybasiert** --
		if vioClientGetElementData ( "club" ) == "rc" then
			availableSocialStates[26] = true
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 26 )
		elseif vioClientGetElementData ( "club" ) == "gartenverein" then
			triggerServerEvent ( "giveSocialState", resourceRoot, getLocalPlayer(), 25 )
			availableSocialStates[25] = true
		end
	return nil
end

function getNextBestState ()

	for key, state in pairs ( availableSocialStates ) do
		if availableSocialStates[key] then
			return socialStates[key]
		end
	end
end

-- // Ca. ist aus dem Internet funktioniert aber
-- // Heult net pls
function shallowcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function checkForSocialStateChanges ()

	if getElementData ( lp, "loggedin" ) == 1 then
	--	local oldAvailableSocialStates = table.copy ( availableSocialStates )
		local oldAvailableSocialStates = shallowcopy ( availableSocialStates )
		local debug = getPlayerSocialAvailableStates ()
		for key, state in pairs ( availableSocialStates ) do
			if not oldAvailableSocialStates[key] and availableSocialStates[key] then
			--	outputChatBox ( "Du hast einen neuen sozialen Status freigeschaltet: "..socialStates[key].."!", 0, 125, 0 )
			--	outputChatBox ( "Vergiss nicht, ihn im Optionsmenue zu aktivieren!", 0, 125, 0 )
				newInfobox("Du hast einen neuen sozialen Status freigeschaltet: "..socialStates[key].."!", 1, 255, 255, 255, 255, 10, "sozialer Status", 168, 30, 15 )
			end
		end
		for key, state in pairs ( oldAvailableSocialStates ) do
			if not availableSocialStates[key] and oldAvailableSocialStates[key] then
				if socialNeeds[getElementData ( lp, "socialState" )] then
					if not availableSocialStates[stringToSocID(getElementData ( lp, "socialState" ))] then
						local newState = getNextBestState ()
						setElementData ( lp, "socialState", newState, true )
					--	outputChatBox ( "Du hast deinen sozialen Status verloren - dein Status wurde auf "..newState.." gesetzt!", 125, 0, 0 )
						newInfobox("Du hast deinen sozialen Status verloren - dein Status wurde auf "..newState.." gesetzt!", 1, 255, 255, 255, 255, 10, "sozialer Status", 168, 30, 15 )
					else
					--	outputChatBox ( "Du hast einen sozialen Status verloren: "..socialStates[key].."!", 125, 0, 0 )
						newInfobox("Du hast einen sozialen Status verloren: "..socialStates[key].."!", 1, 255, 255, 255, 255, 10, "sozialer Status", 168, 30, 15 )
					end
					triggerServerEvent ( "removeSocialState", resourceRoot, getLocalPlayer(), key+1 )
				end
			end
		end
	end
end