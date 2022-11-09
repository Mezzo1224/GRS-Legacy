
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

function hideHorseshoeArray_func ( horseShoeArray )
	for i=1, #horseShoeArray do
		setElementDimension ( horseShoeArray[i], 2 )
	end
end
addEvent ( "hideHorseshoeArray", true )
addEventHandler ( "hideHorseshoeArray", getRootElement(), hideHorseshoeArray_func )


function hideHorseshoe_func ( horseShoe )
	setElementDimension ( horseShoe, 2 )
end
addEvent ( "hideHorseshoe", true )
addEventHandler ( "hideHorseshoe", getRootElement(), hideHorseshoe_func )