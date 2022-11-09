
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

local isshown = false

function hideAllSecPlayerClickWindows ()
	if gWindow["itemsGive"] then
		dgsSetVisible ( gWindow["itemsGive"], false )
	end
	if gWindow["waffendealer"] then
		dgsSetVisible ( gWindow["waffendealer"], false )
	end
	if gWindow["drogenverkauf"] then 
		dgsSetVisible ( gWindow["drogenverkauf"], false )
	end
	if gWindow["sellHotdog"] then
		dgsSetVisible ( gWindow["sellHotdog"], false )
	end
	if gWindow["playerInteraktionShow"] then
		dgsSetVisible ( gWindow["playerInteraktionShow"], false )
	end
	if gWindow["stateInteraction"] then
		dgsSetVisible ( gWindow["stateInteraction"], false )
	end
end

function hideAllPlayerClickWindows ()

	hideAllSecPlayerClickWindows ()
	dgsSetVisible ( gWindow["playerInteraktion"], false )
	triggerServerEvent ( "cancel_gui_server", lp )
	showCursor ( false )
end

function showJobMenues(button)
	if button == "left" then
		local job = vioClientGetElementData ( "job" )
		if job == "wdealer" then
			hideAllSecPlayerClickWindows ()
			wDealerWindow()
		elseif job == "dealer" then
			hideAllSecPlayerClickWindows ()
			showDrugMenue()
		elseif job == "hotdog" then
			hideAllSecPlayerClickWindows ()
			giveHotDogGui()
		else
			outputChatBox ( "Du hast einen ungueltigen Beruf!", 125, 0, 0 )
		end
	end
end

function showZeigenMenue ()

	hideAllSecPlayerClickWindows ()
	if gWindow["playerInteraktionShow"] then
		dgsSetVisible ( gWindow["playerInteraktionShow"], true )
	else
		gWindow["playerInteraktionShow"] = dgsCreateWindow(screenwidth/2-176/2,145,176,78,"Zeigen",false)
		dgsSetAlpha(gWindow["playerInteraktionShow"],1)
		
		gButton["playerInteractionShowLicenses"] = dgsCreateButton(10,27,74,41,"Scheine",false,gWindow["playerInteraktionShow"])
		dgsSetAlpha(gButton["playerInteractionShowLicenses"],1)
		gButton["playerInteractionShowGWD"] = dgsCreateButton(90,27,74,41,"GWD-Note",false,gWindow["playerInteraktionShow"])
		dgsSetAlpha(gButton["playerInteractionShowGWD"],1)
		
		addEventHandler ( "onDgsMouseClickUp", gButton["playerInteractionShowLicenses"],
			function ( btn, state )
				if state == "up" then
					triggerServerEvent ( "showLicenses", lp, lp )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["playerInteractionShowGWD"],
			function ( btn, state )
				if state == "up" then
					triggerServerEvent ( "showGWD", lp, lp )
				end
			end,
		false )
	end
end

function showFactionMenue ()
	if gWindow["stateInteraction"] then
		dgsSetVisible ( gWindow["stateInteraction"], true )
	else
		gWindow["stateInteraction"] = dgsCreateWindow(screenwidth/2-172/2,145,172,153,"Staatsfraktion",false)
		dgsSetAlpha(gWindow["stateInteraction"],1)
		
		gButton["stateInteractionCuff"] = dgsCreateButton(9,26,74,35,"Fesseln",false,gWindow["stateInteraction"])
		dgsSetAlpha(gButton["stateInteractionCuff"],1)
		gButton["stateInteractionTakeWeapons"] = dgsCreateButton(90,26,74,35,"Entwaffnen",false,gWindow["stateInteraction"])
		dgsSetAlpha(gButton["stateInteractionTakeWeapons"],1)
		gButton["stateInteractionTakeIllegal"] = dgsCreateButton(9,66,74,35,"Illegales Abnehmen",false,gWindow["stateInteraction"])
		dgsSetAlpha(gButton["stateInteractionTakeIllegal"],1)
		gButton["stateInteractionFrisk"] = dgsCreateButton(90,66,74,35,"Durchsuchen",false,gWindow["stateInteraction"])
		dgsSetAlpha(gButton["stateInteractionFrisk"],1)
		gButton["stateInteractionDrugTest"] = dgsCreateButton(9,106,74,35,"Drogen / Alkohol\nTest",false,gWindow["stateInteraction"])
		dgsSetAlpha(gButton["stateInteractionDrugTest"],1)
		gButton["stateInteractionTakeGunlicense"] = dgsCreateButton(90,106,74,35,"Waffenschein\nabnehmen",false,gWindow["stateInteraction"])
		dgsSetAlpha(gButton["stateInteractionTakeGunlicense"],1)
		
		addEventHandler ( "onDgsMouseClickUp", gButton["stateInteractionCuff"],
			function ( btn, state )
				if state == "up" then
					triggerServerEvent ( "cuffGUI", lp, lp, "cuff", vioClientGetElementData("curclicked") )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["stateInteractionTakeWeapons"],
			function ( btn, state )
				if state == "up" then
					triggerServerEvent ( "takeweapons", lp, lp, "takeweapons", vioClientGetElementData("curclicked") )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["stateInteractionFrisk"],
			function ( btn, state )
				if state == "up" then
					triggerServerEvent ( "friskGUI", lp, lp, "frisk", vioClientGetElementData("curclicked") )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["stateInteractionTakeIllegal"],
			function ( btn, state )
				if state == "up" then
					triggerServerEvent ( "takeillegalGUI", lp, lp, "takeillegal", vioClientGetElementData("curclicked") )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["stateInteractionDrugTest"],
			function ( btn, state )
				if state == "up" then
					triggerServerEvent ( "test", lp, lp, "test", vioClientGetElementData("curclicked") )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["stateInteractionTakeGunlicense"],
			function ( btn, state )
				if state == "up" then
					triggerServerEvent ( "takegunlicenseGUI", lp, vioClientGetElementData("curclicked") )
				end
			end,
		false )
	end
