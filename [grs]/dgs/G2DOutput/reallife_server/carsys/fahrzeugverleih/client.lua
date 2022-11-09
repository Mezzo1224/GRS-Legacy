
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

-----------------------------------------------------
--------	environment/rollerrent_c.lua	---------
-------------------- by Byte ------------------------
-----------------------------------------------------

local w, h = dgsGetScreenSize()
local rollerverleih_window = dgsCreateWindow(w/2-200/2, h/2-200/2, 400, 200, "Rollerverleih Noobspawn", false)
--local rollerverleih_window = guiCreateStaticImage(w/2-200/2, h/2-200/2, 450, 200,"images/hud/background.png", false)
dgsWindowSetSizable(rollerverleih_window, false)

local text_label = dgsCreateLabel(32, 22, 316, 76, "Willkommen beim Rollerverleih!\nHier kannst du dir einen Roller für 20 Minuten ausleihen.\nWenn du weniger als 15 Spielstunden hast,\nkostet dich der Roller nichts.\nAndernfalls musst du 75$ bezahlen.", false, rollerverleih_window)
local ausleih_button = dgsCreateButton(22, 108, 158, 38, "Roller ausleihen", false, rollerverleih_window)
dgsSetFont(ausleih_button, "default-bold-small")
dgsSetProperty(ausleih_button, "NormalTextColour", "FFAAAAAA")
local close_button = dgsCreateButton(260, 108, 158, 38, "Nein, danke.", false, rollerverleih_window)
dgsSetFont(close_button, "default-bold-small")
dgsSetProperty(close_button, "NormalTextColour", "FFAAAAAA")
dgsSetVisible( rollerverleih_window, false )
local theid = nil

function clientRentWindow( id )
	showCursor( true )
	dgsSetVisible( rollerverleih_window, true )
	dgsBringToFront( rollerverleih_window )
	setElementClicked ( true )
	theid = id
	removeEventHandler("onDgsMouseClickUp", ausleih_button, clientRentRoller)
	addEventHandler("onDgsMouseClickUp", ausleih_button, clientRentRoller)
	addEventHandler("onDgsMouseClickUp", close_button, 
	function()
		showCursor( false )
		setElementClicked ( false )
		dgsSetVisible( rollerverleih_window, false )
	end)
end
addEvent("onClientRentRoller", true)
addEventHandler("onClientRentRoller", root, clientRentWindow)

function clientRentRoller( button )
	if button == "left" then
		showCursor( false )
		setElementClicked ( false )
		dgsSetVisible( rollerverleih_window, false )
		triggerServerEvent ( "onServerRentRoller", localPlayer, theid )
	end
end
