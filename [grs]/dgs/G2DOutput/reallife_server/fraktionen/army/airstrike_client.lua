
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

function AirstrikeThrowDo_func ( airStrikeTrash, player )

	counter = 0
	setTimer ( AirstrikeThrowDoSingle, 250, 8, airStrikeTrash, player )
end
addEvent ( "AirstrikeThrowDo", true )
addEventHandler ( "AirstrikeThrowDo", getRootElement(), AirstrikeThrowDo_func )

function AirstrikeThrowDoSingle ( airStrikeTrash, player )

	local x, y, z = getElementPosition ( airStrikeTrash )
	counter = counter+ 1
	createProjectile ( player, 21, x, y-19, z-2, 1, nil )
	createProjectile ( player, 21, x+0.5, y-18, z-2, 1, nil )
end