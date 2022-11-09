
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

-- Stuntcamera --
if not doesClientDataExists ( "stuntcam" ) then
	setClientData ( "stuntcam", "active" )
end
stuntCameraActive = ( getClientData ( "stuntcam" ) == "active" )
-- Radiosender --
if not doesClientDataExists ( "favradio" ) then
	setClientData ( "favradio", 3 )
end
favRadioChannel = getClientData ( "favradio" )
-- Radio mit Fahrer teilen --
--[[if not doesClientDataExists ( "shareRadio" ) then
	setClientData ( "shareRadio", "active" )
end
shareRadioChannel = ( getClientData ( "shareRadio" ) == "active" )]]