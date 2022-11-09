
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

-------------------------
------- (c) 2009 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function radioenter ( player )

	if player == getLocalPlayer() then
		if not vioClientGetElementData ( "favchannel" ) then
			setRadioChannel ( 0 )
		else
			setRadioChannel ( tonumber ( vioClientGetElementData ( "favchannel" ) ) )
		end
		setPlayerHudComponentVisible ( "radio", true )
	end
end
addEventHandler ( "onClientVehicleEnter", getRootElement(), radioenter )


function radioleave ( player )

	if player == getLocalPlayer() then
		setPlayerHudComponentVisible ( "radio", false )
	end
end
addEventHandler ( "onClientVehicleExit", getRootElement(), radioleave )