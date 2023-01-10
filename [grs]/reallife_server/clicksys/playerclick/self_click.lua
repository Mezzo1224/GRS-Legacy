local resourceName = getResourceName(getThisResource())
local x, y = DGS:dgsGetScreenSize()
local sx, sy = x/1920, y/1080
local dr,dg,db, sdr, sdg, sdb, cdr, cdg, cdb = 0, 84, 5, 4, 170, 4, 17, 153, 7 -- Wenn es AN ist
local ar,ag,ab, sar, sag, sab, car, cag, cab = 95, 96, 96, 13, 112, 6, 168, 173, 173 -- Wenn es AUS ist
oneTabIsOpen = false
local clickFixer = false
local itemText = {} 


function showSelfMenu (byClick)
	if byClick == true and getSetting (15, 1) == 0 then
		return nil
	end
		self = DGS:dgsCreateWindow(787*sx, -75, 346*sx, 108*sy, "", false )
		selfMenu = self
		DGS:dgsMoveTo(self,787*sx, 0,false,false,"OutQuad",500)
		DGS:dgsWindowSetMovable ( self, false )
		DGS:dgsWindowSetSizable ( self, false )
		DGS:dgsWindowSetCloseButtonEnabled(self, true)
		
		local info = DGS:dgsCreateImage(24*sx, (30-23)*sy, 62*sx, 66*sy, "images/self/info_off.png", false, self)
		local settings = DGS:dgsCreateImage(100*sx, (30-23)*sy, 73*sx, 68*sy, "images/self/settings_off.png", false, self)
		local admin = DGS:dgsCreateImage(260*sx, (30-23)*sy, 62*sx, 66*sy, "images/self/admin_off.png", false, self)
		local shop = DGS:dgsCreateImage(187*sx, (30-23)*sy, 62*sx, 66*sy, "images/self/shop_off.png", false, self)

		addEventHandler( "onDgsMouseEnter", root, function()
			if source == info then
				DGS:dgsImageSetImage(info, "images/self/info.png")
			elseif source == settings then
				DGS:dgsImageSetImage(settings, "images/self/settings.png")
			elseif source == admin then
				DGS:dgsImageSetImage(admin, "images/self/admin.png")
			elseif source == shop then
				DGS:dgsImageSetImage(shop, "images/self/shop.png")
			end
		end)

		addEventHandler( "onDgsMouseLeave", root, function()
			if source == info then
				DGS:dgsImageSetImage(info, "images/self/info_off.png")
			elseif source == settings then
				DGS:dgsImageSetImage(settings, "images/self/settings_off.png")
			elseif source == admin then
				DGS:dgsImageSetImage(admin, "images/self/admin_off.png")
			elseif source == shop then
				DGS:dgsImageSetImage(shop, "images/self/shop_off.png")
			end
		end)

		setElementClicked ( true )
		showCursor(true)

		-- // Events //
		addEventHandler( "onDgsWindowClose", selfMenu, closeSelfMenu)
		addEventHandler ( "onDgsMouseClickDown", info, showInfoWindow )
		addEventHandler ( "onDgsMouseClickDown", settings,  showSettingsWindow )
		addEventHandler ( "onDgsMouseClickDown", shop,  showShopWindow )
		addEventHandler ( "onDgsMouseClickDown",admin, 
        function(button, state, x, y)
			if source == admin  then
				if getElementData ( lp, "adminlvl" ) >= 2 then
					showAdminPanel ()
				else
					newInfobox ("Nicht befugt.", 3)
				end
			end
    	end)
	

		
end
addEvent ( "ShowSelfClickMenue", true)
addEventHandler ( "ShowSelfClickMenue", getLocalPlayer(),  showSelfMenu)

function closeSelfMenu ()
	if source == self then
		setElementClicked ( false )
		showCursor(false)
		oneTabIsOpen = false
		if isElement(adminPanelUI["logs_tb_loginfowindow"]) then
			DGS:dgsCloseWindow(adminPanelUI["logs_tb_loginfowindow"])
		end
		if isElement(infoWindow) then
			DGS:dgsCloseWindow(infoWindow)
		elseif isElement(settingsWindow) then
			DGS:dgsCloseWindow(settingsWindow)
		elseif isElement(shopWindow) then
			DGS:dgsCloseWindow(shopDesc)
			DGS:dgsCloseWindow(shopWindow)
		elseif isElement(adminPanelUI["window"]) then
			DGS:dgsCloseWindow(adminPanelUI["window"])
		end
	end
end

function oneTabClose ()
    oneTabIsOpen = false
	if source == infoWindow then
		killTimer(refreshBar)
	end
	if isElement(shopDesc) then
		DGS:dgsCloseWindow(shopDesc)
		shopDesc = nil
	end
	if isTimer(autoUpdater) then
		killTimer(autoUpdater)
	end
	if isElement(adminPanelUI["logs_tb_loginfowindow"]) then
		DGS:dgsCloseWindow(adminPanelUI["logs_tb_loginfowindow"])
	end
	DGS:dgsWindowSetCloseButtonEnabled(selfMenu, true)
end

function debugSelf()
	DGS:dgsCloseWindow(self)
end
addCommandHandler("ds", debugSelf)

