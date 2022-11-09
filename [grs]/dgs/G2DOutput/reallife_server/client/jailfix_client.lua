
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

function jailKeyDisable ()

	if getElementData ( lp, "jailtime" ) > 0 or getElementData ( lp, "prison" ) > 0 then
		toggleControl ( "enter_exit", false )
		toggleControl ( "fire", false )
		toggleControl ( "jump", false )
		toggleControl ( "action", false )
		setTimer ( jailKeyDisable, 1000, 1 )
	end
end
addEvent ( "jailKeyDisable", true )
addEventHandler ( "jailKeyDisable", getRootElement(), jailKeyDisable )