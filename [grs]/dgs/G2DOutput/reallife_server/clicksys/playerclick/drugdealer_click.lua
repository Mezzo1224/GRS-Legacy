
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

function showDrugMenue ()

	if gWindow["drogenverkauf"] then
		dgsSetVisible ( gWindow["drogenverkauf"], true )
	else
		gWindow["drogenverkauf"] = dgsCreateWindow(screenwidth/2-255/2, 145,255,119,"Drogenverkauf",false)
		dgsSetAlpha(gWindow["drogenverkauf"],1)
		gLabel["drogen"] = dgsCreateLabel(14,30,109,18,"Drogen (in gramm)",false,gWindow["drogenverkauf"])
		dgsSetAlpha(gLabel["drogen"],1)
		dgsLabelSetColor(gLabel["drogen"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["drogen"],"top")
		dgsLabelSetHorizontalAlign(gLabel["drogen"],"left",false)
		dgsSetFont(gLabel["drogen"],"default-bold-small")
		gEdit["drogenanzahl"] = dgsCreateEdit(41,58,59,20,"",false,gWindow["drogenverkauf"])
		dgsSetAlpha(gEdit["drogenanzahl"],1)
		gButton["verkaufen"] = dgsCreateButton(86,92,72,18,"Geben",false,gWindow["drogenverkauf"])
		dgsSetAlpha(gButton["verkaufen"],1)
		gButton["abbrechen"] = dgsCreateButton(225,25,20,20,"X",false,gWindow["drogenverkauf"])
		dgsSetAlpha(gButton["abbrechen"],1)
	end
	addEventHandler("onDgsMouseClickUp", gButton["verkaufen"], givedrugs, false)
	addEventHandler("onDgsMouseClickUp", gButton["abbrechen"], closeDrugWindow, false)
end

function givedrugs ()

	local target = vioClientGetElementData ( "curclicked" )
	triggerServerEvent ( "givedrugs", root, localPlayer, "cmd", target, tonumber ( dgsGetText ( gEdit["drogenanzahl"] ) ) )
end

function closeDrugWindow()

	dgsSetVisible(gWindow["drogenverkauf"],false)
end