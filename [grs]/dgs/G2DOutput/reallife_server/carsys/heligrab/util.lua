
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

_DEBUG = false
_DEBUG_DRAW_HANG_LINES = false
_DEBUG_DRAW_HANG_DATA = false

function debugOutput(s)
	if _DEBUG then
		local source = ""
		local line = ""
		
		for title, info in pairs(debug.getinfo(2, "lS")) do
			if tostring(title) == "source" then
				local s, e = tostring(info):find("\\mods\\deathmatch\\resources\\", 0, true)
				
				if s and e then
					source = tostring(info):sub(e)
				end
			elseif tostring(title) == "currentline" then
				line = tostring(info)
			end
		end	

		outputDebugString(source..":"..line..": Debug: " .. s, 3)
	end
end