
----------GUI To DGS Converted----------
if not getElementData(root,"__DGSDef") then
	setElementData(root,"__DGSDef",true)
	addEvent("onDgsEditAccepted-C",true)
	addEvent("onDgsTextChange-C",true)
	addEvent("onDgsComboBoxSelect-C",true)
	addEvent("onDgsTabSelect-C",true)
	function fncTrans(...)
		triggerEvent(eventName.."-C",source,source,...)
	end
	addEventHandler("onDgsEditAccepted",root,fncTrans)
	addEventHandler("onDgsTextChange",root,fncTrans)
	addEventHandler("onDgsComboBoxSelect",root,fncTrans)
	addEventHandler("onDgsTabSelect",root,fncTrans)
	loadstring(exports.dgs:dgsImportFunction())()
end
----------GUI To DGS Converted----------

local curFileSubject

function showPDComputer ()

	showCursor ( true )
	setElementClicked ( true )
	dgsSetInputEnabled ( false )
	dgsSetInputMode ( "no_binds" )
	
	if isElement ( gWindow["policeComputer"] ) then
		dgsSetVisible ( gWindow["policeComputer"], true )
		
		refreshPDComputer ()
	else
		gWindow["policeComputer"] = dgsCreateWindow(screenwidth/2-355/2,screenheight/2-(437+25)/2,380,437+25,"Polizeicomputer",false)
		dgsSetAlpha(gWindow["policeComputer"],1)
		dgsWindowSetMovable ( gWindow["policeComputer"], true )
		local img = dgsCreateImage(24,30,52,51,"images/gui/police.png",false,gWindow["policeComputer"])
		dgsSetAlpha(img,1)
		gGrid["pdPlayers"] = dgsCreateGridList(110,29+50,280,397-50,false,gWindow["policeComputer"])
		dgsGridListSetSelectionMode(gGrid["pdPlayers"],0)
		gColumn["pdPlayer"] = dgsGridListAddColumn(gGrid["pdPlayers"],"Spieler",0.4)
		gColumn["pdFaction"] = dgsGridListAddColumn(gGrid["pdPlayers"],"Fraktion",0.2)
		gColumn["pdWanteds"] = dgsGridListAddColumn(gGrid["pdPlayers"],"Wanteds",0.175)
		gColumn["pdStvo"] = dgsGridListAddColumn(gGrid["pdPlayers"],"StVO",0.175)
		dgsSetAlpha(gGrid["pdPlayers"],1)
		
		gEdit["pdReason"] = dgsCreateEdit(110+50,29,243,30,"",false,gWindow["policeComputer"])
		dgsSetAlpha(gEdit["pdReason"],1)
		gLabel[2] = dgsCreateLabel(110,29,50,30,"Grund:",false,gWindow["policeComputer"])
		dgsSetAlpha(gLabel[2],1)
		dgsLabelSetColor(gLabel[2],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[2],"top")
		dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
		dgsSetFont(gLabel[2],"default-bold-small")
		
		gEdit["pdCount"] = guiCreateNumberField(73-20,222,35,25,"1",false,gWindow["policeComputer"],true,true)
		dgsSetAlpha(gEdit["pdCount"],1)
		gLabel[1] = dgsCreateLabel(11,225,45,17,"Anzahl:",false,gWindow["policeComputer"])
		dgsSetAlpha(gLabel[1],1)
		dgsLabelSetColor(gLabel[1],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[1],"top")
		dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
		dgsSetFont(gLabel[1],"default-bold-small")
		
		gEdit["pdName"] = dgsCreateEdit(11,432+2,100,25,"Name",false,gWindow["policeComputer"])
		dgsSetAlpha(gEdit["pdName"],1)
		gRadio["pdFromList"] = dgsCreateRadioButton ( 111, 432, 50, 25, "Liste", false, gWindow["policeComputer"] )
		dgsSetFont ( gRadio["pdFromList"], "default-bold-small" )
		gRadio["pdFromField"] = dgsCreateRadioButton ( 111+50, 432, 100, 25, "Name", false, gWindow["policeComputer"] )
		dgsSetFont ( gRadio["pdFromField"], "default-bold-small" )
		
		gButton["useDatabase"] = dgsCreateButton(11,335,87,38,"Datenbank\nbenutzen",false,gWindow["policeComputer"])
		dgsSetAlpha(gButton["useDatabase"],1)
		gButton["setWanteds"] = dgsCreateButton(11,90,87,38,"Wanteds setzen",false,gWindow["policeComputer"])
		dgsSetAlpha(gButton["setWanteds"],1)
		gButton["setStvo"] = dgsCreateButton(11,135,87,38,"STVO-Punkte\ngeben",false,gWindow["policeComputer"])
		dgsSetAlpha(gButton["setStvo"],1)
		gButton["delStvo"] = dgsCreateButton(11,180,87,38,"STVO-Punkte\nlöschen",false,gWindow["policeComputer"])
		dgsSetAlpha(gButton["delStvo"],1)
		gButton["pdClose"] = dgsCreateButton(11,383,87,38,"Fenster\nschliessen",false,gWindow["policeComputer"])
		dgsSetAlpha(gButton["pdClose"],1)
		gButton["pdTrace"] = dgsCreateButton(365-90,432+2,87,38-20,"Orten",false,gWindow["policeComputer"])
		dgsSetAlpha(gButton["pdTrace"],1)
		
		dgsRadioButtonSetSelected ( gRadio["pdFromList"], true )
		
		addEventHandler ( "onDgsMouseClickUp", gButton["useDatabase"],
			function ()
				showDatabase ()
				dgsSetVisible ( gWindow["policeComputer"], false )
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["setWanteds"],
			function ()
				local wanteds = tonumber ( dgsGetText ( gEdit["pdCount"] ) )
				local reason = dgsGetText ( gEdit["pdReason"] )
				if wanteds >= 0 and wanteds <= 6 then
					local row, column = dgsGridListGetSelectedItem ( gGrid["pdPlayers"] )
					local name
					if dgsRadioButtonGetSelected ( gRadio["pdFromList"] ) then
						name = dgsGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )
					else
						name = dgsGetText ( gEdit["pdName"] )
					end
					triggerServerEvent ( "pdComputerSetWanted", lp, wanteds, name, reason )
				else
					outputChatBox ( "Du kannst nur Wantedlevel 1-6 vergeben!", 125, 0, 0 )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["setStvo"],
			function ()
				local row, column = dgsGridListGetSelectedItem ( gGrid["pdPlayers"] )
				local stvo = tonumber ( dgsGetText ( gEdit["pdCount"] ) )
				local reason = dgsGetText ( gEdit["pdReason"] )
				if reason then
					if stvo <= 15 and stvo >= 0 then
						local name
						if dgsRadioButtonGetSelected ( gRadio["pdFromList"] ) then
							name = dgsGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )
						else
							name = dgsGetText ( gEdit["pdName"] )
						end
						triggerServerEvent ( "pdComputerAddSTVO", lp, name, stvo, reason )
					else
						outputChatBox ( "Bitte waehle einen Wert zwischen 1 und 15!", 125, 0, 0 )
					end
				else
					outputChatBox ( "Bitte Grund angeben!", 125, 0, 0 )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["delStvo"],
			function ()
				local row, column = dgsGridListGetSelectedItem ( gGrid["pdPlayers"] )
				local stvo = tonumber ( dgsGetText ( gEdit["pdCount"] ) )
				local reason = dgsGetText ( gEdit["pdReason"] )
				if reason then
					if stvo <= 15 and stvo >= 0 then
						local name
						if dgsRadioButtonGetSelected ( gRadio["pdFromList"] ) then
							name = dgsGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )
						else
							name = dgsGetText ( gEdit["pdName"] )
						end
						triggerServerEvent ( "pdComputerDeleteSTVO", lp, name, stvo, reason )
					else
						outputChatBox ( "Bitte waehle einen Wert zwischen 1 und 15!", 125, 0, 0 )
					end
				else
					outputChatBox ( "Bitte Grund angeben!", 125, 0, 0 )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["pdClose"],
			function ()
				showCursor ( false )
				setElementClicked ( false )
				dgsSetInputEnabled ( true )
				dgsSetInputMode ( "allow_binds" )
				dgsSetVisible ( gWindow["policeComputer"], false )
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["pdTrace"],
			function ()
				SFPDTraceCitizen ()
			end,
		false )
		
		dgsSetFont ( gGrid["pdPlayers"], "default-bold-small" )
		
		destroyElement ( gGrid["pdPlayers"] )
		gGrid["pdPlayers"] = dgsCreateGridList(110,29+50,280,397-50,false,gWindow["policeComputer"])
		dgsGridListSetSelectionMode(gGrid["pdPlayers"],0)
		gColumn["pdPlayer"] = dgsGridListAddColumn(gGrid["pdPlayers"],"Spieler",0.4)
		gColumn["pdFaction"] = dgsGridListAddColumn(gGrid["pdPlayers"],"Fraktion",0.2)
		gColumn["pdWanteds"] = dgsGridListAddColumn(gGrid["pdPlayers"],"Wanteds",0.175)
		gColumn["pdStvo"] = dgsGridListAddColumn(gGrid["pdPlayers"],"StVO",0.175)
		dgsSetAlpha(gGrid["pdPlayers"],1)
		local players = getElementsByType("player")
		for i=1, #players do 
			local player = players[i]
			if getElementData ( player, "loggedin" ) == 1 then
				local row = dgsGridListAddRow ( gGrid["pdPlayers"] )
				dgsGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"], getPlayerName ( player ), false, false )
				local wanteds = getElementData ( player, "wanteds" ) or "0"
				dgsGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdWanteds"], wanteds, false, true )
				local fraktion = getElementData ( player, "fraktion" )
				local fraktions = ""
				if getElementData ( player, "fraktion" ) ~= 0 then
					fraktions = fraktionsNamen[fraktion]
				else
					fraktions = "Zivilist"
				end
				dgsGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdFaction"], fraktions, false, false )
				local stvos = getElementData ( player, "stvo_punkte" ) or "0"
				dgsGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdStvo"], stvos, false, true )
				
				dgsGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdPlayer"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
				dgsGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdWanteds"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
				dgsGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdFaction"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
				dgsGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdStvo"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
				
			end
		end
	end
