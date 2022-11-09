
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

local lastsprint = 0								

function antiSprintbot ()				
	if lastsprint + 120 > getTickCount() then		
		toggleControl ( "sprint", false )			
	else
		toggleControl ( "sprint", true )				
		lastsprint = getTickCount()
	end				
end


function startstopAntiSprintbot ( bool )
    if bool then 
        bindKey ( "sprint", "down", antiSprintbot )
    else
		unbindKey ( "sprint", "down", antiSprintbot )
    end
end 
