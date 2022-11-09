
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

local GUIEditor = {
    button = {},
    window = {},
    label = {}
}


--[[ 
	1 = Nahkampf | 2 = Deagle | 3 = Mp5 | 4 = Spezialwaffe | 5 = Gewehr |
	6 = AK47 | 7 = M4 | 8 = Sniper | 9 = Raketenwerfer |
  ]]

local Moneycost = {
	[1] = 100,
	[2] = 200,
	[3] = 300,
	[4] = 300,
	[5] = 300,
	[6] = 300,
	[7] = 400,
	[8] = 1500,
	[9] = 2000
}

local Matscost = {
	[1] = 10,
	[2] = 20,
	[3] = 30,
	[4] = 30,
	[5] = 30,
	[6] = 30,
	[7] = 40,
	[8] = 150,
	[9] = 200
}

local buttonID = {}

function createFgunsGui (therank, thefrac)
	showCursor (true)
	setElementClicked ( true )
    GUIEditor.window[1] = dgsCreateWindow(0.26, 0.07, 0.50, 0.80, "Fraktionslager", true)
    dgsSetAlpha(GUIEditor.window[1], 0.90)
	dgsBringToFront (GUIEditor.window[1])

	-- Yakuza --
	if thefrac == 3 then
        GUIEditor.button[1] = dgsCreateButton(0.03, 0.09, 0.25, 0.11, "Baseball", true, GUIEditor.window[1])
        dgsSetProperty(GUIEditor.button[1], "NormalTextColour", "E3FFFFFF")
		if therank >= 2 then
			GUIEditor.button[4] = dgsCreateButton(0.03, 0.34, 0.25, 0.11, "Katana", true, GUIEditor.window[1])
			dgsSetProperty(GUIEditor.button[4], "NormalTextColour", "E3FFFFFF")
			GUIEditor.label[7] = dgsCreateLabel(0.03, 0.48, 0.25, 0.04, Moneycost[4].."$", true, GUIEditor.window[1])
			dgsLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
			GUIEditor.label[8] = dgsCreateLabel(0.03, 0.52, 0.25, 0.04, Matscost[4].." Mats", true, GUIEditor.window[1])
			dgsLabelSetHorizontalAlign(GUIEditor.label[8], "center", false)
		end
	-- Mafia --
	elseif thefrac == 2 then
        GUIEditor.button[1] = dgsCreateButton(0.03, 0.09, 0.25, 0.11, "Messer", true, GUIEditor.window[1])
        dgsSetProperty(GUIEditor.button[1], "NormalTextColour", "E3FFFFFF")
		if therank >= 2 then
			GUIEditor.button[4] = dgsCreateButton(0.03, 0.34, 0.25, 0.11, "Lupara", true, GUIEditor.window[1])
			dgsSetProperty(GUIEditor.button[4], "NormalTextColour", "E3FFFFFF")
			GUIEditor.label[7] = dgsCreateLabel(0.03, 0.48, 0.25, 0.04, Moneycost[4].."$", true, GUIEditor.window[1])
			dgsLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
			GUIEditor.label[8] = dgsCreateLabel(0.03, 0.52, 0.25, 0.04, Matscost[4].." Mats", true, GUIEditor.window[1])
			dgsLabelSetHorizontalAlign(GUIEditor.label[8], "center", false)
		end
	else
        GUIEditor.button[1] = dgsCreateButton(0.03, 0.09, 0.25, 0.11, "Queue", true, GUIEditor.window[1])
        dgsSetProperty(GUIEditor.button[1], "NormalTextColour", "E3FFFFFF")
		if therank >= 2 then
			GUIEditor.button[4] = dgsCreateButton(0.03, 0.34, 0.25, 0.111, "Molotov", true, GUIEditor.window[1])
			dgsSetProperty(GUIEditor.button[4], "NormalTextColour", "E3FFFFFF")
			GUIEditor.label[7] = dgsCreateLabel(0.03, 0.48, 0.25, 0.04, Moneycost[4].."$", true, GUIEditor.window[1])
			dgsLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
			GUIEditor.label[8] = dgsCreateLabel(0.03, 0.52, 0.25, 0.04, Matscost[4].." Mats", true, GUIEditor.window[1])
			dgsLabelSetHorizontalAlign(GUIEditor.label[8], "center", false)
		end
	end
	GUIEditor.label[1] = dgsCreateLabel(0.03, 0.22, 0.25, 0.04, Moneycost[1].."$", true, GUIEditor.window[1])
	dgsLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
    GUIEditor.label[2] = dgsCreateLabel(0.03, 0.26, 0.25, 0.04, Matscost[1].." Mats", true, GUIEditor.window[1])
    dgsLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)
    
	GUIEditor.button[2] = dgsCreateButton(0.39, 0.09, 0.25, 0.11, "Deagle", true, GUIEditor.window[1])
    dgsSetProperty(GUIEditor.button[2], "NormalTextColour", "E3FFFFFF")
	GUIEditor.label[3] = dgsCreateLabel(0.39, 0.22, 0.25, 0.04, Moneycost[2].."$", true, GUIEditor.window[1])
    dgsLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
	GUIEditor.label[4] = dgsCreateLabel(0.39, 0.26, 0.25, 0.04, Matscost[2].." Mats", true, GUIEditor.window[1])
    dgsLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)
	
	if therank >= 1 then
		GUIEditor.button[3] = dgsCreateButton(0.73, 0.09, 0.25, 0.11, "Mp5", true, GUIEditor.window[1])
		dgsSetProperty(GUIEditor.button[3], "NormalTextColour", "E3FFFFFF")
		GUIEditor.label[5] = dgsCreateLabel(0.73, 0.22, 0.25, 0.04, Moneycost[3].."$", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
		GUIEditor.label[6] = dgsCreateLabel(0.73, 0.26, 0.25, 0.04, Matscost[3].." Mats", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)
	end
	if therank >= 2 then
		GUIEditor.button[5] = dgsCreateButton(0.39, 0.34, 0.25, 0.11, "Gewehr", true, GUIEditor.window[1])
		dgsSetProperty(GUIEditor.button[5], "NormalTextColour", "E3FFFFFF")
		GUIEditor.label[9] = dgsCreateLabel(0.39, 0.48, 0.24, 0.04, Moneycost[5].."$", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[9], "center", false)
		GUIEditor.label[10] = dgsCreateLabel(0.39, 0.52, 0.25, 0.04, Matscost[5].." Mats", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[10], "center", false)
	end
	if therank >= 3 then
		GUIEditor.button[7] = dgsCreateButton(0.03, 0.61, 0.25, 0.11, "M4", true, GUIEditor.window[1])
		dgsSetProperty(GUIEditor.button[7], "NormalTextColour", "E3FFFFFF")
		GUIEditor.label[13] = dgsCreateLabel(0.03, 0.73, 0.25, 0.04, Moneycost[7].."$", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[13], "center", false)
		GUIEditor.label[14] = dgsCreateLabel(0.03, 0.77, 0.25, 0.04, Matscost[7].." Mats", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[14], "center", false)
		
		GUIEditor.button[6] = dgsCreateButton(0.73, 0.34, 0.25, 0.11, "AK47", true, GUIEditor.window[1])
		dgsSetProperty(GUIEditor.button[6], "NormalTextColour", "E3FFFFFF")
		GUIEditor.label[11] = dgsCreateLabel(0.73, 0.48, 0.25, 0.04, Moneycost[6].."$".."$", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[11], "center", false)
		GUIEditor.label[12] = dgsCreateLabel(0.73, 0.52, 0.25, 0.04, Matscost[6].." Mats", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[12], "center", false)
	end
	if therank >= 4 then
		GUIEditor.button[8] = dgsCreateButton(0.39, 0.61, 0.25, 0.11, "Sniper", true, GUIEditor.window[1])
		dgsSetProperty(GUIEditor.button[8], "NormalTextColour", "E3FFFFFF")
		GUIEditor.label[15] = dgsCreateLabel(0.39, 0.73, 0.25, 0.04, Moneycost[8].."$", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[15], "center", false)
		GUIEditor.label[16] = dgsCreateLabel(0.39, 0.77, 0.25, 0.04, Matscost[8].." Mats", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[16], "center", false)
	end
	if therank >= 5 then
		GUIEditor.button[9] = dgsCreateButton(0.73, 0.61, 0.25, 0.11, "Raketenwerfer", true, GUIEditor.window[1])
		dgsSetProperty(GUIEditor.button[9], "NormalTextColour", "E3FFFFFF")
		GUIEditor.label[17] = dgsCreateLabel(0.73, 0.73, 0.25, 0.04, Moneycost[9].."$", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[17], "center", false)
		GUIEditor.label[18] = dgsCreateLabel(0.73, 0.78, 0.25, 0.04, Matscost[9].." Mats", true, GUIEditor.window[1])
		dgsLabelSetHorizontalAlign(GUIEditor.label[18], "center", false)	
	end
	GUIEditor.button[10] = dgsCreateButton(0.29, 0.86, 0.43, 0.09, "Schließen", true, GUIEditor.window[1])
    dgsSetProperty(GUIEditor.button[10], "NormalTextColour", "E3FFFFFF")
	
	for index, button in pairs ( GUIEditor.button ) do
		if index ~= 10 then
			addEventHandler ("onDgsMouseClickUp", GUIEditor.button[index], sendTheWeaponFromFGunsToServer, false)
			buttonID[GUIEditor.button[index]] = index
		end
	end
	addEventHandler ("onDgsMouseClickUp", GUIEditor.button[10], closeFgunsGui, false)
end
addEvent ( "startFgunsGui", true )
addEventHandler( "startFgunsGui", getRootElement(), createFgunsGui )


function sendTheWeaponFromFGunsToServer ( button, state )
	if button == "left" and state == "up" then
		triggerServerEvent ( "giveFgunsWeapon", lp, dgsGetText(source), Moneycost[buttonID[source]], Matscost[buttonID[source]] )
	end
end


function closeFgunsGui ( button, state )
	if button == "left" and state == "up" then
		showCursor (false)
		setElementClicked ( false )
		for i, button in pairs (GUIEditor.button) do
			destroyElement (button)
			GUIEditor.button[i] = nil
		end
		for i, label in pairs (GUIEditor.label) do
			destroyElement (label)
			GUIEditor.label[i] = nil
		end
		destroyElement (GUIEditor.window[1])
		GUIEditor.window[1] = nil
	end
end
				
				