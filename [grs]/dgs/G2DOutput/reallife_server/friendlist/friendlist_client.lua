
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

-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

localPlayer = getLocalPlayer()
local friendlistArray = {}

function showFriendlistCurState ( player, state )

	if gWindow["friendlistIsOnline"] then
		dgsSetVisible ( gWindow["friendlistIsOnline"], true )
		dgsSetText ( gWindow["friendlistIsOnline"], getPlayerName ( player ) )
		dgsSetText ( gLabel["FriendState"], "...ist "..state.."!" )
	else
		local screenwidth, screenheight = dgsGetScreenSize ()
		
		gWindow["friendlistIsOnline"] = dgsCreateWindow(screenwidth-103,screenheight-49,103,49,getPlayerName ( player ),false)
		dgsSetAlpha(gWindow["friendlistIsOnline"],1)
		gLabel["FriendState"] = dgsCreateLabel(0.0971,0.4694,1.068,0.4694,"...ist "..state.."!",true,gWindow["friendlistIsOnline"])
		dgsSetAlpha(gLabel["FriendState"],1)
		dgsLabelSetColor(gLabel["FriendState"],200,200,20)
		dgsLabelSetVerticalAlign(gLabel["FriendState"],"top")
		dgsLabelSetHorizontalAlign(gLabel["FriendState"],"left",false)
	end
	if isTimer ( hideFriendlistStatechangeTimer ) then
		killTimer ( hideFriendlistStatechangeTimer )
	end
	local hideFriendlistStatechangeTimer = setTimer ( hideFriendlistStatechange, 3000, 1 )
	playSoundFrontEnd ( 45 )
end

function hideFriendlistStatechange ()

	dgsSetVisible ( gWindow["friendlistIsOnline"], false )
end

function playerFriendlistJoin ()
	if _G["friend"..getPlayerName(source)] then
		friendlistArray[source] = true
		showFriendlistCurState ( source, "online" )
	else
		friendlistArray[source] = false
	end
end
addEventHandler( "onClientPlayerJoin", root, playerFriendlistJoin )

function playerFriendlistQuit ()

	if friendlistArray[source] then
		showFriendlistCurState ( source, "offline" )
		friendlistArray[source] = nil
	end
end
addEventHandler( "onClientPlayerQuit", root, playerFriendlistQuit )

function loadFriendlist_func ()

	local friendlist = xmlLoadFile ( "friendlist/friendlist.xml" )
	if friendlist then
		local friends = getFriends()
		local lastfriend = "console"
		local newfriend = ""
		for i = 1, 100 do
			local newfriend = gettok ( friends, i, string.byte("|") )
			if tostring ( newfriend ) == tostring ( lastfriend ) then
				break
			elseif newfriend then
				_G["friend"..newfriend] = true
			end
			local lastfriend = gettok ( friends, i, string.byte("|") )
		end
	end
end
addEvent ( "loadFriendlist", true )
addEventHandler ( "loadFriendlist", getRootElement(), loadFriendlist_func )

