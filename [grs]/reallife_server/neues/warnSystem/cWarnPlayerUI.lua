warnPlayerUI = {}


function createPlayerWarnWindow ()

    warnPlayerUI["window_main"] = DGS:dgsCreateWindow(0.38, 0.35, 0.24, 0.31, "Warns", true)
    showCursor(true)
    setElementClicked ( true )
    guiSetInputEnabled ( false )

    DGS:dgsWindowSetMovable ( warnPlayerUI["window_main"], false )
    DGS:dgsWindowSetSizable ( warnPlayerUI["window_main"], false )
    DGS:dgsWindowSetCloseButtonEnabled(warnPlayerUI["window_main"], true)
    DGS:dgsSetProperty(warnPlayerUI["window_main"] ,"titleColor",  tocolor(145, 7, 30, 250) )

    warnPlayerUI["warns"] =  DGS:dgsCreateGridList(0.02, 0.10, 0.96, 0.79, true, warnPlayerUI["window_main"])
    DGS:dgsGridListSetColumnFont(warnPlayerUI["warns"], column, "default-bold")
    DGS:dgsSetProperty(warnPlayerUI["warns"],"rowHeight",24)
    DGS:dgsSetProperty(warnPlayerUI["warns"],"columnColor", tocolor(120, 6, 25, 240))
    warnPlayerUI["warns_admin"] =  DGS:dgsGridListAddColumn( warnPlayerUI["warns"], "Von", 0.1)
    warnPlayerUI["warns_reason"] =  DGS:dgsGridListAddColumn( warnPlayerUI["warns"], "Grund", 0.1)
    warnPlayerUI["warns_points"] =  DGS:dgsGridListAddColumn( warnPlayerUI["warns"], "Punkte", 0.1)
    warnPlayerUI["warns_time"] =  DGS:dgsGridListAddColumn( warnPlayerUI["warns"], "Zeit", 0.1)
    warnPlayerUI["warns_expdate"] =  DGS:dgsGridListAddColumn( warnPlayerUI["warns"], "Ablaufdatum", 0.3)
    warnPlayerUI["warns_creationDate"] = DGS:dgsGridListAddColumn( warnPlayerUI["warns"], "Datum", 0.3)

    warnPlayerUI["info_warns"] =   DGS:dgsCreateLabel(0.02, 0.02, 0.16, 0.05, "Verwarnungen", true,  warnPlayerUI["window_main"])
    DGS:dgsSetProperty(warnPlayerUI["info_warns"],"textColor",tocolor(214, 87, 9,255))
    warnPlayerUI["activ_warns"] =  DGS:dgsCreateLabel(0.20, 0.02, 0.24, 0.05, "aktive Verwarnungen", true,  warnPlayerUI["window_main"])
    DGS:dgsSetProperty(warnPlayerUI["activ_warns"],"textColor",tocolor(41, 158, 17,255))
    warnPlayerUI["points_warns"] = DGS:dgsCreateLabel(0.45, 0.02, 0.24, 0.05, "Strafpunkte", true,  warnPlayerUI["window_main"])    
    DGS:dgsSetProperty(warnPlayerUI["points_warns"],"textColor",tocolor(161, 16, 16,255))
    triggerServerEvent ( "getWarnsFromMySQL", getLocalPlayer(), getPlayerName(getLocalPlayer()) ) 
    
    addEventHandler( "onDgsMouseDoubleClick", warnPlayerUI["warns"], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == warnPlayerUI["warns"] then
                local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(warnPlayerUI["warns"])
                if Selected ~= -1 then 
                    local data = DGS:dgsGridListGetItemData(warnPlayerUI["warns"],Selected, warnPlayerUI["warns_admin"])
                    setClipboard(toJSON(data, true))
                    newInfobox ("Warn in Zwischenablage gespeichert.", 1)
                end
        end
    end)

    addEventHandler( "onDgsWindowClose", warnPlayerUI["window_main"], 
        function()
            setElementClicked ( false )
            if not warnCreationUI["window_main"] then
                showCursor(false)
                guiSetInputEnabled ( true )
            end
        end)
end
addEvent ( "createPlayerWarnWindow", true)
addEventHandler ( "createPlayerWarnWindow", getLocalPlayer(),  createPlayerWarnWindow)


function addPlayerWarnClient (playerData)
    print("Daten angekommen")
    
    DGS:dgsGridListClear(warnPlayerUI["warns"])
    for i,var in pairs(playerData.warns) do
        local row = DGS:dgsGridListAddRow ( warnPlayerUI["warns"] )
        DGS:dgsGridListSetItemData (  warnPlayerUI["warns"], row, warnPlayerUI["warns_admin"], var )
        DGS:dgsGridListSetItemText ( warnPlayerUI["warns"], row, warnPlayerUI["warns_admin"], var.nameFromAdminUID, false, false )
        DGS:dgsGridListSetItemText ( warnPlayerUI["warns"], row, warnPlayerUI["warns_reason"], var.reason, false, false )
        DGS:dgsGridListSetItemText ( warnPlayerUI["warns"], row,warnPlayerUI["warns_points"], var.penaltyPoints, false, false )
        DGS:dgsGridListSetItemText ( warnPlayerUI["warns"], row, warnPlayerUI["warns_time"], var.time, false, false )
        DGS:dgsGridListSetItemText ( warnPlayerUI["warns"], row, warnPlayerUI["warns_creationDate"], var.creationDate, false, false )
        DGS:dgsGridListSetItemText ( warnPlayerUI["warns"], row, warnPlayerUI["warns_expdate"], var.ExpiryDate, false, false )
        if var.isExpired == 1 then
            -- // Abgelaufen
            DGS:dgsGridListSetItemColor( warnPlayerUI["warns"], row, -1, 207, 18, 12,255 )
        else
            -- // Nicht abgelaufen
            DGS:dgsGridListSetItemColor( warnPlayerUI["warns"], row, -1, 11, 117, 7,255 )
        end
    end

    DGS:dgsSetText(warnPlayerUI["info_warns"], playerData.allWarns.." Verwarnungen")
    DGS:dgsSetText(warnPlayerUI["activ_warns"], playerData.allActiveWarns.." aktive Verwarnungen")
    DGS:dgsSetText(warnPlayerUI["points_warns"], playerData.allPenaltyPoints.." Strafpunkte")


end
addEvent ( "addPlayerWarnClient", true)
addEventHandler ( "addPlayerWarnClient", getLocalPlayer(),  addPlayerWarnClient)