end
addEvent ( "showPDComputer", true)
addEventHandler ( "showPDComputer", getRootElement(), showPDComputer )

function refreshPDComputer ()

	destroyElement ( gGrid["pdPlayers"] )
	gGrid["pdPlayers"] = dgsCreateGridList(110,29+50,280,397-50,false,gWindow["policeComputer"])
	dgsGridListSetSelectionMode(gGrid["pdPlayers"],0)
	gColumn["pdPlayer"] = dgsGridListAddColumn(gGrid["pdPlayers"],"Spieler",0.4)
	gColumn["pdFaction"] = dgsGridListAddColumn(gGrid["pdPlayers"],"Fraktion",0.2)
	gColumn["pdWanteds"] = dgsGridListAddColumn(gGrid["pdPlayers"],"Wanteds",0.175)
	gColumn["pdStvo"] = dgsGridListAddColumn(gGrid["pdPlayers"],"StVO",0.175)
	dgsSetAlpha(gGrid["pdPlayers"],1)
	dgsGridListSetSortEnabled ( gGrid["pdPlayers"], false )
	local players = getElementsByType("player")
	for i=1, #players do 
		local player = players[i]
		if getElementData ( player, "loggedin" ) == 1 then
			local row = dgsGridListAddRow ( gGrid["pdPlayers"] )
			dgsGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"], getPlayerName ( player ), false, false )
			local wanteds = getElementData ( player, "wanteds" ) or 0
			dgsGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdWanteds"], tostring(wanteds), false, true )
			local fraktion = getElementData ( player, "fraktion" ) or 0
			local fraktions = fraktionsNamen[fraktion] or "Zivilist"
			dgsGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdFaction"], fraktions, false, false )
			local stvos = getElementData ( player, "stvo_punkte" ) or 0
			dgsGridListSetItemText ( gGrid["pdPlayers"], row, gColumn["pdStvo"], tostring (stvos), false, true )
			
			dgsGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdPlayer"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
			dgsGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdWanteds"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
			dgsGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdFaction"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
			dgsGridListSetItemColor ( gGrid["pdPlayers"], row, gColumn["pdStvo"], factionColors[fraktion][1], factionColors[fraktion][2], factionColors[fraktion][3] )
		end
	end
	dgsGridListSetSortEnabled ( gGrid["pdPlayers"], true )
