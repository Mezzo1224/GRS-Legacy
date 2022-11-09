
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


GUIEditor = {
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}
buyablevehlist = {}

function showFactionCarBuyPanel ()
        GUIEditor.window[1] = dgsCreateWindow(0.38, 0.27, 0.25, 0.45, "Fraktions-Fahrzeuge kaufen", true)
        dgsWindowSetMovable(GUIEditor.window[1], false)
        dgsWindowSetSizable(GUIEditor.window[1], false)

        GUIEditor.gridlist[1] = dgsCreateGridList(0.02, 0.05, 0.57, 0.93, true, GUIEditor.window[1])
       buyablevehsid = dgsGridListAddColumn(GUIEditor.gridlist[1], "ID", 0.3)
        buyablevehsmodel = dgsGridListAddColumn(GUIEditor.gridlist[1], "Fahrzeug", 0.3)
        buyablevehspreis = dgsGridListAddColumn(GUIEditor.gridlist[1], "Preis", 0.3)
        GUIEditor.label[1] = dgsCreateLabel(0.63, 0.05, 0.35, 0.06, "      Fahrzeuginformationen\n-------------------------------------------", true, GUIEditor.window[1])
        infos = dgsCreateLabel(0.63, 0.11, 0.35, 0.17, "Kosten:\n\nGeschwindichkeit:\n\nSitzplätze:\n-------------------------------------------", true, GUIEditor.window[1])
        dgsSetFont(GUIEditor.label[2], "clear-normal")
        GUIEditor.button[1] = dgsCreateButton(0.63, 0.30, 0.35, 0.08, "Fahrzeug kaufen", true, GUIEditor.window[1])
        GUIEditor.button[2] = dgsCreateButton(0.63, 0.90, 0.35, 0.08, "Zurück", true, GUIEditor.window[1])
        GUIEditor.label[3] = dgsCreateLabel(0.63, 0.86, 0.35, 0.03, "-------------------------------------------", true, GUIEditor.window[1])
        GUIEditor.label[4] = dgsCreateLabel(0.63, 0.43, 0.35, 0.06, "            Administration\n-------------------------------------------", true, GUIEditor.window[1])
        GUIEditor.label[5] = dgsCreateLabel(0.63, 0.39, 0.35, 0.03, "-------------------------------------------", true, GUIEditor.window[1])
        GUIEditor.button[3] = dgsCreateButton(0.63, 0.51, 0.35, 0.08, "Fahrzeug erstellen", true, GUIEditor.window[1])
        GUIEditor.edit[1] = dgsCreateEdit(0.63, 0.60, 0.16, 0.07, "Modell", true, GUIEditor.window[1])
        GUIEditor.edit[2] = dgsCreateEdit(0.81, 0.60, 0.16, 0.07, "Preis", true, GUIEditor.window[1])
        GUIEditor.edit[3] = dgsCreateEdit(0.72, 0.67, 0.16, 0.07, "Fraktion", true, GUIEditor.window[1])
        GUIEditor.button[4] = dgsCreateButton(0.63, 0.76, 0.35, 0.08, "Ausgewähltes\nlöschen", true, GUIEditor.window[1])    
		refreshBuyableVehs ()
		setButtonsRights()
		addEventHandler("onDgsMouseClickUp", GUIEditor.gridlist[1], SubmitGridClickFVEH, true)
		addEventHandler("onDgsMouseClickUp", GUIEditor.button[2], function()
			dgsSetVisible(GUIEditor.window[1], false)
			setElementClicked ( false )
			openFraktionMenu ()
    end, false)
		addEventHandler("onDgsMouseClickUp", GUIEditor.button[3], function()
			local model = dgsGetText(GUIEditor.edit[1])
			local price = dgsGetText(GUIEditor.edit[2])
			local faction = dgsGetText(GUIEditor.edit[3])
			triggerServerEvent("makeNewBuyableCar",getRootElement(),getLocalPlayer(), model, price, faction)
			refreshBuyableVehs ()
    end, false)

	addEventHandler("onDgsMouseClickUp",  GUIEditor.button[1], function()
			local model = dgsGridListGetItemText ( GUIEditor.gridlist[1], dgsGridListGetSelectedItem ( GUIEditor.gridlist[1]), 2 )
			local price = dgsGridListGetItemText ( GUIEditor.gridlist[1], dgsGridListGetSelectedItem ( GUIEditor.gridlist[1]), 3 )
			triggerServerEvent("buyNewFactionCar",getRootElement(),getLocalPlayer(), model, price)
    end, false)
	
	addEventHandler("onDgsMouseClickUp",  GUIEditor.button[4], function()
			local id = dgsGridListGetItemText ( GUIEditor.gridlist[1], dgsGridListGetSelectedItem ( GUIEditor.gridlist[1]), 1 )
			triggerServerEvent("deleteBuyableCar",getRootElement(),getLocalPlayer(), id)
			refreshBuyableVehs ()
    end, false)
	
    end


function setButtonsRights()
	local adminlvl = getElementData (lp, "adminlvlShow")
	if adminlvl >= 7 then
		dgsSetEnabled(GUIEditor.button[3], true)
		dgsSetEnabled(GUIEditor.button[4], true)
	else
		dgsSetEnabled(GUIEditor.button[3], false)
		dgsSetEnabled(GUIEditor.button[4], false)
	end
end

function SubmitGridClickFVEH( button )

	if button == "left" then
		local model = dgsGridListGetItemText ( GUIEditor.gridlist[1], dgsGridListGetSelectedItem ( GUIEditor.gridlist[1]), 2 )
		local prize = dgsGridListGetItemText ( GUIEditor.gridlist[1], dgsGridListGetSelectedItem ( GUIEditor.gridlist[1]), 3 )
		--local geschw = tonumber ( getVehicleHandling(getVehicleModelFromName(model),"maxVelocity" )
	--	local seats = tonumber ( getVehicleMaxPassengers(getVehicleModelFromName(model) )
		local geschw = 1
		local seats = 1
		dgsSetText(infos,"Kosten: "..prize.." $\n\nGeschwindichkeit: N.a\n\nSitzplätze: N.a\n-------------------------------------------")
		
	end
end
	
function refreshBuyableVehs ()
	dgsGridListClear (GUIEditor.gridlist[1])
	triggerServerEvent("loadBuyableCars",getRootElement(),getLocalPlayer())
end

function loadBuyableCars (id, model, price)

	

	buyablevehlist[id] = dgsGridListAddRow(GUIEditor.gridlist[1])
	
	dgsGridListSetItemText(GUIEditor.gridlist[1], buyablevehlist[id], buyablevehsid, id, false, false)
	dgsGridListSetItemText(GUIEditor.gridlist[1], buyablevehlist[id],  buyablevehsmodel, getVehicleNameFromModel(model), false, false)
	dgsGridListSetItemText(GUIEditor.gridlist[1], buyablevehlist[id], buyablevehspreis, price, false, false)

	

	
end
addEvent( "loadBuyableCars", true )
addEventHandler( "loadBuyableCars", getRootElement(), loadBuyableCars )