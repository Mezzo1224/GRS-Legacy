
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

addEvent ( "syncPlayerList", true )

local gWindow = { }
local gLabel = { }
local gButton = { }
local gGrid = { }
local gEdit = {}
local fraktionMemberList = {}
local fraktionMemberListInvite = {}
local openagain = false

local screenwidth, screenheight = dgsGetScreenSize ()
 
 
addEventHandler ( "syncPlayerList", root, function ( array1, array2 )
	fraktionMemberList = {}
	fraktionMemberListInvite = {}
	for i, v in pairs ( array1 ) do
		fraktionMemberList[i] = v
	end
	for i, v in pairs ( array2 ) do
		fraktionMemberListInvite[i] = v
	end
	if openagain then
		fraktion_gui()
		openagain = false
	end
 end )
 
 
function fraktion_gui ( )
	if getElementData ( lp, "fraktion" ) == 0 then return end
	setElementClicked ( true )
	showCursor ( true )

	if gWindow["fraktion"] then
		dgsSetVisible ( gWindow["fraktion"], true )
		dgsGridListClear ( gGrid["fraktion"] )
	else
        local screenW, screenH = dgsGetScreenSize()
        gWindow["fraktion"] = dgsCreateImage((screenW - 548) / 2, (screenH - 404) / 2, 548, 364, "images/gui/fraktion.png", false)
		--gWindow["fraktion"] = guiCreateWindow ( screenwidth/2-445/2, screenheight/2-294/2, 536, 297,"Fraktionsuebersicht", false )
		dgsSetAlpha ( gWindow["fraktion"],1 )

		-- Welcome
		gLabel[1] = dgsCreateLabel ( 10, 56, 418, 70,"\n\nHier habt ihr eine Liste der Fraktionsmitglieder.", false, gWindow["fraktion"] )
		dgsSetAlpha ( gLabel[1], 1 )
		dgsLabelSetColor ( gLabel[1], 255, 255, 255)
		dgsLabelSetVerticalAlign ( gLabel[1],"top" )
		dgsLabelSetHorizontalAlign ( gLabel[1],"left", false )
		dgsSetFont ( gLabel[1],"default-bold-small" )

		gGrid["fraktion"] = dgsCreateGridList ( 10, 120, 299, 187, false, gWindow["fraktion"] )
		Name = dgsGridListAddColumn ( gGrid["fraktion"], "Name", 0.3 )								
		Rang = dgsGridListAddColumn ( gGrid["fraktion"], "Rang", 0.1 )				
		Zeit = dgsGridListAddColumn ( gGrid["fraktion"], "Zeit", 0.30 )
		Status = dgsGridListAddColumn ( gGrid["fraktion"], "Status", 0.2 )
		
		-- Close		
		gButton["closeFraktion"] = dgsCreateButton ( 502, 43, 16, 17,"x", false, gWindow["fraktion"] )
		dgsSetAlpha ( gButton["closeFraktion"],1 )
		addEventHandler ( "onDgsMouseClickUp", gButton["closeFraktion"], 
		function ()
			if ( source == gButton["closeFraktion"] ) then
				fraktion_gui_hide ( )
			end
		end
		)
				
		-- Fraktionsmenue
		gLabel[2] = dgsCreateLabel ( 326, 116, 199, 20,"", false, gWindow["fraktion"] )
		dgsSetAlpha ( gLabel[2], 1 )
		dgsLabelSetColor ( gLabel[2], 255, 255, 255)
		dgsLabelSetVerticalAlign ( gLabel[2],"top" )
		dgsLabelSetHorizontalAlign ( gLabel[2],"left", false )
		dgsSetFont ( gLabel[2],"default-bold-small" )		

		-- Orten
		gButton["ortenFraktion"] = dgsCreateButton ( 319, 139, 100, 25,"Orten", false, gWindow["fraktion"] )
		dgsSetAlpha ( gButton["ortenFraktion"],1 )
		addEventHandler ( "onDgsMouseClickUp", gButton["ortenFraktion"], 
		function ()
			if ( source == gButton["ortenFraktion"] ) then
				local pname = dgsGridListGetItemText ( gGrid["fraktion"], dgsGridListGetSelectedItem ( gGrid["fraktion"] ), Name )
				if getPlayerFromName ( pname ) then
					local target = getPlayerFromName ( pname )
					if getElementData ( target, "handystate" ) == "off" then
						outputChatBox ( "Das Handy des Buergers ist ausgeschaltet!", 125, 0, 0 )
					else
						if tonumber ( getElementInterior ( target ) ) ~= 0 or tonumber ( getElementDimension ( target ) ) ~= 0 then
							outputChatBox ( "Der Spieler befindet sich in einem Gebaeude - Ortung nicht moeglich!", 125, 0, 0 )
						else
							if isElement ( MemberBlip ) then
								destroyElement ( MemberBlip )
								if isTimer ( deletetMemberBlipTimer ) then
									killTimer ( deletetMemberBlipTimer )
								end
								MemberBlip = createBlipAttachedTo ( target, 0, 2, 255, 0, 0, 255, 0, 99999.0, player )
								deletetMemberBlipTimer = setTimer ( deletetMemberBlip, 5000, 1 )
							else
								MemberBlip = createBlipAttachedTo ( target, 0, 2, 255, 0, 0, 255, 0, 99999.0, player )
								deletetMemberBlipTimer = setTimer ( deletetMemberBlip, 5000, 1 )
							end
						end
					end
				else
					outputChatBox ( "Der Spieler ist gerade nicht online", 125, 0, 0 )
				end
			end
		end
		)
		
		if tonumber ( vioClientGetElementData ( "rang" ) ) >= 5 then
			-- Leadermenue
			gLabel[3] = dgsCreateLabel ( 326, 188, 199, 20,"Leadermenue", false, gWindow["fraktion"] )
			dgsSetAlpha ( gLabel[3], 1 )
			dgsLabelSetColor ( gLabel[3], 255, 255, 255)
			dgsLabelSetVerticalAlign ( gLabel[3],"top" )
			dgsLabelSetHorizontalAlign ( gLabel[3],"left", false )
			dgsSetFont ( gLabel[3],"default-bold-small" )				
			
			-- Spielername
			gLabel[4] = dgsCreateLabel ( 326, 206, 100, 20,"Spielername:", false, gWindow["fraktion"] )
			dgsSetAlpha ( gLabel[4], 1 )
			dgsLabelSetColor ( gLabel[4], 255, 255, 255)
			dgsLabelSetVerticalAlign ( gLabel[4],"top" )
			dgsLabelSetHorizontalAlign ( gLabel[4],"left", false )
			dgsSetFont ( gLabel[4],"default-bold-small" )	

			-- Spielername - Edit
			gEdit["pnameFraktion"] = dgsCreateEdit ( 319, 225, 100, 25, "", false, gWindow["fraktion"] )

			-- Einladen
			gButton["inviteFraktion"] = dgsCreateButton ( 319, 256, 100, 25, "Einladen", false, gWindow["fraktion"] )
			addEventHandler ( "onDgsMouseClickUp", gButton["inviteFraktion"], 
				function ()
					if ( source == gButton["inviteFraktion"] ) then
						local pname = dgsGetText ( gEdit["pnameFraktion"] )
						triggerServerEvent ( "fraktion_invite", getLocalPlayer (), pname )
						fraktion_gui_hide ()
						openagain = true
					end
				end, false )
			
			-- Kicken
			gButton["kickFraktion"] = dgsCreateButton ( 319, 284, 100, 25, "Kicken", false, gWindow["fraktion"] )
			addEventHandler ( "onDgsMouseClickUp", gButton["kickFraktion"], function ()
				local pname = dgsGridListGetItemText ( gGrid["fraktion"], dgsGridListGetSelectedItem ( gGrid["fraktion"] ), Name )
				if pname then
					triggerServerEvent ( "fraktion_uninvite", getLocalPlayer (), pname )
					fraktion_gui_hide ()
					openagain = true
				end
			end, false )
			
			-- Neuer Rang
			gLabel[5] = dgsCreateLabel( 426, 206, 100, 20,"Neuer Rang:",false,gWindow["fraktion"])
			dgsSetAlpha ( gLabel[5], 1 )
			dgsLabelSetColor ( gLabel[5], 255, 255, 255)
			dgsLabelSetVerticalAlign ( gLabel[5],"top" )
			dgsLabelSetHorizontalAlign ( gLabel[5],"left", false )
			dgsSetFont ( gLabel[5],"default-bold-small" )	
			
			-- Neuer Rang - Edit
			gEdit["newrangFraktion"] = dgsCreateEdit ( 423, 225, 100, 25, "", false, gWindow["fraktion"] )
		
			-- Befördern
			gButton["befoerdernFraktion"] = dgsCreateButton ( 423, 256, 100, 25, "Befördern", false, gWindow["fraktion"] )
			addEventHandler ( "onDgsMouseClickUp", gButton["befoerdernFraktion"], function ()
				local pname = dgsGridListGetItemText ( gGrid["fraktion"], dgsGridListGetSelectedItem ( gGrid["fraktion"] ), Name )		
				local nrang = tonumber ( dgsGetText ( gEdit["newrangFraktion"] ) ) 
				if tonumber(nrang) ~= nil and nrang >= 0 and nrang <= 5 then
					triggerServerEvent ( "fraktion_befoerdern", getLocalPlayer(), pname, nrang )
					fraktion_gui_hide ()
					openagain = true
				end
			end, false )
			
			-- Degradieren
			gButton["dregadierenFraktion"] = dgsCreateButton ( 423, 284, 100, 25, "Degradieren", false, gWindow["fraktion"] )
			dgsSetAlpha(gButton["dregadierenFraktion"],1)
			addEventHandler ( "onDgsMouseClickUp", gButton["dregadierenFraktion"], function ()
				local pname = dgsGridListGetItemText ( gGrid["fraktion"], dgsGridListGetSelectedItem ( gGrid["fraktion"] ), Name )		
				local nrang = tonumber ( dgsGetText ( gEdit["newrangFraktion"] ) )		
				if tonumber(nrang) ~= nil and nrang >= 0 and nrang <= 5 then
					triggerServerEvent ( "fraktion_degradieren", getLocalPlayer(), pname, nrang )
					fraktion_gui_hide ()
					openagain = true
				end
			end, false )
		end
	end
	dgsSetInputMode ( "no_binds_when_editing" )
	if gEdit["newrangFraktion"] then
		dgsSetText ( gEdit["newrangFraktion"], "" )
	end
	if gEdit["pnameFraktion"] then
		dgsSetText ( gEdit["pnameFraktion"], "" ) 
	end
	fill_memberlist_func ( )
