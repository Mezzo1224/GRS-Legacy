
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

function showSettingsMenue ()

	hideall ()
	if not isElement ( gWindow["settings"] ) then
		gWindow["settings"] = dgsCreateWindow(screenwidth/2-285/2,120,285,456+56*1,"Optionen",false)
		dgsSetAlpha(gWindow["settings"],1)
		
		gButton["bonusMenue"] = dgsCreateButton(9,24,101,42,"Bonuspunkte",false,gWindow["settings"])
		dgsSetAlpha(gButton["bonusMenue"],1)
		dgsSetFont(gButton["bonusMenue"],"default-bold-small")
		gButton["loginvideo"] = dgsCreateButton(9,80,101,42,"Login-Video",false,gWindow["settings"])
		dgsSetAlpha(gButton["loginvideo"],1)
		dgsSetFont(gButton["loginvideo"],"default-bold-small")
		gButton["firstPerson"] = dgsCreateButton(9,136,101,42,"First Person",false,gWindow["settings"])
		dgsSetAlpha(gButton["firstPerson"],1)
		dgsSetFont(gButton["firstPerson"],"default-bold-small")
		gButton["socialState"] = dgsCreateButton(9,192,101,42,"Sozialer Status",false,gWindow["settings"])
		dgsSetAlpha(gButton["socialState"],1)
		dgsSetFont(gButton["socialState"],"default-bold-small")
		gButton["spawnPoint"] = dgsCreateButton(9,248,101,42,"Spawnpunkt",false,gWindow["settings"])
		dgsSetAlpha(gButton["spawnPoint"],1)
		dgsSetFont(gButton["spawnPoint"],"default-bold-small")
		gButton["radioSettings"] = dgsCreateButton(9,304,101,42,"Radio",false,gWindow["settings"])
		dgsSetAlpha(gButton["radioSettings"],1)
		-- NEW --
		gButton["stuntCam"] = dgsCreateButton(9,304+56*1,101,42,"Stuntcam",false,gWindow["settings"])
		dgsSetAlpha(gButton["stuntCam"],1)
		-- NEW --
		dgsSetFont(gButton["radioSettings"],"default-bold-small")
		gButton["changePW"] = dgsCreateButton(9,360+56*1,66,42,"Passwort\nändern",false,gWindow["settings"])
		dgsSetAlpha(gButton["changePW"],1)
		dgsSetFont(gButton["changePW"],"default-bold-small")
		gButton["closeSettings"] = dgsCreateButton(210,360+56*1,66,42,"Schließen",false,gWindow["settings"])
		dgsSetAlpha(gButton["closeSettings"],1)
		dgsSetFont(gButton["closeSettings"],"default-bold-small")
		
		addEventHandler ( "onDgsMouseClickUp", gButton["loginvideo"],
			function ()
				if youtubevideoon then
					youtubevideoon = false
					if fileExists ( "einloggvideo.txt" ) then
						fileDelete ( "einloggvideo.txt" )
					end
					local file = fileCreate ( "einloggvideo.txt" )
					fileWrite ( file, "off" )
					fileClose ( file )
					infobox ( "Youtube-Einloggvideo\ndeaktiviert", 4000, 250, 0, 0 )
				else
					youtubevideoon = true
					if fileExists ( "einloggvideo.txt" ) then
						fileDelete ( "einloggvideo.txt" )
					end
					local file = fileCreate ( "einloggvideo.txt" )
					fileWrite ( file, "on" )
					fileClose ( file )
					infobox ( "Youtube-Einloggvideo\naktiviert", 4000, 0, 210, 0 )
				end
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["bonusMenue"],
			function ()
				dgsSetVisible( gWindow["settings"], false )
				_createBonusmenue_func()
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["spawnPoint"],
			function ()
				dgsSetVisible( gWindow["settings"], false )
				showSpawnSelection ()
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["socialState"],
			function ()
				dgsSetVisible( gWindow["settings"], false )
				showSocialRankWindow ()
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["firstPerson"],
			function ()
				executeCommandHandler ( "ego" )
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["radioSettings"],
			function ()
				destroyElement ( gWindow["settings"] )
				showCustomRadioGUI ()
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["closeSettings"],
			function ()
				dgsSetVisible( gWindow["settings"], false )
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["stuntCam"],
			function ()
				stuntCameraActive = not stuntCameraActive
				if stuntCameraActive then
					outputChatBox ( "Stuntkamera aktiviert!", 0, 200, 0 )
					setClientData ( "stuntcam", "active" )
				else
					outputChatBox ( "Stuntkamera deaktiviert!", 200, 0, 0 )
					setClientData ( "stuntcam", "inactive" )
				end
			end,
		false )
		
		gLabel[1] = dgsCreateLabel(117,22,161,51,"Hier kannst du Bonuspunkte\nfür Verbesserungen aus-\ngeben",false,gWindow["settings"])
		dgsSetAlpha(gLabel[1],1)
		dgsLabelSetColor(gLabel[1],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[1],"top")
		dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
		dgsSetFont(gLabel[1],"default-bold-small")
		gLabel[2] = dgsCreateLabel(117,87,162,53,"Hier kannst du das Einlogg\n-Video (de-)aktivieren.",false,gWindow["settings"])
		dgsSetAlpha(gLabel[2],1)
		dgsLabelSetColor(gLabel[2],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[2],"top")
		dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
		dgsSetFont(gLabel[2],"default-bold-small")
		gLabel[3] = dgsCreateLabel(117,134,162,53,"Hier kannst du die Ego-Sicht\nein- und aus schalten\n( Schnellbefehl: /ego )",false,gWindow["settings"])
		dgsSetAlpha(gLabel[3],1)
		dgsLabelSetColor(gLabel[3],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[3],"top")
		dgsLabelSetHorizontalAlign(gLabel[3],"left",false)
		dgsSetFont(gLabel[3],"default-bold-small")
		gLabel[4] = dgsCreateLabel(117,201,162,53,"Hier kannst du deinen\nsozialen Status verwalten.",false,gWindow["settings"])
		dgsSetAlpha(gLabel[4],1)
		dgsLabelSetColor(gLabel[4],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[4],"top")
		dgsLabelSetHorizontalAlign(gLabel[4],"left",false)
		dgsSetFont(gLabel[4],"default-bold-small")
		gLabel[5] = dgsCreateLabel(117,256,162,53,"Hier kannst du deinen Start-\npunkt auswählen.",false,gWindow["settings"])
		dgsSetAlpha(gLabel[5],1)
		dgsLabelSetColor(gLabel[5],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[5],"top")
		dgsLabelSetHorizontalAlign(gLabel[5],"left",false)
		dgsSetFont(gLabel[5],"default-bold-small")
		gLabel[6] = dgsCreateLabel(117,302,162,44,"Hier kannst du deine Radio-\nsender verwalten und neue\nhinzufügen.",false,gWindow["settings"])
		dgsSetAlpha(gLabel[6],1)
		dgsLabelSetColor(gLabel[6],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[6],"top")
		dgsLabelSetHorizontalAlign(gLabel[6],"left",false)
		dgsSetFont(gLabel[6],"default-bold-small")
		gLabel[10] = dgsCreateLabel(117,302+56,162,44,"Hier kannst du die Stunt-\nkamera ein- bzw. aus\nschalten.",false,gWindow["settings"])
		dgsSetAlpha(gLabel[10],1)
		dgsLabelSetColor(gLabel[10],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[10],"top")
		dgsLabelSetHorizontalAlign(gLabel[10],"left",false)
		dgsSetFont(gLabel[10],"default-bold-small")
		gLabel[7] = dgsCreateLabel(101,358+56,90,17,"Altes Passwort:",false,gWindow["settings"])
		dgsSetAlpha(gLabel[7],1)
		dgsLabelSetColor(gLabel[7],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[7],"top")
		dgsLabelSetHorizontalAlign(gLabel[7],"left",false)
		dgsSetFont(gLabel[7],"default-bold-small")
		gLabel[8] = dgsCreateLabel(28,404+56,96,15,"Neues Passwort:",false,gWindow["settings"])
		dgsSetAlpha(gLabel[8],1)
		dgsLabelSetColor(gLabel[8],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[8],"top")
		dgsLabelSetHorizontalAlign(gLabel[8],"left",false)
		dgsSetFont(gLabel[8],"default-bold-small")
		gLabel[9] = dgsCreateLabel(163,404+56,90,15,"Neues Passwort:",false,gWindow["settings"])
		dgsSetAlpha(gLabel[9],1)
		dgsLabelSetColor(gLabel[9],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[9],"top")
		dgsLabelSetHorizontalAlign(gLabel[9],"left",false)
		dgsSetFont(gLabel[9],"default-bold-small")
		
		gEdit[1] = dgsCreateEdit(89,375+56,110,27,"",false,gWindow["settings"])
		dgsSetAlpha(gEdit[1],1)
		gEdit[2] = dgsCreateEdit(19,420+56,110,27,"",false,gWindow["settings"])
		dgsSetAlpha(gEdit[2],1)
		gEdit[3] = dgsCreateEdit(154,420+56,110,27,"",false,gWindow["settings"])
		dgsSetAlpha(gEdit[3],1)
	else
		dgsSetVisible ( gWindow["settings"], true )
	end
