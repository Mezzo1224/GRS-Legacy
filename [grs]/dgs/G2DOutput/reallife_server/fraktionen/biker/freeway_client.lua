
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

function formationSpeedUp ()

	setPedCanBeKnockedOffBike ( lp, false )
	local veh = getPedOccupiedVehicle ( lp )
	if veh then
		if getElementModel ( veh ) == 463 and getElementData ( lp, "fraktion" ) == 9 then
			if getPedControlState ( lp, "accelerate" ) then
				local vx, vy, vz = getElementVelocity ( veh )
				local speed = math.sqrt ( vx ^ 2 + vy ^ 2 + vz ^ 2 ) / 0.00464
				if speed <= 50 then
					--setElementVelocity ( veh, vx * 1.003 * 1.003, vy * 1.003 * 1.003, vz * 1.003 * 1.003 )
				elseif speed <= 100 then
					setElementVelocity ( veh, vx * 1.002 * 1.002, vy * 1.002 * 1.002, vz * 1.002 * 1.002 )
				elseif speed <= 150 then
					setElementVelocity ( veh, vx * 1.002 * 1.002, vy * 1.002 * 1.002, vz * 1.002 * 1.002 )
				elseif speed <= 180 then
					setElementVelocity ( veh, vx * 1.005 * 1.005, vy * 1.005 * 1.005, vz * 1.005 * 1.005 )
				elseif speed <= 220 then
					setElementVelocity ( veh, vx * 1.007 * 1.007, vy * 1.007 * 1.007, vz * 1.007 * 1.007 )
				end
			end
			setTimer ( formationSpeedUp, 50, 1 )
			return true
		end
	end
end

--[[addEventHandler ( "onClientPlayerVehicleEnter", getRootElement(),
	function ( veh, seat )
		if veh and isElement ( veh ) and getElementModel ( veh ) == 463 and seat == 0 and getElementData ( lp, "fraktion" ) == 9 then
			setPedCanBeKnockedOffBike ( lp, false )
			formationSpeedUp ()
		end
	end
)]]
addEventHandler ( "onClientPlayerVehicleExit", getRootElement(),
	function ( veh, seat )
		if veh and isElement ( veh ) and getElementModel ( veh ) == 463 and seat == 0 and getElementData ( lp, "fraktion" ) == 9 then
			setPedCanBeKnockedOffBike ( lp, true )
		end
	end
)