function showInfoWindow ()
    if oneTabIsOpen == false then
		infoWindow = DGS:dgsCreateWindow(0.38, 0.12, 0.24, 0.33, "", true)
		DGS:dgsWindowSetMovable ( infoWindow, false )
		DGS:dgsWindowSetSizable ( infoWindow, false )
		-- DGS:dgsWindowSetCloseButtonEnabled(self,false)
        addEventHandler("onDgsWindowClose", infoWindow,oneTabClose)
        local infoTabMenuMain = DGS:dgsCreateTabPanel(0.03, 0.02, 0.95, 0.90, true, infoWindow)
        local infoTabMenuMainPlayer = DGS:dgsCreateTab("Informationen",infoTabMenuMain)
        oneTabIsOpen = true
        -- // Daten zeigen //
			local licenseState = {}
			licenseState[1] = {name = "Personalausweis", elementName = "perso"}
			licenseState[2] = {name = "Führerschein", elementName = "carlicense"}
			licenseState[3] = {name = "Motorradschein", elementName = "bikelicense"}
			licenseState[4] = {name = "Fischer-Schein", elementName = "fishinglicense"}
			licenseState[5] = {name = "LKW-Schein", elementName = "lkwlicense"}
			licenseState[6] = {name = "Waffenschein", elementName = "gunlicense"}
			licenseState[7] = {name = "Motorbootschein", elementName = "motorbootlicense"}
			licenseState[8] = {name = "Segelbootschein", elementName = "segellicense"}
			licenseState[9] = {name = "Flugschein B", elementName = "planelicenseb"}
			licenseState[10] = {name = "Flugschein A", elementName = "planelicensea"}
			licenseState[11] = {name = "Helikopter-Lizens", elementName = "helilicense"}

        local job = jobNames[vioClientGetElementData ( "job" )]
        local fraktion = tonumber ( getElementData ( lp, "fraktion" ) )
        local fraktion = fraktionsNamen[fraktion]
        if not fraktion then
            fraktion = "Zivilist"
        end
        if not job then
            job = "Arbeitslos"
        end
        local playtime = getElementData ( lp, "playingtime" )
        local playtimehours = math.floor(playtime/60)
        local playtimeminutes = playtime-playtimehours*60
        if playtimeminutes < 10 then
            playtimeminutes = "0"..playtimeminutes
        end
        local playtime = playtimehours..":"..playtimeminutes
        local gwd = vioClientGetElementData ( "armyperm10" )
        if not gwd then
            gwd = "0 %"
        else
            gwd = gwd.." %"
        end
        DGS:dgsCreateLabel(0.02, 0.03, 0.48, 0.94, "Spielzeit: "..playtime.."\n\nFraktion: "..fraktion.."\n\nStatus:\n\nJob: "..job.."\n\nGWD: "..gwd.."\n\nGeld(Bar/Bank): "..mymoney.."/"..vioClientGetElementData("bankmoney").." $", true, infoTabMenuMainPlayer)
        local licenseList = DGS:dgsCreateGridList(0.52, 0.02, 0.46, 0.94, true, infoTabMenuMainPlayer)
        local licenseListLicense = DGS:dgsGridListAddColumn( licenseList, "Schein", 0.7 )
        local licenseListState = DGS:dgsGridListAddColumn( licenseList, "Status", 0.2 )
        for var, license in ipairs(licenseState) do
            local row = DGS:dgsGridListAddRow ( licenseList )
            if vioClientGetElementData ( license.elementName ) == 1 then
                state = "[x]"
            else
                state = "[_]"
            end
            DGS:dgsGridListSetItemText ( licenseList, row, licenseListLicense, license.name , false, false )
            DGS:dgsGridListSetItemText ( licenseList, row, licenseListState, state , false, false )
        end
		local level = getElementData ( getLocalPlayer(), "MainLevel")
		local infoTabMenuLevel = DGS:dgsCreateTab("Level",infoTabMenuMain)
		local levelInfo = DGS:dgsCreateProgressBar(0.02, 0.05, 0.95, 0.11, true, infoTabMenuLevel)  
		local levelProgress = calculateLevelProgress(getLocalPlayer())
		local levelProgress = ((100/1)*levelProgress)*sx
		DGS:dgsProgressBarSetProgress(levelInfo,levelProgress)
		if level < maxLevel then
			levelReal = "Fortschritt bis Level "..(level + 1)
		else
			levelReal = "Maximal Level erreicht."
		end
		DGS:dgsCreateLabel(0.36, 0.19, 0.29, 0.12, levelReal, true, infoTabMenuLevel)
		local prestigeInfo = DGS:dgsCreateProgressBar(0.02, 0.34, 0.95, 0.11, true, infoTabMenuLevel ) 
		if level < maxLevel then		
		--	DGS:dgsProgressBarSetProgress(prestigeInfo,level/maxlevel*100-100)
			local wert1 = ((level/maxLevel*100) - 100) + 100
			DGS:dgsProgressBarSetProgress(prestigeInfo,wert1)
		else
			DGS:dgsProgressBarSetProgress(prestigeInfo,100)
		end
		local goPrestigeButton = DGS:dgsCreateButton(0.34, 0.48, 0.32, 0.11, "Prestige "..(getElementData ( player, "pLevel")+1).." gehen.", true,  infoTabMenuLevel, nil, nil, nil, nil, nil, nil, tocolor(dr,dg,db),tocolor(sdr, sdg, sdb),tocolor(cdr, cdg, cdb))
		addEventHandler ( "onDgsMouseClick", goPrestigeButton, goPrestige )
		DGS:dgsCreateLabel(0.02, 0.62, 0.38, 0.25, "Nächste Prestige Belohnung: N.a", true, infoTabMenuLevel)    
		if level == maxLevel then
			DGS:dgsSetEnabled(goPrestigeButton, false)
		else
			DGS:dgsSetEnabled(goPrestigeButton, false)
		end
		local infoTabMenuSupport = DGS:dgsCreateTab("Support",infoTabMenuMain)
		
		
		DGS:dgsCreateLabel(0.32, 0.03, 0.36, 0.07, "Permanenter Supporttoken: ", true, infoTabMenuSupport)
        permToken = DGS:dgsCreateLabel(0.44, 0.14, 0.10, 0.07, "nil", true, infoTabMenuSupport)
		triggerServerEvent ( "getSecturityToken", getLocalPlayer() )
        copyPermToken = DGS:dgsCreateButton(0.41, 0.25, 0.16, 0.09, "Kopieren", true, infoTabMenuSupport)
        DGS:dgsCreateLabel(0.31, 0.37, 0.36, 0.07, "Temporärer Supporttoken:", true, infoTabMenuSupport)
		tempToken = DGS:dgsCreateLabel(0.43, 0.47, 0.10, 0.07, playerTempToken, true, infoTabMenuSupport)
        copyTempToken = DGS:dgsCreateButton(0.41, 0.58, 0.16, 0.09, "Kopieren", true, infoTabMenuSupport)
        nextTempToken = DGS:dgsCreateProgressBar(0.02, 0.83, 0.95, 0.12, true, infoTabMenuSupport)
        DGS:dgsCreateLabel(0.02, 0.72, 0.47, 0.07, "Nächster temporärer Supporttoken:", true, infoTabMenuSupport)    
		
		addEventHandler("onDgsMouseClick", copyPermToken,
	    function ()
			setClipboard(DGS:dgsGetText(permToken))
	    end
		)
		
		addEventHandler("onDgsMouseClick", copyTempToken,
		function ()
			setClipboard(DGS:dgsGetText(tempToken))
		end
		)
		refreshBar = setTimer ( function()
			local remaining, executesRemaining, totalExecutes = getTimerDetails(resetToken)
			local remainTime = (60000*60)/remaining*100
			DGS:dgsProgressBarSetProgress(nextTempToken,remainTime)
		end, 1000, 0 )

		local infoTabAchievments = DGS:dgsCreateTab("Erfolge",infoTabMenuMain)
		achievmentsList = DGS:dgsCreateGridList(0.02, 0.02, 0.46, 0.94, true, infoTabAchievments)
        achievmentsListName = DGS:dgsGridListAddColumn( achievmentsList, "Erfolg", 0.8 )
        achievmentsListState = DGS:dgsGridListAddColumn( achievmentsList, "Status", 0.2 )
		DGS:dgsSetProperty(achievmentsList,"rowHeight",25)
		triggerServerEvent ( "loadAchievements", getLocalPlayer(), getLocalPlayer() ) 


	

		achPic = DGS:dgsCreateImage(0.66, 0.09, 0.16, 0.22, "", true, infoTabAchievments)
		archDateLabel = DGS:dgsCreateLabel(0.51, 0.37, 0.47, 0.37, "", true, infoTabAchievments)
        archCountLabel = DGS:dgsCreateLabel(0.52, 0.90, 0.47, 0.07, "", true, infoTabAchievments)    

		addEventHandler ( "onDgsMouseClickDown", achievmentsList, function()
			if source == achievmentsList then
				local row, column = DGS:dgsGridListGetSelectedItem ( achievmentsList )
				if row ~= -1 then 
					local achData = DGS:dgsGridListGetItemData( achievmentsList, row, column )
					local aDesc = tostring ( gettok ( achData, 1, string.byte( '|' ) ))
					local aXp = tonumber ( gettok ( achData, 2, string.byte( '|' ) ))
					local aMoney = tonumber ( gettok ( achData, 3, string.byte( '|' ) ))
					local aSocial = tostring ( gettok ( achData, 4, string.byte( '|' ) ))
					local aTime = tostring ( gettok ( achData, 5, string.byte( '|' ) ))
					local aPic = tostring ( gettok ( achData, 6, string.byte( '|' ) ))
					DGS:dgsImageSetImage(achPic, ":reallife_server/neues/achievementSystem/achievmentPictures/"..aPic )
					DGS:dgsSetText(archDateLabel, aDesc.."\n\nErhaltenes Geld: "..aMoney.." $\n\nErhaltene EP: "..aXp.." EP\n\nSozialer Status: "..aSocial.."\n\nFreigeschaltet am: "..aTime )
					
				end
			end
		end)

    end
