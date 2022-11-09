
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

local lastdeagleshot = 0
local gotdeagle = false
toggleControl ( "fire", true )


function stopFastShotOnDeagleEvent ( )
	if lastdeagleshot + 700 >= getTickCount() then
		toggleControl ( "fire", false )
		lastdeagleshot = getTickCount() + 560000/(getTickCount()-lastdeagleshot)
	else
		lastdeagleshot = getTickCount()
	end
end


function stopFastShotOnDeagleBinded ( )
	if lastdeagleshot + 700 < getTickCount() then
		toggleControl ( "fire", true )
	end
end


addEventHandler ( "onClientPlayerWeaponSwitch", root, function ( previous, current )	
	if getPedWeapon ( localPlayer, current ) == 24 then
		addEventHandler ( "onClientPlayerWeaponFire", localPlayer, stopFastShotOnDeagleEvent )
		bindKey ( "fire", "both", stopFastShotOnDeagleBinded )
		gotdeagle = true
	elseif gotdeagle then
		removeEventHandler ( "onClientPlayerWeaponFire", localPlayer, stopFastShotOnDeagleEvent )
		unbindKey ( "fire", "both", stopFastShotOnDeagleBinded )
		toggleControl ( "fire", true )
		gotdeagle = false
	end
end )