end
addEvent ( "refreshPDComputer", true )
addEventHandler ( "refreshPDComputer", getRootElement(), refreshPDComputer )

function SFPDTraceCitizen ()

	local name
	if dgsRadioButtonGetSelected ( gRadio["pdFromList"] ) then
		local row, column = dgsGridListGetSelectedItem ( gGrid["pdPlayers"] )
		name = dgsGridListGetItemText ( gGrid["pdPlayers"], row, gColumn["pdPlayer"] )
	else
		name = dgsGetText ( gEdit["pdName"] )
	end
	local target = getPlayerFromName ( name )
	--if tonumber(getElementData ( lp, "rang" )) >= 0 then
		if getElementData ( target, "handystate" ) == "off" then
			outputChatBox ( "Das Handy des Buergers ist ausgeschaltet!", 125, 0, 0 )
		else
			if tonumber ( getElementInterior ( target ) ) ~= 0 or tonumber ( getElementDimension ( target ) ) ~= 0 then
				outputChatBox ( "Der Buerger befindet sich in einem Gebaeude - Ortung nicht moeglich!", 125, 0, 0 )
			else
				if isElement ( wantedBlip ) then
					destroyElement ( wantedBlip )
					if deletetWantedBlipTimer then
						killTimer ( deletetWantedBlipTimer )
					end
				end
				wantedBlip = createBlipAttachedTo ( target, 0, 2, 255, 0, 0, 255, 0, 99999.0 )
				deletetWantedBlipTimer = setTimer ( deletetWantedBlip, 30000, 1 )
			end
		end
--	else
	--	outputChatBox ( "Du bist nicht befugt!", 125, 0, 0 )
	--end
end

