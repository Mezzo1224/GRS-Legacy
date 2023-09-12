local tutBubbleData = {}

function vehicleHelpEnter ()
	if getElementData ( lp, "playingtime" ) <= 240 then
		infobox_start_func ( "Drücke \"X\" und\n\"L\", um den\nMotor bzw. das\nLicht ein/aus\nzu schalten.", 7500, 255, 255, 255 )
	else
		removeEventHandler ( "onClientPlayerVehicleEnter", localPlayer, vehicleHelpEnter ) 
	end
end
addEventHandler ( "onClientPlayerVehicleEnter", localPlayer, vehicleHelpEnter )

function createTutorialBubble ( x, y, z, text, maxTime, r, g, b, range )

	if not b then
		r, g, b = 255, 255, 255
	end
	if not text then
		text = ""
	end
	if not maxTime then
		maxTime = 3
	end
	if not range then
		range = 3
	end
	local tutColshape = createColSphere ( x, y, z, range )
	tutBubbleData[tutColshape] = { ["text"] = text, ["r"] = r, ["g"] = g, ["b"] = b, ["max"] = maxTime }
	addEventHandler ( "onClientColShapeHit", tutColshape,
		function ( element, dim )
			if dim and element == lp then
				local text = tutBubbleData[source]["text"]
				local r = tutBubbleData[source]["r"]
				local g = tutBubbleData[source]["g"]
				local b = tutBubbleData[source]["b"]
				local maxt = tutBubbleData[source]["max"] * 60
				if maxt >= getElementData ( lp, "playingtime" ) then
					infobox ( text, 10000, r, g, b )
				end
			end
		end
	)
end

function createTutorialText (x, y, z, head, msg )
	local titel = DGS:dgsCreate3DText(x, y, z+0.3, head)
	DGS:dgsSetProperty(titel,"color",tocolor(66, 135, 245, 255))
	DGS:dgsSetProperty(titel,"textSize",{0.6, 0.6})
	DGS:dgsSetProperty(titel,"fadeDistance",3)
	DGS:dgsSetProperty(titel,"canBeBlocked", true)
	DGS:dgsSetProperty(titel,"maxDistance",13)
	DGS:dgsSetProperty(titel,"alignment",{"center","center"})

	local text = DGS:dgsCreate3DText(x, y, z, msg)
	DGS:dgsSetProperty(text,"textSize",{0.5, 0.5})
	DGS:dgsSetProperty(text,"fadeDistance",3)
	DGS:dgsSetProperty(text,"canBeBlocked", true)
	DGS:dgsSetProperty(text,"maxDistance",13)
	DGS:dgsSetProperty(text,"alignment",{"center","center"})
end
-- // Automatisieren für Bankautomaten 
function addTextToATMs ()
	setTimer ( function()
		if getElementData ( lp, "playingtime" ) <= 6000 then -- todo zu 60
			local objects = getElementsByType("object")
			for i, object in pairs(objects) do
				local model = getElementModel(object)
				if model == 2942 then
					local x, y, z = getElementPosition(object)
					createTutorialText (x, y, z+2, "Bankautomaten", "Drücke M und klicke auf den Geldautomaten, um mit ihm zu interagieren.\nEr erlaubt es dir Geld abzuheben, zu überweisen oder deine Zahlungen zu verfolgen." )
				end
			end
		end
	end, 5000, 1 )
end

createTutorialText (-1935.7763671875, 236.38671875, 35.3125, "Tuning","Nitro oder größerer Kofferraum Gefällig ?\nBei einem Tuningshop kannst du dein Fahrzeug modifizieren." )

createTutorialBubble ( -2633.6958007813, 211.23025512695, 3.4143309593201, "In der Kisten kannst du Waffen lagern, drücke M und klicken auf sie.", 5, 200, 200, 0 )
createTutorialBubble ( -2172.8569335938, 710.32220458984, 52.89062, "In der Kisten kannst du Waffen lagern, drücke M und klicken auf sie.", 5, 200, 200, 0 )
createTutorialBubble ( -700.05700683594, 943.8525390625, 11.3368101, "In der Kisten kannst du Waffen lagern, drücke M und klicken auf sie.", 5, 200, 200, 0 )
createTutorialBubble ( -1970.5015869141, -1585.2413330078, 86.7981414794, "In der Kisten kannst du Waffen lagern, drücke M und klicken auf sie.", 5, 200, 200, 0 )
createTutorialBubble ( -767.6689453125, 2419.4206542969, 156.05166625977, "In der Kisten kannst du Waffen lagern, drücke M und klicken auf sie.", 5, 200, 200, 0 )