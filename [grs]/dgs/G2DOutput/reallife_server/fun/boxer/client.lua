
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

-----------------------------------------------
------Made and copyright by (c)Sorginator------
--angepasst für mehrere Spieler & Vio Extended-
------------------by Bonus---------------------
-----------------------------------------------

--Variablen
local box1
local box2
local entwaffnenTimer
local falsevar1 = 100
local falsevar2 = 300
local KampfstyledesBoxers = 4
local timerDreschen = nil

--Events

addEvent("dreschen", true)
addEvent("jih", true)
addEvent("guiBoxenPed", true)

--EventHandler

addEventHandler("jih", getRootElement(), function()	--Dieses Event gibt den Text zur jeweiligen Runde aus
	if vioClientGetElementData("boxlvl") == 0 then
		outputChatBox("Willkommen in der ersten Runde!", 20, 150, 50)
		outputChatBox("Für die gesamte Zeit des Kampfes gilt: ", 20, 150, 50)
		outputChatBox("Du kannst den Ring innerhalb der ersten 15 Sekunden mit /aufgeben verlassen.", 20, 150, 50)
		outputChatBox("Solltest du ihn danach verlassen oder disconnecten, gilt der Kampf als verloren!", 20, 150, 50)
		outputChatBox("Erledige den Boxer, um die erste Runde für dich zu entscheiden!", 20, 150, 50)
		--falsevar2 = 300
	elseif vioClientGetElementData("boxlvl") == 1 then
		outputChatBox("Willkommen in der zweiten Runde!", 20, 180, 50)
		outputChatBox("Die Regeln dürften dir bekannt sein!", 20, 180, 50)
		outputChatBox("Besiege den Boxer in dieser Runde, um zur letzten Runde antreten zu können!", 20, 180, 50)
		--falsevar2 = 225
	elseif vioClientGetElementData("boxlvl") == 2 then
		outputChatBox("Willkommen in der dritten und letzten Runde!", 20, 200, 50)
		outputChatBox("Die Regeln dürften dir bekannt sein!", 20, 200, 50)
		outputChatBox("Besiege den Boxer nun endgültig, um den gesamten Kampf für dich entscheiden zu können!", 20, 200, 50)
		--falsevar2 = 150
	end
end )

addEventHandler("dreschen", getRootElement(), function(bot, abstand)	--Dieses Event lüsst den Boxer auf den Spieler einprügeln
	if (bot) and (abstand) then
		timerDreschen = setTimer ( dreschIhn, tonumber(abstand), -1, bot, source )
	end
end )

function dreschIhn ( bot, ziel )
	if bot and isElement(bot) and getElementType(bot)=="ped" and ziel then
		local x, y, z = getElementPosition(ziel)
		local x1, y1, z1 = getElementPosition(bot)
		local rot = math.atan2(y - y1, x - x1) * 180 / math.pi
		rot = rot-90
		setElementRotation(bot, 0, 0, rot)
		box1 = setTimer(function()
			if bot and isElement(bot) and getElementType(bot)=="ped" and not (bot == 1) then
				setPedControlState(bot, "fire", false)
			end
		end, falsevar1, 1 )
		box2 = setTimer(function()
			if bot and isElement(bot) and getElementType(bot)=="ped" and not (bot == 1) then
				setPedControlState(bot, "fire", true)
			end
		end, falsevar2, 1 )
	elseif isTimer ( timerDreschen ) then
		killTimer ( timerDreschen )
		timerDreschen = nil
	end
end

addEventHandler("guiBoxenPed", getRootElement(),
	function()
		local sWidth, sHeight = dgsGetScreenSize()
		local Width,Height = 234,140
		local x = (sWidth/2) - (Width/2)
		local y = (sHeight/2) - (Height/2)
    	local fenster = dgsCreateWindow(x, y, Width, Height, "Willkommen beim Boxring", false)
    	dgsWindowSetSizable(fenster, false)
    	local Label = dgsCreateLabel(73, 24, 98, 15, "Hier kannst du", false, fenster)
    	dgsSetFont(Label, "default-bold-small")
    	local Label2 = dgsCreateLabel(45, 39, 156, 16, "gegen einen Boxer kümpfen", false, fenster)
    	dgsSetFont(Label2, "default-bold-small")
    	local knopf = dgsCreateButton(14, 100, 69, 30, "Kampf starten", false, fenster)
    	local knopf2 = dgsCreateButton(154, 102, 70, 28, "Abbrechen", false, fenster)	
		dgsSetVisible(fenster, true)
		showCursor(true)
		setElementClicked ( true )
		addEventHandler("onDgsMouseClickUp", knopf, function()
			triggerServerEvent("boxenstarten1", root, getLocalPlayer())
			dgsSetVisible(fenster, false)
			showCursor(false)
			setElementClicked ( false )
		end )
		addEventHandler("onDgsMouseClickUp", knopf2, function()
			dgsSetVisible(fenster, false)
			showCursor(false)
			setElementClicked ( false )
		end )
	end
)