
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

gWindow = {}
gWindows = {}
gButton = {}
gButtons = {}
gLabel = {}
gLabels = {}
gGrid = {}
gColumn = {}
gProgress = {}
gEdit = {}
gRadio = {}
gMemo = {}
gCheckbox = {}
gCheck = {}
gRow = {}
gImage = {}
gTab = {}
gTabPanel = {}
gNumberfield = {}
gNumberField = {}
gScroll = {}

screenwidth, screenheight = dgsGetScreenSize ()

lp = getLocalPlayer()

timers = {}

setWaterColor ( 0, 50, 125, 150 )