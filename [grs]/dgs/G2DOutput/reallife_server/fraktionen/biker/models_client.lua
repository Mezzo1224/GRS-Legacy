
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

txd = engineLoadTXD ( "fraktionen/biker/skins/wmycr.txd" )
engineImportTXD ( txd, 100 )
txd = engineLoadTXD ( "fraktionen/biker/skins/bikera.txd" )
engineImportTXD ( txd, 247 )
txd = engineLoadTXD ( "fraktionen/biker/skins/bikerb.txd" )
engineImportTXD ( txd, 248 )