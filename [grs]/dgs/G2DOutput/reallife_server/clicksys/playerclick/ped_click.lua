
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

npcTexts = {}
 npcTexts["dealer"] = "Psst...\nBrauchst du Stoff?"
 npcTexts["wdealer"] = "Hier rüber!\nIch hab da was für dich..."
 npcTexts["sdealer"] = "Ich hab hier n Pflänzchen -\nzumindest sinds welche, wenn\nman die richtig anbaut..."
 npcTexts["bum"] = "Hey du! Hassu was zu essen?\nIch verreck hier sons..."
 npcTexts["gunbuyer"] = "Hey Kumpel...\nHast du ne Knarre?"
 npcTexts["carseller1"] = "Hey, Interesse an nem neuen Wagen?"
 npcTexts["carseller2"] = "Der hier ist vom Laster gefallen...\nInteressiert?"
 npcTexts["carseller3"] = "Neuer Wagen gefällig?"

function showPedInteraction_func ( typ, item, price )

	if gWindow["pedInteraction"] then
		dgsSetVisible ( gWindow["pedInteraction"], true )
	else
		gWindow["pedInteraction"] = dgsCreateWindow(screenwidth/2-292/2, screenheight/2-245/2,292,245,"Gelegenheit",false)
		dgsSetAlpha(gWindow["pedInteraction"],1)
		dgsWindowSetMovable(gWindow["pedInteraction"],false)
		dgsWindowSetSizable(gWindow["pedInteraction"],false)
		gLabel["pedInteraction"] = dgsCreateLabel(10,27,272,150,"",false,gWindow["pedInteraction"])
		dgsSetAlpha(gLabel["pedInteraction"],1)
		dgsLabelSetColor(gLabel["pedInteraction"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["pedInteraction"],"top")
		dgsLabelSetHorizontalAlign(gLabel["pedInteraction"],"left",false)
		dgsSetFont(gLabel["pedInteraction"],"default-bold-small")
		
		gLabel["pedInteraction2"] = dgsCreateLabel(8,137,39,18,"Bietet:",false,gWindow["pedInteraction"])
		dgsLabelSetColor(gLabel["pedInteraction2"],0,200,0)
		dgsLabelSetVerticalAlign(gLabel["pedInteraction2"],"top")
		dgsLabelSetHorizontalAlign(gLabel["pedInteraction2"],"left",false)
		dgsSetFont(gLabel["pedInteraction2"],"default-bold-small")
		gLabel["pedInteraction3"] = dgsCreateLabel(141,137,49,18,"Fordert:",false,gWindow["pedInteraction"])
		dgsLabelSetColor(gLabel["pedInteraction3"],200,00,0)
		dgsLabelSetVerticalAlign(gLabel["pedInteraction3"],"top")
		dgsLabelSetHorizontalAlign(gLabel["pedInteraction3"],"left",false)
		dgsSetFont(gLabel["pedInteraction3"],"default-bold-small")
		gLabel["pedInteractionOffers"] = dgsCreateLabel(23,156,89,35,"",false,gWindow["pedInteraction"])
		dgsLabelSetColor(gLabel["pedInteractionOffers"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["pedInteractionOffers"],"top")
		dgsLabelSetHorizontalAlign(gLabel["pedInteractionOffers"],"left",false)
		dgsSetFont(gLabel["pedInteractionOffers"],"default-bold-small")
		gLabel["pedInteractionNeeds"] = dgsCreateLabel(156,154,89,35,"",false,gWindow["pedInteraction"])
		dgsLabelSetColor(gLabel["pedInteractionNeeds"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["pedInteractionNeeds"],"top")
		dgsLabelSetHorizontalAlign(gLabel["pedInteractionNeeds"],"left",false)
		dgsSetFont(gLabel["pedInteractionNeeds"],"default-bold-small")
		
		gButton["pedAgree"] = dgsCreateButton(113,197,72,35,"Zustimmen",false,gWindow["pedInteraction"])
		dgsSetAlpha(gButton["pedAgree"],1)
		dgsSetFont(gButton["pedAgree"],"default-bold-small")
		gButton["pedClose"] = dgsCreateButton(267,24,15,17,"x",false,gWindow["pedInteraction"])
		dgsSetAlpha(gButton["pedClose"],1)
		
		addEventHandler ( "onDgsMouseClickUp", gButton["pedClose"],
			function ()
				dgsSetVisible ( gWindow["pedInteraction"], false )
				showCursor ( false )
				triggerServerEvent ( "cancel_gui_server", lp )
			end,
		false )
		addEventHandler ( "onDgsMouseClickUp", gButton["pedAgree"],
			function ()
				dgsSetVisible ( gWindow["pedInteraction"], false )
				showCursor ( false )
				triggerServerEvent ( "cancel_gui_server", lp )
				triggerServerEvent ( "agreeWithPed", lp )
			end,
		false )
	end
	if typ == "car" then
		typ = "carseller"..math.random(1,3)
	end
	local text = npcTexts[typ]
	dgsSetText ( gLabel["pedInteraction"], text )
	dgsSetText ( gLabel["pedInteractionOffers"], item )
	dgsSetText ( gLabel["pedInteractionNeeds"], price )
end
addEvent ( "showPedInteraction", true )
addEventHandler ( "showPedInteraction", getRootElement(), showPedInteraction_func )