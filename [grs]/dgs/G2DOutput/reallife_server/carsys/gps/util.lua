
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

-- #######################################
-- ## Name: 	Cursor				    ##
-- ## Author:	Stivik					##
-- #######################################

function table.find(tab, value)
	for k, v in pairs(tab) do
		if v == value then
			return k
		end
	end
	return nil
end

function isCursorOverRectangle (x, y, w, h)
	local cX, cY = getCursorPosition()
	if isCursorShowing() then
		return ((cX*screenW > x) and (cX*screenW < x + w)) and ( (cY*screenH > y) and (cY*screenH < y + h));
	else
		return false;
	end
end