
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

----------------------------------------------------
----------------------------------------------------
------ Copyright (c) 2013 by [vio]Lars-Marcel ------
----------------------------------------------------
----------------------------------------------------

function michelleSelect()
	showCursor(true)
	setElementClicked(true)
	michelles_Window = {}
	michelles_Button = {}
	michelles_Label = {}

	michelles_Window[1] = dgsCreateWindow(392,202,222,204,"Michelle's",false)
	michelles_Label[1] = dgsCreateLabel(10,27,248,42,"Herzlich Willkommen bei Michelle's!\n\nWas koennen wir fuer dich tun?",false,michelles_Window[1])
	dgsSetFont(michelles_Label[1],"default-bold-small")
	michelles_Button[1] = dgsCreateButton(38,119,137,30,"Speziallack",false,michelles_Window[1])
	dgsSetFont(michelles_Button[1],"default-bold-small")
	michelles_Button[2] = dgsCreateButton(38,155,137,30,"Nichts",false,michelles_Window[1])
	dgsSetFont(michelles_Button[2],"default-bold-small")


	addEventHandler("onDgsMouseClickUp", michelles_Button[1], function()
		dgsSetVisible(michelles_Window[1], false)
		showSpezialLack()
	end)
	addEventHandler("onDgsMouseClickUp", michelles_Button[2], function()
		dgsSetVisible(michelles_Window[1], false)
		showCursor(false)
		triggerServerEvent("closeMichelles", getLocalPlayer())
	end)
end
addEvent( "showMichelles", true )
addEventHandler( "showMichelles", getRootElement(), michelleSelect )

SpezialLack_Window = {}
SpezialLack_Button = {}
SpezialLack_Label = {}
SpezialLack_Scrollbar = {}

function showSpezialLack()
	--showCursor(true)
	
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if getElementData(veh, "spezcolor") == "" then
		kosten = "2.500"
	else
		kosten = "1.250"
	end
	
	SpezialLack_Window[1] = dgsCreateWindow(7,201,328,337,"Michelle's Speziallack",false)
	SpezialLack_Label[1] = dgsCreateLabel(11,26,308,45,"Willkommen bei Michelle's Speziallack Tuning-Garage!\nHier kannst du dir dein Fahrzeug in knalligen Farben\numlackieren. Mische dir dazu eine Farbe zusammen.",false,SpezialLack_Window[1])
	dgsSetFont(SpezialLack_Label[1],"default-bold-small")
	SpezialLack_Label[2] = dgsCreateLabel(13,79,50,16,"Farbe 1:",false,SpezialLack_Window[1])
	dgsSetFont(SpezialLack_Label[2],"default-bold-small")
	SpezialLack_Scrollbar[1] = dgsCreateScrollBar(52,95,265,21,true,false,SpezialLack_Window[1])
	SpezialLack_Label[3] = dgsCreateLabel(12,97,23,13,"Rot:",false,SpezialLack_Window[1])
	dgsLabelSetColor(SpezialLack_Label[3],255,0,0)
	dgsSetFont(SpezialLack_Label[3],"default-bold-small")
	SpezialLack_Scrollbar[2] = dgsCreateScrollBar(52,120,265,21,true,false,SpezialLack_Window[1])
	SpezialLack_Label[4] = dgsCreateLabel(12,121,38,14,"Gruen:",false,SpezialLack_Window[1])
	dgsLabelSetColor(SpezialLack_Label[4],0,255,0)
	dgsSetFont(SpezialLack_Label[4],"default-bold-small")
	SpezialLack_Scrollbar[3] = dgsCreateScrollBar(52,146,265,21,true,false,SpezialLack_Window[1])
	SpezialLack_Label[5] = dgsCreateLabel(12,147,38,14,"Blau:",false,SpezialLack_Window[1])
	dgsLabelSetColor(SpezialLack_Label[5],0,0,255)
	dgsSetFont(SpezialLack_Label[5],"default-bold-small")
	SpezialLack_Label[6] = dgsCreateLabel(9,172,278,15,"Farbe 2: (Motorraeder u. Fahrzeuge mit Paintjob)",false,SpezialLack_Window[1])
	dgsSetFont(SpezialLack_Label[6],"default-bold-small")
	SpezialLack_Scrollbar[4] = dgsCreateScrollBar(52,193,264,21,true,false,SpezialLack_Window[1])
	SpezialLack_Label[7] = dgsCreateLabel(12,195,23,13,"Rot:",false,SpezialLack_Window[1])
	dgsLabelSetColor(SpezialLack_Label[7],255,0,0)
	dgsSetFont(SpezialLack_Label[7],"default-bold-small")
	SpezialLack_Scrollbar[5] = dgsCreateScrollBar(52,220,263,21,true,false,SpezialLack_Window[1])
	SpezialLack_Scrollbar[6] = dgsCreateScrollBar(52,247,263,21,true,false,SpezialLack_Window[1])
	SpezialLack_Label[8] = dgsCreateLabel(12,222,38,14,"Gruen:",false,SpezialLack_Window[1])
	dgsLabelSetColor(SpezialLack_Label[8],0,255,0)
	dgsSetFont(SpezialLack_Label[8],"default-bold-small")
	SpezialLack_Label[9] = dgsCreateLabel(12,249,38,14,"Blau:",false,SpezialLack_Window[1])
	dgsLabelSetColor(SpezialLack_Label[9],0,0,255)
	dgsSetFont(SpezialLack_Label[9],"default-bold-small")
	SpezialLack_Label[10] = dgsCreateLabel(32,272,300,14,"Umlackieren: 1.250$, Neue Lackierung: 2.500$",false,SpezialLack_Window[1])
	dgsSetFont(SpezialLack_Label[10],"default-bold-small")
	SpezialLack_Button[1] = dgsCreateButton(11,294,141,29,"Lackieren ("..kosten.." $)",false,SpezialLack_Window[1])
	dgsSetFont(SpezialLack_Button[1],"default-bold-small")
	SpezialLack_Button[2] = dgsCreateButton(171,294,141,29,"Abbrechen",false,SpezialLack_Window[1])
	dgsSetFont(SpezialLack_Button[2],"default-bold-small")

	addEventHandler("onDgsElementScroll", SpezialLack_Window[1], function()
		local red1 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[1]))
		local green1 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[2]))
		local blue1 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[3]))
		local red2 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[4]))
		local green2 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[5]))
		local blue2 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[6]))
		triggerServerEvent("seeSpezialLack", getLocalPlayer(), red1, green1, blue1, red2, green2, blue2)
	end)
	
	addEventHandler("onDgsMouseClickUp", SpezialLack_Button[1], function()
		dgsSetVisible(SpezialLack_Window[1], false)
		showCursor(false)
		setElementClicked(false)
		local red1 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[1]))
		local green1 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[2]))
		local blue1 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[3]))
		local red2 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[4]))
		local green2 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[5]))
		local blue2 = math.floor(dgsScrollBarGetScrollPosition(SpezialLack_Scrollbar[6]))
		triggerServerEvent("buySpezialLack", getLocalPlayer(), red1, green1, blue1, red2, green2, blue2)
	end)
	
	addEventHandler("onDgsMouseClickUp", SpezialLack_Button[2], function()
		dgsSetVisible(SpezialLack_Window[1], false)
		showCursor(false)
		setElementClicked(false)
		triggerServerEvent("closeSpezialLack", getLocalPlayer())
	end)
end
--addEvent( "showSpezialLack", true )
--addEventHandler( "showSpezialLack", getRootElement(), showSpezialLack )