end
--addCommandHandler ( "fraktion", fraktion_gui )

function fill_memberlist_func ( )
	local frac = getElementData (lp, "fraktion")
	if frac == 11 then frac = 10 end
	for player, rang in pairs (fraktionMemberList) do
		local loggedin = getPlayerFromName( player )
		local status = ""
		if loggedin then
			status = "online"
		else
			status = "offline"
		end
		local Zeile = dgsGridListAddRow ( gGrid["fraktion"] )
		local frakzeit = fraktionMemberListInvite[player] or "Unbekannt"
		dgsGridListSetItemText ( gGrid["fraktion"], Zeile, Name, player, false, false )
		dgsGridListSetItemText ( gGrid["fraktion"], Zeile, Rang, rang, false, false )	
		dgsGridListSetItemText ( gGrid["fraktion"], Zeile, Zeit, frakzeit, false, false )
		dgsGridListSetItemText ( gGrid["fraktion"], Zeile, Status, status, false, false )	
		if status == "online" then
			dgsGridListSetItemColor ( gGrid["fraktion"], Zeile, Status, 0, 125, 0 )
		elseif status == "offline" then
			dgsGridListSetItemColor ( gGrid["fraktion"], Zeile, Status, 125, 0, 0 )
		end
	end
end

function fraktion_gui_hide ( )
	dgsSetVisible ( gWindow["fraktion"], false )
	showCursor ( false )
	setElementClicked ( false )
	dgsGridListClear ( gGrid["fraktion"] )
	dgsSetInputMode ( "allow_binds" )
end

function deletetMemberBlip ()

	destroyElement ( MemberBlip )
	MemberBlip = nil
end