end


function fillAchievementList (name, achData)
	
	local row = DGS:dgsGridListAddRow ( achievmentsList )
	DGS:dgsGridListSetItemText (  achievmentsList, row, achievmentsListName, name, false)
	DGS:dgsGridListSetItemText (  achievmentsList, row, achievmentsListState, "[x]", false)
	DGS:dgsGridListSetItemData ( achievmentsList, row, achievmentsListName, achData )
end
addEvent( "fillAchievementList", true )
addEventHandler( "fillAchievementList", getRootElement(), fillAchievementList )

function setAchievementClientData (allAch, playersAch)
	DGS:dgsSetText(archCountLabel, playersAch.." von "..allAch.." Erfolgen")
end
addEvent( "setAchievementClientData", true )
addEventHandler( "setAchievementClientData", getRootElement(), setAchievementClientData )

function showSettingsWindow ()
    if oneTabIsOpen == false then

		local settingsTab = nil
        settingsWindow = DGS:dgsCreateWindow(0.38, 0.12, 0.24, 0.33, "Einstellung", true)
		DGS:dgsWindowSetMovable ( settingsWindow, false )
		DGS:dgsWindowSetSizable ( settingsWindow, false )
		-- DGS:dgsWindowSetCloseButtonEnabled(self,false)
        addEventHandler("onDgsWindowClose", settingsWindow,oneTabClose)
        oneTabIsOpen = true
		local settingsList = DGS:dgsCreateGridList(0.02, 0.06, 0.30, 0.86, true, settingsWindow, 0.04)
		DGS:dgsSetProperty(settingsList,"rowHeight",25)
		local column = DGS:dgsGridListAddColumn( settingsList, "", 0.98 )
		local settingsListTable = { [1] = "Einstellungen", [2] = "Kontoverwaltung", [3] = "Spawnauswahl", [4] = "Sozialer-Status"}
		for var, option in ipairs(settingsListTable) do
			local row = DGS:dgsGridListAddRow ( settingsList )
            DGS:dgsGridListSetItemText ( settingsList, row, column, option , false )
        end
		
		settingsElements = {}
		settingsElements.IDs = {}
		local settingsScrollPane = DGS:dgsCreateScrollPane(0.33, 0.02, 0.65, 0.90,true,settingsWindow) --0.33
	--	local settingsScrollBar = DGS:dgsCreateScrollBar(0.95, 0.01, 0.05, 0.99, false, true,settingsScrollPane )
		
		addEventHandler ( "onDgsMouseClickDown", settingsList, function (cmd, state)
			if source == settingsList then 
			--	if state == "down" then
					local Selected = DGS:dgsGridListGetSelectedItem(settingsList)
					
					if Selected ~= -1 then 
						local name = DGS:dgsGridListGetItemText(settingsList,Selected, 1)
						for var, data in ipairs(settingsElements) do 
							destroyElement(settingsElements[var])
							settingsElements[var] = nil
						end
						if isTimer(autoUpdater) then
							killTimer(autoUpdater)
						end
					--	if name == "HUD-Optionen" then
					--		settingsElements[1] =		DGS:dgsCreateLabel(0.03, 0.16, 0.54, 0.07, "In Arbeit.",true,settingsScrollPane)
							
						if name == "Einstellungen" then
							
							settingsElements[1] =	DGS:dgsCreateLabel(0.03, 0.05, 0.26, 0.07,"Joinmessage:",true,settingsScrollPane)
							settingsElements[2] =	DGS:dgsCreateLabel(0.03, 0.16, 0.54, 0.07, "Experimenteller Map Stream:",true,settingsScrollPane)
							settingsElements[3] =	DGS:dgsCreateLabel(0.03, 0.26, 0.23, 0.07, "Sichtweite:",true,settingsScrollPane)
							settingsElements[4] =	DGS:dgsCreateLabel(0.03, 0.35, 0.37, 0.06, "Render-Reichweite:",true,settingsScrollPane)
							settingsElements[5] =	DGS:dgsCreateLabel(0.03, 0.44, 0.30, 0.07, "FPS: (max. 65):",true,settingsScrollPane)
							settingsElements[6] =	DGS:dgsCreateLabel(0.03, 0.64, 0.46, 0.07, "Foren Register anzeigen:",true,settingsScrollPane)
							settingsElements[7] =	DGS:dgsCreateLabel(0.03, 0.73, 0.17, 0.07, "Wolken:",true,settingsScrollPane)
							settingsElements[8] =	DGS:dgsCreateSwitchButton(0.32, 0.04, 0.16, 0.09, "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))  -- Joinmessage
							settingsElements[9] =	DGS:dgsCreateSwitchButton(0.61, 0.15, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))   -- Mapstream
							settingsElements[11] =	DGS:dgsCreateSwitchButton(0.33, 0.53, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))  -- Hitmarker
							settingsElements[10] =	DGS:dgsCreateSwitchButton(0.54, 0.63, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))  -- Forum
							settingsElements[12] =	DGS:dgsCreateSwitchButton(0.23, 0.72, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))  -- Wolken
							settingsElements[13] =	DGS:dgsCreateEdit( 0.29, 0.26, 0.20, 0.06, "", true, settingsScrollPane ) -- Sichtweite
							settingsElements[14] =	DGS:dgsCreateEdit( 0.44, 0.35, 0.20, 0.06, "", true, settingsScrollPane ) -- Render
							settingsElements[15] =	DGS:dgsCreateEdit( 0.37, 0.45, 0.20, 0.06, "", true, settingsScrollPane ) -- FPS
							settingsElements[16] =	DGS:dgsCreateLabel(0.03, 0.54, 0.27, 0.07, "GW-Hitmarker:",true,settingsScrollPane)
							-- After
							settingsElements[17] =	DGS:dgsCreateLabel(0.03, 0.83, 0.64, 0.07, "/self durch Klicken:",true,settingsScrollPane)
							settingsElements[18] =	DGS:dgsCreateSwitchButton(0.43, 0.82, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))   -- /self
							settingsElements[19] =	DGS:dgsCreateLabel(0.03, 0.93, 0.64, 0.07, "Autologin:",true,settingsScrollPane)
							settingsElements[20] =	DGS:dgsCreateSwitchButton(0.43, 0.92, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))   -- Autologin
							settingsElements[21] =	DGS:dgsCreateLabel(0.03, 1.03, 0.64, 0.07, "Neue Infobox:",true,settingsScrollPane)
							settingsElements[22] =	DGS:dgsCreateSwitchButton(0.43, 1.02, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))   -- Neue Infobox

							--
							settingsElements[23] =	DGS:dgsCreateLabel(0.03, 1.13, 0.64, 0.07, "EP-Boost-Hinweis:",true,settingsScrollPane)
							settingsElements[24] =	DGS:dgsCreateSwitchButton(0.43, 1.12, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))   -- Neue Infobox
							settingsElements[25] =	DGS:dgsCreateLabel(0.03, 1.23, 0.64, 0.07, "Versions-Hinweis:",true,settingsScrollPane)
							settingsElements[26] =	DGS:dgsCreateSwitchButton(0.43, 1.22, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))   -- Neue Infobox
							settingsElements[27] =	DGS:dgsCreateLabel(0.03, 1.33, 0.64, 0.07, "NODM-Zone-Hinweis:",true,settingsScrollPane)
							settingsElements[28] =	DGS:dgsCreateSwitchButton(0.43, 1.32, 0.16, 0.09,  "An", "Aus", false, true, settingsScrollPane ,  tocolor(89, 207, 95), tocolor(76, 176, 80))   -- Neue Infobox
							-- ID's der Buttons
							settingsElements.IDs[8] = 1 -- Join
							settingsElements.IDs[9] = 3 -- Mapstream
							settingsElements.IDs[10] = 11 -- Forum
							settingsElements.IDs[11] = 9 -- Hitmarker
							settingsElements.IDs[12] = 5 -- Wolken
							settingsElements.IDs[18] = 15 -- ByPass /self
							settingsElements.IDs[22] = 16 -- Neue Infobox
							settingsElements.IDs[24] = 21 -- EP
							settingsElements.IDs[26] = 22 -- Version
							settingsElements.IDs[28] = 23 -- Greenzone
							autoUpdater = setTimer ( autoUpdateSettings, 1000, 0 )
							checkSettingStates ()
							
							addEventHandler("onDgsTextChange", settingsElements[15], function() 
								if tonumber(DGS:dgsGetText(settingsElements[15])) <= 65 then
										setFPSLimit(DGS:dgsGetText(settingsElements[15]))
								end
							end)
							for var, button in pairs(settingsElements) do
								if tonumber(settingsElements.IDs[var]) and DGS:dgsGetType(button) == "dgs-dxswitchbutton" then
									addEventHandler ( "onDgsMouseClickDown", button, function()
										if source == button then
											local v = DGS:dgsSwitchButtonGetState(source)
											if v == true then
												changeSetting (settingsElements.IDs[var], 1, 0)
											else 
												changeSetting (settingsElements.IDs[var], 1, 1)
											end
										end
								end)
							end
						end

						addEventHandler("onDgsSwitchButtonStateChange", settingsElements[20], function(state) 
							toggleAutoLogin (state)
						end)

						
						elseif name == "Kontoverwaltung" then
							settingsElements[1] =	DGS:dgsCreateLabel(0.01, 0.01, 0.95, 0.10,"Passwort\n----------------------------------------------------------------------",true,settingsScrollPane)
							settingsElements[2] =	DGS:dgsCreateLabel(0.01, 0.13, 0.32, 0.05,"Neues Passwort:",true,settingsScrollPane)
							settingsElements[3] =	DGS:dgsCreateLabel(0.01, 0.22, 0.43, 0.05,"Neues Passwort Wdh.:",true,settingsScrollPane)
							settingsElements[4] = 	DGS:dgsCreateLabel(0.01, 0.30, 0.32, 0.05,"Aktu. Passwort:",true,settingsScrollPane)
							settingsElements[5] = 	DGS:dgsCreateEdit( 0.49, 0.14, 0.45, 0.05, "", true, settingsScrollPane )
							settingsElements[6] = 	DGS:dgsCreateEdit( 0.49, 0.22, 0.45, 0.05, "", true, settingsScrollPane )
							settingsElements[7] = 	DGS:dgsCreateEdit( 0.49, 0.30, 0.45, 0.05, "", true, settingsScrollPane )
							settingsElements[8] = 	DGS:dgsCreateButton(0.30, 0.38, 0.37, 0.06, "Passwort ändern", true, settingsScrollPane, nil, nil, nil, nil, nil, nil, tocolor(89, 207, 95), tocolor(76, 176, 80), tocolor(76, 176, 80) )	
							addEventHandler ( "onDgsMouseClickDown", settingsElements[8], function()
								if source == settingsElements[8] then
								--	executeCommandHandler("newpw", getLocalPlayer(), "", DGS:dgsGetText(settingsElements[4]), DGS:dgsGetText(settingsElements[5]))
								outputConsole("Funktioniert bald")
								end
						end)
							
					--	elseif name == "Tastenzuweisung" then
							
					--		settingsElements[1] =		DGS:dgsCreateLabel(0.03, 0.16, 0.54, 0.07, "In Arbeit.",true,settingsScrollPane)
						
					elseif name == "Spawnauswahl" then
							

							settingsElements[1] = 		DGS:dgsCreateGridList(0.02, 0.00, 0.92, 0.51, true, settingsScrollPane)
							DGS:dgsSetProperty(settingsElements[1],"rowHeight",25)
							local column = DGS:dgsGridListAddColumn( settingsElements[1], "Name", 0.98 )
							local list = settingsElements[1]
							
							-- // TODO: Outsourcen
							row = DGS:dgsGridListAddRow ( list )
							DGS:dgsGridListSetItemText ( list, row, column, "Noobspawn", false)
							-- Haus --
							if vioClientGetElementData ( "housekey" ) ~= 0 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Haus", false)
							end
							-- Fraktion --
							local fraktion = getElementData ( lp, "fraktion" )
							if fraktion == 1 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "SFPD", false)
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "LVPD", false)
							elseif fraktion == 2 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Ranch", false)
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Caligulas Casino", false)
							elseif fraktion == 3 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Chinatown", false )
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Four Dragons", false)
							elseif fraktion == 6 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "SF Basis", false)
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "LVPD", false)
							elseif fraktion == 7 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Basis", false)
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Striplokal", false)
							elseif fraktion == 8 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Flugzeugträger", false)
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Area 51", false)
							elseif fraktion == 9 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Angel Pine", false)
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Clubgelände", false)
							elseif fraktion > 0 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Basis", false)
							end
							-- Admin --
							if getElementData ( lp, "adminlvl" ) >= 1 then
								row = DGS:dgsGridListAddRow ( list )
								DGS:dgsGridListSetItemText ( list, row, column, "Hier", false)
							end
							-- Yacht --
							row = DGS:dgsGridListAddRow ( list )
							DGS:dgsGridListSetItemText ( list, row, column, "Yacht", false)
							-- Wohnwagen --
							row = DGS:dgsGridListAddRow ( list )
							DGS:dgsGridListSetItemText ( list, row, column, "Wohnwagen", false)

							-- Hotels --
							row = DGS:dgsGridListAddRow ( list )
							DGS:dgsGridListSetItemText ( list, row, column, "Hotel ( SF )", false)
							row = DGS:dgsGridListAddRow ( list )
							DGS:dgsGridListSetItemText ( list, row, column, "Hotel ( LV )", false)
							settingsElements[2] = 	DGS:dgsCreateButton(0.23, 0.54, 0.51, 0.18, "Ändern", true, settingsScrollPane, nil, nil, nil, nil, nil, nil)						

							addEventHandler ( "onDgsMouseClickDown", settingsElements[2], function()
								if source == settingsElements[2] then
									local row, column = DGS:dgsGridListGetSelectedItem ( list )
									local text = DGS:dgsGridListGetItemText( list, row, column )
									
									local cmd1 = spawnPointListCMD1[text]
									local cmd2 = spawnPointListCMD2[text]
								
									if cmd1 then
										triggerServerEvent ( "changeSpawnPosition", lp, cmd1, cmd2 )
									end
								end
							end)

						elseif name == "Sozialer-Status" then
							settingsElements[1] = 		DGS:dgsCreateGridList(0.01, 0.01, 0.96, 0.71, true, settingsScrollPane)
							DGS:dgsSetProperty(settingsElements[1],"rowHeight",25)
							local column = DGS:dgsGridListAddColumn( settingsElements[1], "Status", 0.98 )
							socialListColumn = column
							local noStateSelected = "Wähle den Status aus, denn du nutzen willst."
							settingsElements[2] = 	DGS:dgsCreateLabel(0.03, 0.74,1, 0.11,noStateSelected,true,settingsScrollPane)	
							settingsElements[3] = 	DGS:dgsCreateButton(0.29, 0.82, 0.40, 0.11, "Anzeigen", true, settingsScrollPane, nil, nil, nil, nil, nil, nil)  
							triggerServerEvent ( "loadSocialState", getLocalPlayer(), getLocalPlayer() ) 

							addEventHandler ( "onDgsMouseClickDown", settingsElements[1], function()
								if source == settingsElements[1] then
									local row, column = DGS:dgsGridListGetSelectedItem ( settingsElements[1] )
									local text = DGS:dgsGridListGetItemData( settingsElements[1], row, column )
									if not text == false then
										DGS:dgsSetText(settingsElements[2], text)
									else
										DGS:dgsSetText(settingsElements[2], noStateSelected)
									end
									
								end
							end)

							addEventHandler ( "onDgsMouseClickDown", settingsElements[3], function()
								if source == settingsElements[3] then
									local row, column = DGS:dgsGridListGetSelectedItem ( settingsElements[1] )
									if Selected ~= -1 then 
										local text = DGS:dgsGridListGetItemText( settingsElements[1], row, column )
										setElementData ( lp, "socialState", text, true )
									end
								end
							end)
						end
					end
			--	end
			end
		end )
	end
