
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

function showCustomRadioGUI ()

	gWindow["radioOptions"] = dgsCreateWindow(screenwidth/2-317/2,120,317,234,"Radiosender",false)
	dgsSetAlpha(gWindow["radioOptions"],1)
	gGrid["radioSenders"] = dgsCreateGridList(9,24,159,200,false,gWindow["radioOptions"])
	dgsGridListSetSelectionMode(gGrid["radioSenders"],0)
	gColumn["radioNames"] = dgsGridListAddColumn(gGrid["radioSenders"],"Name",0.8)
	dgsSetAlpha(gGrid["radioSenders"],1)
	
	gButton["deleteRadio"] = dgsCreateButton(172,95,65,33,"Loeschen",false,gWindow["radioOptions"])
	dgsSetAlpha(gButton["deleteRadio"],1)
	dgsSetFont(gButton["deleteRadio"],"default-bold-small")
	gButton["addRadio"] = dgsCreateButton(241,95,65,33,"Adden",false,gWindow["radioOptions"])
	dgsSetAlpha(gButton["addRadio"],1)
	dgsSetFont(gButton["addRadio"],"default-bold-small")
	
	addEventHandler ( "onDgsMouseClickUp", gButton["deleteRadio"],
		function ()
			local toDelete = dgsGridListGetItemText ( gGrid["radioSenders"], dgsGridListGetSelectedItem ( gGrid["radioSenders"] ), 1 )
			if checkIfCustomRadioChannelExists ( toDelete ) then
				deleteCustomRadioChannel ( toDelete )
				refreshChannelList ()
				outputChatBox ( "Kanal gelöscht!", 0, 200, 0 )
			end
		end,
	false )
	addEventHandler ( "onDgsMouseClickUp", gButton["addRadio"],
		function ()
			local name = dgsGetText ( gEdit["radioName"] )
			local url  = dgsGetText ( gEdit["radioURL"] )
			if not checkIfCustomRadioChannelExists ( name ) then
				
				local result = playSound ( url )
				if not result then
					outputChatBox ( "Ungültige Adresse!", 200, 0, 0 )
					return true
				else
					stopSound ( result )
				end
				
				result = saveNewCustomRadioChannel ( name, url )
				refreshChannelList ()
				if result then
					outputChatBox ( "Kanal hinzugefügt!", 0, 200, 0 )
				else
					outputChatBox ( "Ungültiger Name!", 200, 0, 0 )
				end
			else
				outputChatBox ( "Der Sender ist bereits auf der Liste!", 0, 200, 0 )
			end
		end,
	false )
	
	gEdit["radioName"] = dgsCreateEdit(172,147,136,29,"",false,gWindow["radioOptions"])
	dgsSetAlpha(gEdit["radioName"],1)
	gEdit["radioURL"] = dgsCreateEdit(172,191,131,29,"",false,gWindow["radioOptions"])
	dgsSetAlpha(gEdit["radioURL"],1)
	
	gLabel[1] = dgsCreateLabel(170,23,144,71,"Hier kannst du Adressen\nvon Webradios wie z.B.\nTechnobase hinzufuegen,\nso dass sie im Auto\nverfügbar sind.",false,gWindow["radioOptions"])
	dgsSetAlpha(gLabel[1],1)
	dgsLabelSetColor(gLabel[1],200,200,0)
	dgsLabelSetVerticalAlign(gLabel[1],"top")
	dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
	dgsSetFont(gLabel[1],"default-bold-small")
	gLabel[2] = dgsCreateLabel(173,130,31,16,"Name:",false,gWindow["radioOptions"])
	dgsSetAlpha(gLabel[2],1)
	dgsLabelSetColor(gLabel[2],255,255,255)
	dgsLabelSetVerticalAlign(gLabel[2],"top")
	dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
	dgsSetFont(gLabel[2],"default-bold-small")
	gLabel[3] = dgsCreateLabel(173,176,31,16,"URL:",false,gWindow["radioOptions"])
	dgsSetAlpha(gLabel[3],1)
	dgsLabelSetColor(gLabel[3],255,255,255)
	dgsLabelSetVerticalAlign(gLabel[3],"top")
	dgsLabelSetHorizontalAlign(gLabel[3],"left",false)
	dgsSetFont(gLabel[3],"default-bold-small")
	
	refreshChannelList ()
end

function refreshChannelList ()

	dgsGridListClear ( gGrid["radioSenders"] )
	local channels = getCustomRadioChannels ()
	local row
	for key, index in pairs ( channels ) do
		row = dgsGridListAddRow ( gGrid["radioSenders"] )
		dgsGridListSetItemText ( gGrid["radioSenders"], row, gColumn["radioNames"], key, false, false )
	end
end