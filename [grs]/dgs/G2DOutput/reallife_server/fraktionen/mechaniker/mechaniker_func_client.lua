
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

------------------------------
-------- Urheberrecht --------
------- by [LA]Leyynen -------
-------- 2012 - 2013 ---------
------------------------------
---- Script by Noneatme ------

local Guivar = 0
local GuivarMech = 0

addEvent("onVioOrdnungsamtTuningGuiStart1", true)
addEvent("onVioOrdnungsamtTuningGuiStart2", true)
local aramp1, aramp2
local aramp3

local Fenster = {}

local Knopf = {}
local Label = {}
local Grid = {}
	

local oamt_tunings = {
	{ "Kleine Reparatur", 50, "fix" },
	{ "Nitro auffüllen", 250, "fix" },
	{ "Sportmotor 1", 100000, "sportmotor" },
	{ "Sportmotor 2", 250000, "sportmotor" },
	{ "Sportmotor 3", 500000, "sportmotor" },
	{ "Bremse 1", 25000, "bremse" },
	{ "Bremse 2", 50000, "bremse" },
	{ "Bremse 3", 100000, "bremse" },
	{ "Frontantrieb", 40000, "antrieb" },
	{ "Heckantrieb", 40000, "antrieb" },
	{ "Allradantrieb", 40000, "antrieb" }
}

local function refreshOAMTGrid2(car)
	dgsGridListClear(Grid[1])
	if isElement ( aramp2 ) and getElementData ( aramp2, "owner" ) and getElementData ( aramp2, "owner" ) ~= getPlayerName ( localPlayer ) then
		for i = 1, #oamt_tunings, 1 do
			local name, preis, data = oamt_tunings[i][1], oamt_tunings[i][2], oamt_tunings[i][3]
			local eingebaut = "-"
			if data == "sportmotor" then
				if getElementData ( aramp2, "sportmotor" ) >= i - 2 then
					eingebaut = "Ja"
				else
					eingebaut = "Nein"
				end
			elseif data == "bremse" then
				if getElementData ( aramp2, "bremse" ) >= i - 5 then
					eingebaut = "Ja"
				else
					eingebaut = "Nein"
				end
			elseif data == "antrieb" then
				local antrieb = getElementData ( aramp2, "antrieb" ) 
				if antrieb == "fwd" and name == "Frontantrieb" then 
					eingebaut = "Ja"
				elseif antrieb == "rwd" and name == "Heckantrieb" then
					eingebaut = "Ja"
				elseif antrieb == "awd" and name == "Allradantrieb" then
					eingebaut = "Ja"
				else
					eingebaut = "Nein"
				end
			end
			local Besitzer = getElementData (car[1], "owner")
			local model = getElementModel(car[1])
			local row = dgsGridListAddRow(Grid[1])
			dgsGridListSetItemText(Grid[1], row, 1, name, false, false)
			dgsGridListSetItemText(Grid[1], row, 2, eingebaut, false, false)
			dgsGridListSetItemText(Grid[1], row, 3, preis.."$", false, false)
		end	
	end
end

--[[local function refreshOAMTGrid1(car)
	dgsGridListClear(Grid[1])
	if isElement ( aramp1 ) then
		for i = 1, #oamt_tunings, 1 do
			local name, preis, data = gettok(oamt_tunings[i], 1, ","), gettok(oamt_tunings[i], 2, ","), gettok(oamt_tunings[i], 3, ",")
			local eingebaut = "Nein"
			if(data ~= "fix") then
				if(getElementData(aramp2, data) == true) then
					eingebaut = "Ja"
				end
			end
			local Besitzer = getElementData (car[1], "owner")
			local model = getElementModel(car[1])
			local row = dgsGridListAddRow(Grid[1])
			dgsGridListSetItemText(Grid[1], row, 1, name, false, false)
			dgsGridListSetItemText(Grid[1], row, 2, eingebaut, false, false)
			dgsGridListSetItemText(Grid[1], row, 3, preis.."$", false, false)
		end	
	end
end]]