end



function fillSocialStateList (name, text)
	
	local row = DGS:dgsGridListAddRow ( settingsElements[1] )
	DGS:dgsGridListSetItemText (  settingsElements[1], row, socialListColumn, name, false)
	DGS:dgsGridListSetItemData ( settingsElements[1], row, socialListColumn, text )

end
addEvent( "fillSocialStateList", true )
addEventHandler( "fillSocialStateList", getRootElement(), fillSocialStateList )

function setPremiumClientData (coins, premTime, pack, premState)

	DGS:dgsSetText(shopCoins, "Deine Coins: "..coins)

	if premState == false then
		premState = "Nicht aktiv"
	else
		premState = "Aktiv bis zum "..getData(premTime)
	end
	DGS:dgsSetText(shopPremstate,"Premium-Status: "..tostring(premState))
end
addEvent( "setPremiumClientData", true )
addEventHandler( "setPremiumClientData", lp, setPremiumClientData )

function showShopWindow () 
	if oneTabIsOpen == false then
		-- Shop System ist unter /neues/shopsystem.lua
	
		oneTabIsOpen = true
		local shopWindow = DGS:dgsCreateWindow(0.37, 0.12, 0.25, 0.32, "Shop", true)
		DGS:dgsWindowSetCloseButtonEnabled(selfMenu, false)
		DGS:dgsWindowSetMovable ( shopWindow, false )
		DGS:dgsWindowSetSizable ( shopWindow, false )
		-- DGS:dgsWindowSetCloseButtonEnabled(self,false)
		-- // temp fix
		shopCoins = DGS:dgsCreateLabel(0.03, 0.02, 0.19, 0.06, "", true, shopWindow)
	
		shopPremstate = DGS:dgsCreateLabel(0.48, 0.02, 0.50, 0.06, "", true, shopWindow)
		local shopWindowTab = DGS:dgsCreateTabPanel(0.03, 0.11, 0.95, 0.80, true, shopWindow)
        local shopWindowTabItems1 = DGS:dgsCreateTab("Items",shopWindowTab)
		local premiumAuto = DGS:dgsCreateCheckBox(0.02, 0.03, 0.96, 0.11, "Premium ggf. automatich nach Ablauf erneut erwerben.",false,true,shopWindowTabItems1)
		addEventHandler("onDgsWindowClose", shopWindow, oneTabClose)

		triggerServerEvent ( "getPremiumData", getRootElement(), getLocalPlayer() )
		if getSetting (7, 1) == 1 then
			DGS:dgsCheckBoxSetSelected(premiumAuto,true)
		end
		
		items = DGS:dgsCreateGridList (0.02, 0.14, 0.96, 0.79, true, shopWindowTabItems1  )
		itemsid = DGS:dgsGridListAddColumn( items, "ID", 0.2 ) 
		itemsname = DGS:dgsGridListAddColumn( items, "Name", 0.4 ) 
		itemspreis = DGS:dgsGridListAddColumn( items, "Preis", 0.3 ) 
		
		
		
		-- Item
		shopDesc = DGS:dgsCreateWindow(0.20, 0.19, 0.15, 0.29, "Beschreibung", true)
		DGS:dgsWindowSetMovable ( shopDesc, false )
		DGS:dgsWindowSetSizable ( shopDesc, false )
		desc = DGS:dgsCreateMemo(0.06, 0.03, 0.88, 0.71,"",true,shopDesc)
		DGS:dgsMemoSetReadOnly(desc, true )
		buyItemBtn = DGS:dgsCreateButton(0.06, 0.76, 0.31, 0.09, "Kaufen", true, shopDesc, nil, nil, nil, nil, nil, nil, tocolor(1,223,1), tocolor(4,170,4), tocolor(4,170,4) )  
		DGS:dgsWindowSetCloseButtonEnabled(shopDesc,false)
		
		addEventHandler ( "onDgsMouseDoubleClick", buyItemBtn, function(button, state, x, y)
			if source == buyItemBtn and button == 'left' and state == 'up' then
				local Selected = DGS:dgsGridListGetSelectedItem(items)
				if Selected ~= -1 then 
					local id = DGS:dgsGridListGetItemText(items,Selected, 1)
					local shouldRenew = DGS:dgsCheckBoxGetSelected(premiumAuto)
					
					triggerServerEvent ( "buyShopItem",  getLocalPlayer(),getLocalPlayer(), id, shouldRenew)
				end
			end
		end)

		triggerServerEvent ( "listShopItems", getLocalPlayer(),getLocalPlayer() )
		addEventHandler ( "onDgsMouseClick", items, function (cmd, state)
			if source == items then 
				if state == "down" then
					local Selected = DGS:dgsGridListGetSelectedItem(items)
					if Selected ~= -1 then 
						local id = DGS:dgsGridListGetItemText(items,Selected, 1)
						local text = DGS:dgsGridListGetItemData(items,Selected, 1)
						DGS:dgsClear(desc)
						DGS:dgsSetText(desc, text.."\nDrücke Doppelt auf Kaufen um das Item zu kaufen.")
					end
				end
			end
		end )

		addEventHandler( "onDgsCheckBoxChange", premiumAuto,
		function ( current, previous )
			if current == true then
				changeSetting (7, 1, 1)
			else
				changeSetting (7, 1, 0)
			end
		end
		)
		
		if sendPaysavecards == true then
			local x, y = DGS:dgsGetScreenSize()
			local Asx, Asy = x/2560, y/1440
			local shopWindowPSC = DGS:dgsCreateTab("Paysafecard einschicken",shopWindowTab)
			local Code_1 = DGS:dgsCreateEdit(56*Asx, 50*Asy, 95*Asx, 30*Asy, "", false, shopWindowPSC)
			local Code_2 = DGS:dgsCreateEdit(178*Asx, 50*Asy, 95*Asx, 30*Asy, "", false, shopWindowPSC)
			local Code_3 = DGS:dgsCreateEdit(302*Asx, 50*Asy, 95*Asx, 30*Asy, "", false, shopWindowPSC)
			local Code_4 = DGS:dgsCreateEdit(428*Asx, 50*Asy, 95*Asx, 30*Asy, "", false, shopWindowPSC)
			-- // Property
			DGS:dgsSetProperty(Code_1,"enableTabSwitch",true)
			DGS:dgsSetProperty(Code_2,"enableTabSwitch",true)
			DGS:dgsSetProperty(Code_3,"enableTabSwitch",true)
			DGS:dgsSetProperty(Code_4,"enableTabSwitch",true)
			DGS:dgsSetProperty(Code_1,"maxLength",4)
			DGS:dgsSetProperty(Code_2,"maxLength",4)
			DGS:dgsSetProperty(Code_3,"maxLength",4)
			DGS:dgsSetProperty(Code_4,"maxLength",4)
			DGS:dgsCreateLabel(151*Asx, 56*Asy, 28*Asx, 24*Asy, "-", false, shopWindowPSC)
			DGS:dgsCreateLabel(275*Asx, 56*Asy, 28*Asx, 24*Asy, "-", false, shopWindowPSC)
			DGS:dgsCreateLabel(401*Asx, 56*Asy, 28*Asx, 24*Asy, "-", false, shopWindowPSC)
			local sendCode = DGS:dgsCreateButton(203*Asx, 280*Asy, 177*Asx, 47*Asy, "Code abschicken", false, shopWindowPSC)
			local pscValue = DGS:dgsCreateEdit(242*Asx, 90*Asy, 94*Asx, 34*Asy, "", false, shopWindowPSC)
			DGS:dgsSetProperty(pscValue,"placeHolder","Wert in €")
			infotext = DGS:dgsCreateMemo(59*Asx, 144*Asy, 467*Asx, 126*Asy, "", false, shopWindowPSC)    
			DGS:dgsSetProperty(infotext,"readOnly", true )

			addEventHandler ( "onDgsMouseClickDown", sendCode, function()
				if source == sendCode then
					local c1,c2,c3,c4 = DGS:dgsGetText(Code_1),DGS:dgsGetText(Code_2),DGS:dgsGetText(Code_3),DGS:dgsGetText(Code_4)
					local pscValue_edit = DGS:dgsGetText(pscValue)
					if tonumber(c1) and tonumber(c2) and tonumber(c3) and tonumber(c4) then
						if string.len(c1) == 4 or string.len(c2) == 4 or string.len(c3) == 4 or string.len(c4) == 4 then
							if string.len(pscValue_edit) > 0 and tonumber(pscValue_edit) > 0 then
								triggerServerEvent ( "sendPaysafecard",  getLocalPlayer(), getLocalPlayer(), c1,c2,c3,c4, pscValue_edit )
							else
								newInfobox ("Ungültiger Wert.", 3)
							end
						else
							newInfobox ("Ungültige Länge des Codes.", 3)
						end
					else
						newInfobox ("Ungültiger Code.", 3)
					end
				end
			end)
			
		end
	end
