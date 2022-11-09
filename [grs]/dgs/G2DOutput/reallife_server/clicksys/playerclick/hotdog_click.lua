
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

function giveHotDogGui()

	if gWindow["sellHotdog"] then
		dgsSetVisible ( gWindow["sellHotdog"], true )
	else
		gWindow["sellHotdog"] = dgsCreateWindow(screenwidth/2-187/2,145,187,108,"Hotdogverkauf",false)
		dgsSetAlpha(gWindow["sellHotdog"],1)
		gButton["sellHotdog"] = dgsCreateButton(0.5722,0.2685,0.369,0.2963,"Anbieten",true,gWindow["sellHotdog"])
		dgsSetAlpha(gButton["sellHotdog"],1)
		gLabel["hotdogPreis"] = dgsCreateLabel(0.0481,0.3148,0.1765,0.1759,"Preis:",true,gWindow["sellHotdog"])
		dgsSetAlpha(gLabel["hotdogPreis"],1)
		dgsLabelSetColor(gLabel["hotdogPreis"],200,200,125)
		dgsLabelSetVerticalAlign(gLabel["hotdogPreis"],"top")
		dgsLabelSetHorizontalAlign(gLabel["hotdogPreis"],"left",false)
		dgsSetFont(gLabel["hotdogPreis"],"default-bold-small")
		gEdit["hotdogPrice"] = dgsCreateEdit(0.2567,0.2963,0.1872,0.213,"",true,gWindow["sellHotdog"])
		dgsSetAlpha(gEdit["hotdogPrice"],1)
		gLabel["hotdogsLeft"] = dgsCreateLabel(0.0428,0.6019,0.7005,0.3241,"Verbleibende Hotdogs\n im Wagen:",true,gWindow["sellHotdog"])
		dgsSetAlpha(gLabel["hotdogsLeft"],1)
		dgsLabelSetColor(gLabel["hotdogsLeft"],200,015,015)
		dgsLabelSetVerticalAlign(gLabel["hotdogsLeft"],"top")
		dgsLabelSetHorizontalAlign(gLabel["hotdogsLeft"],"left",false)
		dgsSetFont(gLabel["hotdogsLeft"],"default-bold-small")
		gLabel["hotdogsCurrent"] = dgsCreateLabel(0.4064,0.7315,0.4385,0.1759,"0 Hotdogs",true,gWindow["sellHotdog"])
		dgsSetAlpha(gLabel["hotdogsCurrent"],1)
		dgsLabelSetColor(gLabel["hotdogsCurrent"],000,125,000)
		dgsLabelSetVerticalAlign(gLabel["hotdogsCurrent"],"top")
		dgsLabelSetHorizontalAlign(gLabel["hotdogsCurrent"],"left",false)
		dgsSetFont(gLabel["hotdogsCurrent"],"default-bold-small")
		gLabel["hotdog$Symbol"] = dgsCreateLabel(0.4652,0.3148,0.0535,0.1481,"$",true,gWindow["sellHotdog"])
		dgsSetAlpha(gLabel["hotdog$Symbol"],1)
		dgsLabelSetColor(gLabel["hotdog$Symbol"],015,200,000)
		dgsLabelSetVerticalAlign(gLabel["hotdog$Symbol"],"top")
		dgsLabelSetHorizontalAlign(gLabel["hotdog$Symbol"],"left",false)
		
		addEventHandler("onDgsMouseClickUp", gButton["sellHotdog"],
			function()
				triggerServerEvent ( "sellhotdog", getLocalPlayer(), getLocalPlayer(), "", dgsGetText ( gEdit["hotdogPrice"] ) )
			end
		)
	end
end

function HotdogLoadMenue()

	showCursor ( true )
	setElementClicked ( true )
	if gWindow["hotdogBuyin"] then
		dgsSetVisible ( gWindow["hotdogBuyin"], true )
	else
		gWindow["hotdogBuyin"] = dgsCreateWindow(screenwidth/2-135/2,screenheight/2-99/2,135,99,"Hotdogs einladen",false)
		dgsSetAlpha(gWindow["hotdogBuyin"],1)
		gButton["hotdogLoad"] = dgsCreateButton(0.4519,0.2424,0.4815,0.2727,"Einladen",true,gWindow["hotdogBuyin"])
		dgsSetAlpha(gButton["hotdogLoad"],1)
		gEdit["hotdogAmount"] = dgsCreateEdit(0.0667,0.2626,0.2667,0.202,"",true,gWindow["hotdogBuyin"])
		dgsSetAlpha(gEdit["hotdogAmount"],1)
		gLabel["hotdogInfotext"] = dgsCreateLabel(0.0667,0.5253,0.7185,0.1919,"Preis pro Hotdog:",true,gWindow["hotdogBuyin"])
		dgsSetAlpha(gLabel["hotdogInfotext"],1)
		dgsLabelSetColor(gLabel["hotdogInfotext"],200,200,000)
		dgsLabelSetVerticalAlign(gLabel["hotdogInfotext"],"top")
		dgsLabelSetHorizontalAlign(gLabel["hotdogInfotext"],"left",false)
		dgsSetFont(gLabel["hotdogInfotext"],"default-bold-small")
		gLabel["hotdogPrice"] = dgsCreateLabel(0.0593,0.7273,0.5556,0.1515,"1 $ / Stueck",true,gWindow["hotdogBuyin"])
		dgsSetAlpha(gLabel["hotdogPrice"],1)
		dgsLabelSetColor(gLabel["hotdogPrice"],000,125,000)
		dgsLabelSetVerticalAlign(gLabel["hotdogPrice"],"top")
		dgsLabelSetHorizontalAlign(gLabel["hotdogPrice"],"left",false)
		dgsSetFont(gLabel["hotdogPrice"],"default-bold-small")
		
		addEventHandler("onDgsMouseClickUp", gButton["hotdogLoad"],
			function()
				triggerServerEvent ( "buyhotdogs", lp, lp, math.abs ( math.floor ( tonumber ( dgsGetText ( gEdit["hotdogAmount"] ) ) ) ) )
				showCursor ( false )
				dgsSetVisible ( gWindow["hotdogBuyin"], false )
				triggerServerEvent ( "cancel_gui_server", lp )
			end
		)
	end
end
addEvent ( "showHotdogLoadMenue", true )
addEventHandler ( "showHotdogLoadMenue", getRootElement(), HotdogLoadMenue )