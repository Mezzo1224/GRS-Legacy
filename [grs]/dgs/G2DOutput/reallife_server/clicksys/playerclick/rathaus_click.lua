
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

function cancelRathausMenue ( button )

	dgsSetVisible(gWindow["rathausbg"], false)
	showCursor(false)
	triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
end

function beantragen ( button, state )

	if button == "left" then
		player = getLocalPlayer()
		cancelRathausMenue ( button )
		triggerServerEvent ( "LizenzKaufen", getLocalPlayer(), player, license )
	end
end

function ShowRathausMenue_func()

	_createCityhallGui()
end
addEvent ( "ShowRathausMenue", true)
addEventHandler ( "ShowRathausMenue", getLocalPlayer(),  ShowRathausMenue_func)

function _createCityhallGui()

	if gWindow["rathausbg"] then
		dgsSetVisible ( gWindow["rathausbg"], true )
	else
		gWindow["rathausbg"] = dgsCreateWindow(screenwidth/2-500/2,screenheight/2-251/2,500,251,"Stadthalle",false)
		dgsSetAlpha(gWindow["rathausbg"],1)
		gGrid["Licenses"] = dgsCreateGridList(0.0201,0.2709,0.4509,0.6773,true,gWindow["rathausbg"])
		dgsGridListSetSelectionMode(gGrid["Licenses"],0)
		gColumn["cityhallLicense"] = dgsGridListAddColumn(gGrid["Licenses"],"Schein",0.51)
		gColumn["cityhallPreis"] = dgsGridListAddColumn(gGrid["Licenses"],"Preis",0.25)
		gColumn["cityhallVorhanden"] = dgsGridListAddColumn(gGrid["Licenses"],"",0.04)
		dgsSetAlpha(gGrid["Licenses"],1)
		gLabel["cityhalInfotext1"] = dgsCreateLabel(0.0179,0.0797,0.9688,0.1753,"Herzlich wilkommen bei der Stadthalle!\nHier kannst du neue Scheine erwerben sowie dir einen neuen Job besorgen -\ndafuer schliesse dieses Fenster und begib dich zum Aktenkoffer neben an.",true,gWindow["rathausbg"])
		dgsSetAlpha(gLabel["cityhalInfotext1"],1)
		dgsLabelSetColor(gLabel["cityhalInfotext1"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["cityhalInfotext1"],"top")
		dgsLabelSetHorizontalAlign(gLabel["cityhalInfotext1"],"left",false)
		dgsSetFont(gLabel["cityhalInfotext1"],"default-bold-small")
		gLabel["cityhalInfotext2"] = dgsCreateLabel(0.6228,0.3347,0.1964,0.0677,"Fuehrerschein",true,gWindow["rathausbg"])
		dgsSetAlpha(gLabel["cityhalInfotext2"],1)
		dgsLabelSetColor(gLabel["cityhalInfotext2"],200,200,000)
		dgsLabelSetVerticalAlign(gLabel["cityhalInfotext2"],"top")
		dgsLabelSetHorizontalAlign(gLabel["cityhalInfotext2"],"left",false)
		dgsSetFont(gLabel["cityhalInfotext2"],"default-bold-small")
		gLabel["cityhalInfotext3"] = dgsCreateLabel(0.4888,0.4024,0.4866,0.2231,"Mit einem Fuehrerschein kannst du\nalle Autos fahren, jedoch ist eine\ntheoretische und praktische Pruefung\nPflicht.",true,gWindow["rathausbg"])
		dgsSetAlpha(gLabel["cityhalInfotext3"],1)
		dgsLabelSetColor(gLabel["cityhalInfotext3"],125,125,200)
		dgsLabelSetVerticalAlign(gLabel["cityhalInfotext3"],"top")
		dgsLabelSetHorizontalAlign(gLabel["cityhalInfotext3"],"left",false)
		dgsSetFont(gLabel["cityhalInfotext3"],"default-bold-small")
		gButton["beantragen"] = dgsCreateButton(0.5022,0.7729,0.2143,0.1633,"Beantragen",true,gWindow["rathausbg"])
		dgsSetAlpha(gButton["beantragen"],1)
		gButton["schliessen"] = dgsCreateButton(0.75,0.7729,0.2143,0.1633,"Schliessen",true,gWindow["rathausbg"])
		dgsSetAlpha(gButton["schliessen"],1)
		
		addEventHandler("onDgsMouseClickUp", gButton["schliessen"], cancelRathausMenue, true)
		addEventHandler("onDgsMouseClickUp", gButton["beantragen"], beantragen, true)
		
		refreshCityhallTexts()
	end
	refreshLicenses()
end

function rathausClick ()
	if gWindow["rathausbg"] then
		local rowindex, columnindex = dgsGridListGetSelectedItem ( gGrid["Licenses"] )
		local selectedText = dgsGridListGetItemText ( gGrid["Licenses"], rowindex, gColumn["cityhallLicense"] )
		if selectedText == "Fuehrerschein" then
			license = "car"
			refreshCityhallTexts()
		elseif selectedText == "Flugschein B" then
			license = "planeb"
			refreshCityhallTexts()
		elseif selectedText == "Flugschein A" then
			license = "planea"
			refreshCityhallTexts()
		elseif selectedText == "Helikopterschein" then
			license = "heli"
			refreshCityhallTexts()
		elseif selectedText == "Motorbootschein" then
			license = "motorboot"
			refreshCityhallTexts()
		elseif selectedText == "Segelschein" then
			license = "raft"
			refreshCityhallTexts()
		elseif selectedText == "LKW-Fuehrerschein" then
			license = "lkw"
			refreshCityhallTexts()
		elseif selectedText == "Personalausweis" then
			license = "perso"
			refreshCityhallTexts()
		elseif selectedText == "Angelschein" then
			license = "fishing"
			refreshCityhallTexts()
		elseif selectedText == "Motorradschein" then
			license = "bike"
			refreshCityhallTexts()
		elseif selectedText == "Waffenschein" then
			license = "wschein"
			refreshCityhallTexts()
		elseif selectedText == "Max. Fahrzeuge" then
			license = "maxveh"
			refreshCityhallTexts()
		end
	end
end
addEventHandler ( "onDgsMouseClickUp", getRootElement(), rathausClick )

function refreshLicenses()

	dgsGridListClear ( gGrid["Licenses"] )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Fuehrerschein", false, false )
	if getElementData ( player, "playingtime" ) >= 60 * 50 then
		dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "4.750 $", false, false )
	elseif getElementData ( player, "playingtime" ) >= 60 * 25 then
		dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "1.750 $", false, false )
	else
		dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "750 $", false, false )
	end
	if vioClientGetElementData ( "carlicense" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Motorradschein", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "450 $", false, false )
	if vioClientGetElementData ( "bikelicense" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "LKW-Fuehrerschein", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "450 $", false, false )
	if vioClientGetElementData ( "lkwlicense" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Flugschein A", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "15.000 $", false, false )
	if vioClientGetElementData ( "planelicensea" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Flugschein B", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "34.950 $", false, false )
	if vioClientGetElementData ( "planelicenseb" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Helikopterschein", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "20.000 $", false, false )
	if vioClientGetElementData ( "helilicense" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Motorbootschein", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "400 $", false, false )
	if vioClientGetElementData ( "motorbootlicense" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Segelschein", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "350 $", false, false )
	if vioClientGetElementData ( "segellicense" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Waffenschein", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "4.750 $", false, false )
	if vioClientGetElementData ( "gunlicense" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Angelschein", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "79 $", false, false )
	if vioClientGetElementData ( "fishinglicense" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Personalausweis", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], "40 $", false, false )
	if vioClientGetElementData ( "perso" ) == 1 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )
	
	local row = dgsGridListAddRow ( gGrid["Licenses"] )
	local thepreis = convertNumber(fahrzeugslotprice[vioClientGetElementData( "maxcars")])
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallLicense"], "Max. Fahrzeuge", false, false )
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallPreis"], thepreis.." $", false, false )
	if vioClientGetElementData ( "maxcars" ) >= 15 then fix = "[x]" else fix = "[_]" end
	dgsGridListSetItemText( gGrid["Licenses"], row, gColumn["cityhallVorhanden"], fix, false, false )

	license = "car"
	refreshCityhallTexts()
end

function refreshCityhallTexts()

	--[[
		license = "wschein"
		
		license = "bike"
		license = "fishing"
		license = "perso"
		license = "lkw"
		license = "raft"
		license = "motorboot"
		license = "planeb"
		license = "car"
		license = "heli"
		license = "planea"
		license = "maxveh"
	]]
	if license == "car" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Fuehrerschein" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Mit einem Fuehrerschein kannst du\nalle Autos fahren, jedoch ist eine\ntheoretische und praktische Pruefung\nPflicht." )
	elseif license == "planeb" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Flugschein B" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Mit einem Flugschein B kannst du\nalle Flugzeuge fliegen, egal wie goss.\nWichtig: Flugschein Klasse A wird benoetigt!" )
	elseif license == "planea" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Flugschein A" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Mit einem Flugschein A kannst du\nalle kleineren Flugzeuge fliegen." )
	elseif license == "heli" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Helikopterschein" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Mit einem Flugschein fuer Helikopter\nkannst du alle arten von\nHelikoptern fliegen." )
	elseif license == "motorboot" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Motorbootschein" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Mit einem Motorbootschein kannst du\nalle arten von Booten mit\nMotor fahren." )
	elseif license == "raft" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Segelschein" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Mit einem Segelschein kannst du\nauch Schiffe mit Segel fahren.\nWichtig: Motorbootschein wird benoetigt!" )
	elseif license == "lkw" then
		dgsSetText ( gLabel["cityhalInfotext2"], "LKW-Fuehrerschein" )
		dgsSetText ( gLabel["cityhalInfotext3"], "	Mit einem LKW-Fuehrerschein\nkannst du alle groesseren und\nkleineren Trucks fahren.\nWichtig: Fuehrerschein wird benoetigt!" )
	elseif license == "perso" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Personalausweis" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Ohne einen Personalausweiss kannst du\nbestimmte Locations nicht betreten." )
	elseif license == "fishing" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Angelschein" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Ohne Angelschein darfst du nicht fischen,\naussderm brauchst du ihn, wenn du\nals Fischer arbeiten willst." )
	elseif license == "bike" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Motorradschein" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Damit du mit einem Motorrad fahren darfst\nbenoetigst du diesen Schein." )
	elseif license == "wschein" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Waffenschein" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Ohne Waffenschein darfst du keine\nWaffen legal erwerben." )
	elseif license == "maxveh" then
		dgsSetText ( gLabel["cityhalInfotext2"], "Max. Fahrzeuge" )
		dgsSetText ( gLabel["cityhalInfotext3"], "Die Stadt erlaubt dir nur eine\ngewissen Anzahl von Fahrzeugen.\nDu kannst die Anzahl jedoch\nhier erhöhen." )
	end
end


function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1.%2")    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end