end

function setIDforAutorenew (player, id, expire)
	changeSetting (24, 1, id)
	-- // TODO: Tage zum Timesamp umwandeln
	local rt = getRealTime ()
    local timesamp = rt.timestamp
	local expireDate = timesamp+86400*expire
	changeSetting (25, 1, tonumber(expireDate))
end
addEvent ( "setIDforAutorenew", true )
addEventHandler ( "setIDforAutorenew", getRootElement(), setIDforAutorenew )

function fillShopItems (id, name, preis, text)
	local row = DGS:dgsGridListAddRow ( items )
	DGS:dgsGridListSetItemText ( items, row, itemsid, id , false, false )
	DGS:dgsGridListSetItemText ( items, row, itemsname, name , false, false )
	DGS:dgsGridListSetItemText ( items, row, itemspreis, preis , false, false )
	DGS:dgsGridListSetItemData ( items, row, itemsid, text  )

end
addEvent ( "fillShopItems", true )
addEventHandler ( "fillShopItems", getRootElement(), fillShopItems )


function autoUpdateSettings ()
	local renderDistance = DGS:dgsGetText(settingsElements[14])
	local distance = DGS:dgsGetText(settingsElements[13])
	local fps = DGS:dgsGetText(settingsElements[15])
	if tonumber(renderDistance) then
		changeSetting (6, 1, renderDistance)
	end
	if tonumber(distance) then
		changeSetting (4, 1, distance)
	end
	if tonumber(fps) <= 65 and tonumber(fps) >= 10 then
		changeSetting (12, 1, fps)
	end
