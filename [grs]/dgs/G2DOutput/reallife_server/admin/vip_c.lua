
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


local ppanel = {}
local width, height = dgsGetScreenSize()
ppanel.window = dgsCreateWindow(width/2-182, height/2-77, 364, 153, "Ultimate-RL Premium Panel", false)
dgsWindowSetSizable(ppanel.window, false)
dgsWindowSetMovable(ppanel.window ,true)

local tankenbutton = dgsCreateButton(14, 30, 159, 27, "Fahrzeug Tanken", false, ppanel.window)
local repairvehbutton = dgsCreateButton(189, 30, 159, 27, "Fahrzeug reparieren [100$]", false, ppanel.window)
local radiobutton = dgsCreateButton(14, 81, 159, 27, "Radio", false, ppanel.window)
local lebenessenbutton = dgsCreateButton(189, 81, 159, 27, "Leben auffüllen [300$]", false, ppanel.window)
local endebutton = dgsCreateButton(138, 119, 85, 25, "Verlassen", false, ppanel.window)

dgsSetVisible( ppanel.window, false)

function enterClickpp ()
    dgsSetVisible(ppanel.window, true)
	showCursor ( true )
	setElementClicked ( true )
end
addEvent("ppstart",true)
addEventHandler("ppstart", getRootElement(), enterClickpp)

function exitClickpp ( button )
	if button == "left" then  
		dgsSetVisible(ppanel.window, false)
		showCursor ( false )
		setElementClicked ( false )
	end
end
addEventHandler("onDgsMouseClickUp", endebutton, exitClickpp)

function fixvehClick ( button )
	if button == "left" then  
		dgsSetVisible(ppanel.window, false)
		triggerServerEvent ( "fixveh1", getLocalPlayer(), getLocalPlayer() )
		showCursor ( false )
		setElementClicked ( false )
	end
end
addEventHandler("onDgsMouseClickUp", repairvehbutton, fixvehClick)

function lebenClick ( button )
   	if button == "left" then 
		dgsSetVisible(ppanel.window, false)
		triggerServerEvent ( "lebenessen", getLocalPlayer(), getLocalPlayer() )
		showCursor ( false )
		setElementClicked ( false )
	end
end
addEventHandler("onDgsMouseClickUp", lebenessenbutton, lebenClick)

function radioClick ( button )
	if button == "left" then
		dgsSetVisible(ppanel.window, false)
		triggerEvent ( "onPlayerViewSpeakerManagment", getLocalPlayer(), getLocalPlayer() )
	end
end
addEventHandler("onDgsMouseClickUp", radiobutton, radioClick)

function tankenClick ( button )
	if button == "left" then  
		dgsSetVisible(ppanel.window, false)
		triggerServerEvent ( "fillComplete1", getLocalPlayer(), getLocalPlayer() )
		showCursor ( false )
		setElementClicked ( false )
	end
end
addEventHandler("onDgsMouseClickUp", tankenbutton, tankenClick)