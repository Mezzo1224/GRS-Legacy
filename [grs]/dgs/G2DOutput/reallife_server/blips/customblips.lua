
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

---------------BUGS-------------------
--* 1)		There's a period in between entering and exiting a vehicle whereby the camera switches its "lock on" from the ped to the vehicle or vice versa
--		During this period, It is not possible to rotate the camera, but getCameraMatrix returns the lookAt point as if it had rotated.  
--		This means the customblip rotates like crazy but the radar doesnt
--
--* 2)		showPlayerHUDComponent has the ability to hide the radar, but custom blips is not aware of this.
--		All scripts would also need to hook into customblips to notify it whenever hiding the radar
--
-- Bug #2 is most easily fixed if we get a isRadarVisible/isPlayerHUDComponentVisible function or something to that effect

local g_screenX,g_screenY = dgsGetScreenSize()
local localPlayer = getLocalPlayer()

--Radar position/size 
local rel = { 	pos_x = 0.0625,
				pos_y = 0.76333333333333333333333333333333,
				size_x = 0.15,
				size_y = 0.175,
				radar_blip_y = 0.03333333333333333333333333333333,
}

local abs = { 	pos_x = math.floor(rel.pos_x * g_screenX),
				pos_y = math.floor(rel.pos_y * g_screenY),
				size_x = math.floor(rel.size_x * g_screenX),
				size_y = math.floor(rel.size_y * g_screenY),
				radar_blip_y = math.floor(rel.radar_blip_y * g_screenY)
}
abs.half_size_x =  abs.size_x/2
abs.half_size_y =  abs.size_y/2
abs.center_x = abs.pos_x + abs.half_size_x
abs.center_y = abs.pos_y +abs.half_size_y
local minBound = 0.1*g_screenY

function getRadarScreenRadius ( angle ) --Since the radar is not a perfect ciricle, we work out the screen size of the radius at a certain angle
	return math.max(math.abs((math.sin(angle)*(abs.half_size_x - abs.half_size_y))) + abs.half_size_y,minBound)
end


function renderBlip ( blip )
	local blipX,blipY = streamedBlips[blip].x,streamedBlips[blip].y
	local width,height = streamedBlips[blip].width,streamedBlips[blip].height
	local radarScale = streamedBlips[blip].radarScale
	if not isPlayerMapVisible() then --Render to the radar
		local cameraTarget = getCameraTarget()
		local x,y,camRot
		--Are we in fixed camera mode?
		if not cameraTarget then
			local px,py,_,lx,ly = getCameraMatrix()
			x,y = px,py
			camRot = getVectorRotation(px,py,lx,ly)
		else
			x,y = getElementPosition(cameraTarget)
			local vehicle = getPedOccupiedVehicle(localPlayer)
			if ( vehicle ) then
				--Look back works on all vehicles
				if getPedControlState"vehicle_look_behind" or
				( getPedControlState"vehicle_look_left" and getPedControlState"vehicle_look_right" ) or
				--Look left/right on any vehicle except planes and helis (these rotate them)
				( getVehicleType(vehicle)~="Plane" and getVehicleType(vehicle)~="Helicopter" and 
				( getPedControlState"vehicle_look_left" or getPedControlState"vehicle_look_right" ) ) then
					camRot = -math.rad(getPedRotation(localPlayer))
				else
					local px,py,_,lx,ly = getCameraMatrix()
					camRot = getVectorRotation(px,py,lx,ly)
				end
			elseif getPedControlState"look_behind" then
				camRot = -math.rad(getPedRotation(localPlayer))
			else
				local px,py,_,lx,ly = getCameraMatrix()
				camRot = getVectorRotation(px,py,lx,ly)
			end
		end
		local toBlipRot = getVectorRotation(x,y,blipX,blipY )
		local blipRot = toBlipRot - camRot
		--Get the screen radius at that rotation
		local radius = getRadarScreenRadius ( blipRot )
		local radarRadius = getRadarRadius()
		local distance = getDistanceBetweenPoints2D ( x,y,blipX,blipY )
		if (distance <= radarRadius) then
			radius = (distance/radarRadius)*radius		
		end
		local tx = radius * math.sin(blipRot) + abs.center_x
		local ty = -radius * math.cos(blipRot) + abs.center_y	
		--
		local sx,sy  = width,height
		if radarScale then
			sx,sy = width*radarScale, height*radarScale
			setWidgetSize (blip,sx,sy)
		else
			--If the user hasnt forced a radar blip scale, we use GTA's default sizing
			local ratio = abs.radar_blip_y/height
			sx = ratio*width
			sy = abs.radar_blip_y
			setWidgetSize (blip,sx,sy)
		end
		setWidgetPosition(blip,tx-sx/2,ty-sy/2)
	else --Render to f11 map
		local minX,minY,maxX,maxY = getPlayerMapBoundingBox()
		local sizeX = maxX - minX
		local sizeY = maxY - minY
		--
		sizeX = sizeX/6000
		sizeY = sizeY/6000
		--
		local mapX = blipX + 3000
		local mapY = blipY + 3000
		mapX = mapX*sizeX + minX
		mapY = maxY - mapY*sizeY
		--We set the original size in the F11 map
		local sx,sy = width,height
		setWidgetSize (blip,width,height)
		setWidgetPosition(blip,mapX-sx/2,mapY-sy/2)
	end
end
