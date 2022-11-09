warnCreationUI = {}

-- Name ( not edit )
-- Grund
-- Punkte
-- Zeiteinheit und Zeit
-- Schalter für: "Soll die Strafe automatisch ausgeführt werden?"

function createWarnCreationUI (name)

    warnCreationUI["window_main"] = DGS:dgsCreateWindow(0.42, 0.39, 0.17, 0.22, name.." verwarnen", true)
    DGS:dgsWindowSetMovable ( warnCreationUI["window_main"], false )
    DGS:dgsWindowSetSizable ( warnCreationUI["window_main"], false )
    DGS:dgsWindowSetCloseButtonEnabled(warnCreationUI["window_main"], true)
    DGS:dgsSetProperty(warnCreationUI["window_main"] ,"titleColor",  tocolor(145, 7, 30, 250) )
    -- - 6 
    warnCreationUI["warnlist"] =  DGS:dgsCreateGridList(0.02, 0.04, 0.25, 0.85, true, warnCreationUI["window_main"])
    warnCreationUI["warnlist_name"] = DGS:dgsGridListAddColumn( warnCreationUI["warnlist"], "Strafe", 1)
    for name,var in pairs(predefinedWarns) do
        local row = DGS:dgsGridListAddRow ( warnCreationUI["warnlist"] )
        DGS:dgsGridListSetItemData (  warnCreationUI["warnlist"], row, warnCreationUI["warnlist_name"], predefinedWarns )
        DGS:dgsGridListSetItemText ( warnCreationUI["warnlist"], row, warnCreationUI["warnlist_name"], name, false, false )
    end
    DGS:dgsSetProperty(warnCreationUI["warnlist"],"columnColor", tocolor(120, 6, 25, 240))
    warnCreationUI["name"] =  DGS:dgsCreateEdit(0.29, 0.04, 0.27, 0.17, name, true, warnCreationUI["window_main"])
    DGS:dgsSetProperty( warnCreationUI["name"], "readOnly",true)
    warnCreationUI["reason"] =  DGS:dgsCreateEdit(0.29, 0.26, 0.35, 0.17, "", true, warnCreationUI["window_main"])
    DGS:dgsSetProperty( warnCreationUI["reason"], "placeHolder","Grund")
    warnCreationUI["time"] =  DGS:dgsCreateEdit(0.29, 0.47, 0.14, 0.17, "", true, warnCreationUI["window_main"])
    DGS:dgsSetProperty( warnCreationUI["time"], "placeHolder","Zeit")
    warnCreationUI["points"] =  DGS:dgsCreateEdit(0.73, 0.26, 0.18, 0.17, "", true, warnCreationUI["window_main"])
    DGS:dgsSetProperty( warnCreationUI["points"], "placeHolder","Punkte")
    
    warnCreationUI["time_info"] =  DGS:dgsCreateLabel(0.46, 0.47, 0.52, 0.17, "d = Tage, w = Wochen, mo = Monate, y = Jahre, p = permanent. Nichts = Tage", true, warnCreationUI["window_main"])
    DGS:dgsSetProperty( warnCreationUI["time_info"],"wordbreak",true)
    DGS:dgsCreateLabel(0.29, 0.66, 0.33, 0.08, " Automatische Strafe ?", true, warnCreationUI["window_main"])
    warnCreationUI["automaticPenalty"] =  DGS:dgsCreateSwitchButton(0.30, 0.73, 0.32, 0.11, "Ja", "Nein", false, true, warnCreationUI["window_main"] )
    DGS:dgsSetProperty(warnCreationUI["automaticPenalty"],"colorOn",{tocolor(8, 140, 44, 255),tocolor(8, 140, 44, 255),tocolor(8, 140, 44, 255)})
    DGS:dgsSetProperty(warnCreationUI["automaticPenalty"],"colorOff",{ tocolor(140, 8, 8, 255), tocolor(140, 8, 8, 255), tocolor(140, 8, 8, 255)})
    --guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
    warnCreationUI["warn"] = DGS:dgsCreateButton(0.66, 0.65, 0.32, 0.24, "Verwarnen", true, warnCreationUI["window_main"])
    
    local iconImg = ":reallife_server/images/warn.png"
    DGS:dgsSetProperty(warnCreationUI["warn"],"iconImage",{iconImg,iconImg,iconImg})
    DGS:dgsSetProperty(warnCreationUI["warn"],"iconOffset",{-5,0})
    DGS:dgsSetProperty(warnCreationUI["warn"],"color",{tocolor (145, 7, 30, 255), tocolor (186, 9, 39, 255),tocolor (145, 7, 30, 255)})
  

    addEventHandler( "onDgsMouseDoubleClick",warnCreationUI["warnlist"], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == warnCreationUI["warnlist"] then
                local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(warnCreationUI["warnlist"])
                if Selected ~= -1 then 
                    local predefWarn = DGS:dgsGridListGetItemData(warnCreationUI["warnlist"],Selected, warnCreationUI["warnlist_name"])
                    local predefWarn = toJSON(predefWarn)
                    local predefWarn = fromJSON( predefWarn )
                    local points, warnTime,reason = tonumber(predefWarn.penaltyPoints), tostring(predefWarn.time), tostring(predefWarn.reason)
                    print(points, warnTime,reason)
                    DGS:dgsSetText(warnCreationUI["time"], warnTime)
                    DGS:dgsSetText(warnCreationUI["points"], points)
                    DGS:dgsSetText(warnCreationUI["reason"], reason)
                    iprint(toJSON(predefWarn,true))
                    print(predefWarn)
                end
        end
    end)

    
    addEventHandler( "onDgsMouseClick",  warnCreationUI["warn"], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == warnCreationUI["warn"] then
            local points, warnTime, reason = DGS:dgsGetText(warnCreationUI["points"]), DGS:dgsGetText(warnCreationUI["time"]), DGS:dgsGetText(warnCreationUI["reason"])
            -- TODO: Switch
            triggerServerEvent ( "givePlayerWarn", getLocalPlayer(), getLocalPlayer(), name, points, warnTime, reason ) 
        end
    end)


    addEventHandler( "onDgsWindowClose", warnCreationUI["window_main"], 
    function()
        createWarnWindow(name)
    end)
end  


function closeWarnCreasionUIWhenWarned ()
    if  warnCreationUI["window_main"] then
        DGS:dgsCloseWindow( warnCreationUI["window_main"] )
    end
end
addEvent ( "closeWarnCreasionUIWhenWarned", true)
addEventHandler ( "closeWarnCreasionUIWhenWarned", getLocalPlayer(),  closeWarnCreasionUIWhenWarned)