
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

addEvent ( "triggeredBlacklist", true )
addEvent ( "playerInBlacklistDied", true )
addEvent ( "playerInBlacklistJoined", true )

blacklistArray = {}


addEventHandler ( "triggeredBlacklist", root, function ( array )
	blacklistArray = {}
	if array then
		for i, v in pairs ( array ) do
			blacklistArray[i] = v
		end 
	end
end )


addEventHandler ( "playerInBlacklistDied", root, function ( name )
	blacklistArray[name] = nil
end )


addEventHandler ( "playerInBlacklistJoined", root, function ( name )
	blacklistArray[name] = true
end )