function showFriendlistSelf()

	if gWindow["friendlistMenue"] then
		dgsSetVisible ( gWindow["friendlistMenue"], true )
	else
		local screenwidth, screenheight = dgsGetScreenSize ()
		
		gWindow["friendlistMenue"] = dgsCreateWindow(screenwidth/2-364/2,120,364,282,"Friendlist",false)
		dgsSetAlpha(gWindow["friendlistMenue"],1)
		dgsWindowSetMovable(gWindow["friendlistMenue"],false)
		dgsWindowSetSizable(gWindow["friendlistMenue"],false)
		gGrid["friendlistNames"] = dgsCreateGridList(0.0302,0.0957,0.4038,0.8617,true,gWindow["friendlistMenue"])
		dgsGridListSetSelectionMode(gGrid["friendlistNames"],2)
		gColumn["friendNames"] = dgsGridListAddColumn(gGrid["friendlistNames"],"Name",0.8)
		dgsSetAlpha(gGrid["friendlistNames"],1)
		gLabel["addFriend"] = dgsCreateLabel(0.4478,0.078,0.3269,0.0638,"Freund hinzufuegen:",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gLabel["addFriend"],1)
		dgsLabelSetColor(gLabel["addFriend"],200,200,000)
		dgsLabelSetVerticalAlign(gLabel["addFriend"],"top")
		dgsLabelSetHorizontalAlign(gLabel["addFriend"],"left",false)
		dgsSetFont(gLabel["addFriend"],"default-bold-small")
		gEdit["friendName"] = dgsCreateEdit(0.4451,0.1348,0.2582,0.0957,"",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gEdit["friendName"],1)
		gLabel["curFriendSelected"] = dgsCreateLabel(0.4451,0.2695,0.3819,0.0674,"Momentan ausgewaehlt:",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gLabel["curFriendSelected"],1)
		dgsLabelSetColor(gLabel["curFriendSelected"],000,125,000)
		dgsLabelSetVerticalAlign(gLabel["curFriendSelected"],"top")
		dgsLabelSetHorizontalAlign(gLabel["curFriendSelected"],"left",false)
		dgsSetFont(gLabel["curFriendSelected"],"default-bold-small")
		gLabel["FriendName"] = dgsCreateLabel(0.467,0.3404,0.3489,0.0887,"",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gLabel["FriendName"],1)
		dgsLabelSetColor(gLabel["FriendName"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["FriendName"],"top")
		dgsLabelSetHorizontalAlign(gLabel["FriendName"],"left",false)
		gLabel["friendHandNR"] = dgsCreateLabel(0.4396,0.422,0.1758,0.0674,"Handy-NR:",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gLabel["friendHandNR"],1)
		dgsLabelSetColor(gLabel["friendHandNR"],000,125,000)
		dgsLabelSetVerticalAlign(gLabel["friendHandNR"],"top")
		dgsLabelSetHorizontalAlign(gLabel["friendHandNR"],"left",false)
		dgsSetFont(gLabel["friendHandNR"],"default-bold-small")
		gLabel["friendState"] = dgsCreateLabel(0.6923,0.422,0.2335,0.0674,"Status:",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gLabel["friendState"],1)
		dgsLabelSetColor(gLabel["friendState"],000,125,000)
		dgsLabelSetVerticalAlign(gLabel["friendState"],"top")
		dgsLabelSetHorizontalAlign(gLabel["friendState"],"left",false)
		dgsSetFont(gLabel["friendState"],"default-bold-small")
		gLabel["friendHandyNRValue"] = dgsCreateLabel(0.4396,0.4858,0.1484,0.0567,"",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gLabel["friendHandyNRValue"],1)
		dgsLabelSetColor(gLabel["friendHandyNRValue"],125,125,50)
		dgsLabelSetVerticalAlign(gLabel["friendHandyNRValue"],"top")
		dgsLabelSetHorizontalAlign(gLabel["friendHandyNRValue"],"left",false)
		gLabel["friendStateValue"] = dgsCreateLabel(0.6923,0.4858,0.1484,0.0603,"",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gLabel["friendStateValue"],1)
		dgsLabelSetColor(gLabel["friendStateValue"],000,255,000)
		dgsLabelSetVerticalAlign(gLabel["friendStateValue"],"top")
		dgsLabelSetHorizontalAlign(gLabel["friendStateValue"],"left",false)
		gLabel["friendFaction"] = dgsCreateLabel(0.4451,0.5816,0.1648,0.0638,"Fraktion:",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gLabel["friendFaction"],1)
		dgsLabelSetColor(gLabel["friendFaction"],000,125,000)
		dgsLabelSetVerticalAlign(gLabel["friendFaction"],"top")
		dgsLabelSetHorizontalAlign(gLabel["friendFaction"],"left",false)
		dgsSetFont(gLabel["friendFaction"],"default-bold-small")
		gLabel["friendFactionValue"] = dgsCreateLabel(0.4451,0.6383,0.1511,0.0638,"",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gLabel["friendFactionValue"],1)
		dgsLabelSetColor(gLabel["friendFactionValue"],125,125,50)
		dgsLabelSetVerticalAlign(gLabel["friendFactionValue"],"top")
		dgsLabelSetHorizontalAlign(gLabel["friendFactionValue"],"left",false)
		
		gButton["friendAdd"] = dgsCreateButton(0.728,0.1348,0.2308,0.0957,"Hinzufuegen",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gButton["friendAdd"],1)
		
		gButton["delFriend"] = dgsCreateButton(0.4423,0.7128,0.2225,0.1099,"Freund entfernen",true,gWindow["friendlistMenue"])
		dgsSetAlpha(gButton["delFriend"],1)
		--gButton["smsFriend"] = guiCreateButton(0.7088,0.7128,0.2225,0.1099,"SMS\nschreiben",true,gWindow["friendlistMenue"])
		--guiSetAlpha(gButton["smsFriend"],1)
		--gButton["pmFriend"] = guiCreateButton(0.4423,0.8511,0.2225,0.1099,"PM\nschreiben",true,gWindow["friendlistMenue"])
		--guiSetAlpha(gButton["pmFriend"],1)
		--gButton["callFriend"] = guiCreateButton(0.7088,0.8511,0.2225,0.1099,"Anrufen",true,gWindow["friendlistMenue"])
		--guiSetAlpha(gButton["callFriend"],1)
		
		addEventHandler("onDgsMouseClickUp", gButton["friendAdd"],
			function()
				triggerServerEvent ( "addFriend", getRootElement(), getLocalPlayer(), dgsGetText ( gEdit["friendName"] ) )
			end
		)
		addEventHandler("onDgsMouseClickUp", gGrid["friendlistNames"],
			function()
				local row = dgsGridListGetItemText ( gGrid["friendlistNames"], dgsGridListGetSelectedItem ( gGrid["friendlistNames"] ), 1 )
				dgsSetText ( gLabel["FriendName"], tostring ( row ) )
				local player = getPlayerFromName ( row )
				deleteFriendLabels()
				if row then
					if player then
						local fraktion = fraktionsNamen[tonumber ( getElementData ( player, "fraktion" ) )]
						dgsSetText ( gLabel["friendFactionValue"], fraktion )
						dgsSetText ( gLabel["friendStateValue"], "online" )
						dgsLabelSetColor ( gLabel["friendStateValue"], 0, 255, 0 )
						dgsSetText ( gLabel["friendHandyNRValue"], getElementData ( player, "telenr" ) )
						dgsSetText ( gLabel["FriendName"], tostring ( row ) )
					else
						dgsSetText ( gLabel["friendFactionValue"], "-" )
						dgsSetText ( gLabel["friendStateValue"], "offline" )
						dgsLabelSetColor ( gLabel["friendStateValue"], 125, 0, 0 )
						dgsSetText ( gLabel["friendHandyNRValue"], "-" )
						dgsSetText ( gLabel["FriendName"], tostring ( row ) )
					end
				else
					dgsSetText ( gLabel["friendFactionValue"], "-" )
					dgsSetText ( gLabel["friendStateValue"], "-" )
					dgsLabelSetColor ( gLabel["friendStateValue"], 255, 255, 255 )
					dgsSetText ( gLabel["friendHandyNRValue"], "-" )
					dgsSetText ( gLabel["FriendName"], "Bitte waehlen!" )
				end
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["delFriend"],
			function()
				local row = dgsGridListGetItemText ( gGrid["friendlistNames"], dgsGridListGetSelectedItem ( gGrid["friendlistNames"] ), 1 )
				deleteFriend( row )
			end
		)
		--[[addEventHandler("onClientGUIClick", gButton["callFriend"],
			function()
				outputChatBox ( "NR: "..tonumber ( gLabel["friendHandyNRValue"] ) ) -- DEBUG
				triggerServerEvent ( "callSomeone", getLocalPlayer(), getLocalPlayer(), tonumber ( gLabel["friendHandyNRValue"] ) )
				SelfCancelBtn ()
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["smsFriend"],
			function()
				dgsSetVisible ( gWindow["friendlistMenue"], false )
				local smsnr = tonumber ( gLabel["friendHandyNRValue"] )
				outputChatBox ( "NR: "..smsnr ) -- DEBUG
				handysmsschreiben ( smsnr )
			end
		)]]
	end
	deleteFriendLabels()
	fillFriendlist()
end

function deleteFriendLabels()

	if isElement ( gEdit["FriendName"] ) then
		dgsSetText ( gEdit["FriendName"], "" )
		dgsSetText ( gLabel["friendFactionValue"], "-" )
		dgsSetText ( gLabel["friendStateValue"], "-" )
		dgsLabelSetColor ( gLabel["friendStateValue"], 255, 255, 255 )
		dgsSetText ( gLabel["friendHandyNRValue"], "-" )
		dgsSetText ( gLabel["FriendName"], "Bitte waehlen!" )
	end
end

function deleteFriend ( friendname )

	local newfriends = ""
	for i = 0, dgsGridListGetRowCount ( gGrid["friendlistNames"] ) do
		local text = dgsGridListGetItemText ( gGrid["friendlistNames"], i, gColumn["friendNames"] )
		if text ~= friendname then
			newfriends = newfriends..text.."|"
		else
			outputChatBox ( "Freund geloescht!", 125, 0, 0 )
			_G["friend"..friendname] = false
		end
	end
	local friendlist = xmlLoadFile ( "friendlist/friendlist.xml" )
	local friends = xmlNodeGetChildren ( friendlist, 0 )
	xmlNodeSetValue ( friends, newfriends )
	xmlSaveFile ( friendlist )
	deleteFriendLabels()
	fillFriendlist()
end

function getFriends ()

	local friendlist = xmlLoadFile ( "friendlist/friendlist.xml" )
	local friends = xmlNodeGetChildren ( friendlist, 0 )
	xmlSaveFile ( friendlist )
	local friends = xmlNodeGetValue ( friends )
	if friends then
		return friends
	else
		return false
	end
end

function addFriend_func ( friendname )

	local friendlist = xmlLoadFile ( "friendlist/friendlist.xml" )
	local friends = xmlNodeGetChildren ( friendlist, 0 )
	local curfriends = xmlNodeGetValue ( friends )
	local lastfriend = "console"
	for i = 1, 100 do
		local newfriend = gettok ( curfriends, i, string.byte("|") )
		if not newfriend then
			outputChatBox ( "Freund wurde zur Liste hinzugefuegt!", 0, 125, 0 )
			_G["friend"..friendname] = true
			xmlNodeSetValue ( friends, curfriends..friendname.."|" )
			xmlSaveFile ( friendlist )
			deleteFriendLabels()
			fillFriendlist()
			break
		end
		if tostring ( newfriend ) == tostring ( friendname ) then
			outputChatBox ( "Der Spieler ist bereits in der Liste!", 125, 0, 0 )
			break
		end	
		local lastfriend = newfriend
	end
end
addEvent ( "addFriend", true )
addEventHandler ( "addFriend", getRootElement(), addFriend_func )

function fillFriendlist()

	if gGrid["friendlistNames"] then
		dgsGridListClear ( gGrid["friendlistNames"] )
		local friendlist = xmlLoadFile ( "friendlist/friendlist.xml" )
		if not friendlist then
			local friendlist = xmlCreateFile ( "friendlist/friendlist.xml", "friendlist" )
			local friends = xmlCreateChild ( friendlist, "friends" )
			xmlNodeSetValue ( friends, "" )
			xmlSaveFile ( friendlist )
		end
		local friendlist = xmlLoadFile ( "friendlist/friendlist.xml" )
		local friends = getFriends()
		local lastfriend = "console"
		local newfriend = ""
		for i = 1, 100 do
			local newfriend = gettok ( friends, i, string.byte("|") )
			if tostring ( newfriend ) == tostring ( lastfriend ) then
				break
			elseif newfriend then
				local row = dgsGridListAddRow ( gGrid["friendlistNames"] )
				dgsGridListSetItemText ( gGrid["friendlistNames"], row, gColumn["friendNames"], newfriend, false, false )
				_G["friend"..newfriend] = true
			end
			local lastfriend = gettok ( friends, i, string.byte("|") )
		end
	end
end