tuningUI = {}
tuningUIAddition = {}
-- Farben (Auto und Lichter)
-- Tuning an sich (Kennzeichen, Teile)
-- Einzelteile
-- Premium-Funktionen

function createTuningUI ()
    tuningUI["window"] = DGS:dgsCreateWindow(-0.05, 0.30, 0.06, 0.40, "", true)
    DGS:dgsWindowSetCloseButtonEnabled(tuningUI["window"], false)
    DGS:dgsCenterElement(tuningUI["window"], true, false) 
    DGS:dgsMoveTo( tuningUI["window"], 0, 0.30,true,"OutQuad",1000) 
    DGS:dgsWindowSetSizable(tuningUI["window"], false)
    DGS:dgsWindowSetMovable(tuningUI["window"], false)
    -- // Bilder
    tuningUI["colorpicker"] =  DGS:dgsCreateImage(0.07, 0.01, 0.88, 0.22, ":grs_tests/tuning/color-picker.png", true,  tuningUI["window"])
    tuningUI["tuning"] =   DGS:dgsCreateImage(0.06, 0.24, 0.87, 0.22, ":grs_tests/tuning/wrench.png", true,  tuningUI["window"])
    tuningUI["headlight"] =  DGS:dgsCreateImage(0.06, 0.48, 0.87, 0.22, ":grs_tests/tuning/headlight.png", true,  tuningUI["window"])
    tuningUI["premium"] =  DGS:dgsCreateImage(0.06, 0.72, 0.87, 0.22, ":grs_tests/tuning/star.png", true,  tuningUI["window"])   


    -- // Anderes
    showCursor(true)
    showChat(false)

    addEventHandler( "onDgsMouseClick",tuningUI["headlight"], 
    function(button, state, x, y)
        if isElement( tuningUIAddition["window"] ) then
            destroyElement( tuningUIAddition["window"])
        end
        -- // Kamera
        local x, y, z = getVehicleComponentPosition(tuningVehicle, "bonnet_dummy")
        print(x, y, z)
        showHeadlightChanger ()
        setVehicleOverrideLights(tuningVehicle, 2)
    end)


    addEventHandler( "onDgsMouseClick",tuningUI["colorpicker"], 
    function(button, state, x, y)
        if isElement( tuningUIAddition["window"] ) then
            destroyElement( tuningUIAddition["window"])
        end
        showColorpicker ()
    end)
end

function showColorpicker ()
    tuningUIAddition["window"] =  DGS:dgsCreateWindow(0.42, 0.00, 0.16, 0.25, "", true)
    DGS:dgsWindowSetSizable( tuningUIAddition["window"], false)
    DGS:dgsWindowSetMovable( tuningUIAddition["window"], false)

    tuningUIAddition["colortabpanel_selector"] = DGS:dgsCreateSelector(0.02, 0.02, 0.95, 0.08, true,tuningUIAddition["window"] )
    DGS:dgsSelectorAddItem( tuningUIAddition["colortabpanel_selector"], "Farbe I")
    DGS:dgsSelectorAddItem( tuningUIAddition["colortabpanel_selector"], "Farbe II")
    DGS:dgsSelectorAddItem( tuningUIAddition["colortabpanel_selector"], "Farbe III")
    DGS:dgsSelectorAddItem( tuningUIAddition["colortabpanel_selector"], "Farbe IV")
    DGS:dgsSelectorSetSelectedItem( tuningUIAddition["colortabpanel_selector"], 1 )
    tuningUIAddition["colortabpanel"]  = DGS:dgsCreateTabPanel(0.02, 0.14, 0.95, 0.78, true, tuningUIAddition["window"])

    tuningUIAddition["colortabpanel_picker"] = DGS:dgsCreateTab("Normale Farbauswahl", tuningUIAddition["colortabpanel"])
    tuningUIAddition["colortabpanel_vippicker"] = DGS:dgsCreateTab("VIP-Farbauswahl", tuningUIAddition["colortabpanel"])
    
    tuningUIAddition["colortabpanel_picker_colorpicker"] = DGS:dgsCreateColorPicker("HSLSquare",0.03, 0.04, 0.95, 0.91,true,tuningUIAddition["colortabpanel_picker"])

    -- // VIP-Colorpicker
    tuningUIAddition["colortabpanel_picker_selector1"] = DGS:dgsColorPickerCreateComponentSelector(0.03, 0.04, 0.11, 0.92, false, true, tuningUIAddition["colortabpanel_vippicker"])
    tuningUIAddition["colortabpanel_picker_selector2"] = DGS:dgsColorPickerCreateComponentSelector(0.16, 0.04, 0.11, 0.92, false, true, tuningUIAddition["colortabpanel_vippicker"])
    tuningUIAddition["colortabpanel_picker_selector3"] = DGS:dgsColorPickerCreateComponentSelector(0.30, 0.04, 0.11, 0.92, false, true, tuningUIAddition["colortabpanel_vippicker"])

    tuningUIAddition["colortabpanel_picker_vipcolorpicker"] = DGS:dgsCreateColorPicker("HLDisk",0.43, 0.04, 0.54, 0.92, true, tuningUIAddition["colortabpanel_vippicker"])
    
    DGS:dgsBindToColorPicker( tuningUIAddition["colortabpanel_picker_colorpicker"], tuningUIAddition["colortabpanel_picker_vipcolorpicker"],"RGB","RGB")
    DGS:dgsBindToColorPicker( tuningUIAddition["colortabpanel_picker_selector1"],tuningUIAddition["colortabpanel_picker_vipcolorpicker"],"RGB","R")
    DGS:dgsBindToColorPicker( tuningUIAddition["colortabpanel_picker_selector2"],tuningUIAddition["colortabpanel_picker_vipcolorpicker"],"RGB","G")
    DGS:dgsBindToColorPicker( tuningUIAddition["colortabpanel_picker_selector3"],tuningUIAddition["colortabpanel_picker_vipcolorpicker"],"RGB","B")

    addEventHandler("onDgsColorPickerChange",tuningUIAddition["colortabpanel_picker_colorpicker"], changeVehicleColorByColorpicker ,false)
    addEventHandler("onDgsColorPickerChange",tuningUIAddition["colortabpanel_picker_vipcolorpicker"], changeVehicleColorByColorpicker ,false)

