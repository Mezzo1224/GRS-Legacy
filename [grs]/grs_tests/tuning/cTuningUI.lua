tuningUI = {}

function testColor ()
    tuningUI.colorpicker = {}
    tuningUI.colorpicker["window"] = DGS:dgsCreateWindow(0.23, 0.26, 0.12, 0.32, "Farbe", true)

    DGS:dgsWindowSetSizable(tuningUI.colorpicker["window"], false)
    DGS:dgsWindowSetMovable(tuningUI.colorpicker["window"], false)
    DGS:dgsSetProperty(tuningUI.colorpicker["window"],"ignoreTitle", true)
    DGS:dgsWindowSetCloseButtonEnabled(tuningUI.colorpicker["window"], false)

    tuningUI.colorpicker["color1_info"] = DGS:dgsCreateLabel(0.03, 0.08, 0.93, 0.09, "Farbe 1", false, tuningUI.colorpicker["window"])
    tuningUI.colorpicker["color2_info"] = DGS:dgsCreateLabel(0.03, 0.51, 0.93, 0.09, "Farbe 2", false, tuningUI.colorpicker["window"])
    DGS:dgsSetProperty(tuningUI.colorpicker["color1_info"],"alignment", {"center", "center"})
    DGS:dgsSetProperty(tuningUI.colorpicker["color1_info"],"alignment",  {"center", "center"})
  
    tuningUI.colorpicker["color1_picker"] = DGS:dgsCreateColorPicker("HLDisk",0.21, 0.17, 0.57, 0.30, true, tuningUI.colorpicker["window"])
    tuningUI.colorpicker["color2_picker"] = DGS:dgsCreateColorPicker("HLDisk",0.21, 0.62, 0.57, 0.30, true, tuningUI.colorpicker["window"])

    addEventHandler("onDgsColorPickerChange",tuningUI.colorpicker["color1_picker"],function(RGB,HSL,HSV)
        local R,G,B,A = DGS:dgsColorPickerGetColor(source,"RGB")
        local vehicle = getPedOccupiedVehicle ( getLocalPlayer() )
        refeshVehicleColor (vehicle,R, G, B, 1)
      end,false)

      addEventHandler("onDgsColorPickerChange",tuningUI.colorpicker["color2_picker"],function(RGB,HSL,HSV)
        local R,G,B,A = DGS:dgsColorPickerGetColor(source,"RGB")
        local vehicle = getPedOccupiedVehicle ( getLocalPlayer() )
        refeshVehicleColor (vehicle, R, G, B, 2)
      end,false)
end


function refeshVehicleColor (vehicle, r, g, b, colorType)
    local colorCache = {}
    local r1, g1, b1, a1, r2, g2, b2, a2,  r3, g3, b3, a3,  r4, g4, b4, a4 = getVehicleColor ( vehicle, true )
    if colorType == 1 then
        colorCache[2] = {r2, g2, b2}
        print("colorType 1")
        setVehicleColor( vehicle, r, g, b, r2, g2, b2,  r3, g3, b3, r4, g4, b4)
    end
    if colorType == 2 then
        print("colorType 2")
        setVehicleColor( vehicle, r1, g1, b1, r, g, b, r3, g3, b3, r4, g4, b4)
    end

end