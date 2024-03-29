﻿carhouseTextToRender = ""

function showCarhouseInfo_func ( text )

	setInvulnerable ( true )
	setMoveable ( false )
	carhouseTextToRender = text
	fadeCamera ( false, 1, 0, 0, 0 )
	addEventHandler ( "onClientRender", getRootElement(), drawCarhouseName )
	setTimer ( 
		function ()
			fadeCamera ( true )
		end,
	3000, 1 )
end
addEvent ( "showCarhouseInfo", true )
addEventHandler ( "showCarhouseInfo", getRootElement(), showCarhouseInfo_func )

function drawCarhouseName ()

	dxDrawText ( carhouseTextToRender, screenwidth-450+2, screenheight-150+2, 2000, 1006, tocolor ( 0, 0, 0, 255 ), 2.5, "pricedown", "left", "top", false, false, true )
	dxDrawText ( carhouseTextToRender, screenwidth-450, screenheight-150, 2000, 1006, tocolor ( 255, 255, 0, 255 ), 2.5, "pricedown", "left", "top", false, false, true )
end

function leaveCarhouse_func ()

	removeEventHandler ( "onClientRender", getRootElement(), drawCarhouseName )
	setInvulnerable ( false )
	fadeCamera ( false, 1, 0, 0, 0 )
	setTimer ( fadeCamera, 1000, 1, true )
	carhouseInfoTextAdded = false
	removeEventHandler ( "onClientRender", getRootElement(), drawCarhouseInfo )
end
addEvent ( "leaveCarhouse", true )
addEventHandler ( "leaveCarhouse", getRootElement(), leaveCarhouse_func )

function displayCarData_func ( name, price, info )

	removeEventHandler ( "onClientRender", getRootElement(), drawCarhouseName )
	carhouseTextToRender = name.."\n"..price.." $".."\n"..info
	if not carhouseInfoTextAdded then
		carhouseInfoTextAdded = true
		addEventHandler ( "onClientRender", getRootElement(), drawCarhouseInfo )
	end
end
addEvent ( "displayCarData", true )
addEventHandler ( "displayCarData", getRootElement(), displayCarData_func )

function drawCarhouseInfo ()

	dxDrawText ( carhouseTextToRender, screenwidth - 250, screenheight - 135, 2000, 1006, tocolor ( 0, 0, 0, 255 ), 1, "bankgothic", "left", "top", false, false, true )
	dxDrawText ( carhouseTextToRender, screenwidth - 249, screenheight - 134, 2000, 1006, tocolor ( 255, 150, 0, 255 ), 1, "bankgothic", "left", "top", false, false, true )

	local x, y = guiGetScreenSize()
	local sx, sy = x/2560, y/1440
	if tonumber(getElementData( getLocalPlayer(), "coopID")) > 0 and  tonumber(getElementData(getLocalPlayer(), "coopRang")) >= 3 then
		dxDrawText("Mit der Taste \" R-Shift \" kannst du das Fahrzeug für dein Unternehmen kaufen.\nEs kostet 19% weniger.", 860*sx, 5*sy, 1734*sx, 70*sy, tocolor(239, 99, 5, 255), 2.00, "default", "left", "top", false, false, true, false, false)
        dxDrawRectangle(855*sx, 0*sy, 889*sx, 70*sy, tocolor(3, 1, 0, 61), false)
	end
end