local element = {}

local liftmoving = false
local liftvar = 1

function attachElementsInCorrectWay ( element1, element2, bool )
	
	local x1, y1, z1 = getElementPosition ( element1 )
	local rx1, ry1, rz1 = getElementRotation ( element1 )
	local x2, y2, z2 = getElementPosition ( element2 )
	local rx2, ry2, rz2 = getElementRotation ( element2 )
	if(bool == true) then 
		attachElements ( element1, element2, x1-x2, y1-y2, z1-z2+0.5, rx1-rx2, ry1-ry2, rz1-rz2 )
	else
		attachElements ( element1, element2, x1-x2, y1-y2, z1-z2, rx1-rx2, ry1-ry2, rz1-rz2 )
	end
end

-- LIFT --

element["lift"] = createObject(3095, -2707.4086914063, 627.94787597656, 12.949222564697, 0, 0, 0)
element["liftf1"] = createObject(983, -2702.9228515625, 627.70568847656, 14.188142776489, 0, 0, 0)
element["liftf2"] = createObject(983, -2707.4538574219, 623.48986816406, 14.188142776489, 0, 0, 270)
element["liftcol"]= createColSphere(-2707.4086914063, 627.94787597656, 12.949222564697, 5.5)

attachElementsInCorrectWay(element["liftf1"], element["lift"])
attachElementsInCorrectWay(element["liftf2"], element["lift"])
attachElements(element["liftcol"], element["lift"])

local lift_pos = {
	[1] = {-2707.4086914063, 627.94787597656, 12.949222564697},
	[2] = {-2707.4086914063, 627.94787597656, 32.824119567871},
	[3] = {-2707.4086914063, 627.94787597656, 65.659103393555},
}



addCommandHandler("mlift", function(thePlayer, cmd, var)
	local x, y, z = getElementPosition(thePlayer)
	local x2, y2, z2 = getElementPosition(element["lift"])
	if(getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) > 100) then return end
	var = tonumber(var)
if(isMedic(thePlayer) or isMechaniker(thePlayer) or isGatePermitted(thePlayer)) then
	if(var == 1) or (var == 2) or (var == 3) then
		if(isMedic(thePlayer) or isMechaniker(thePlayer)) then
			if(liftmoving == true) then return end
			if(liftvar == var) then return end
			liftvar = var
			liftmoving = true
			local x, y, z = lift_pos[var][1], lift_pos[var][2], lift_pos[var][3]
			moveObject(element["lift"], 7500, x, y, z, 0, 0, 0, "InOutQuad")
			setTimer(function()
				liftmoving = false
			end, 7500, 1)
			--[[
			for index, ele in pairs(getElementsWithinColShape(element["liftcol"], "vehicle")) do
				attachElementsInCorrectWay(ele, element["lift"], true)
				setTimer(function()
					detachElements(ele)
				end, 5000, 1)
			end]]
		end
	else
		outputChatBox("Nutze: /mlift [1-3]", thePlayer, 175, 0, 0)
	end
else
	outputChatBox("Du bist kein Sanitäter/Mechaniker!", thePlayer, 175, 0, 0)
end
end)

-- SCHRANKEN --

element["schranke1"] = createObject(968, -2670.1000976563, 578.40002441406, 14.275009155273, 0, 90, 0)
element["schranke2"] = createObject(968, -2612.4885253906, 596.18243408203, 14.304552078247, 0, 90, 270)
element["schranke3"] = createObject(968, -2612.0163574219, 627.93658447266, 14.204551696777, 0, 90, 270)

local svar = {}
svar[1] = false
svar[2] = false
svar[3] = false

local smoving = {}
smoving[1] = false
smoving[2] = false
smoving[3] = false

for i = 1, #svar, 1 do
	addCommandHandler("mv", function(thePlayer)
		if(isMedic(thePlayer) or isMechaniker(thePlayer) or isOnDuty(thePlayer)) then
			local x, y, z = getElementPosition(element["schranke"..i])
			local x2, y2, z2 = getElementPosition(thePlayer)
			if(getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) > 10) then return end
			if(smoving[i] == true) then return end
			smoving[i] = true
			if(svar[i] == false) then
				svar[i] = true
				moveObject(element["schranke"..i], 1500, x, y, z, 0, -90, 0, "OutBounce")
			else
				svar[i] = false
				moveObject(element["schranke"..i], 1500, x, y, z, 0, 90, 0, "OutBounce")
			end
			setTimer(function()
				smoving[i] = false
			end, 1500, 1)
		end
	end)
end

