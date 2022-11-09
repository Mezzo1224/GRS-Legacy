------------------------------
-------- Urheberrecht --------
------- by [LA]Leyynen -------
------------ 2012 ------------
------------------------------
inNoDMZone = false
local x, y = guiGetScreenSize()
local sx, sy = x/2560, y/1440
local FrontSize = sy*1.2 
local greenzones = { 
	[1] = { x = -2016.5999755859, y = 78.300003051758, width = 102.5, height = 160.1 }, -- Bahnhof
	[2] = { x = -1781.6999511719, y = 915.29998779297, width =  57.6999511719, height = 55 } -- rathhaus
	
}
local colCuboids = {}

addEventHandler ("onClientResourceStart", resourceRoot, function()
	for i=1, #greenzones do
		createRadarArea ( greenzones[i].x, greenzones[i].y, greenzones[i].width, greenzones[i].height, 0, 255, 0, 127, localPlayer )
		colCuboids[i] = createColCuboid ( greenzones[i].x, greenzones[i].y, -50, greenzones[i].width, greenzones[i].height, 7500)
		setElementID (colCuboids[i], "greenzoneColshape")
		addEventHandler ( "onClientColShapeHit", colCuboids[i], startGreenZone )
		addEventHandler ( "onClientColShapeLeave", colCuboids[i], stopGreenZone )
	end
end )


function startGreenZone (hitElement, matchingDimension)
	if hitElement == localPlayer and matchingDimension then
		newInfobox ( "Du hast eine Schutzzone betreten!", 2 )
		vioClientSetElementData ( "nodmzone", 1 )
		toggleControl ("fire", false)
		toggleControl ("next_weapon", false)
		toggleControl ("previous_weapon", false)
		toggleControl ("aim_weapon", false)
		toggleControl ("vehicle_fire", false)
		setPedDoingGangDriveby ( hitElement, false )
		setPedWeaponSlot( hitElement, 0 )
		renderWarn(true)
	end
end

function stopGreenZone (leaveElement, matchingDimension)
	if leaveElement == localPlayer and matchingDimension then
		newInfobox ( "Du hast die Schutzzone verlassen!",2 )
		vioClientSetElementData ( "nodmzone", 0 )
		toggleControl ("fire", true)
		toggleControl ("next_weapon", true)
		toggleControl ("previous_weapon", true)
		toggleControl ("aim_weapon", true)
		toggleControl ("vehicle_fire", true)
		renderWarn(false)
	end
end

addEventHandler ( "onClientPlayerSpawn", localPlayer, function ( )
	for i=1, #colCuboids do
		if isElementWithinColShape ( source, colCuboids[i] ) then
			startGreenZone ( source, true )
		end
	end
end )


addEventHandler ( "onClientPlayerVehicleExit", localPlayer, function ( )
	setPedWeaponSlot ( localPlayer, 0 )
end )

function drawWarn ()
	if 	hud == "on" then
		dxDrawLine(2129*sx, 377*sy, 2129*sx, 426*sy, tocolor(0, 0, 0, 255), 1, false)
		dxDrawLine(2550*sx, 377*sy, 2129*sx, 377*sy, tocolor(0, 0, 0, 255), 1, false)
		dxDrawLine(2129*sx, 426*sy, 2550*sx, 426*sy, tocolor(0, 0, 0, 255), 1, false)
		dxDrawLine(2550*sx, 426*sy, 2550*sx, 377*sy, tocolor(0, 0, 0, 255), 1, false)
		dxDrawRectangle(2130*sx, 378*sy, 420*sx, 48*sy, tocolor(255, 0, 0, 109), false)
		dxDrawText("Du befindest dich in einer NO-DM Zone, jegliche Form von Deathmatch\n                                                     ist untersagt.", 2140*sx, 384*sy, 2488*sx, 416*sy, tocolor(255, 255, 255, 255), FrontSize, "default-bold", "left", "top", false, false, false, false, false)
	else
		dxDrawLine(2129*sx, 18*sy, 2129*sx, 67*sy, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(2550*sx, 18*sy, 2129*sx, 18*sy, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(2129*sx, 67*sy, 2550*sx, 67*sy, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(2550*sx, 67*sy, 2550*sx, 18*sy, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(2130*sx, 19, 420*sx, 48*sy, tocolor(255, 0, 0, 109), false)
        dxDrawText("Du befindest dich in einer NO-DM Zonem, jegliche Form von Deathmatch\n                                                     ist untersagt.", 2140*sx, 25*sy, 2488*sx, 57*sy, tocolor(255, 255, 255, 255), FrontSize, "default-bold", "left", "top", false, false, false, false, false)
	end
end

function renderWarn(value)
	if value == true then
		if getSetting (23) == 1 then
			addEventHandler ( "onClientRender", root, drawWarn )
		end
		inNoDMZone = true
	else
		removeEventHandler ( "onClientRender", root, drawWarn )
		inNoDMZone = false
	end
end