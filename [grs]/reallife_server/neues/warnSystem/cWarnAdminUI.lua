warnUI = {}
local sortfnc = [[
	local arg = {...}
	local a = arg[1]
	local b = arg[2]
	local column = dgsElementData[self].sortColumn
	local texta,textb = a[column][1],b[column][1]
	return texta < textb
]] 

 function createWarnWindow (target, warnedPlayersCache)
        
        warnData = {}
        warnUI["window_main"] = DGS:dgsCreateWindow(0.35, 0.30, 0.31, 0.41, "Warnsystem", true)
        showCursor(true)
        setElementClicked ( true )
        guiSetInputEnabled ( false )
        DGS:dgsWindowSetMovable ( warnUI["window_main"], false )
		DGS:dgsWindowSetSizable ( warnUI["window_main"], false )
		DGS:dgsWindowSetCloseButtonEnabled(warnUI["window_main"], true)
        DGS:dgsSetProperty(warnUI["window_main"] ,"titleColor",  tocolor(145, 7, 30, 250) )
-- - 4
        warnUI["playerlist"] =  DGS:dgsCreateGridList(0.01, 0.12, 0.19, 0.82, true, warnUI["window_main"])
        warnUI["playerlist_name"] = DGS:dgsGridListAddColumn( warnUI["playerlist"], "Name", 0.9)
        warnUI["search"] = DGS:dgsCreateEdit (0.01, 0.02, 0.18, 0.08, "", true, warnUI["window_main"])
        DGS:dgsSetProperty( warnUI["search"],"placeHolder","Spielername")
        if warnedPlayersCache then
            for name,var in pairs(warnedPlayersCache) do
                print(tostring(name))
                DGS:dgsEditAddAutoComplete(warnUI["search"], tostring(name), true )
            end
        end
        --DGS:dgsSetProperty(warnUI["search"],"autoComplete",warnedPlayersCache)
        warnUI["notes"] =  DGS:dgsCreateMemo(0.22, 0.02, 0.55, 0.27, "Notizen", true, warnUI["window_main"])
        DGS:dgsSetProperty( warnUI["notes"], "allowCopy",false)
        DGS:dgsSetProperty( warnUI["notes"], "readOnly",true)
        DGS:dgsSetProperty(warnUI["notes"],"bgColor", tocolor(42, 43, 42, 255))
       
        DGS:dgsCreateLabel( 0.84, 0.02, 0.09, 0.05, "Letzter Login", true, warnUI["window_main"])
        warnUI["last_login"] =  DGS:dgsCreateLabel(0.82, 0.08, 0.09, 0.05, "", true, warnUI["window_main"])
        warnUI["info_warns"] =   DGS:dgsCreateLabel(0.22, 0.3, 0.13, 0.04, "Verwarnungen", true,  warnUI["window_main"])
        DGS:dgsSetProperty(warnUI["info_warns"],"textColor",tocolor(214, 87, 9,255))
        warnUI["activ_warns"] =  DGS:dgsCreateLabel(0.37, 0.3, 0.19, 0.04, "aktive Verwarnungen", true,  warnUI["window_main"])
        DGS:dgsSetProperty(warnUI["activ_warns"],"textColor",tocolor(41, 158, 17,255))
        warnUI["points_warns"] = DGS:dgsCreateLabel(0.57, 0.3, 0.19, 0.04, "Strafpunkte", true,  warnUI["window_main"])    
        DGS:dgsSetProperty(warnUI["points_warns"],"textColor",tocolor(161, 16, 16,255))

        warnUI["warns"] =  DGS:dgsCreateGridList(0.22, 0.35, 0.76, 0.59, true, warnUI["window_main"])
        DGS:dgsGridListSetColumnFont(warnUI["warns"], column, "default-bold")
        DGS:dgsSetProperty(warnUI["warns"],"rowHeight",24)
        warnUI["warns_admin"] =  DGS:dgsGridListAddColumn( warnUI["warns"], "Von", 0.1)
        warnUI["warns_reason"] =  DGS:dgsGridListAddColumn( warnUI["warns"], "Grund", 0.1)
        warnUI["warns_points"] =  DGS:dgsGridListAddColumn( warnUI["warns"], "Punkte", 0.1)
        warnUI["warns_time"] =  DGS:dgsGridListAddColumn( warnUI["warns"], "Zeit", 0.1)
        warnUI["warns_expdate"] =  DGS:dgsGridListAddColumn( warnUI["warns"], "Ablaufdatum", 0.3)
        warnUI["warns_creationDate"] = DGS:dgsGridListAddColumn( warnUI["warns"], "Datum", 0.3)
        
        warnUI["warn"] = DGS:dgsCreateButton(0.79, 0.14, 0.19, 0.09, "Verwarnen", true, warnUI["window_main"])
        warnUI["delWarn"] = DGS:dgsCreateButton(0.79, 0.24, 0.19, 0.07, "Warn löschen", true, warnUI["window_main"])
        local iconImg = ":reallife_server/images/warn.png"
        DGS:dgsSetProperty(warnUI["warn"],"iconImage",{iconImg,iconImg,iconImg})
        DGS:dgsSetProperty(warnUI["warn"],"iconOffset",{-5,0})
        DGS:dgsSetProperty(warnUI["warn"],"color",{tocolor (145, 7, 30, 255), tocolor (186, 9, 39, 255),tocolor (145, 7, 30, 255)})
        local iconImg = ":reallife_server/images/delete.png"
        DGS:dgsSetProperty(warnUI["delWarn"],"iconImage",{iconImg,iconImg,iconImg})
        DGS:dgsSetProperty(warnUI["delWarn"],"iconOffset",{-5,0})
        DGS:dgsSetProperty(warnUI["delWarn"],"color",{tocolor (145, 7, 30, 255), tocolor (186, 9, 39, 255),tocolor (145, 7, 30, 255)})
        DGS:dgsSetProperty(warnUI["warns"],"columnColor", tocolor(120, 6, 25, 240))
        DGS:dgsSetProperty(warnUI["playerlist"],"columnColor", tocolor(120, 6, 25, 240))
        DGS:dgsSetEnabled(warnUI["warn"], false)
        DGS:dgsSetEnabled(warnUI["delWarn"], false)
        if target then
            triggerServerEvent ( "getWarnsFromMySQL", getLocalPlayer(), target ) 
            triggerServerEvent ( "cacheSearchedPlayers", getLocalPlayer(), target ) 
        end
            
        DGS:dgsGridListClear(warnUI["playerlist"])
        local players = getElementsByType("player")
        for i=1, #players do
            local row = DGS:dgsGridListAddRow ( warnUI["playerlist"] )
            DGS:dgsGridListSetItemText ( warnUI["playerlist"], row, warnUI["playerlist_name"], getPlayerName ( players[i] ), false, false )
            DGS:dgsEditAddAutoComplete(warnUI["search"], tostring(getPlayerName ( players[i] )), true )
        end
        bindKey("enter", "down", searchWarnPlayer )

        addEventHandler( "onDgsMouseClick",  warnUI["warn"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == warnUI["warn"] then
                createWarnCreationUI (currentNickname)
                DGS:dgsCloseWindow( warnUI["window_main"] )
            end
        end)

         addEventHandler( "onDgsMouseClick",  warnUI["delWarn"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == warnUI["delWarn"] then
                            local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(warnUI["warns"])
                            if Selected ~= -1 then 
                                local data = DGS:dgsGridListGetItemData(warnUI["warns"],Selected, warnUI["warns_admin"])
                                local id, adminname, name = tonumber (data.id), tostring (data.nameFromAdminUID), tostring(data.nameFromAdminUID)
                                local adminUID, uid = tonumber (data.uid),tonumber (data.AdminUID)
                                deleteWarnQuery(id, adminname, name, adminUID, uid)
                                print(id, adminname, name)
                            else
                                newInfobox ("Wähle einen Warn aus.", 3)
                            end
                        end
                    end)

        addEventHandler( "onDgsMouseDoubleClick",  warnUI["notes"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source ==  warnUI["notes"] then
                DGS:dgsSetProperty( warnUI["notes"], "readOnly",false)
                addEventHandler( "onDgsMouseDoubleClick", root ,saveNoticeOnClick )
            end
        end)

        addEventHandler( "onDgsMouseDoubleClick", warnUI["warns"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == warnUI["warns"] then
                    local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(warnUI["warns"])
                    if Selected ~= -1 then 
                        local data = DGS:dgsGridListGetItemData(warnUI["warns"],Selected, warnUI["warns_admin"])
                        setClipboard(toJSON(data, true))
                        newInfobox ("Warn in Zwischenablage gespeichert.", 1)
                    end
            end
        end)
        
        addEventHandler( "onDgsMouseDoubleClick", warnUI["playerlist"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == warnUI["playerlist"] then
                    local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(warnUI["playerlist"])
                    if Selected ~= -1 then 
                        local name = DGS:dgsGridListGetItemText(warnUI["playerlist"],Selected, warnUI["playerlist_name"])
                        triggerServerEvent ( "getWarnsFromMySQL", getLocalPlayer(), name ) 
                    end
            end
        end)

        addEventHandler( "onDgsWindowClose", warnUI["window_main"], 
            function()
                if not warnCreationUI["window_main"] then
                    setElementClicked ( false )
                    showCursor(true)
                    guiSetInputEnabled ( true )
                    warnedPlayersCache = nil
                end
            end)

    end
addEvent ( "createWarnWindow", true)
addEventHandler ( "createWarnWindow", getLocalPlayer(),  createWarnWindow)

function searchWarnPlayer ()
    local name = DGS:dgsGetText(warnUI["search"])
    print(string.len(name))
    if string.len(name) > 0 then
        triggerServerEvent ( "getWarnsFromMySQL", getLocalPlayer(), name ) 
        triggerServerEvent ( "cacheSearchedPlayers", getLocalPlayer(), name ) 
    end
end



function updateWarnUI (name, playerData)
    currentNickname = name

      

    DGS:dgsGridListClear(warnUI["warns"])
    for i,var in pairs(playerData.warns) do
        local row = DGS:dgsGridListAddRow ( warnUI["warns"] )
        DGS:dgsGridListSetItemData (  warnUI["warns"], row, warnUI["warns_admin"], var )
        DGS:dgsGridListSetItemText ( warnUI["warns"], row, warnUI["warns_admin"], var.nameFromAdminUID, false, false )
        DGS:dgsGridListSetItemText (warnUI["warns"], row, warnUI["warns_reason"], var.reason, false, false )
        DGS:dgsGridListSetItemText ( warnUI["warns"], row,warnUI["warns_points"], var.penaltyPoints, false, false )
        DGS:dgsGridListSetItemText ( warnUI["warns"], row, warnUI["warns_time"], var.time, false, false )
        DGS:dgsGridListSetItemText ( warnUI["warns"], row, warnUI["warns_creationDate"], var.creationDate, false, false )
        DGS:dgsGridListSetItemText ( warnUI["warns"], row, warnUI["warns_expdate"], var.ExpiryDate, false, false )
        if var.isExpired == 1 then
            -- // Abgelaufen
            DGS:dgsGridListSetItemColor( warnUI["warns"], row, -1, 207, 18, 12,255 )
        else
            -- // Nicht abgelaufen
            DGS:dgsGridListSetItemColor( warnUI["warns"], row, -1, 11, 117, 7,255 )
        end
    end
    DGS:dgsSetText(warnUI["last_login"], playerData.lastlogin)
    DGS:dgsSetText(warnUI["notes"], playerData.adminnote)
    DGS:dgsSetText(warnUI["info_warns"], playerData.allWarns.." Verwarnungen")
    DGS:dgsSetText(warnUI["activ_warns"], playerData.allActiveWarns.." aktive Verwarnungen")
    DGS:dgsSetText(warnUI["points_warns"], playerData.allPenaltyPoints.." Strafpunkte")
    DGS:dgsSetEnabled(warnUI["warn"], true)
    DGS:dgsSetEnabled(warnUI["delWarn"], true)
end
addEvent ( "updateWarnUI", true)
addEventHandler ( "updateWarnUI", getLocalPlayer(),  updateWarnUI)

function saveNoticeOnClick (button, state, x, y)
    if button == 'left' and state == 'up' and source ~=  warnUI["notes"] and currentNickname then
        print("Saved")
        DGS:dgsSetProperty( warnUI["notes"], "readOnly",true)
        triggerServerEvent ( "saveAdminNoticeInMysql", getLocalPlayer(),  getLocalPlayer(), currentNickname, DGS:dgsGetText(warnUI["notes"]) ) 
        removeEventHandler("onDgsMouseDoubleClick", warnUI["notes"], saveNoticeOnClick )
    end
end

local warnQuery = {}
function deleteWarnQuery (id, adminname, name, adminUID, uid)
    DGS:dgsSetEnabled(warnUI["window_main"], false)
    warnQuery["window_main"] = DGS:dgsCreateWindow(0.46, 0.44, 0.08, 0.12, "", true)
    DGS:dgsSetProperty(warnQuery["window_main"] ,"titleColor",  tocolor(145, 7, 30, 250) )
    DGS:dgsSetCurrentLayerIndex ( warnQuery["window_main"],2)
    DGS:dgsBringToFront( warnQuery["window_main"])
    DGS:dgsSetLayer (warnQuery["window_main"],"top")
    DGS:dgsWindowSetMovable ( warnQuery["window_main"], false )
    DGS:dgsWindowSetSizable ( warnQuery["window_main"], false )
    DGS:dgsWindowSetCloseButtonEnabled(warnQuery["window_main"], false)

    warnQuery["info"] = DGS:dgsCreateLabel(0.04, 0.11, 0.88, 0.34, "Sicher das du den Warn "..id.." von "..adminname.." an "..name.." löschen willst?", true, warnQuery["window_main"])
    DGS:dgsLabelSetHorizontalAlign(warnQuery["info"], "left")
    DGS:dgsSetProperty( warnQuery["info"],"wordbreak",true)
    warnQuery["yes"] = DGS:dgsCreateButton(0.05, 0.53, 0.31, 0.29, "Ja", true, warnQuery["window_main"])
    warnQuery["no"] = DGS:dgsCreateButton(0.61, 0.53, 0.31, 0.29, "Nein", true, warnQuery["window_main"])
    DGS:dgsSetProperty(warnQuery["no"],"color",{tocolor (145, 7, 30, 255), tocolor (186, 9, 39, 255),tocolor (145, 7, 30, 255)})
    DGS:dgsSetProperty(warnQuery["yes"],"color",{tocolor (12, 153, 12, 255), tocolor (15, 191, 15, 255),tocolor (15, 219, 15, 255)})
    DGS:dgsFocus(warnQuery["window_main"])

    triggerServerEvent ( "isPermittedFordeleteWarn", getLocalPlayer(), getLocalPlayer(), id, adminUID, uid )

    -- Löschen
    addEventHandler( "onDgsMouseClick",  warnQuery["yes"], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source ==  warnQuery["yes"] then
            DGS:dgsCloseWindow( warnQuery["window_main"] )
            DGS:dgsSetEnabled(warnUI["window_main"], true)
            triggerServerEvent ( "deleteWarn", getLocalPlayer(), getLocalPlayer(), id, adminUID, uid ) 
            triggerServerEvent ( "getWarnsFromMySQL", getLocalPlayer(), name ) 
        end
    end)
    -- Nicht Löschen
    addEventHandler( "onDgsMouseClick",  warnQuery["no"], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source ==  warnQuery["no"] then
            DGS:dgsCloseWindow( warnQuery["window_main"] )
            DGS:dgsSetEnabled(warnUI["window_main"], true)
            
        end
    end)
end

function disableYes_deleteWarnQuery ()
    DGS:dgsSetEnabled(warnQuery["yes"], false)
    DGS:dgsSetText(warnQuery["yes"], "//")
    
end
addEvent ( "disableYes_deleteWarnQuery", true)
addEventHandler ( "disableYes_deleteWarnQuery", getLocalPlayer(),  disableYes_deleteWarnQuery)