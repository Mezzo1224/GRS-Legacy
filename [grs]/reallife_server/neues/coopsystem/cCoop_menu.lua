coopMenu = {}
local x, y = guiGetScreenSize()
local sx, sy = x/2560, y/1440

function openCoopMenu (coopID, coopType, image)
    if not getElementClicked() then
        coopMenu["window"] = DGS:dgsCreateWindow(1015*sx, 494*sy, 531*sx, 453*sy, "", false)
        if image then
            -- // Bild sollte 520 x 180 sein
            local imageTexture = DGS:dgsCreateRemoteImage(image)
            coopMenu["logo"] = DGS:dgsCreateImage(1019*sx, 304*sy, 520*sx, 180*sy, imageTexture, false)   
        end
        DGS:dgsWindowSetMovable ( coopMenu["window"], false )
        DGS:dgsWindowSetSizable ( coopMenu["window"], false )
        setElementClicked ( true )
        showCursor(true)
        DGS:dgsSetInputEnabled( true )
        coopMenu["tabpanel"] = DGS:dgsCreateTabPanel(18*sx, 3*sy, 496*sx, 412*sy, false, coopMenu["window"])
        coopMenu["organ"] = DGS:dgsCreateTab("Verwaltung", coopMenu["tabpanel"])
        coopMenu["organ_stats"] = DGS:dgsCreateLabel(275*sx, 14*sy, 211*sx, 364*sy, "STATUS", false, coopMenu["organ"])

        coopMenu["organ_storage"] = DGS:dgsCreateGridList(14*sx, 14*sy, 133*sx, 123*sy, false, coopMenu["organ"] )
        coopMenu["organ_storage_item"] = DGS:dgsGridListAddColumn(coopMenu["organ_storage"], "Gegenstand", 0.9)
        DGS:dgsGridListSetItemText (coopMenu["organ_storage"], DGS:dgsGridListAddRow ( coopMenu["organ_storage"] ), coopMenu["organ_storage_item"], "Geld", false, false )
        if coopType == 2 then   
            DGS:dgsGridListSetItemText (coopMenu["organ_storage"], DGS:dgsGridListAddRow ( coopMenu["organ_storage"] ), coopMenu["organ_storage_item"], "Mats", false, false )
            DGS:dgsGridListSetItemText (coopMenu["organ_storage"], DGS:dgsGridListAddRow ( coopMenu["organ_storage"] ), coopMenu["organ_storage_item"], "Drogen", false, false )
        end
        coopMenu["organ_depo"] = DGS:dgsCreateButton(157*sx, 15*sy, 108*sx, 37*sy, "Einlagern", false, coopMenu["organ"] )
        coopMenu["organ_withdraw"] = DGS:dgsCreateButton(157*sx, 62*sy, 108*sx, 37*sy, "Entnehmen", false, coopMenu["organ"] )
        coopMenu["organ_number"] = DGS:dgsCreateEdit(159*sx, 109*sy, 106*sx, 28*sy, "", false, coopMenu["organ"] )
        coopMenu["organ_ranks"] = DGS:dgsCreateGridList(14*sx, 147*sy, 139*sx, 159*sy, false, coopMenu["organ"] )
        coopMenu["organ_ranks_rank"] = DGS:dgsGridListAddColumn(coopMenu["organ_ranks"], "Rangname", 0.9)
        coopMenu["organ_changerank"] = DGS:dgsCreateButton(159*sx, 150*sy, 106*sx, 33*sy, "Ändern", false, coopMenu["organ"] )
        coopMenu["organ_newrankname"] = DGS:dgsCreateEdit(159*sx, 193*sy, 108*sx, 37*sy, "", false, coopMenu["organ"] )

        DGS:dgsSetProperty(coopMenu["organ_number"],"placeHolder","Anzahl")
        DGS:dgsSetProperty(coopMenu["organ_newrankname"],"placeHolder","Rangnamen")

        addEventHandler( "onDgsMouseClick",  coopMenu["organ_changerank"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source ==  coopMenu["organ_changerank"] then
                local Selected = DGS:dgsGridListGetSelectedItem( coopMenu["organ_ranks"])
                if Selected ~= -1 then 
                    local rang = DGS:dgsGridListGetItemData( coopMenu["organ_ranks"],Selected,  coopMenu["organ_storage_item"])
                    local newName = DGS:dgsGetText(coopMenu["organ_newrankname"])
                    triggerServerEvent ( "setCoopRankName", lp, lp, rang, newName  )
                    refreshCoopData (coopID)
                else
                    newInfobox ( "Wähle den Rang.", 3)
                end
            end
        end)
        
        addEventHandler( "onDgsMouseClick", coopMenu["organ_depo"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == coopMenu["organ_depo"] then
                local Selected = DGS:dgsGridListGetSelectedItem(coopMenu["organ_storage"])
                if Selected ~= -1 then 
                    local name = DGS:dgsGridListGetItemText(coopMenu["organ_storage"],Selected,  coopMenu["organ_storage_item"])
                    local value = DGS:dgsGetText(coopMenu["organ_number"])
                    triggerServerEvent ( "executeAdminServerCMD", lp, "cdepot", "store "..name.." "..value )
                    refreshCoopData (coopID)
                else
                    newInfobox ( "Wähl aus was du Einlagern willst.", 3)
                end
            end
        end)

        addEventHandler( "onDgsMouseClick", coopMenu["organ_withdraw"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == coopMenu["organ_withdraw"] then
                local Selected = DGS:dgsGridListGetSelectedItem(coopMenu["organ_storage"])
                if Selected ~= -1 then 
                    local name = DGS:dgsGridListGetItemText(coopMenu["organ_storage"],Selected,  coopMenu["organ_storage_item"])
                    local value = DGS:dgsGetText(coopMenu["organ_number"])
                    triggerServerEvent ( "executeAdminServerCMD", lp, "cdepot", "take "..name.." "..value )
                else
                    newInfobox ( "Wähl aus was du Einlagern willst.", 3)
                end
            end
        end)

        coopMenu["members"] = DGS:dgsCreateTab("Mitglieder", coopMenu["tabpanel"])

        coopMenu["members_list"] = DGS:dgsCreateGridList(10*sx, 8*sy, 224*sx, 370*sy, false, coopMenu["members"])
        coopMenu["members_list_name"] =  DGS:dgsGridListAddColumn(coopMenu["members_list"], "Name", 0.5)
        coopMenu["members_list_online"] = DGS:dgsGridListAddColumn(coopMenu["members_list"], "Zuletzt online", 0.5)
        coopMenu["members_list_uninvite"] = DGS:dgsCreateButton(238*sx, 10*sy, 99*sx, 32*sy, "Uninviten", false, coopMenu["members"])
        coopMenu["members_list_invite"] = DGS:dgsCreateButton(238*sx, 52*sy, 99*sx, 32*sy, "Inviten", false, coopMenu["members"])
        coopMenu["members_playername"] = DGS:dgsCreateEdit(348*sx, 53*sy, 87*sx, 31*sy, "", false, coopMenu["members"])
        coopMenu["members_list_setrank"] = DGS:dgsCreateButton(239*sx, 94*sy, 99*sx, 32*sy, "Rang setzen", false, coopMenu["members"])
        coopMenu["members_list_newrank"] = DGS:dgsCreateEdit(348*sx, 94*sy, 87*sx, 31*sy, "", false, coopMenu["members"])

        DGS:dgsSetProperty(coopMenu["members_playername"],"placeHolder","Spielername")
        DGS:dgsSetProperty(coopMenu["members_list_newrank"],"placeHolder","Rang")


        addEventHandler( "onDgsMouseClick",  coopMenu["members_list_uninvite"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == coopMenu["members_list_uninvite"] then
                local Selected = DGS:dgsGridListGetSelectedItem(coopMenu["members_list"])
                if Selected ~= -1 then 
                    local name = DGS:dgsGridListGetItemText(coopMenu["members_list"], Selected, coopMenu["members_list_name"])
                    triggerServerEvent ( "executeAdminServerCMD", lp, "cuninvite", name )
                    refreshCoopData (coopID)
                end
            end
        end)

        addEventHandler( "onDgsMouseClick",  coopMenu["members_list_setrank"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == coopMenu["members_list_setrank"] then
                local Selected = DGS:dgsGridListGetSelectedItem(coopMenu["members_list"])
                if Selected ~= -1 then 
                    local name = DGS:dgsGridListGetItemText(coopMenu["members_list"], Selected, coopMenu["members_list_name"])
                    local rang = DGS:dgsGetText(coopMenu["members_list_newrank"])
                    if tonumber(rang) then

                        triggerServerEvent ( "executeAdminServerCMD", lp, "csetrang", name.." "..rang )
                        refreshCoopData (coopID)
                    end
                end
            end
        end)

        addEventHandler( "onDgsMouseClick",  coopMenu["members_list_invite"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source ==coopMenu["members_list_invite"] then
                local name = DGS:dgsGetText(coopMenu["members_playername"])
                triggerServerEvent ( "executeAdminServerCMD", lp, "cinvite", name )
            end
        end)

        coopMenu["vehicles"] = DGS:dgsCreateTab("Fahrzeuge", coopMenu["tabpanel"])

        coopMenu["vehicles_list"] = DGS:dgsCreateGridList(15*sx, 9*sy, 471*sx, 313*sy, false, coopMenu["vehicles"])
        coopMenu["vehicles_list_name"] = DGS:dgsGridListAddColumn(coopMenu["vehicles_list"], "Name", 0.2)
        coopMenu["vehicles_list_location"] = DGS:dgsGridListAddColumn(coopMenu["vehicles_list"], "Ort", 0.4)
        coopMenu["vehicles_list_rank"] = DGS:dgsGridListAddColumn(coopMenu["vehicles_list"], "Erf. Rang", 0.18)
        coopMenu["vehicles_list_fuel"] = DGS:dgsGridListAddColumn(coopMenu["vehicles_list"], "Benzinstand", 0.18)
        coopMenu["vehicles_find"] =DGS:dgsCreateButton(20*sx, 334*sy, 117*sx, 40*sy, "Orten", false, coopMenu["vehicles"])
        coopMenu["vehicles_sell"] = DGS:dgsCreateButton(147*sx, 334*sy, 117*sx, 40*sy, "Verkaufen", false, coopMenu["vehicles"])
        coopMenu["vehicles_setrank"] = DGS:dgsCreateButton(274*sx, 334*sy, 117*sx, 40*sy, "Rang setzen", false, coopMenu["vehicles"])
        coopMenu["vehicles_rank"] = DGS:dgsCreateEdit(399*sx, 336*sy, 77*sx, 38*sy, "", false, coopMenu["vehicles"])
        DGS:dgsSetProperty(coopMenu["vehicles_rank"],"placeHolder","Rang")


        
        addEventHandler( "onDgsMouseClick",  coopMenu["vehicles_setrank"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source ==  coopMenu["vehicles_setrank"] then
                local Selected = DGS:dgsGridListGetSelectedItem(coopMenu["vehicles_list"])
                if Selected ~= -1 then 
                    local veh = DGS:dgsGridListGetItemData(coopMenu["vehicles_list"],Selected, coopMenu["vehicles_list_name"])
                    local rang = DGS:dgsGetText(coopMenu["vehicles_rank"])
                    triggerServerEvent ( "setCooperationVehicleRang", lp, veh, rang )
                    refreshCoopData (coopID)
                end
            end
        end)

        addEventHandler( "onDgsMouseClick", coopMenu["vehicles_find"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == coopMenu["vehicles_find"] then
                local Selected = DGS:dgsGridListGetSelectedItem(coopMenu["vehicles_list"])
                if Selected ~= -1 then 
                    local veh = DGS:dgsGridListGetItemData(coopMenu["vehicles_list"],Selected, coopMenu["vehicles_list_name"])
                    triggerServerEvent ( "findCoopVehicle", lp, veh )
                end
            end
        end)

        addEventHandler( "onDgsMouseClick", coopMenu["vehicles_sell"], 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == coopMenu["vehicles_sell"] then
                local Selected = DGS:dgsGridListGetSelectedItem(coopMenu["vehicles_list"])
                if Selected ~= -1 then 
                    local veh = DGS:dgsGridListGetItemData(coopMenu["vehicles_list"],Selected, coopMenu["vehicles_list_name"])
                    triggerServerEvent ( "sellCoopVehicle", lp, veh )

                end
            end
        end)

        
        coopMenu["delete"] = DGS:dgsCreateTab("Auflösen", coopMenu["tabpanel"])

        coopMenu["delete_info"] = DGS:dgsCreateMemo(8*sx, 13*sy, 469*sx, 311*sy, "", false,  coopMenu["delete"])
        DGS:dgsSetProperty(coopMenu["delete_info"],"readOnly",true)
        coopMenu["delete_delete"] = DGS:dgsCreateButton(12*sx, 339*sy, 138*sx, 35*sy, "Löschen\n10000$ kosten", false,  coopMenu["delete"])
        coopMenu["delete_deactivate"] = DGS:dgsCreateButton(160*sx, 339*sy, 138*sx, 35*sy, "Deaktivieren", false, coopMenu["delete"])     

        addEventHandler( "onDgsWindowClose", coopMenu["window"], 
        function()
            setElementClicked ( false )
            showCursor(false)
            DGS:dgsSetInputEnabled( false )
            if isElement(coopMenu["logo"]) then
                destroyElement(coopMenu["logo"])
            end
        end)

        refreshCoopData (coopID)
    end
end
addEvent ( "openCoopMenu", true)
addEventHandler ( "openCoopMenu", getLocalPlayer(),  openCoopMenu)

refreshCoopDataCooldown = {}
function refreshCoopData (coopID)
     -- // Anti-Spam ( ja tabelle war unnötig ik )
    if not refreshCoopDataCooldown[getPlayerName(getLocalPlayer())] then
        refreshCoopDataCooldown[getPlayerName(getLocalPlayer())] = setTimer ( function()
            refreshCoopDataCooldown[getPlayerName(getLocalPlayer())] = nil
            if isElement( coopMenu["window"] ) then
                DGS:dgsGridListClear(coopMenu["organ_ranks"])
                DGS:dgsGridListClear(coopMenu["vehicles_list"])
                DGS:dgsGridListClear(coopMenu["members_list"])
                triggerServerEvent ( "getCoopMenuData", getLocalPlayer(), getLocalPlayer(), coopID ) 
            end
        end, 5000, 1 )

        DGS:dgsGridListClear(coopMenu["organ_ranks"])
        DGS:dgsGridListClear(coopMenu["vehicles_list"])
        DGS:dgsGridListClear(coopMenu["members_list"])
        triggerServerEvent ( "getCoopMenuData", getLocalPlayer(), getLocalPlayer(), coopID ) 
    else 
        infobox_start_func ( "Warte bitte...", 7500, 125, 0, 0 )
    end
end
addEvent ( "refreshCoopData", true)
addEventHandler ( "refreshCoopData", getLocalPlayer(),  refreshCoopData)

function setCoopMenuData (storedMoney, storedDrugs, storedMats, coopLevel, coopTuningLevel, coopMaxVehicles )

    DGS:dgsSetText(coopMenu["organ_stats"], "Geld: "..storedMoney.."\nDrogen: "..storedDrugs.."\nMats: "..storedMats.."\nLevel: "..coopLevel.."\nTuning-Level: "..coopTuningLevel.."\nMax. Fahrzeuge: "..coopMaxVehicles)
end
addEvent ( "setCoopMenuData", true)
addEventHandler ( "setCoopMenuData", getLocalPlayer(),  setCoopMenuData)

rankMoneyClient = {}
function addToCoopGridlist (liste, value1, value2, value3, value4)

    if liste == "ranks" then
        local row = DGS:dgsGridListAddRow (  coopMenu["organ_ranks"] )
        DGS:dgsGridListSetItemText (  coopMenu["organ_ranks"], row,  coopMenu["organ_ranks_rank"], value1, false, false )
        DGS:dgsGridListSetItemData ( coopMenu["organ_ranks"], row,coopMenu["organ_ranks_rank"], value2 )
        
    elseif liste == "vehicles" then
        local row = DGS:dgsGridListAddRow (  coopMenu["vehicles_list"] )
        DGS:dgsGridListSetItemText (  coopMenu["vehicles_list"], row,  coopMenu["vehicles_list_name"], getVehicleName(value1), false, false )
        DGS:dgsGridListSetItemText (  coopMenu["vehicles_list"], row,  coopMenu["vehicles_list_location"], value2, false, false )
        DGS:dgsGridListSetItemText (  coopMenu["vehicles_list"], row,  coopMenu["vehicles_list_rank"], value3, false, false )
        DGS:dgsGridListSetItemText (  coopMenu["vehicles_list"], row,  coopMenu["vehicles_list_fuel"], math.floor(value4).."%", false, false )
        DGS:dgsGridListSetItemData ( coopMenu["vehicles_list"], row,coopMenu["vehicles_list_name"], value1 )
    elseif liste == "members" then
        local row = DGS:dgsGridListAddRow (  coopMenu["members_list"] )
        
        DGS:dgsGridListSetItemText ( coopMenu["members_list"], row,  coopMenu["members_list_name"], value1, false, false )
        if value2 == "on" then
            DGS:dgsGridListSetItemText (  coopMenu["members_list"], row, coopMenu["members_list_online"], "Online", false, false )
            DGS:dgsGridListSetItemColor ( coopMenu["members_list"], row, coopMenu["members_list_online"], 21, 189, 29 )
        else
            DGS:dgsGridListSetItemText (  coopMenu["members_list"], row, coopMenu["members_list_online"], getData(value2), false, false )
            DGS:dgsGridListSetItemColor ( coopMenu["members_list"], row, coopMenu["members_list_online"], 189, 38, 21 )
        end
    end
end
addEvent ( "addToCoopGridlist", true)
addEventHandler ( "addToCoopGridlist", getLocalPlayer(),  addToCoopGridlist)