local function createOAMTGui2(car)
	if(GuivarMech == 1) then return end
	GuivarMech = 1
	showCursor(true)
	setElementClicked ( true )

	local sWidth, sHeight = dgsGetScreenSize()
 
    local Width,Height = 404,330
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	Fenster[1] = dgsCreateWindow(X, Y, Width, Height, "Mechaniker Tuningfenster",false)
	Label[1] = dgsCreateLabel(11,21,384,52,"Willkommen an der Werkbank!\nHier kannst du aussuchen, was mit dem Auto in der Werkstatt\npassieren soll.",false,Fenster[1])
	dgsSetFont(Label[1],"default-bold-small")
	Label[2] = dgsCreateLabel(11,51,383,19,"______________________________________________________________",false,Fenster[1])
	dgsLabelSetColor(Label[2],0, 255, 0)
	local t1 = "N/A"
	aramp2 = nil
	if(type(car) == "table") then
		if(isElement(car[1])) then
			t1 = getVehicleNameFromModel(getElementModel(car[1]))
			aramp2 = car[1]
		end
	end
	
	Label[3] = dgsCreateLabel(12,79,380,34,"Werkstatt: "..t1,false,Fenster[1])
	dgsSetFont(Label[3],"default-bold-small")
	Grid[1] = dgsCreateGridList(15,163,226,158,false,Fenster[1])
	dgsGridListSetSelectionMode(Grid[1],1)

	dgsGridListAddColumn(Grid[1],"Aktion",0.5)

	dgsGridListAddColumn(Grid[1],"Eingebaut",0.2)

	dgsGridListAddColumn(Grid[1],"Preis",0.2)
	Knopf[1] = dgsCreateButton(250,172,138,32,"Aktion durchführen",false,Fenster[1])
	Knopf[2] = dgsCreateButton(252,279,138,32,"Abbrechen",false,Fenster[1])
	Knopf[3] = dgsCreateButton(250,207,138,32,"Aktion entfernen",false,Fenster[1])
	dgsSetEnabled(Knopf[3], false)
	refreshOAMTGrid2(car)
	-- EVENT HANDLERS --
	
	addEventHandler("onDgsMouseClickUp", Knopf[1], function()
		local aktion, eingebaut, preis = dgsGridListGetItemText(Grid[1], dgsGridListGetSelectedItem(Grid[1]), 1), dgsGridListGetItemText(Grid[1], dgsGridListGetSelectedItem(Grid[1]), 2),  dgsGridListGetItemText(Grid[1], dgsGridListGetSelectedItem(Grid[1]), 3)
		if(aktion == "") then return end
		car = aramp2
		if(eingebaut == "Ja") then
			outputChatBox("Diese Aktion wurde bereits durchgeführt!", 200, 0, 0)
			return
		end
		triggerServerEvent("onVioOAmtCarTuning", getLocalPlayer(), car, aktion, tonumber(gettok(preis, 1, "$")))
	end, false)

	-- CANCEL BUTTON --
	addEventHandler("onDgsMouseClickUp", Knopf[2], function()
		GuivarMech = 0
		destroyElement(Fenster[1])
		showCursor(false)
		setElementClicked ( false )
	end, false)
end
addEventHandler("onVioOrdnungsamtTuningGuiStart2", getLocalPlayer(), createOAMTGui2)


--[[local function createOAMTGui1(car)
	if(GuivarMech == 1) then return end
	GuivarMech = 1
	showCursor(true)

	local sWidth, sHeight = dgsGetScreenSize()
 
    local Width,Height = 404,330
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
	
	Fenster[1] = dgsCreateWindow(X, Y, Width, Height, "Mechaniker Lackiererei",false)
	--Label[1] = guiCreateLabel(11,21,384,52,"Willkommen an der Lackiererei!\nHier kannst du aussuchen, was mit dem Auto in der Lackiererei\npassieren soll.",false,Fenster[1])
	Label[1] = dgsCreateLabel(11,21,384,52,"Kommt demnächst!",false,Fenster[1])
	dgsSetFont(Label[1],"default-bold-small")
	Label[2] = dgsCreateLabel(11,51,383,19,"______________________________________________________________",false,Fenster[1])
	dgsLabelSetColor(Label[2],0, 255, 0)
	local t1 = "N/A"
	aramp1 = nil
	if(type(car) == "table") then
		if(isElement(car[1])) then
			t1 = getVehicleNameFromModel(getElementModel(car[1]))
			aramp1 = car[1]
		end
	end
	
	Label[3] = dgsCreateLabel(12,79,380,34,"Lackiererei: "..t1,false,Fenster[1])
	dgsSetFont(Label[3],"default-bold-small")
	Grid[1] = dgsCreateGridList(15,163,226,158,false,Fenster[1])
	dgsGridListSetSelectionMode(Grid[1],1)

	dgsGridListAddColumn(Grid[1],"Aktion",0.5)

	dgsGridListAddColumn(Grid[1],"Eingebaut",0.2)

	dgsGridListAddColumn(Grid[1],"Preis",0.2)
	Knopf[1] = dgsCreateButton(250,172,138,32,"Aktion durchführen",false,Fenster[1])
	Knopf[2] = dgsCreateButton(252,279,138,32,"Abbrechen",false,Fenster[1])
	Knopf[3] = dgsCreateButton(250,207,138,32,"Aktion entfernen",false,Fenster[1])
	dgsSetEnabled(Knopf[3], false)
	refreshOAMTGrid1(car)
	-- EVENT HANDLERS --
	
	addEventHandler("onDgsMouseClickUp", Knopf[1], function()
		local aktion, eingebaut, preis = dgsGridListGetItemText(Grid[1], dgsGridListGetSelectedItem(Grid[1]), 1), dgsGridListGetItemText(Grid[1], dgsGridListGetSelectedItem(Grid[1]), 2),  dgsGridListGetItemText(Grid[1], dgsGridListGetSelectedItem(Grid[1]), 3)
		if(aktion == "") then return end
		car = aramp1
		if(eingebaut == "Ja") then
			outputChatBox("Diese Aktion wurde bereits durchgeführt!", 200, 0, 0)
			return
		end
		-- SICHERHEITSHINWEIS --
		local money = mymoney
		if(money < tonumber(gettok(preis, 1, "$"))) then
			outputChatBox("Du hast nicht genug Geld!", 200, 0, 0)
			return
		end
		triggerServerEvent("onVioOAmtCarTuning", getLocalPlayer(), car, aktion, tonumber(gettok(preis, 1, "$")))
	end, false)

	-- CANCEL BUTTON --
	addEventHandler("onDgsMouseClickUp", Knopf[2], function()
		GuivarMech = 0
		destroyElement(Fenster[1])
		showCursor(false)
	end, false)
end
addEventHandler("onVioOrdnungsamtTuningGuiStart1", getLocalPlayer(), createOAMTGui1)]]