end

function changeVehicleColorByColorpicker (RGB,HSL,HSV)
    print(source, theElement)
    local currentSelector = DGS:dgsSelectorGetSelectedItem(  tuningUIAddition["colortabpanel_selector"] )
    local r, g, b, a =  DGS:dgsColorPickerGetColor(source, "RGB")
    local vehicleColors = {getVehicleColor(tuningVehicle, true)}
    local r1, g1, b1 = vehicleColors[1], vehicleColors[2], vehicleColors[3]
    local r2, g2, b2 = vehicleColors[4], vehicleColors[5], vehicleColors[6]
    local r3, g3, b3 = vehicleColors[7], vehicleColors[8], vehicleColors[9]
    local r4, g4, b4 = vehicleColors[10], vehicleColors[11], vehicleColors[12]

    if currentSelector == 1 then
        setVehicleColor(tuningVehicle, r, g, b, r2, g2, b2, r3, g3, b3, r4, g4, b4 )  
    elseif currentSelector == 2 then
        setVehicleColor(tuningVehicle,  r1, g1, b1,  r, g, b, r3, g3, b3, r4, g4, b4 )  
    elseif currentSelector == 3 then
        setVehicleColor(tuningVehicle, r1, g1, b1, r2, g2, b2, r, g, b, r4, g4, b4 )  
    elseif currentSelector == 4 then
        setVehicleColor(tuningVehicle,  r1, g1, b1, r2, g2, b2, r3, g3, b3, r, g, b )  
    end
    outputChatBox("Old RGB:("..RGB[1]..","..RGB[2]..","..RGB[3]..")")
end

function showHeadlightChanger ()
    tuningUIAddition["window"] =  DGS:dgsCreateWindow(0.07, 0.40, 0.11, 0.21, "", true)
    DGS:dgsWindowSetSizable( tuningUIAddition["window"], false)
    DGS:dgsWindowSetMovable( tuningUIAddition["window"], false)

    tuningUIAddition["colorpicker"] =  DGS:dgsCreateColorPicker("HSVRing",0.03, 0.08, 0.93, 0.88 ,true,tuningUIAddition["window"])
    addEventHandler("onDgsColorPickerChange",tuningUIAddition["colorpicker"],function(RGB,HSL,HSV)
        local r, g, b =  DGS:dgsColorPickerGetColor(tuningUIAddition["colorpicker"], "RGB")
        print(r,g,b, "Headlight")
        setVehicleHeadLightColor ( tuningVehicle, r, g, b )

    end,false)

end
function destroyTuningUI ()
    local close = DGS:dgsCloseWindow( tuningUI["window"] )
	if close then
		showCursor(false)
        showChat(true)
	end
end


addEventHandler ( "onClientRender", root,
function()
	countTest = 0
	if isPedInVehicle ( localPlayer ) and getPedOccupiedVehicle ( localPlayer ) then
		local veh = getPedOccupiedVehicle ( localPlayer )
		for v in pairs ( getVehicleComponents(veh) ) do
			countTest = countTest + 1
			local x,y,z = getVehicleComponentPosition ( veh, v, "world" )
			local sx,sy = getScreenFromWorldPosition ( x, y, z )
			if sx and sy then
				dxDrawRectangle(sx,sy, 10, 10)
				dxDrawLine(sx, sy, sx - (100 + (countTest * 5)), sy-(200+ (countTest * 10)))
				dxDrawText ( v, (sx-(120 + (countTest * 5))) -1, (sy-(220 + (countTest * 10))) -1, 0 -1, 0 -1, tocolor(0,0,0), 1, "default-bold" )
				dxDrawText ( v, (sx-(120 + (countTest * 5))) +1, (sy-(220 + (countTest * 10))) -1, 0 +1, 0 -1, tocolor(0,0,0), 1, "default-bold" )
				dxDrawText ( v, (sx-(120 + (countTest * 5))) -1, (sy-(220 + (countTest * 10))) +1, 0 -1, 0 +1, tocolor(0,0,0), 1, "default-bold" )
				dxDrawText ( v, (sx-(120 + (countTest * 5))) +1, (sy-(220 + (countTest * 10))) +1, 0 +1, 0 +1, tocolor(0,0,0), 1, "default-bold" )
				dxDrawText ( v, (sx-(120 + (countTest * 5))), (sy-(220 + (countTest * 10))), 0, 0, tocolor(0,255,255), 1, "default-bold" )
			end
		end
	end
end)