
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
respawnCMDs = { ["faggio"]="faggio",
 ["sfpd"]="sfpd",
 ["mafia"]="mafia",
 ["triaden"]="triaden",
 ["news"]="news",
 ["terror"]="terror",
 ["fbi"]="fbi",
 ["aztecas"]="aztecas",
 ["army"]="army",
 ["biker"]="biker",
 ["fishing"]="fishing",
 ["taxi"]="taxi",
 ["hotdog"]="hotdog"
}

function showAdminMenue ()

	if gWindow["plistadmin"] then
		dgsSetVisible ( gWindow["plistadmin"], true )
	else
		gWindow["plistadmin"] = dgsCreateWindow(screenwidth/2-568/2,120,568,585,"Adminmenue",false)
		dgsSetAlpha(gWindow["plistadmin"],1)
		dgsWindowSetMovable ( gWindow["plistadmin"], true )
		
		gGrid["plistadmin"] = dgsCreateGridList(9,27,229,543,false,gWindow["plistadmin"])
		dgsGridListSetSelectionMode(gGrid["plistadmin"],0)
		gColumn["adminName"] = dgsGridListAddColumn(gGrid["plistadmin"],"Spieler",0.6)
		gColumn["adminPing"] = dgsGridListAddColumn(gGrid["plistadmin"],"Ping",0.2)
		
		dgsSetAlpha(gGrid["plistadmin"],1)
		gTabPanel["adminMenue"] = dgsCreateTabPanel(241,29,318,541,false,gWindow["plistadmin"])
		dgsSetAlpha(gTabPanel["adminMenue"],1)
		
		gTab[1] = dgsCreateTab("Basis",gTabPanel["adminMenue"])
		dgsSetAlpha(gTab[1],1)
		gImage[1] = dgsCreateImage(5,7,76,43,"images/colors/c_red.jpg",false,gTab[1])
		dgsSetAlpha(gImage[1],1)
		gLabel[1] = dgsCreateLabel(8,7,57,29,"Notfallab-\nschaltung",false,gImage[1])
		dgsSetAlpha(gLabel[1],1)
		dgsLabelSetColor(gLabel[1],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[1],"top")
		dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
		dgsSetFont(gLabel[1],"default-bold-small")
		gCheck[1] = dgsCreateCheckBox(87,18,198,18,"Wirklich dauerhaft abschalten?",false,false,gTab[1])
		dgsSetAlpha(gCheck[1],1)
		dgsSetFont(gCheck[1],"default-bold-small")
		addEventHandler ( "onDgsMouseClickUp", gImage[1], 
			function ()
				if source == gImage[1] or source == gLabel[1] then
					if dgsCheckBoxGetSelected ( gCheck[1] ) then
						triggerServerEvent ( "executeAdminServerCMD", lp, "shut" )
					else
						outputChatBox ( "Bitte aktiviere das Kontrollkaestchen!", 125, 0, 0 )
					end
				end
			end
		)

		gGrid["respawnList"] = dgsCreateGridList(107,336,179,162,false,gTab[1])
		dgsGridListSetSelectionMode(gGrid["respawnList"],0)
		gColumn["respawnList"] = dgsGridListAddColumn(gGrid["respawnList"],"Spieler",0.8)
		
		for key, index in pairs ( respawnCMDs ) do
			local row = dgsGridListAddRow ( gGrid["respawnList"] )
			dgsGridListSetItemText ( gGrid["respawnList"], row, gColumn["respawnList"], key, false, false )
		end
		
		gButton["adminRespawn"] = dgsCreateButton(4,394,79,38,"Respawnen",false,gTab[1])
		addEventHandler ( "onDgsMouseClickUp", gButton["adminRespawn"], 
			function ( btn, state )
				if state == "up" then
				
					if dgsGetText( gEdit[15] ) ~= "" then
					
						triggerServerEvent ( "executeAdminServerCMD", lp, "crespawn", tonumber(dgsGetText( gEdit[15] )) )
					
					else
				
						row, column = dgsGridListGetSelectedItem(gGrid["respawnList"])
						veh = dgsGridListGetItemText ( gGrid["respawnList"], row, column )
						triggerServerEvent ( "executeAdminServerCMD", lp, "respawn", veh )
					
					end
					
				end
			end,
		false)
		
		gButton[1] = dgsCreateButton(4,62,79,38,"Kick",false,gTab[1])
		dgsSetAlpha(gButton[1],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[1], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "rkick", player.." "..dgsGetText ( gMemo[1] ) )
			end,
		false )
		gButton[2] = dgsCreateButton(5,106,79,38,"Ban",false,gTab[1])
		dgsSetAlpha(gButton[2],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[2], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "rban", player.." "..dgsGetText ( gMemo[1] ) )
			end,
		false )
		gButton[3] = dgsCreateButton(5,149,79,38,"Warn",false,gTab[1])
		dgsSetAlpha(gButton[3],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[3], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				
				if not row then
					player = dgsGetText ( gEdit[2] )
				else
					player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				end
				triggerServerEvent ( "warn", lp, player, dgsGetText ( gEdit[1] ), dgsGetText ( gMemo[1] ) )
			end,
		false )
		gButton[4] = dgsCreateButton(6,193,79,38,"Timeban",false,gTab[1])
		dgsSetAlpha(gButton[4],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[4], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "tban", player.." "..dgsGetText ( gEdit[1] ).." "..dgsGetText ( gMemo[1] ) )
			end,
		false )
		gMemo[1] = dgsCreateMemo(92,78,212,110,"",false,gTab[1])
		dgsSetAlpha(gMemo[1],1)
		gLabel[2] = dgsCreateLabel(119,61,39,17,"Grund:",false,gTab[1])
		dgsSetAlpha(gLabel[2],1)
		dgsLabelSetColor(gLabel[2],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[2],"top")
		dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
		dgsSetFont(gLabel[2],"default-bold-small")
		gEdit[1] = dgsCreateEdit(174,192,86,41,"",false,gTab[1])
		dgsSetAlpha(gEdit[1],1)
		gLabel[3] = dgsCreateLabel(141,204,29,16,"Zeit:",false,gTab[1])
		dgsSetAlpha(gLabel[3],1)
		dgsLabelSetColor(gLabel[3],200,00,0)
		dgsLabelSetVerticalAlign(gLabel[3],"top")
		dgsLabelSetHorizontalAlign(gLabel[3],"left",false)
		dgsSetFont(gLabel[3],"default-bold-small")
		gLabel[4] = dgsCreateLabel(264,202-15,48,55,"Stunden\n(TBan)\nTage\n(Warn)",false,gTab[1])
		dgsSetAlpha(gLabel[4],1)
		dgsLabelSetColor(gLabel[4],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[4],"top")
		dgsLabelSetHorizontalAlign(gLabel[4],"left",false)
		dgsSetFont(gLabel[4],"default-bold-small")
		gButton[5] = dgsCreateButton(6,236,79,38,"Entbannen",false,gTab[1])
		dgsSetAlpha(gButton[5],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[5], 
			function ()
				triggerServerEvent ( "executeAdminServerCMD", lp, "unban", dgsGetText ( gEdit[2] ) )
			end,
		false )
		gButton["playerToCheckWarns"] = dgsCreateButton(6,236+15+34,79,38,"Warns\nPrüfen",false,gTab[1])
		dgsSetAlpha(gButton["playerToCheckWarns"],1)
		addEventHandler ( "onDgsMouseClickUp", gButton["playerToCheckWarns"], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				
				if not row then
					player = dgsGetText ( gEdit[2] )
				else
					player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				end
				triggerServerEvent ( "checkwarns", lp, player )
			end,
		false )
		gButton["playerToCheckIP"] = dgsCreateButton(6,236+15*2+34*2,79,38,"IP\nPrüfen",false,gTab[1])
		dgsSetAlpha(gButton["playerToCheckIP"],1)
		addEventHandler ( "onDgsMouseClickUp", gButton["playerToCheckIP"], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				
				if not row then
					player = dgsGetText ( gEdit[2] )
				else
					player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				end
				triggerServerEvent ( "getip", lp, lp, "getip", player )
			end,
		false )
		gLabel[5] = dgsCreateLabel(92,244,104,29,"Spielername:",false,gTab[1])
		dgsSetAlpha(gLabel[5],1)
		dgsLabelSetColor(gLabel[5],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[5],"top")
		dgsLabelSetHorizontalAlign(gLabel[5],"left",false)
		dgsSetFont(gLabel[5],"default-bold-small")
		gEdit[2] = dgsCreateEdit(175,238,92,34,"",false,gTab[1])
		dgsSetAlpha(gEdit[2],1)
		gTab[2] = dgsCreateTab("Raeumlich",gTabPanel["adminMenue"])
		dgsSetAlpha(gTab[2],1)
		gButton[6] = dgsCreateButton(4,6,81,39,"Zum Spieler teleportieren",false,gTab[2])
		dgsSetAlpha(gButton[6],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[6], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "goto", player )
			end,
		false )
		gButton[7] = dgsCreateButton(4,52,81,39,"Spieler her teleportieren",false,gTab[2])
		dgsSetAlpha(gButton[7],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[7], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "gethere", player )
			end,
		false )
		
		gButton["move_left"] = dgsCreateButton(100,100,20,20,"*",false,gTab[2])
		dgsSetAlpha(gButton["move_left"],1)
		addEventHandler ( "onDgsMouseClickUp", gButton["move_left"], 
			function ()
				triggerServerEvent ( "move", lp, lp, "move", "left" )
			end,
		false )
		gButton["move_up"] = dgsCreateButton(120,80,20,20,"*",false,gTab[2])
		dgsSetAlpha(gButton["move_up"],1)
		addEventHandler ( "onDgsMouseClickUp", gButton["move_up"], 
			function ()
				triggerServerEvent ( "move", lp, lp, "move", "up" )
			end,
		false )
		gButton["move_right"] = dgsCreateButton(140,100,20,20,"*",false,gTab[2])
		dgsSetAlpha(gButton["move_right"],1)
		addEventHandler ( "onDgsMouseClickUp", gButton["move_right"], 
			function ()
				triggerServerEvent ( "move", lp, lp, "move", "right" )
			end,
		false )
		gButton["move_down"] = dgsCreateButton(120,120,20,20,"*",false,gTab[2])
		dgsSetAlpha(gButton["move_down"],1)
		addEventHandler ( "onDgsMouseClickUp", gButton["move_down"], 
			function ()
				triggerServerEvent ( "move", lp, lp, "move", "down" )
			end,
		false )
		gButton["move_higher"] = dgsCreateButton(100,80,20,20,"+",false,gTab[2])
		dgsSetAlpha(gButton["move_higher"],1)
		addEventHandler ( "onDgsMouseClickUp", gButton["move_higher"], 
			function ()
				triggerServerEvent ( "move", lp, lp, "move", "higher" )
			end,
		false )
		gButton["move_lower"] = dgsCreateButton(140,80,20,20,"-",false,gTab[2])
		dgsSetAlpha(gButton["move_higher"],1)
		addEventHandler ( "onDgsMouseClickUp", gButton["move_lower"], 
			function ()
				triggerServerEvent ( "move", lp, lp, "move", "lower" )
			end,
		false )
		
		
		gButton[8] = dgsCreateButton(5,97,81,39,"Markierung setzen",false,gTab[2])
		dgsSetAlpha(gButton[8],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[8], 
			function ()
				triggerServerEvent ( "executeAdminServerCMD", lp, "mark" )
			end,
		false )
		gButton[9] = dgsCreateButton(6,143,81,39,"Zur Markierung gehen",false,gTab[2])
		dgsSetAlpha(gButton[9],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[9], 
			function ()
				triggerServerEvent ( "executeAdminServerCMD", lp, "gotomark" )
			end,
		false )
		gButton[10] = dgsCreateButton(6,188,151,30,"Interior/Dimension setzen",false,gTab[2])
		dgsSetAlpha(gButton[10],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[10], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "intdim", player.." "..dgsGetText(gEdit[3]).." "..dgsGetText(gEdit[4]) )
			end,
		false )
		gEdit[3] = dgsCreateEdit(162,188,58,32,"",false,gTab[2])
		dgsSetAlpha(gEdit[3],1)
		gEdit[4] = dgsCreateEdit(226,188,58,32,"",false,gTab[2])
		dgsSetAlpha(gEdit[4],1)
		gLabel[6] = dgsCreateLabel(166,173,50,16,"Interior:",false,gTab[2])
		dgsSetAlpha(gLabel[6],1)
		dgsLabelSetColor(gLabel[6],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[6],"top")
		dgsLabelSetHorizontalAlign(gLabel[6],"left",false)
		dgsSetFont(gLabel[6],"default-bold-small")
		gLabel[7] = dgsCreateLabel(224,173,64,15,"Dimension:",false,gTab[2])
		dgsSetAlpha(gLabel[7],1)
		dgsLabelSetColor(gLabel[7],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[7],"top")
		dgsLabelSetHorizontalAlign(gLabel[7],"left",false)
		dgsSetFont(gLabel[7],"default-bold-small")
		gTab[3] = dgsCreateTab("Spieler",gTabPanel["adminMenue"])
		dgsSetAlpha(gTab[3],1)
		gButton[11] = dgsCreateButton(4,8,78,38,"Beobachten",false,gTab[3])
		dgsSetAlpha(gButton[11],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[11], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "spec", player )
			end,
		false )
		gButton[12] = dgsCreateButton(4,52,78,38,"Checken",false,gTab[3])
		dgsSetAlpha(gButton[12],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[12], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "check", player )
			end,
		false )
		gButton[13] = dgsCreateButton(5,96,78,38,"Freezen",false,gTab[3])
		dgsSetAlpha(gButton[13],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[13], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "freeze", player )
			end,
		false )
		gButton[14] = dgsCreateButton(6,141,78,38,"Slapen",false,gTab[3])
		dgsSetAlpha(gButton[14],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[14], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				if dgsCheckBoxGetSelected ( gCheck[2] ) then
					triggerServerEvent ( "executeAdminServerCMD", lp, "slap", player.." ja" )
				else
					triggerServerEvent ( "executeAdminServerCMD", lp, "slap", player )
				end
			end,
		false )
		gButton[15] = dgsCreateButton(7,186,78,38,"Skydiven",false,gTab[3])
		dgsSetAlpha(gButton[15],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[15], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "skydive", player )
			end,
		false )
		gButton[16] = dgsCreateButton(8,229,78,38,"Zum Leader machen",false,gTab[3])
		dgsSetAlpha(gButton[16],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[16], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "makeleader", player.." "..dgsGetText(gEdit[5]) )
			end,
		false )
		gButton[17] = dgsCreateButton(8,275,78,38,"Passwort aendern",false,gTab[3])
		dgsSetAlpha(gButton[17],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[17], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "pwchange", dgsGetText(gEdit[6]).." "..dgsGetText(gEdit[7]) )
			end,
		false )
		
		--[[gButton["offlinewarn"] = guiCreateButton(114,350,78,38,"Offlinewarn",false,gTab[3])
		addEventHandler ( "onDgsMouseClickUp", gButton["offlinewarn"], 
			function ()
				triggerServerEvent ( "executeAdminServerCMD", lp, "warn", dgsGetText(gEdit[6]).." "..dgsGetText(gMemo["offlineReason"]) )
			end,
		false )]]
		gButton["offlineban"] = dgsCreateButton(115,395,78,38,"Offlineban",false,gTab[3])
		addEventHandler ( "onDgsMouseClickUp", gButton["offlineban"], 
			function ()
				triggerServerEvent ( "executeAdminServerCMD", lp, "ban", dgsGetText(gEdit[6]).." "..dgsGetText(gMemo["offlineReason"]) )
			end,
		false )
		
		gMemo["offlineReason"] = dgsCreateMemo(199,369,106,45,"",false,gTab[3])
		gLabel["offlineReason"] = dgsCreateLabel(228,349,45,16,"Grund:",false,gTab[3])
		dgsLabelSetColor(gLabel["offlineReason"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["offlineReason"],"top")
		dgsLabelSetHorizontalAlign(gLabel["offlineReason"],"left",false)
		dgsSetFont(gLabel["offlineReason"],"default-bold-small")
		
		gCheck[2] = dgsCreateCheckBox(86,151,92,21,"Anzuenden?",false,false,gTab[3])
		dgsSetAlpha(gCheck[2],1)
		dgsSetFont(gCheck[2],"default-bold-small")
		gEdit[5] = dgsCreateEdit(149,234,31,31,"",false,gTab[3])
		dgsSetAlpha(gEdit[5],1)
		gLabel[8] = dgsCreateLabel(91,240,53,20,"Fraktion:",false,gTab[3])
		dgsSetAlpha(gLabel[8],1)
		dgsLabelSetColor(gLabel[8],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[8],"top")
		dgsLabelSetHorizontalAlign(gLabel[8],"left",false)
		dgsSetFont(gLabel[8],"default-bold-small")
		gEdit[6] = dgsCreateEdit(95,298,68,33,"",false,gTab[3])
		dgsSetAlpha(gEdit[6],1)
		gLabel[9] = dgsCreateLabel(107,276,45,16,"Spieler:",false,gTab[3])
		dgsSetAlpha(gLabel[9],1)
		dgsLabelSetColor(gLabel[9],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[9],"top")
		dgsLabelSetHorizontalAlign(gLabel[9],"left",false)
		dgsSetFont(gLabel[9],"default-bold-small")
		gEdit[7] = dgsCreateEdit(192,298,68,33,"",false,gTab[3])
		dgsSetAlpha(gEdit[7],1)
		gLabel[10] = dgsCreateLabel(180,276,96,17,"Neues Passwort:",false,gTab[3])
		dgsSetAlpha(gLabel[10],1)
		dgsLabelSetColor(gLabel[10],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[10],"top")
		dgsLabelSetHorizontalAlign(gLabel[10],"left",false)
		dgsSetFont(gLabel[10],"default-bold-small")
		gLabel[11] = dgsCreateLabel(12,352,94,138,"Fraktions-IDs:\n\n1 = SFPD\n2 = Mafia\n3 = Triaden\n4 = Terroristen\n5 = LTR\n6 = FBI\n7 = Los Aztecas\n8 = Army",false,gTab[3])
		dgsSetAlpha(gLabel[11],1)
		dgsLabelSetColor(gLabel[11],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[11],"top")
		dgsLabelSetHorizontalAlign(gLabel[11],"left",false)
		dgsSetFont(gLabel[11],"default-bold-small")
		gTab[4] = dgsCreateTab("Rang 3/4",gTabPanel["adminMenue"])
		dgsSetAlpha(gTab[4],1)
		gButton[18] = dgsCreateButton(6,21,84,46,"Query ausfuehren",false,gTab[4])
		dgsSetAlpha(gButton[18],1)
		dgsSetFont(gButton[18],"default-bold-small")
		addEventHandler ( "onDgsMouseClickUp", gButton[18], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "query", dgsGetText(gMemo[2]) )
			end,
		false )
		gMemo[2] = dgsCreateMemo(93,9,217,77,"",false,gTab[4])
		dgsSetAlpha(gMemo[2],1)
		gButton[19] = dgsCreateButton(5,104,87,48,"Restart",false,gTab[4])
		addEventHandler ( "onDgsMouseClickUp", gButton[19], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "gmx", dgsGetText(gEdit[8]) )
			end,
		false )
		dgsSetAlpha(gButton[19],1)
		dgsSetFont(gButton[19],"default-bold-small")
		gEdit[8] = dgsCreateEdit(120,109,59,37,"",false,gTab[4])
		dgsSetAlpha(gEdit[8],1)
		gLabel[12] = dgsCreateLabel(100,120,12,17,"in",false,gTab[4])
		dgsSetAlpha(gLabel[12],1)
		dgsLabelSetColor(gLabel[12],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[12],"top")
		dgsLabelSetHorizontalAlign(gLabel[12],"left",false)
		dgsSetFont(gLabel[12],"default-bold-small")
		gLabel[13] = dgsCreateLabel(185,120,53,19,"Minuten",false,gTab[4])
		dgsSetAlpha(gLabel[13],1)
		dgsLabelSetColor(gLabel[13],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[13],"top")
		dgsLabelSetHorizontalAlign(gLabel[13],"left",false)
		dgsSetFont(gLabel[13],"default-bold-small")
		gButton[20] = dgsCreateButton(6,169,87,48,"Haus anlegen",false,gTab[4])
		dgsSetAlpha(gButton[20],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[20], 
			function ()
				local preis = dgsGetText(gEdit[9])
				local playtime = dgsGetText(gEdit[11])
				local int = dgsGetText(gEdit[10])
				triggerServerEvent ( "executeAdminServerCMD", lp, "newhouse", preis.." "..playtime.." "..int )
			end,
		false )
		dgsSetFont(gButton[20],"default-bold-small")
		gEdit[9] = dgsCreateEdit(99,185,72,32,"",false,gTab[4])
		dgsSetAlpha(gEdit[9],1)
		gLabel[14] = dgsCreateLabel(103,165,60,18,"Preis:",false,gTab[4])
		dgsSetAlpha(gLabel[14],1)
		dgsLabelSetColor(gLabel[14],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[14],"top")
		dgsLabelSetHorizontalAlign(gLabel[14],"left",false)
		dgsSetFont(gLabel[14],"default-bold-small")
		gEdit[10] = dgsCreateEdit(176,185,33,32,"",false,gTab[4])
		dgsSetAlpha(gEdit[10],1)
		gLabel[15] = dgsCreateLabel(156,165,71,16,"Innenraum:",false,gTab[4])
		dgsSetAlpha(gLabel[15],1)
		dgsLabelSetColor(gLabel[15],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[15],"top")
		dgsLabelSetHorizontalAlign(gLabel[15],"left",false)
		dgsSetFont(gLabel[15],"default-bold-small")
		gEdit[11] = dgsCreateEdit(215,185,77,32,"",false,gTab[4])
		dgsSetAlpha(gEdit[11],1)
		gLabel[16] = dgsCreateLabel(227,153,59,31,"Mindest-\nSpielzeit:",false,gTab[4])
		dgsSetAlpha(gLabel[16],1)
		dgsLabelSetColor(gLabel[16],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[16],"top")
		dgsLabelSetHorizontalAlign(gLabel[16],"left",false)
		dgsSetFont(gLabel[16],"default-bold-small")
		gButton[21] = dgsCreateButton(8,232,87,48,"Tuningteil-\nID*",false,gTab[4])
		addEventHandler ( "onDgsMouseClickUp", gButton[21], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "tunecar", dgsGetText(gEdit[12]) )
			end,
		false )
		dgsSetAlpha(gButton[21],1)
		dgsSetFont(gButton[21],"default-bold-small")
		gEdit[12] = dgsCreateEdit(106,242,75,28,"",false,gTab[4])
		dgsSetAlpha(gEdit[12],1)
		gLabel[17] = dgsCreateLabel(7,491,61,17,"*s.h. Wiki",false,gTab[4])
		dgsSetAlpha(gLabel[17],1)
		dgsLabelSetColor(gLabel[17],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[17],"top")
		dgsLabelSetHorizontalAlign(gLabel[17],"left",false)
		dgsSetFont(gLabel[17],"default-bold-small")
		gButton[22] = dgsCreateButton(8,290,87,48,"Innenraum\nansehen",false,gTab[4])
		addEventHandler ( "onDgsMouseClickUp", gButton[22],  
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "iraum", dgsGetText(gEdit[13]) )
			end,
		false )
		dgsSetAlpha(gButton[22],1)
		dgsSetFont(gButton[22],"default-bold-small")
		gEdit[13] = dgsCreateEdit(105,296,75,28,"",false,gTab[4])
		dgsSetAlpha(gEdit[13],1)
		gTab[5] = dgsCreateTab("Chat",gTabPanel["adminMenue"])
		dgsSetAlpha(gTab[5],1)
		gMemo[3] = dgsCreateMemo(91,29,220,231,"",false,gTab[5])
		dgsSetAlpha(gMemo[3],1)
		gLabel[18] = dgsCreateLabel(180,13,34,16,"Text:",false,gTab[5])
		dgsSetAlpha(gLabel[18],1)
		dgsLabelSetColor(gLabel[18],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[18],"top")
		dgsLabelSetHorizontalAlign(gLabel[18],"left",false)
		dgsSetFont(gLabel[18],"default-bold-small")
		gButton[23] = dgsCreateButton(5,28,82,41,"O-Chat",false,gTab[5])
		dgsSetAlpha(gButton[23],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[23], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "o", dgsGetText(gMemo[3]) )
			end,
		false )
		gButton[24] = dgsCreateButton(4,75,82,41,"A-Chat",false,gTab[5])
		dgsSetAlpha(gButton[24],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[24], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "a", dgsGetText(gMemo[3]) )
			end,
		false )
		gButton[25] = dgsCreateButton(6,122,82,41,"Fluestern",false,gTab[5])
		dgsSetAlpha(gButton[25],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[25], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "w", dgsGetText(gEdit[14]).." "..dgsGetText(gMemo[3]) )
			end,
		false )
		gLabel[19] = dgsCreateLabel(7,166,43,20,"An ID:",false,gTab[5])
		dgsSetAlpha(gLabel[19],1)
		dgsLabelSetColor(gLabel[19],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[19],"top")
		dgsLabelSetHorizontalAlign(gLabel[19],"left",false)
		dgsSetFont(gLabel[19],"default-bold-small")
		gButton[26] = dgsCreateButton(5,216,82,41,"PM",false,gTab[5])
		dgsSetAlpha(gButton[26],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[26], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "pm", player.." "..dgsGetText(gMemo[3]) )
			end,
		false )
		gEdit[14] = dgsCreateEdit(14,185,66,27,"",false,gTab[5])
		dgsSetAlpha(gEdit[14],1)
		--[[gButton[27] = guiCreateButton(5,266,82,41,"Mute",false,gTab[5])
		dgsSetAlpha(gButton[27],1)
		addEventHandler ( "onDgsMouseClickUp", gButton[27], 
			function ()
				row, column = dgsGridListGetSelectedItem(gGrid["plistadmin"])
				player = dgsGridListGetItemText ( gGrid["plistadmin"], row, column )
				triggerServerEvent ( "executeAdminServerCMD", lp, "mute", player )
			end,
		false )]]
		gButton[28] = dgsCreateButton(8,316,82,41,"Chat leeren",false,gTab[5])
		addEventHandler ( "onDgsMouseClickUp", gButton[28], 
			function ()
				triggerServerEvent ( "executeAdminServerCMD", lp, "cleartext" )
			end,
		false )
		dgsSetAlpha(gButton[28],1)
	end
	dgsGridListClear ( gGrid["plistadmin"] )
	local players = getElementsByType("player")
	for i=1, #players do
		local row = dgsGridListAddRow ( gGrid["plistadmin"] )
		dgsGridListSetItemText ( gGrid["plistadmin"], row, gColumn["adminName"], getPlayerName ( players[i] ), false, false )
		dgsGridListSetItemText ( gGrid["plistadmin"], row, gColumn["adminPing"], "  "..tostring(getPlayerPing ( players[i] )), true, false )
	end
	
	-------------------------
	gLabel[20] = dgsCreateLabel(4,438,43,20,"Radius:",false,gTab[1])
	gEdit[15] = dgsCreateEdit(4,458,79,38,"",false,gTab[1])
	gButton[30] = dgsCreateButton(8,414,87,48,"Skin\nannehmen",false,gTab[4]) 
	gButton[29] = dgsCreateButton(8,352,87,48,"Wetter-\nändern*",false,gTab[4])
	gEdit[16] = dgsCreateEdit(105,420,75,28,"",false,gTab[4])
		
	addEventHandler ( "onDgsMouseClickUp", gButton[29], 
		function ()
			triggerServerEvent ( "executeAdminServerCMD", lp, "aweather" )
		end,
	false )
	
	addEventHandler ( "onDgsMouseClickUp", gButton[30], 
		function ()
			triggerServerEvent ( "executeAdminServerCMD", lp, "askin", tonumber(dgsGetText(gEdit[16])) )
		end,
	false )	
	-------------------------
	gButton[31] = dgsCreateButton( 6, 230, 151, 30, "zum Wagen teleportieren", false, gTab[2] )

	gEdit[17] = dgsCreateEdit( 162, 235, 58, 32, "", false, gTab[2] )
	dgsSetAlpha( gEdit[17], 1 )

	gEdit[18] = dgsCreateEdit( 226, 235, 58, 32, "", false, gTab[2] )
	dgsSetAlpha( gEdit[18], 1 )

	gLabel[21] = dgsCreateLabel( 166, 220, 50, 16, "Name:", false, gTab[2] )
	dgsSetAlpha( gLabel[21], 1 )
	dgsLabelSetColor( gLabel[21], 255, 255, 255 )
	dgsLabelSetVerticalAlign( gLabel[21], "top" )
	dgsLabelSetHorizontalAlign( gLabel[21], "left", false )
	dgsSetFont( gLabel[21], "default-bold-small" )

	gLabel[22] = dgsCreateLabel( 224, 220, 64, 15, "Slot:", false, gTab[2] )
	dgsSetAlpha( gLabel[22], 1 )
	dgsLabelSetColor( gLabel[22], 255, 255, 255 )
	dgsLabelSetVerticalAlign( gLabel[22], "top" )
	dgsLabelSetHorizontalAlign( gLabel[22], "left", false )
	dgsSetFont( gLabel[22], "default-bold-small" )
	
	addEventHandler ( "onDgsMouseClickUp", gButton[31], 
		function ()
		
			local gotocarname = dgsGetText(gEdit[17])
			local gotocarslot = dgsGetText(gEdit[18])
			
			if gotocarname ~= "" and gotocarslot ~= "" then
		
				triggerServerEvent ( "executeAdminServerCMD", lp, "gotocar", gotocarname.." "..gotocarslot )
			
			else
			
				outputChatBox ( "Beide Felder muessen ausgefuellt sein!", 255, 0, 0 )
			
			end
			
		end, false )
		
end