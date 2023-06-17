
local x, y = DGS:dgsGetScreenSize()
local sx, sy = x/2560, y/1440
adminPanelUI = {}
adminPanelUI.NeededRank = {}

local respawnList = {
    [1] = "sfpd",
    [2] = "mafia",
    [3] = "triaden",
    [4] = "terror",
    [5] = "news",
    [6] = "fbi",
    [7] = "aztecas",
    [8] = "army",
    [9] = "biker",
    [10] = "medic",
    [11] = "mechanic",
    [12] = "ballas",
    [13] = "grove",
    [14] = "taxi",
    [15] = "hotdog",
    [16] = "fishing"
}

local logsTypes = { ["allround"] = 1, ["admin"] = 2, ["damage"] = 3, ["Heilung"] = 4, ["Chat"] = 5, ["aktion"] = 6, ["Armor"] = 7, ["autodelete"] = 8, ["b-Chat"] = 9, ["casino"] = 10, 
					["death"] = 11, ["dmg"] = 12, ["drogen"] = 13, ["explodecar"] = 14, ["fguns"] = 15, ["fkasse"] = 16, ["gangwar"] = 17, ["Geld"] = 18, ["house"] = 19, ["kill"] = 20,
					["pwchange"] = 21, ["sellcar"] = 22, ["vehicle"] = 23, ["tazer"] = 24, ["Team-Chat"] = 25, ["weed"] = 26, ["werbung"] = 27,["fraktion"] = 28, ["factionmsg"] = 29 }