function deletetWantedBlip ()

	destroyElement ( wantedBlip )
	wantedBlip = nil
end

function showDatabase ()

	curFileSubject = ""
	gWindow["dataBase"] = dgsCreateWindow(screenwidth/2-320/2,screenheight/2-327/2,320,327,"Datenbank",false)
	dgsSetAlpha(gWindow["dataBase"],1)
	gLabel[1] = dgsCreateLabel(12,34,113,15,"Name des Buergers:",false,gWindow["dataBase"])
	dgsSetAlpha(gLabel[1],1)
	dgsLabelSetColor(gLabel[1],255,255,255)
	dgsLabelSetVerticalAlign(gLabel[1],"top")
	dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
	dgsSetFont(gLabel[1],"default-bold-small")
	gEdit["suspectName"] = dgsCreateEdit(132,29,93,27,"[Rise]Bonus",false,gWindow["dataBase"])
	dgsSetAlpha(gEdit["suspectName"],1)
	gButton["searchFile"] = dgsCreateButton(230,26,73,32,"Suchen",false,gWindow["dataBase"])
	dgsSetAlpha(gButton["searchFile"],1)
	dgsSetFont(gButton["searchFile"],"default-bold-small")
	gMemo["fileText"] = dgsCreateMemo(10,62,296,213,"",false,gWindow["dataBase"])
	dgsSetAlpha(gMemo["fileText"],1)
	gImage[1] = dgsCreateImage(93,53,103,101,"images/gui/police.png",false,gMemo["fileText"])
	dgsSetAlpha(gImage[1],0.5)
	gButton["saveFile"] = dgsCreateButton(142,284,79,33,"Speichern",false,gWindow["dataBase"])
	dgsSetAlpha(gButton["saveFile"],1)
	dgsSetFont(gButton["saveFile"],"default-bold-small")
	gLabel[2] = dgsCreateLabel(12,281,115,15,"Zuletzt editiert von:",false,gWindow["dataBase"])
	dgsSetAlpha(gLabel[2],1)
	dgsLabelSetColor(gLabel[2],255,255,255)
	dgsLabelSetVerticalAlign(gLabel[2],"top")
	dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
	dgsSetFont(gLabel[2],"default-bold-small")
	gLabel["lastEditor"] = dgsCreateLabel(13,300,120,16,"",false,gWindow["dataBase"])
	dgsSetAlpha(gLabel["lastEditor"],1)
	dgsLabelSetColor(gLabel["lastEditor"],50,50,255)
	dgsLabelSetVerticalAlign(gLabel["lastEditor"],"top")
	dgsLabelSetHorizontalAlign(gLabel["lastEditor"],"left",false)
	dgsSetFont(gLabel["lastEditor"],"default-bold-small")
	gButton["closeFile"] = dgsCreateButton(228,284,79,33,"Schliessen",false,gWindow["dataBase"])
	dgsSetAlpha(gButton["closeFile"],1)
	dgsSetFont(gButton["closeFile"],"default-bold-small")
	
	addEventHandler ( "onDgsMouseClickUp", gButton["closeFile"],
		function ()
			showCursor ( false )
			setElementClicked ( false )
			dgsSetInputMode ( "allow_binds" )
			dgsSetInputEnabled ( true )
			destroyElement ( gWindow["dataBase"] )
		end,
	false )
	addEventHandler ( "onDgsMouseClickUp", gButton["searchFile"],
		function ()
			triggerServerEvent ( "getDatabaseFile", lp, dgsGetText ( gEdit["suspectName"] ) )
		end,
	false )
	addEventHandler ( "onDgsMouseClickUp", gButton["saveFile"],
		function ()
			if curFileSubject == "" then
				infobox ( "Du hast im Moment\nkeine Akte geöffnet!", 5000, 255, 0, 0 )
			else
				triggerServerEvent ( "saveDatabaseFile", lp, curFileSubject, dgsGetText ( gMemo["fileText"] ) )
			end
		end,
	false )
end

function recieveDatabaseFile ( name, text, editor, faction )

	if isElement ( gWindow["dataBase"] ) then
		curFileSubject = name
		dgsSetText ( gEdit["suspectName"], name )
		dgsSetText ( gMemo["fileText"], text )
		dgsSetText ( gLabel["lastEditor"], editor )
		if faction == 1 then
			dgsLabelSetColor ( gLabel["lastEditor"], 50, 50, 255 )
		elseif faction == 6 then
			dgsLabelSetColor ( gLabel["lastEditor"], 200, 0, 0 )
		elseif faction == 8 then
			dgsLabelSetColor ( gLabel["lastEditor"], 50, 255, 50 )
		end
	end
end
addEvent ( "recieveDatabaseFile", true )
addEventHandler ( "recieveDatabaseFile", getRootElement(), recieveDatab�L#BJV  