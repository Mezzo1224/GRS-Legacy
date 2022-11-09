
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

curMaxSpeed = false

function limit_func ( cmd, amount )
	if vioClientGetElementData ( "imzugjob" ) or vioClientGetElementData ( "imtramjob" ) then return false end
	local amount = tonumber ( amount )
	if amount then
		local amount = math.abs ( amount )
		curMaxSpeed = amount
		curMaxSpeed = curMaxSpeed*0.00464
		if not isTimer ( curMaxSpeedTimer ) then
			curMaxSpeedTimer = setTimer ( fixSpeed, 50, -1 )
		end
		outputChatBox ( "Maximale Geschwindigkeit auf "..amount.." km/h gesetzt - tippe /stoplimit, um es zu entfernen.", 125, 0, 0 )
	else
		outputChatBox ( "Bitte gib eine gueltige km/h Zahl an!", 125, 0, 0 )
	end
end
addCommandHandler ( "limit", limit_func )

function stoplimit_func ()

	if not curMaxSpeed then
		if not vioClientGetElementData ( "imzugjob" ) and not vioClientGetElementData ( "imtramjob" ) then
			outputChatBox ( "Du hast momentan den Tempomat nicht aktiviert - tippe /limit [km/h], um ihn zu aktivieren!", 125, 0, 0 )
		end
	else
		curMaxSpeed = false
		killTimer ( curMaxSpeedTimer )
		outputChatBox ( "Tempomat wurde entfernt!", 0, 125, 0 )
	end
end
addCommandHandler ( "stoplimit", stoplimit_func )

function fixSpeed ()

	local veh = getPedOccupiedVehicle(lp)
	if veh then
		if isVehicleOnGround ( veh ) and getPedOccupiedVehicleSeat ( lp ) == 0 then
			local vx, vy, vz = getElementVelocity(veh)
			local speed = math.sqrt(vx^2 + vy^2 + vz^2)
			if speed > curMaxSpeed then
				setElementVelocity ( veh, vx*0.97, vy*0.97, vz*0.97 )
			end
		end
	end
end

function blitzer ()

	local img = dgsCreateImage ( 0, 0, 1, 1, "images/colors/c_white.jpg", true, nil )
	dgsSetAlpha ( img, 0 )
	setTimer ( blitzerIMGAlpha, 50, 10, img, true )
end
addEvent ( "blitzer", true )
addEventHandler ( "blitzer", getRootElement(), blitzer )

function blitzerIMGAlpha ( img, lower )

	if lower then
		dgsSetAlpha ( img, dgsGetAlpha ( img ) + 0.1 )
		if dgsGetAlpha ( img ) >= 1 then
			setTimer ( blitzerIMGAlpha, 50, 10, img, false )
		end
	else
		dgsSetAlpha ( img, dgsGetAlpha ( img ) - 0.1 )
		if dgsGetAlpha ( img ) == 0 then
			destroyElement ( img )
		end
	end
end

function showBlitzerGUI ( kmh, tomuch, strafe, points )

	gImage["ticket"] = dgsCreateImage(screenwidth/2-354/2,0,354,187,"images/colors/c_white.jpg",false)
	gImage[2] = dgsCreateImage(13,45,103,101,"images/gui/police.png",false,gImage["ticket"])
	gImage[3] = dgsCreateImage(0,0,354,17,"images/colors/c_red.jpg",false,gImage["ticket"])
	gLabel[1] = dgsCreateLabel(0,20,354,18,"STRAFZETTEL",false,gImage["ticket"])
	dgsLabelSetColor(gLabel[1],0,0,0)
	dgsLabelSetVerticalAlign(gLabel[1],"top")
	dgsLabelSetHorizontalAlign(gLabel[1],"center",false)
	dgsSetFont(gLabel[1],"default-bold-small")
	gLabel[2] = dgsCreateLabel(130,42,102,110,"Geschwindigkeit:\n\nÜberschreitung:\n\nStrafe:\n\nSTVO-Punkte:",false,gImage["ticket"])
	dgsLabelSetColor(gLabel[2],0,0,0)
	dgsLabelSetVerticalAlign(gLabel[2],"top")
	dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
	dgsSetFont(gLabel[2],"default-bold-small")
	gImage[4] = dgsCreateImage(0,170,354,17,"images/colors/c_red.jpg",false,gImage["ticket"])
	gLabel[3] = dgsCreateLabel(1,1,352,16,"Leertaste zum ausblenden",false,gImage[4])
	dgsLabelSetColor(gLabel[3],255,255,255)
	dgsLabelSetVerticalAlign(gLabel[3],"top")
	dgsLabelSetHorizontalAlign(gLabel[3],"center",false)
	gLabel[4] = dgsCreateLabel(131,42,203,110,kmh.." km/h\n\n"..tomuch.." km/h\n\n"..strafe.." $\n\n+"..points.." = "..getElementData ( lp, "stvo_punkte" ),false,gImage["ticket"])
	dgsLabelSetColor(gLabel[4],0,0,0)
	dgsLabelSetVerticalAlign(gLabel[4],"top")
	dgsLabelSetHorizontalAlign(gLabel[4],"right",false)
	dgsSetFont(gLabel[4],"default-bold-small")
	
	bindKey ( "space", "down", hideBlitzerGUI )
end
addEvent ( "showBlitzerGUI", true )
addEventHandler ( "showBlitzerGUI", getRootElement(), showBlitzerGUI )

function hideBlitzerGUI ()

	destroyElement ( gImage["ticket"] )
	unbindKey ( "space", "down", hideBlitzerGUI )
end