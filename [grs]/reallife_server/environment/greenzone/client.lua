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
	if hud == "off" then
        paddingY = -280
    else
        paddingY = 0
    end
    dxDrawRectangle(2131, 283 + paddingY, 419, 61, tocolor(123, 0, 0, 228), false)
    dxDrawText("Du befindest dich in einer Greenzone.\nDeathmatch ist absolut untersagt.", 2224, 293 + paddingY, 2494, 328, tocolor(255, 255, 255, 255), 1.20, "default-bold", "left", "top", false, false, false, false, false)
    dxDrawImage(2141, 283 + paddingY, 73, 59, "images/infobox/prohibited.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end

function renderWarn(value)
	if value == true then
	--	if getSetting (23) == 1 then
			addEventHandler ( "onClientRender", root, drawWarn )
	--	end
		inNoDMZone = true
	else
		removeEventHandler ( "onClientRender", root, drawWarn )
		inNoDMZone = false
	end
end