--rathauspickup_1 = createPickup ( -2764.5270996094, 375.37478637695, 6.3415489196777, 3, 1239, 0)

jobchoosepickup = createPickup ( 362.39953613281, 180.4635925293, 1008.0034790039, 3, 1210, 50)
setElementInterior (jobchoosepickup, 3, 362.39953613281, 180.4635925293, 1008.0034790039)



createMarker (  -1754.0999755859, 963.90002441406, 23.889999389648, "cylinder", 1, getColorFromString ( "#FF000099" ) )
cityHallEnter = createMarker ( -1754.1999511719, 963.70001220703, 24.3, "corona", 1, 0, 0, 0, 0 )
cityHallExit = createMarker ( 389.89999389648, 173.82061767578, 1007.3699951172+.5, "corona", 1, 0, 0, 0, 0 )
cityHallExitOptic = createMarker ( 389.89999389648, 173.82061767578, 1007.3699951172, "cylinder", 1, getColorFromString ( "#FF000099" ) )
setElementInterior ( cityHallExit, 3 )
setElementInterior ( cityHallExitOptic, 3 )


function jobchoosepickup_func (player)

	setElementFrozen ( player, true )
    setTimer ( setElementFrozen, 100, 1, player, false )
	triggerClientEvent ( player, "showJobGui", getRootElement() )
	showCursor ( player, true )
	setElementClicked ( player, true )
end
addEventHandler ( "onPickupHit", jobchoosepickup, jobchoosepickup_func )

function pickedUpRathaus (source, dim)

	if getPedOccupiedVehicle(source) == false and dim then
		fadeElementInterior ( source, 3, 388.5, 173.82061767578, 1008.032043457, 90 )
		toggleControl ( source, "fire", false )
		toggleControl ( source, "enter_exit", false )
		vioSetElementData(source,"nodmzone", 1)
	end
end
addEventHandler ( "onMarkerHit", cityHallEnter, pickedUpRathaus )

--rathauspickup_2 = createPickup ( 387.705, 174.3994, 1008.3828, 3, 1239, 0)
--setElementInterior (rathauspickup_2, 3)

function pickedUpRathaus2 (source)

   fadeElementInterior ( source, 0,-1754.3000488281, 961.09997558594, 24.89999961853, 180 )
 --  toggleControl ( source, "fire", true )
--   toggleControl ( source, "enter_exit", true )
   
end
addEventHandler ( "onMarkerHit", cityHallExit, pickedUpRathaus2 )

rathausmarker = createMarker ( 362.45562744141, 173.81, 1007.5, "corona", 2, 125, 0, 0, 0 )
setElementInterior (rathausmarker, 3)
rathausmarker2 = createMarker ( 362.45562744141, 173.81, 1007, "cylinder", 1, 125, 0, 0 )
setElementInterior (rathausmarker2, 3)

createcoopmarker = createMarker (  358.5595703125, 164.8818359375, 1007.3828125,"corona", 2, 125, 0, 0, 0 )
setElementInterior (createcoopmarker, 3)
createcoopmarker2 = createMarker (  358.5595703125, 164.8818359375, 1007.3828125,  "cylinder", 1, 125, 0, 0 )
setElementInterior (createcoopmarker2, 3)


function createcoop_func (player)
   
	triggerClientEvent(player, "showCoopCreateMenu", player, cooperationCreateCosts)

end
addEventHandler ( "onMarkerHit", createcoopmarker, createcoop_func )

function rathausmarker_func (player)
   
    setElementFrozen ( player, true )
    setTimer ( setElementFrozen, 100, 1, player, false )
	triggerClientEvent ( player, "ShowRathausMenue", getRootElement() )
	showCursor ( player, true )
	setElementClicked ( player, true )
end
addEventHandler ( "onMarkerHit", rathausmarker, rathausmarker_func )

rathausped = createPed(141, 359.7138671875, 173.625765625, 1008.38934)
setElementInterior (rathausped, 3)
setElementRotation(rathausped, 0,0,280)

rathausped2 = createPed(147, 356.296875, 164.75390625, 1008.3762207031)
setElementRotation(rathausped2, 0, 0, 272.49530029297)
setElementInterior (rathausped2, 3)