function showAdminPanel ()
    local adminlevel = getElementData(getLocalPlayer(), "adminlvlShow")
    if oneTabIsOpen == false then
            -- adminPanel_createPlayerBase
            adminPanelUI["window"] = DGS:dgsCreateWindow(831*sx, 165*sy, 828*sx, 491*sy, "Adminpanel", false)
            addEventHandler("onDgsWindowClose", adminPanelUI["window"],oneTabClose)
            oneTabIsOpen = true
            DGS:dgsWindowSetMovable ( adminPanelUI["window"], false )
		    DGS:dgsWindowSetSizable ( adminPanelUI["window"], false )
		    DGS:dgsWindowSetCloseButtonEnabled(adminPanelUI["window"], true)
            -- // Tabpanel wo man zwischen Fraktion, Spielerbasiert etc. wechseln kann
            adminPanelUI["adminselectPanel"] = DGS:dgsCreateTabPanel(9*sx, 9*sy, 809*sx, 441*sy, false, adminPanelUI["window"])

            -- // Spielerbasierte interaktionen
                adminPanelUI["playerbased_tb"]  = DGS:dgsCreateTab("Spielerbasiert", adminPanelUI["adminselectPanel"])
        
                adminPanelUI["playerlist"] = DGS:dgsCreateGridList(11*sx, 13*sy, 159*sx, 385*sy, false, adminPanelUI["playerbased_tb"])
                adminPanelUI["playerlist_name"] = DGS:dgsGridListAddColumn( adminPanelUI["playerlist"], "Name", 1 )
                DGS:dgsSetProperty( adminPanelUI["playerlist"],"rowHeight",18)
                refreshAdminPanels ()

                adminPanelUI["playername"] = DGS:dgsCreateEdit(180*sx, 15*sy, 111*sx, 35*sy, "", false, adminPanelUI["playerbased_tb"])
                DGS:dgsSetProperty(adminPanelUI["playername"],"placeHolder","Spielername")
                DGS:dgsCreateTabPanel(181*sx, 57*sy, 618*sx, 345*sy, false, adminPanelUI["playerbased_tb"])
                DGS:dgsCreateLabel(303*sx, 17*sy, 479*sx, 33*sy, "Zeiten: Warns = Tage, Time-Ban: Stunden, Fraktion-Ban: Stunden (0=permanent)", false,adminPanelUI["playerbased_tb"])  

                -- Auswahlen der verschiedenen Interaktions-Arten
                adminPanelUI["playerbased_tb_overview"] = DGS:dgsCreateTabPanel(181*sx, 57*sy, 618*sx, 305*sy, false,adminPanelUI["playerbased_tb"])
                DGS:dgsSetProperty(adminPanelUI["playerbased_tb_overview"],"bgColor",tocolor(36, 35, 34, 255))
                
                adminPanelUI["playerbased_base_tb"] = DGS:dgsCreateTab("Grundbasis",   adminPanelUI["playerbased_tb_overview"])
                DGS:dgsSetProperty(adminPanelUI["playerbased_base_tb"],"tabColor", {tocolor ( 51, 51, 56, 255 ),tocolor ( 94, 94, 102, 255 ),tocolor ( 128, 128, 135,255 )} )
                
                adminPanelUI["playerbased_base_ban"] = DGS:dgsCreateButton(12*sx, 10*sy, 130*sx, 47*sy, "Bannen", false, adminPanelUI["playerbased_base_tb"])
                adminPanelUI["playerbased_base_kick"] = DGS:dgsCreateButton(12*sx, 67*sy, 130*sx, 47*sy, "Kicken", false, adminPanelUI["playerbased_base_tb"])
                adminPanelUI["playerbased_base_warn"] = DGS:dgsCreateButton(12*sx, 124*sy, 130*sx, 47*sy, "Verwarnen", false, adminPanelUI["playerbased_base_tb"])
                adminPanelUI["playerbased_base_time"] = DGS:dgsCreateEdit(12*sx, 181*sy, 127*sx, 37*sy, "", false, adminPanelUI["playerbased_base_tb"])
                adminPanelUI["playerbased_base_reason"] = DGS:dgsCreateEdit(12*sx, 228*sy, 127*sx, 37*sy, "", false, adminPanelUI["playerbased_base_tb"])
                DGS:dgsSetProperty(adminPanelUI["playerbased_base_time"],"placeHolder","Zeit (siehe oben)")
                DGS:dgsSetProperty(adminPanelUI["playerbased_base_reason"],"placeHolder","Grund")
                adminPanelUI["playerbased_base_goto"] = DGS:dgsCreateButton(152*sx, 10*sy, 130*sx, 47*sy, "Hin teleportieren", false, adminPanelUI["playerbased_base_tb"])
                adminPanelUI["playerbased_base_gethere"] = DGS:dgsCreateButton(152*sx, 67*sy, 130*sx, 47*sy, "Her teleportieren", false, adminPanelUI["playerbased_base_tb"])
                adminPanelUI["playerbased_base_skydrive"] = DGS:dgsCreateButton(152*sx, 124*sy, 130*sx, 47*sy, "Skydriven", false, adminPanelUI["playerbased_base_tb"])


                adminPanelUI["playerbased_base_gotocar"] = DGS:dgsCreateButton(292*sx, 10*sy, 130*sx, 47*sy, "Zu Fahrzeug\ngehen", false,adminPanelUI["playerbased_base_tb"])
                adminPanelUI["playerbased_base_getcar"] = DGS:dgsCreateButton(292*sx, 67*sy, 130*sx, 47*sy, "Fahrzeug her\nteleportieren", false, adminPanelUI["playerbased_base_tb"])
                adminPanelUI["playerbased_base_slot"] = DGS:dgsCreateEdit(295*sx, 124*sy, 127*sx, 47*sy, "", false, adminPanelUI["playerbased_base_tb"])
                DGS:dgsSetProperty(adminPanelUI["playerbased_base_slot"],"placeHolder","Slot")
			

                -- // Events
                    addEventHandler( "onDgsMouseClick",adminPanelUI["playerbased_base_gotocar"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_base_gotocar"] then
                            local slot = tonumber(DGS:dgsGetText(adminPanelUI["playerbased_base_slot"]))
                            local name = getSelectedNameFromAdminPanel ()
                            triggerServerEvent ( "executeAdminServerCMD", lp, "gotocar", name.." "..slot)
                        end
                    end)

                    addEventHandler( "onDgsMouseClick",adminPanelUI["playerbased_base_getcar"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_base_getcar"] then
                            local slot = tonumber(DGS:dgsGetText(adminPanelUI["playerbased_base_slot"]))
                            local name = getSelectedNameFromAdminPanel ()
                            triggerServerEvent ( "executeAdminServerCMD", lp, "getcar", name.." "..slot)
                        end
                    end)

                    addEventHandler( "onDgsMouseClick", adminPanelUI["playerbased_base_ban"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_base_ban"] then
                            local name = getSelectedNameFromAdminPanel ()
                            local timeEdit, reasonEdit = tonumber( DGS:dgsGetText(adminPanelUI["playerbased_base_time"])), DGS:dgsGetText(adminPanelUI["playerbased_base_reason"])
                            if timeEdit == 0 then
                                triggerServerEvent ( "executeAdminServerCMD", lp, "rban", name.." "..reasonEdit )
                            else
                                triggerServerEvent ( "executeAdminServerCMD", lp, "tban", name.." "..timeEdit.." "..reasonEdit )
                            end
                        end
                    end)

                    addEventHandler( "onDgsMouseClick", adminPanelUI["playerbased_base_kick"], 
                        function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_base_kick"] then
                                local name = getSelectedNameFromAdminPanel ()
                                local reasonEdit =  DGS:dgsGetText(adminPanelUI["playerbased_base_reason"])
                                triggerServerEvent ( "executeAdminServerCMD", lp, "rkick", name.." "..reasonEdit )
                            end
                    end)


                    addEventHandler( "onDgsMouseClick", adminPanelUI["playerbased_base_warn"], 
                        function(button, state, x, y)
                            if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_base_warn"] then
                                local name = getSelectedNameFromAdminPanel ()
                                local timeEdit, reasonEdit = tonumber( DGS:dgsGetText(adminPanelUI["playerbased_base_time"])), DGS:dgsGetText(adminPanelUI["playerbased_base_reason"])
                         --       triggerServerEvent ( "warn", lp, name, timeEdit, reasonEdit )
                            end
                        end)
                    
                    addEventHandler( "onDgsMouseClick", adminPanelUI["playerbased_base_goto"], 
                        function(button, state, x, y)
                        if button == 'left' and state == 'up' and source ==adminPanelUI["playerbased_base_goto"] then
                                local name = getSelectedNameFromAdminPanel ()
                                triggerServerEvent ( "executeAdminServerCMD", lp, "goto", name )
                            end
                        end)
                    addEventHandler( "onDgsMouseClick", adminPanelUI["playerbased_base_gethere"], 
                        function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_base_gethere"] then
                                local name = getSelectedNameFromAdminPanel ()
                                triggerServerEvent ( "executeAdminServerCMD", lp, "gethere", name )
                            end
                        end)
            
                    addEventHandler( "onDgsMouseClick", adminPanelUI["playerbased_base_skydrive"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source ==adminPanelUI["playerbased_base_skydrive"] then
                            local name = getSelectedNameFromAdminPanel ()
                            triggerServerEvent ( "executeAdminServerCMD", lp, "skydive", name )
                        end
                    end)
           
            -- // Fraktionbasiert
                adminPanelUI["playerbased_faction_tb"] = DGS:dgsCreateTab("Fraktion",adminPanelUI["playerbased_tb_overview"])
                DGS:dgsSetProperty(adminPanelUI["playerbased_faction_tb"],"tabColor", {tocolor ( 51, 51, 56, 255 ),tocolor ( 94, 94, 102, 255 ),tocolor ( 128, 128, 135,255 )} )

                adminPanelUI["playerbased_faction_makeleader"] =  DGS:dgsCreateButton(12*sx, 67*sy, 130*sx, 47*sy, "Leader setzen", false, adminPanelUI["playerbased_faction_tb"])
                adminPanelUI["playerbased_faction_setrang"] =  DGS:dgsCreateButton(12*sx, 124*sy, 130*sx, 47*sy, "Rang setzen", false, adminPanelUI["playerbased_faction_tb"])
                adminPanelUI["playerbased_faction_rangfaction"] = DGS:dgsCreateEdit(14*sx, 180*sy, 128*sx, 46*sy, "", false, adminPanelUI["playerbased_faction_tb"])
                DGS:dgsSetProperty(adminPanelUI["playerbased_faction_rangfaction"],"placeHolder","Rang / FraktionID")
                adminPanelUI["playerbased_faction_resetztime"] = DGS:dgsCreateButton(12*sx, 10*sy, 130*sx, 47*sy, "Zivilzeit\nzurücksetzen", false, adminPanelUI["playerbased_faction_tb"])
                adminPanelUI["playerbased_faction_givefactionban"] = DGS:dgsCreateButton(152*sx, 10*sy, 130*sx, 47*sy, "Fraktionsban geben", false, adminPanelUI["playerbased_faction_tb"])
                adminPanelUI["playerbased_faction_bantime"] = DGS:dgsCreateEdit(152*sx, 67*sy, 128*sx, 46*sy, "", false, adminPanelUI["playerbased_faction_tb"])
                adminPanelUI["playerbased_faction_banreason"] =  DGS:dgsCreateEdit(152*sx, 125*sy, 128*sx, 46*sy, "", false, adminPanelUI["playerbased_faction_tb"])
                DGS:dgsSetProperty(adminPanelUI["playerbased_faction_bantime"],"placeHolder","Zeit (siehe oben)")
                DGS:dgsSetProperty( adminPanelUI["playerbased_faction_banreason"],"placeHolder","Grund")
                adminPanelUI["playerbased_other_tb"] =  DGS:dgsCreateTab("Anderes",adminPanelUI["playerbased_tb_overview"])
                DGS:dgsSetProperty(adminPanelUI["playerbased_base_tb"],"tabColor", {tocolor ( 51, 51, 56, 255 ),tocolor ( 94, 94, 102, 255 ),tocolor ( 128, 128, 135,255 )} )
                
                -- // Events
                    addEventHandler( "onDgsMouseClick",adminPanelUI["playerbased_faction_makeleader"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_faction_makeleader"] then
                            local name = getSelectedNameFromAdminPanel ()
                            local factionID = tonumber( DGS:dgsGetText( adminPanelUI["playerbased_faction_rangfaction"]))
                            triggerServerEvent ( "executeAdminServerCMD", lp, "makeleader", name.." "..factionID )
                        end
                    end)

                    addEventHandler( "onDgsMouseClick",adminPanelUI["playerbased_faction_setrang"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_faction_setrang"] then
                            local name = getSelectedNameFromAdminPanel ()
                            local rank = tonumber( DGS:dgsGetText( adminPanelUI["playerbased_faction_rangfaction"]))
                            triggerServerEvent ( "executeAdminServerCMD", lp, "setrank", name.." "..rank )
                        end
                    end)

                    addEventHandler( "onDgsMouseClick",adminPanelUI["playerbased_faction_resetztime"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_faction_resetztime"] then
                            local name = getSelectedNameFromAdminPanel ()
                            triggerServerEvent ( "executeAdminServerCMD", lp, "dfban", name)
                        end
                    end)

                    addEventHandler( "onDgsMouseClick",adminPanelUI["playerbased_faction_givefactionban"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["playerbased_faction_givefactionban"] then
                            local name = getSelectedNameFromAdminPanel ()
                            local banTime, banReason = tonumber( DGS:dgsGetText( adminPanelUI["playerbased_faction_bantime"])), DGS:dgsGetText(adminPanelUI["playerbased_faction_banreason"])
                            triggerServerEvent ( "executeAdminServerCMD", lp, "fban", name.." "..banTime.." "..banReason )
                        end
                    end)


            -- // Respawnen
            adminPanelUI["respawn_tb"]  = DGS:dgsCreateTab("Respawnen", adminPanelUI["adminselectPanel"])

            adminPanelUI["respawn_list"] = DGS:dgsCreateGridList(11*sx, 13*sy, 159*sx, 385*sy, false, adminPanelUI["respawn_tb"])
            adminPanelUI["respawn_list_name"] = DGS:dgsGridListAddColumn( adminPanelUI["respawn_list"], "Name", 1 )
            adminPanelUI["respawn_respawn"] = DGS:dgsCreateButton(181*sx, 16*sy, 110*sx, 43*sy, "Respawnen", false, adminPanelUI["respawn_tb"])
            adminPanelUI["respawn_crespawn"] = DGS:dgsCreateButton(181*sx, 69*sy, 110*sx, 43*sy, "Alles im Umkreis\nrespawnen", false, adminPanelUI["respawn_tb"])
            adminPanelUI["respawn_respawnmeter"] = DGS:dgsCreateEdit(181*sx, 122*sy, 110*sx, 35*sy, "", false, adminPanelUI["respawn_tb"])
            local row = DGS:dgsGridListAddRow ( adminPanelUI["respawn_list"] )
            DGS:dgsGridListSetItemText ( adminPanelUI["respawn_list"], row, adminPanelUI["respawn_list_name"], "Fraktionen", false, false )
            DGS:dgsGridListSetItemColor( adminPanelUI["respawn_list"], row, adminPanelUI["respawn_list_name"], 45, 194, 84  )
            DGS:dgsGridListSetRowAsSection ( adminPanelUI["respawn_list"], row, true )

            DGS:dgsSetProperty( adminPanelUI["respawn_respawnmeter"],"placeHolder","Meter")
            for i, var in ipairs(respawnList) do
                local row = DGS:dgsGridListAddRow ( adminPanelUI["respawn_list"] )
		        DGS:dgsGridListSetItemText ( adminPanelUI["respawn_list"], row, adminPanelUI["respawn_list_name"], var, false, false )
                if i == 1 then
                    DGS:dgsSetProperty(adminPanelUI["respawn_list"],"preSelect",{i, adminPanelUI["respawn_list_name"]})
                end
                if i == 13 then -- // Nach der letzten Fraktion
                    local row = DGS:dgsGridListAddRow ( adminPanelUI["respawn_list"] )
                    DGS:dgsGridListSetItemText ( adminPanelUI["respawn_list"], row, adminPanelUI["respawn_list_name"], "Jobs", false, false )
                    DGS:dgsGridListSetItemColor( adminPanelUI["respawn_list"], row, adminPanelUI["respawn_list_name"], 45, 194, 84  )
                    DGS:dgsGridListSetRowAsSection ( adminPanelUI["respawn_list"], row, true )
                end

            end
            
                -- Events
                    addEventHandler( "onDgsMouseClick", adminPanelUI["respawn_respawn"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["respawn_respawn"] then
                            local Selected = DGS:dgsGridListGetSelectedItem(adminPanelUI["respawn_list"])
                            if Selected ~= -1 then 
                                local respawnName = DGS:dgsGridListGetItemText(adminPanelUI["respawn_list"], Selected, adminPanelUI["respawn_list_name"])
                                triggerServerEvent ( "executeAdminServerCMD", lp, "respawn", respawnName )
                            end
                        end
                    end)

                    addEventHandler( "onDgsMouseClick", adminPanelUI["respawn_crespawn"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["respawn_crespawn"] then
                                local respawnRadius = tonumber( DGS:dgsGetText( adminPanelUI["respawn_respawnmeter"] ) )
                                triggerServerEvent ( "executeAdminServerCMD", lp, "crespawn", respawnRadius )
                            end
                    end)

            -- // Unternehmen
            adminPanelUI["coop_tb"]  = DGS:dgsCreateTab("Unternehmen", adminPanelUI["adminselectPanel"])

            adminPanelUI["coop_tb_coopList"] = DGS:dgsCreateGridList(11*sx, 13*sy, 155*sx, 394*sy, false,adminPanelUI["coop_tb"])
            adminPanelUI["coop_tb_coopList_id"] = DGS:dgsGridListAddColumn(adminPanelUI["coop_tb_coopList"], "ID", 0.2)
            adminPanelUI["coop_tb_coopList_name"] = DGS:dgsGridListAddColumn(adminPanelUI["coop_tb_coopList"], "Name", 0.8)
            DGS:dgsCreateLabel(221*sx, 13*sy, 57*sx, 31*sy, "Mitglieder", false, adminPanelUI["coop_tb"])
            adminPanelUI["coop_tb_coopMemberList"] = DGS:dgsCreateGridList(176*sx, 53*sy, 147*sx, 354*sy, false, adminPanelUI["coop_tb"])
            adminPanelUI["coop_tb_coopMemberList_name"] = DGS:dgsGridListAddColumn( adminPanelUI["coop_tb_coopMemberList"], "Name", 0.6)
            adminPanelUI["coop_tb_coopMemberList_state"] = DGS:dgsGridListAddColumn( adminPanelUI["coop_tb_coopMemberList"], "Status", 0.4)
            DGS:dgsCreateLabel(389*sx, 13*sy, 57*sx, 31*sy, "Fahrzeuge", false, adminPanelUI["coop_tb"])
            adminPanelUI["coop_tb_coopVehicleList"] = DGS:dgsCreateGridList(333*sx, 54*sy, 170*sx, 353*sy, false, adminPanelUI["coop_tb"])
            adminPanelUI["coop_tb_coopVehicleList_name"] = DGS:dgsGridListAddColumn(adminPanelUI["coop_tb_coopVehicleList"], "Name", 1)
            adminPanelUI["coop_tb_stats"] = DGS:dgsCreateLabel(514*sx, 55*sy, 133*sx, 352*sy, "", false, adminPanelUI["coop_tb"])
            triggerServerEvent ( "fillCooperationList", getLocalPlayer(), getLocalPlayer() ) 

            -- // Events
                addEventHandler( "onDgsMouseDoubleClick", adminPanelUI["coop_tb_coopList"], 
                function(button, state, x, y)
                    if button == 'left' and state == 'up' and source == adminPanelUI["coop_tb_coopList"] then
                            local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(adminPanelUI["coop_tb_coopList"])
                            if Selected ~= -1 then 
                                local id = DGS:dgsGridListGetItemText(adminPanelUI["coop_tb_coopList"],Selected, adminPanelUI["coop_tb_coopList_id"])
                                DGS:dgsGridListClear(adminPanelUI["coop_tb_coopMemberList"])
                                DGS:dgsGridListClear(adminPanelUI["coop_tb_coopVehicleList"])
                                triggerServerEvent ( "getCooperationDetails", getLocalPlayer(), getLocalPlayer(), id ) 
                                triggerServerEvent ( "fillCooperationVehList", getLocalPlayer(), getLocalPlayer(), id) 
                                triggerServerEvent ( "fillCooperationMemberList", getLocalPlayer(), getLocalPlayer(), id ) 
                            end
                    end
                end)
            -- // Logs
            adminPanelUI["logs_tb"]  = DGS:dgsCreateTab("Logs", adminPanelUI["adminselectPanel"])

            adminPanelUI["logs_list"] = DGS:dgsCreateGridList(12*sx, 12*sy, 602*sx, 395*sy, false, adminPanelUI["logs_tb"])
            adminPanelUI["logs_list_faction"] = DGS:dgsGridListAddColumn(adminPanelUI["logs_list"], "Fraktion", 0.3)
            adminPanelUI["logs_list_logtype"] = DGS:dgsGridListAddColumn(adminPanelUI["logs_list"], "Log-Art", 0.3)
            adminPanelUI["logs_list_date"] = DGS:dgsGridListAddColumn(adminPanelUI["logs_list"], "Datum", 0.3)
            adminPanelUI["logs_types"] = DGS:dgsCreateComboBox(621*sx, 14*sy, 178*sx, 20*sy, "", false, adminPanelUI["logs_tb"])
            
            for i, type in pairs(logsTypes) do
                DGS:dgsComboBoxAddItem(adminPanelUI["logs_types"], i)
            end
            DGS:dgsComboBoxSetSelectedItem(adminPanelUI["logs_types"], 1)

            
            adminPanelUI["logs_playername"] = DGS:dgsCreateEdit(625*sx, 70*sy, 174*sx, 40*sy, "", false, adminPanelUI["logs_tb"])
            adminPanelUI["logs_dateFrom"] = DGS:dgsCreateEdit(624*sx, 127*sy, 175*sx, 40*sy, "", false, adminPanelUI["logs_tb"])
            adminPanelUI["logs_dateTo"] = DGS:dgsCreateEdit(625*sx, 177*sy, 175*sx, 40*sy, "", false, adminPanelUI["logs_tb"])
            DGS:dgsSetProperty( adminPanelUI["logs_playername"],"placeHolder","Spielername")
            DGS:dgsSetProperty( adminPanelUI["logs_dateFrom"],"placeHolder","Datum Von (TT.MM.YYYY)")
            DGS:dgsSetProperty( adminPanelUI["logs_dateTo"],"placeHolder","Datum Bis (TT.MM.YYYY)")
            adminPanelUI["logs_search"] = DGS:dgsCreateButton(655*sx, 230*sy, 113*sx, 33*sy, "Suchen", false, adminPanelUI["logs_tb"])
            adminPanelUI["logs_delete"] = DGS:dgsCreateButton(655*sx, 300*sy, 113*sx, 33*sy, "Logs älter als\n7 Tage löschen", false, adminPanelUI["logs_tb"])
            adminPanelUI["logs_deeplog"] = DGS:dgsCreateCheckBox(625*sx, 269*sy, 174*sx, 29*sy, "Deep-Log nutzen", false, false, adminPanelUI["logs_tb"])
            refreshLogs ()
            
            
            addEventHandler( "onDgsComboBoxSelect", adminPanelUI["logs_types"], 
                    function(current,previous)
                        if current ~=  previous then
                            refreshLogs ()
                        end
                    end)

            addEventHandler( "onDgsMouseClick", adminPanelUI["logs_delete"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["logs_delete"] then
                            triggerServerEvent ( "deleteLogsFromMySQL", lp, lp )
                        end
                    end)

            addEventHandler( "onDgsMouseClick", adminPanelUI["logs_search"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["logs_search"] then
                            refreshLogs ()
                            end
                    end)
                    -- Vorher Double click
            addEventHandler( "onDgsMouseClick", adminPanelUI["logs_list"], 
            function(button, state, x, y)
                if button == 'left' and state == 'up' and source == adminPanelUI["logs_list"] then
                        local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(adminPanelUI["logs_list"])
                        if Selected ~= -1 then 
                            local text = DGS:dgsGridListGetItemData(adminPanelUI["logs_list"],Selected, adminPanelUI["logs_list_logtype"])
                            DGS:dgsSetText(adminPanelUI["logs_tb_loginfowindow_text"], text)
                            
                        end
                end
            end)
            
            addEventHandler( "onDgsTabSelect", adminPanelUI["adminselectPanel"], 
            function(new, old)
                if new == 4 then -- // ID vom Tab "Logs"
                    adminPanelUI["logs_tb_loginfowindow"] =  DGS:dgsCreateWindow(821*sx, 666*sy, 848*sx, 211*sy, "Logeinsicht", false)
                    DGS:dgsWindowSetCloseButtonEnabled(adminPanelUI["logs_tb_loginfowindow"], false)
                    adminPanelUI["logs_tb_loginfowindow_text"] =  DGS:dgsCreateMemo(9*sx, 2*sy, 829*sx, 181*sy, "", false, adminPanelUI["logs_tb_loginfowindow"])   
                else
                    if isElement(adminPanelUI["logs_tb_loginfowindow"]) then
                        DGS:dgsCloseWindow(adminPanelUI["logs_tb_loginfowindow"])
                    end
                end
            end)

            -- // Bans
            adminPanelUI["bans_tb"]  = DGS:dgsCreateTab("Bans", adminPanelUI["adminselectPanel"])
            adminPanelUI["bans_list"] = DGS:dgsCreateGridList(7*sx, 12*sy, 792*sx, 317*sy, false, adminPanelUI["bans_tb"])
            adminPanelUI["bans_list_uid"] = DGS:dgsGridListAddColumn(adminPanelUI["bans_list"], "UID", 0.1)
            adminPanelUI["bans_list_name"] = DGS:dgsGridListAddColumn(adminPanelUI["bans_list"], "Name", 0.2)
            adminPanelUI["bans_list_bannedFrom"] = DGS:dgsGridListAddColumn(adminPanelUI["bans_list"], "Von", 0.2)
            adminPanelUI["bans_list_reason"] = DGS:dgsGridListAddColumn(adminPanelUI["bans_list"], "Grund", 0.2)
            adminPanelUI["bans_list_date"] = DGS:dgsGridListAddColumn(adminPanelUI["bans_list"], "Datum", 0.2)
            adminPanelUI["bans_list_time"] = DGS:dgsGridListAddColumn(adminPanelUI["bans_list"], "Zeit", 0.1)
            adminPanelUI["bans_search"]= DGS:dgsCreateButton(11*sx, 339*sy, 182*sx, 34*sy, "Suchen", false, adminPanelUI["bans_tb"])
            adminPanelUI["bans_uid"] = DGS:dgsCreateEdit(11*sx, 380*sy, 182*sx, 27*sy, "", false, adminPanelUI["bans_tb"])
            DGS:dgsSetProperty(adminPanelUI["bans_uid"],"placeHolder","UID")
            adminPanelUI["bans_unban"] = DGS:dgsCreateButton(203*sx, 339*sy, 106*sx, 34*sy, "Entbannen", false, adminPanelUI["bans_tb"])
            refreshBans ()

            addEventHandler( "onDgsMouseClick",  adminPanelUI["bans_search"], 
            function(button, state, x, y)
                if button == 'left' and state == 'up' and source ==  adminPanelUI["bans_search"] then
                    refreshBans ()
                    end
            end)
            addEventHandler( "onDgsMouseClick",  adminPanelUI["bans_unban"], 
                function(button, state, x, y)
                    if button == 'left' and state == 'up' and source == adminPanelUI["bans_unban"] then
                        local Selected = DGS:dgsGridListGetSelectedItem(adminPanelUI["bans_list"])
                            if Selected ~= -1 then 
                                local banName = DGS:dgsGridListGetItemText(adminPanelUI["bans_list"], Selected, adminPanelUI["bans_list_name"])
                                triggerServerEvent ( "executeAdminServerCMD", lp, "runban", banName )
                                refreshBans ()
                            end
                    end
                end)

            -- // PSC
                if adminlevel == 8 then
                    adminPanelUI["psc_tb"]  = DGS:dgsCreateTab("Paysafecards", adminPanelUI["adminselectPanel"])
                    adminPanelUI["psc_list"] = DGS:dgsCreateGridList(7*sx, 16*sy, 569*sx, 391*sy, false, adminPanelUI["psc_tb"])
                    adminPanelUI["psc_list_uid"] = DGS:dgsGridListAddColumn(adminPanelUI["psc_list"], "UID", 0.1)
                    adminPanelUI["psc_list_name"] = DGS:dgsGridListAddColumn(adminPanelUI["psc_list"], "Name", 0.2)
                    adminPanelUI["psc_list_pin"] = DGS:dgsGridListAddColumn(adminPanelUI["psc_list"], "PIN", 0.4)
                    adminPanelUI["psc_list_value"] = DGS:dgsGridListAddColumn(adminPanelUI["psc_list"], "Wert", 0.1)
                    adminPanelUI["psc_giveCoins"] = DGS:dgsCreateButton(586*sx, 19*sy, 213*sx, 49*sy, "Coins gutschreiben", false, adminPanelUI["psc_tb"])
                    adminPanelUI["psc_delete"] = DGS:dgsCreateButton(586*sx, 78*sy, 213*sx, 49*sy, "Anfrage löschen", false, adminPanelUI["psc_tb"])
                
                    refreshPsc ()
                    addEventHandler( "onDgsMouseClick",  adminPanelUI["psc_giveCoins"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["psc_giveCoins"] then
                            local Selected = DGS:dgsGridListGetSelectedItem( adminPanelUI["psc_list"])
                                if Selected ~= -1 then 
                                    local uid = DGS:dgsGridListGetItemText( adminPanelUI["psc_list"], Selected,  adminPanelUI["psc_list_uid"])
                                    triggerServerEvent ( "givePlayerCoins", lp, lp, uid )
                                    refreshPsc ()
                                end
                        end
                    end)

                    addEventHandler( "onDgsMouseClick", adminPanelUI["psc_delete"], 
                    function(button, state, x, y)
                        if button == 'left' and state == 'up' and source == adminPanelUI["psc_delete"] then
                            local Selected = DGS:dgsGridListGetSelectedItem( adminPanelUI["psc_list"])
                                if Selected ~= -1 then 
                                    local uid = DGS:dgsGridListGetItemText( adminPanelUI["psc_list"], Selected,  adminPanelUI["psc_list_uid"])
                                    triggerServerEvent ( "deletePsc", lp, lp, uid )
                                    refreshPsc ()
                                end
                        end
                    end)
                end
        end
end

function refreshPsc ()
    DGS:dgsGridListClear(adminPanelUI["psc_list"])
    triggerServerEvent ( "fillPaysafecardList", getLocalPlayer(), getLocalPlayer() ) 
end

function addPscToList (uid, name, code, value)
    local row = DGS:dgsGridListAddRow ( adminPanelUI["psc_list"] )
    local logType = type
    DGS:dgsGridListSetItemText ( adminPanelUI["psc_list"], row,  adminPanelUI["psc_list_uid"], uid, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["psc_list"], row, adminPanelUI["psc_list_name"], name, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["psc_list"], row,  adminPanelUI["psc_list_pin"], code, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["psc_list"], row,  adminPanelUI["psc_list_value"], value, false, false )
end
addEvent ( "addPscToList", true)
addEventHandler ( "addPscToList", getLocalPlayer(),  addPscToList)

function refreshBans ()
    local banUID = DGS:dgsGetText( adminPanelUI["bans_uid"] )
    DGS:dgsGridListClear(adminPanelUI["bans_list"])
    triggerServerEvent ( "getBansFromMySQL", getLocalPlayer(), getLocalPlayer(), banUID ) 
end

function addBanToList(uid,adminName, name, reason, date, time)
    local row = DGS:dgsGridListAddRow ( adminPanelUI["bans_list"] )
    local logType = type
    if time == 0 then
        time = "permanent"
    elseif time < 0 then
        time = "entbannt"
    else
        time = math.floor(time).."h"
    end
    DGS:dgsGridListSetItemText ( adminPanelUI["bans_list"], row, adminPanelUI["bans_list_uid"], uid, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["bans_list"], row, adminPanelUI["bans_list_bannedFrom"], adminName, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["bans_list"], row,adminPanelUI["bans_list_name"], name, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["bans_list"], row, adminPanelUI["bans_list_reason"], reason, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["bans_list"], row,adminPanelUI["bans_list_date"], date, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["bans_list"], row, adminPanelUI["bans_list_time"], time, false, false )
end
addEvent ( "addBanToList", true)
addEventHandler ( "addBanToList", getLocalPlayer(),  addBanToList)

function refreshLogs ()
    DGS:dgsGridListClear(adminPanelUI["logs_list"])
    local searchName, dateTo, dateFrom = DGS:dgsGetText(adminPanelUI["logs_playername"]),DGS:dgsGetText(adminPanelUI["logs_dateTo"]), DGS:dgsGetText(adminPanelUI["logs_dateFrom"])
    local doDeepLog = DGS:dgsCheckBoxGetSelected(adminPanelUI["logs_deeplog"])
    local searchType = DGS:dgsComboBoxGetItemText(adminPanelUI["logs_types"], DGS:dgsComboBoxGetSelectedItem (adminPanelUI["logs_types"]))
    local searchType = logsTypes[searchType]
    triggerServerEvent ( "getLogsFromMySQL", getLocalPlayer(), getLocalPlayer(), searchType, searchName, dateTo, dateFrom, doDeepLog ) 
end

function addLogsToList (fraktion, type, date, text)
    local row = DGS:dgsGridListAddRow ( adminPanelUI["logs_list"] )
    local logType = type
    DGS:dgsGridListSetItemText ( adminPanelUI["logs_list"], row, adminPanelUI["logs_list_faction"], fraktion, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["logs_list"], row,adminPanelUI["logs_list_logtype"], logType, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["logs_list"], row, adminPanelUI["logs_list_date"], date, false, false )
    DGS:dgsGridListSetItemData ( adminPanelUI["logs_list"], row,adminPanelUI["logs_list_logtype"], text )
end
addEvent ( "addLogsToList", true)
addEventHandler ( "addLogsToList", getLocalPlayer(),  addLogsToList)

function getSelectedNameFromAdminPanel ()
    local Selected = DGS:dgsGridListGetSelectedItem(adminPanelUI["playerlist"])
    local playerNameEdit = DGS:dgsGetText( adminPanelUI["playername"] )
    if Selected ~= -1 then 
        if string.len(playerNameEdit) > 0 then 
            return playerNameEdit
        else
            local name = DGS:dgsGridListGetItemText(adminPanelUI["playerlist"], Selected, adminPanelUI["playerlist_name"])
            return name
        end
    end
end


function refreshAdminPanels ()
    DGS:dgsGridListClear(adminPanelUI["playerlist"])
    local players = getElementsByType("player")
	for i=1, #players do
		local row = DGS:dgsGridListAddRow ( adminPanelUI["playerlist"] )
		DGS:dgsGridListSetItemText ( adminPanelUI["playerlist"], row, adminPanelUI["playerlist_name"], getPlayerName ( players[i] ), false, false )
	end
end

function setCooperationDetails (text)
    DGS:dgsSetText(adminPanelUI["coop_tb_stats"], text)
end
addEvent ( "setCooperationDetails", true)
addEventHandler ( "setCooperationDetails", getLocalPlayer(),  setCooperationDetails)

-- // Unternehmen
function addCooperationToList (id, name, stats)
    local row = DGS:dgsGridListAddRow ( adminPanelUI["coop_tb_coopList"] )
    DGS:dgsGridListSetItemText ( adminPanelUI["coop_tb_coopList"], row, adminPanelUI["coop_tb_coopList_id"], id, false, false )
    DGS:dgsGridListSetItemText ( adminPanelUI["coop_tb_coopList"], row,adminPanelUI["coop_tb_coopList_name"], name, false, false )
end
addEvent ( "addCooperationToList", true)
addEventHandler ( "addCooperationToList", getLocalPlayer(),  addCooperationToList)

function addCooperationVehToList (name)
    local row = DGS:dgsGridListAddRow ( adminPanelUI["coop_tb_coopVehicleList"] )
    DGS:dgsGridListSetItemText ( adminPanelUI["coop_tb_coopVehicleList"], row, adminPanelUI["coop_tb_coopVehicleList_name"], name, false, false )
end
addEvent ( "addCooperationVehToList", true)
addEventHandler ( "addCooperationVehToList", getLocalPlayer(),  addCooperationVehToList)

function addCooperationMemberToList (name, state)
    if state == "on" then
        state = "Online"
    else
        state = "Offline"
    end
    local row = DGS:dgsGridListAddRow ( adminPanelUI["coop_tb_coopMemberList"] )
    DGS:dgsGridListSetItemText (  adminPanelUI["coop_tb_coopMemberList"], row,  adminPanelUI["coop_tb_coopMemberList_name"], name, false, false )
    DGS:dgsGridListSetItemText (  adminPanelUI["coop_tb_coopMemberList"], row,  adminPanelUI["coop_tb_coopMemberList_state"], state, false, false )
end
addEvent ( "addCooperationMemberToList", true)
addEventHandler ( "addCooperationMemberToList", getLocalPlayer(),  addCooperationMemberToList)


-- // Supporttoken

function setTempToken ()

	resetToken = setTimer ( setTempToken, 60000*60, 0 )
	local token = generateString ( 6 )
	triggerServerEvent ( "setTempToken", getLocalPlayer(), token )
	playerTempToken = token
end