end
function checkSettingStates ()
	-- Autologin 
	local autoLoginState =  getAutoLogin ()
	DGS:dgsSetProperty(settingsElements[20],"state", autoLoginState)
	-- Edits
	 DGS:dgsSetText(settingsElements[13], getSetting (4, 1))
	 DGS:dgsSetText(settingsElements[14], getSetting (6, 1)) 
	 DGS:dgsSetText(settingsElements[15], getSetting (12, 1))
	-- Switches
	for var, button in pairs(settingsElements) do
            if tonumber(settingsElements.IDs[var]) then
                local v = getSetting (settingsElements.IDs[var], 1)
                if tonumber(v) == 1 then
					DGS:dgsSetProperty(settingsElements[var],"state", true)
                else
					DGS:dgsSetProperty(settingsElements[var],"state", false)
                end
				
            end
        end	
	end
	
function changeSettingSwitch (button, state)
	if state == "down" then
		local var = getSetting (tonumber(settingsButton.settingID[source]), 1)
		if var == 1 then
			newstate = 0
		else
			newstate = 1 
		end
		changeSetting (tonumber(settingsButton.settingID[source]), 1, newstate)
		checkSettingStates ()

	end
end
		
function goPrestige (button, state)
	if state == "down" and button == goPrestigeButton then
		if triggerServerEvent ( "goPrestige", resourceRoot) == true then
			DGS:dgsCloseWindow(infoWindow)
		end
	end
end


function setPermToken (token)
	DGS:dgsSetText(permToken, token)
end
addEvent ( "setPermToken", true )
addEventHandler ( "setPermToken", getRootElement(), setPermToken )