
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

alcoholPrices = {
 ["Bier"]=5,
 
 ["Wein"]=15,
 
 ["Appletini"]=25, 
 ["Whiskey"]=30,
 ["Wodka"]=35,
 
 ["TNT Whiskey"]=75
 }
 
alcoholSorts = {
 ["Bier"]=1,
 
 ["Wein"]=2,
 
 ["Appletini"]=3, 
 ["Whiskey"]=3,
 ["Wodka"]=3,
 
 ["TNT Whiskey"]=5
 }

alcoholGramma = {
 ["Bier"]="e Flasche Bier",
 
 ["Wein"]="Glass Wein",
 
 ["Appletini"]="en Appletini",
 ["Whiskey"]="en Whiskey",
 ["Wodka"]="en Wodka",
 
 ["TNT Whiskey"]="en TNT-Whiskey"
 }