end
--[[
function BonusMenueBtn ()

	triggerEvent ( "_createBonusmenue", getLocalPlayer() )
	dgsSetVisible ( gWindow["options"], false )
end

function prevOptionsMenueBtn ()

	if channel ~= 1 then
		channel = channel - 1
		if channel == -1 or channel == 0 or channel == 1 then
			dgsSetText ( gLabel["channel"], "Playback FM" )
		elseif channel == 2 then
			dgsSetText ( gLabel["channel"], "K-Rose" )
		elseif channel == 3 then
			dgsSetText ( gLabel["channel"], "K-DST" )
		elseif channel == 4 then
			dgsSetText ( gLabel["channel"], "Bounce FM" )
		elseif channel == 5 then
			dgsSetText ( gLabel["channel"], "SF-UR" )
		elseif channel == 6 then
			dgsSetText ( gLabel["channel"], "Radio Los Santos" )
		elseif channel == 7 then
			dgsSetText ( gLabel["channel"], "Radio X" )
		elseif channel == 8 then
			dgsSetText ( gLabel["channel"], "CSR 103.9" )
		elseif channel == 9 then
			dgsSetText ( gLabel["channel"], "K-Jah West" )
		elseif channel == 10 then
			dgsSetText ( gLabel["channel"], "Master Sounds FM" )
		elseif channel == 11 then
			dgsSetText ( gLabel["channel"], "WCTR" )
		elseif channel == 12 then
			dgsSetText ( gLabel["channel"], "User Track Player" )
		elseif channel == 13 then
			dgsSetText ( gLabel["channel"], "Radio aus" )
		end
	else
		channel = 13
		dgsSetText ( gLabel["channel"], "Radio aus" )
	end
	triggerEvent ( "radiochange", getLocalPlayer(), getLocalPlayer(), channel )
end

function nextOptionsMenueBtn ()

	if channel ~= 13 then
		channel = channel + 1
		if channel == 0 or channel == 1 then
			dgsSetText ( gLabel["channel"], "Playback FM" )
		elseif channel == 2 then
			dgsSetText ( gLabel["channel"], "K-Rose" )
		elseif channel == 3 then
			dgsSetText ( gLabel["channel"], "K-DST" )
		elseif channel == 4 then
			dgsSetText ( gLabel["channel"], "Bounce FM" )
		elseif channel == 5 then
			dgsSetText ( gLabel["channel"], "SF-UR" )
		elseif channel == 6 then
			dgsSetText ( gLabel["channel"], "Radio Los Santos" )
		elseif channel == 7 then
			dgsSetText ( gLabel["channel"], "Radio X" )
		elseif channel == 8 then
			dgsSetText ( gLabel["channel"], "CSR 103.9" )
		elseif channel == 9 then
			dgsSetText ( gLabel["channel"], "K-Jah West" )
		elseif channel == 10 then
			dgsSetText ( gLabel["channel"], "Master Sounds FM" )
		elseif channel == 11 then
			dgsSetText ( gLabel["channel"], "WCTR" )
		elseif channel == 12 then
			dgsSetText ( gLabel["channel"], "User Track Player" )
		elseif channel == 13 then
			dgsSetText ( gLabel["channel"], "Radio aus" )
		end
	else
		channel = 1
		dgsSetText ( gLabel["channel"], "Playback FM" )
	end
	triggerEvent ( "radiochange", getLocalPlayer(), getLocalPlayer(), channel )
end

function HelpMenueBtn ()

	dgsSetVisible( gWindows["selfclick"], false )
	dgsSetVisible( bonusmenue, false )
	dgsSetVisible ( gWindow["options"], false )
	triggerEvent ( "ShowHelpmenueGui", getLocalPlayer() )
end

function _createOptionmenue_func()

	if gWindow["options"] then
		dgsSetVisible ( gWindow["options"], true )
	else
		if vioClientGetElementData ( "favchannel" ) == nil then channel = 6 else channel = tonumber ( vioClientGetElementData ( "favchannel" ) ) end
		
		gWindow["options"] = dgsCreateWindow(screenwidth/2-335/2,120,335,420+60,"Optionen",false)
		dgsSetAlpha(gWindow["options"],1)
		dgsWindowSetMovable ( gWindow["options"], false )
		dgsWindowSetSizable ( gWindow["options"], false )
			
		gButton["bonusmenue"] = dgsCreateButton(275*0.0327,150*0.2095,275*0.3455,150*0.2365,"Bonusmenue",false,gWindow["options"])
		dgsSetAlpha(gButton["bonusmenue"],1)
		gButton["<"] = dgsCreateButton(209,77,18,19,"<",false,gWindow["options"])
		dgsSetAlpha(gButton["<"],1)
		gButton[">"] = dgsCreateButton(231,77,18,19,">",false,gWindow["options"])
		dgsSetAlpha(gButton[">"],1)
		gButton["helpmenue"] = dgsCreateButton(9,104,95,34,"Hilfemenue",false,gWindow["options"])
		dgsSetAlpha(gButton["helpmenue"],1)
		gButton["egoSight"] = dgsCreateButton(9,164,95,34,"First-Person-\nSicht",false,gWindow["options"])
		dgsSetAlpha(gButton["egoSight"],1)
		gButton["reddot"] = dgsCreateButton(9,224,95,34,"Rotpunktvisir",false,gWindow["options"])
		dgsSetAlpha(gButton["reddot"],1)
		gButton["socialState"] = dgsCreateButton(9,284,95,34,"Sozialer\nStatus",false,gWindow["options"])
		dgsSetAlpha(gButton["socialState"],1)
		gButton["spawnSelection"] = dgsCreateButton(9,344,95,34,"Startpunkt",false,gWindow["options"])
		dgsSetAlpha(gButton["spawnSelection"],1)
		gButton["changePW"] = dgsCreateButton(9,344+60,95,34,"Passwort\naendern",false,gWindow["options"])
		dgsSetAlpha(gButton["changePW"],1)
		
		addEventHandler("onDgsMouseClickUp", gButton["bonusmenue"], BonusMenueBtn, false)
		addEventHandler("onDgsMouseClickUp", gButton["<"], prevOptionsMenueBtn, false)
		addEventHandler("onDgsMouseClickUp", gButton[">"], nextOptionsMenueBtn, false)
		addEventHandler("onDgsMouseClickUp", gButton["helpmenue"], HelpMenueBtn, false)
		addEventHandler("onDgsMouseClickUp", gButton["egoSight"], 
		function ( btn, state )
			if state == "up" then
				executeCommandHandler ( "ego" )
			end
		end, false)
		addEventHandler("onDgsMouseClickUp", gButton["reddot"], 
		function ( btn, state )
			if state == "up" then
				executeCommandHandler ( "reddot" )
			end
		end, false)
		addEventHandler("onDgsMouseClickUp", gButton["socialState"], 
		function ( btn, state )
			if state == "up" then
				dgsSetVisible ( gWindow["options"], false )
				showSocialRankWindow ()
			end
		end, false)
		addEventHandler("onDgsMouseClickUp", gButton["spawnSelection"], 
		function ( btn, state )
			if state == "up" then
				dgsSetVisible ( gWindow["options"], false )
				showSpawnSelection ()
			end
		end, false)
		addEventHandler("onDgsMouseClickUp", gButton["changePW"], 
		function ( btn, state )
			if state == "up" then
				triggerServerEvent ( "newPW", lp, dgsGetText ( gEdit["newPW1"] ), dgsGetText ( gEdit["newPW2"] ) )
			end
		end, false)
		
		gLabel["favsender"] = dgsCreateLabel(275*0.0364,150*0.5135,275*0.3491,150*0.1419,"Lieblingssender:",false,gWindow["options"])
		dgsSetFont(gLabel["favsender"],"default-bold-small")
		dgsSetAlpha(gLabel["favsender"],1)
		dgsLabelSetColor(gLabel["favsender"],000,000,200)
		dgsLabelSetVerticalAlign(gLabel["favsender"],"top")
		dgsLabelSetHorizontalAlign(gLabel["favsender"],"left",false)
		gLabel["channel"] = dgsCreateLabel(275*0.4,150*0.5135,275*0.3491,150*0.1284,"",false,gWindow["options"])
		dgsSetFont(gLabel["channel"],"default-bold-small")
		if channel == 0 or channel == 1 then
			dgsSetText ( gLabel["channel"], "Playback FM" )
		elseif channel == 2 then
			dgsSetText ( gLabel["channel"], "K-Rose" )
		elseif channel == 3 then
			dgsSetText ( gLabel["channel"], "K-DST" )
		elseif channel == 4 then
			dgsSetText ( gLabel["channel"], "Bounce FM" )
		elseif channel == 5 then
			dgsSetText ( gLabel["channel"], "SF-UR" )
		elseif channel == 6 then
			dgsSetText ( gLabel["channel"], "Radio Los Santos" )
		elseif channel == 7 then
			dgsSetText ( gLabel["channel"], "Radio X" )
		elseif channel == 8 then
			dgsSetText ( gLabel["channel"], "CSR 103.9" )
		elseif channel == 9 then
			dgsSetText ( gLabel["channel"], "K-Jah West" )
		elseif channel == 10 then
			dgsSetText ( gLabel["channel"], "Master Sounds" )
		elseif channel == 11 then
			dgsSetText ( gLabel["channel"], "WCTR" )
		elseif channel == 12 then
			dgsSetText ( gLabel["channel"], "User Track Player" )
		elseif channel == 13 then
			dgsSetText ( gLabel["channel"], "Radio aus" )
		end
		dgsSetAlpha(gLabel["channel"],1)
		dgsLabelSetColor(gLabel["channel"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["channel"],"top")
		dgsLabelSetHorizontalAlign(gLabel["channel"],"left",false)
		
		gLabel["bonuspoints"] = dgsCreateLabel(275*0.4036,150*0.1959,275*0.5709,150*0.2365,"Hier kannst du Bonuspunkte\nfuer besonderes ausgeben",false,gWindow["options"])
		dgsSetFont(gLabel["bonuspoints"],"default-bold-small")
		dgsSetAlpha(gLabel["bonuspoints"],1)
		dgsLabelSetColor(gLabel["bonuspoints"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["bonuspoints"],"top")
		dgsLabelSetHorizontalAlign(gLabel["bonuspoints"],"left",false)
		
		gLabel["helpmenue"] = dgsCreateLabel(275*0.3964,150*0.69,275*0.5709,150*0.2297,"Hier kannst du Hilfe erhalten,\nwenn du Probleme hast.",false,gWindow["options"])
		dgsSetFont(gLabel["helpmenue"],"default-bold-small")
		dgsSetAlpha(gLabel["helpmenue"],1)
		dgsLabelSetColor(gLabel["helpmenue"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["helpmenue"],"top")
		dgsLabelSetHorizontalAlign(gLabel["helpmenue"],"left",false)
		
		gLabel["egoInfo"] = dgsCreateLabel(275*0.3964,164,275*0.5709,150*0.2297,"Eine komplett neue Sicht -\nbesonders beim Fahren!",false,gWindow["options"])
		dgsSetFont(gLabel["egoInfo"],"default-bold-small")
		dgsSetAlpha(gLabel["egoInfo"],1)
		dgsLabelSetColor(gLabel["egoInfo"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["egoInfo"],"top")
		dgsLabelSetHorizontalAlign(gLabel["egoInfo"],"left",false)
		
		gLabel["reddotInfo"] = dgsCreateLabel(275*0.3964,224,275*0.5709,150*0.2297+20,"Alle deine Waffen werden\nmit einem Rotpunkt-Visir\naugestattet!",false,gWindow["options"])
		dgsSetFont(gLabel["reddotInfo"],"default-bold-small")
		dgsSetAlpha(gLabel["reddotInfo"],1)
		dgsLabelSetColor(gLabel["reddotInfo"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["reddotInfo"],"top")
		dgsLabelSetHorizontalAlign(gLabel["reddotInfo"],"left",false)
		
		gLabel["socialInfo"] = dgsCreateLabel(275*0.3964,284,275*0.5709,150*0.2297+20,"Hier kannst du deinen\nsozialen Status auswaehlen!",false,gWindow["options"])
		dgsSetFont(gLabel["socialInfo"],"default-bold-small")
		dgsSetAlpha(gLabel["socialInfo"],1)
		dgsLabelSetColor(gLabel["socialInfo"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["socialInfo"],"top")
		dgsLabelSetHorizontalAlign(gLabel["socialInfo"],"left",false)
		
		gLabel["spawnInfo"] = dgsCreateLabel(275*0.3964,344,275*0.5709,150*0.2297+20,"Hier kannst du den Punkt veraendern,\nan dem du startest.",false,gWindow["options"])
		dgsSetFont(gLabel["spawnInfo"],"default-bold-small")
		dgsSetAlpha(gLabel["spawnInfo"],1)
		dgsLabelSetColor(gLabel["spawnInfo"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["spawnInfo"],"top")
		dgsLabelSetHorizontalAlign(gLabel["spawnInfo"],"left",false)
		
		gLabel["passwordInfo"] = dgsCreateLabel(275*0.3964,344 + 60,275*0.5709,150*0.2297+20,"Hier kannst du\ndein Passwort aendern!",false,gWindow["options"])
		dgsSetFont(gLabel["passwordInfo"],"default-bold-small")
		dgsSetAlpha(gLabel["passwordInfo"],1)
		dgsLabelSetColor(gLabel["passwordInfo"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["passwordInfo"],"top")
		dgsLabelSetHorizontalAlign(gLabel["passwordInfo"],"left",false)
		
		gEdit["newPW1"] = dgsCreateEdit ( 109, 404+37, 80, 30, "", false, gWindow["options"] )
		gEdit["newPW2"] = dgsCreateEdit ( 109+100, 404+37, 80, 30, "", false, gWindow["options"] )
	end
end
addEvent ( "_createOptionmenue", true )
addEventHandler ( "_createOptionmenue", getRootElement(), _createOptionmenue_func )]]