end

function ShowInteraktionsguiGui_func ()

	if gWindow["playerInteraktion"] then
		dgsSetVisible ( gWindow["playerInteraktion"], true )
	else
		gWindow["playerInteraktion"] = dgsCreateWindow(screenwidth/2-211/2,0,211,132,"Interaktion",false)
		dgsSetAlpha(gWindow["playerInteraktion"],1)
		
		gButton["playerInteraktionShow"] = dgsCreateButton(9,48,60,34,"Zeigen",false,gWindow["playerInteraktion"])
		dgsSetAlpha(gButton["playerInteraktionShow"],1)
		gButton["playerInteraktionGive"] = dgsCreateButton(77,48,60,34,"Geben",false,gWindow["playerInteraktion"])
		dgsSetAlpha(gButton["playerInteraktionGive"],1)
		gButton["playerInteraktionFriendlist"] = dgsCreateButton(145,48,57,34,"Zur Friendlist",false,gWindow["playerInteraktion"])
		dgsSetAlpha(gButton["playerInteraktionFriendlist"],1)
		gButton["playerInteraktionJob"] = dgsCreateButton(9,87,60,34,"Job",false,gWindow["playerInteraktion"])
		dgsSetAlpha(gButton["playerInteraktionJob"],1)
		gButton["playerInteraktionFaction"] = dgsCreateButton(77,87,60,34,"Fraktion",false,gWindow["playerInteraktion"])
		dgsSetAlpha(gButton["playerInteraktionFaction"],1)
		gButton["playerInteraktionClose"] = dgsCreateButton(145,87,60,34,"Schliessen",false,gWindow["playerInteraktion"])
		dgsSetAlpha(gButton["playerInteraktionClose"],1)
		
		gLabel["playerInteraktionInfo1"] = dgsCreateLabel(10,22,111,22,"Name des Spielers:",false,gWindow["playerInteraktion"])
		dgsSetAlpha(gLabel["playerInteraktionInfo1"],1)
		dgsLabelSetColor(gLabel["playerInteraktionInfo1"],200,200,000)
		dgsLabelSetVerticalAlign(gLabel["playerInteraktionInfo1"],"top")
		dgsLabelSetHorizontalAlign(gLabel["playerInteraktionInfo1"],"left",false)
		dgsSetFont(gLabel["playerInteraktionInfo1"],"default-bold-small")
		
		gLabel["playerInteraktionClickedPlayer"] = dgsCreateLabel(121,23,82,20,"",false,gWindow["playerInteraktion"])
		dgsSetAlpha(gLabel["playerInteraktionClickedPlayer"],1)
		dgsLabelSetColor(gLabel["playerInteraktionClickedPlayer"],125,200,200)
		dgsLabelSetVerticalAlign(gLabel["playerInteraktionClickedPlayer"],"top")
		dgsLabelSetHorizontalAlign(gLabel["playerInteraktionClickedPlayer"],"left",false)
		dgsSetFont(gLabel["playerInteraktionClickedPlayer"],"default-bold-small")
		
		addEventHandler ( "onDgsMouseClickUp", gButton["playerInteraktionClose"], hideAllPlayerClickWindows, false )
		addEventHandler ( "onDgsMouseClickUp", gButton["playerInteraktionShow"], showZeigenMenue, false )
		addEventHandler ( "onDgsMouseClickUp", gButton["playerInteraktionJob"], showJobMenues, false )
		addEventHandler ( "onDgsMouseClickUp", gButton["playerInteraktionFaction"],
			function ( btn, state )
				if getElementData ( lp, "fraktion" ) == 1 or getElementData ( lp, "fraktion" ) == 6 or getElementData ( lp, "fraktion" ) == 8 then
					showFactionMenue()
				else
					outputChatBox ( "Du bist in keiner gueltigen Fraktion!", 125, 0, 0 )
				end
			end,
		false )
		
		addEventHandler ( "onDgsMouseClickUp", gButton["playerInteraktionFriendlist"],
			function ( btn, state )
				if state == "up" then
					triggerServerEvent ( "addFriend", getRootElement(), lp, vioClientGetElementData("curclicked") )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["playerInteraktionGive"],
			function ( btn, state )
				if state == "up" then
					hideAllSecPlayerClickWindows ()
					showItemGiveList()
				end
			end,
		false )
	end
	dgsSetText ( gLabel["playerInteraktionClickedPlayer"], vioClientGetElementData("curclicked") )
end
addEvent ( "ShowInteraktionsguiGui", true )
addEventHandler ( "ShowInteraktionsguiGui", getRootElement(), ShowInteraktionsguiGui_func )