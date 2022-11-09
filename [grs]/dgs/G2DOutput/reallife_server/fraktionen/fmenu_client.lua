
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

-- fraktionsNamen
FrakiGui = {
    tab = {},
    label = {},
    tabpanel = {},
    edit = {},
    gridlist = {},
    window = {},
    button = {},
    memo = {}
}
lastText = {}
memberlist = {}
vehiclelist = {}
warnlist = {}
loglist = {}
cityabk = {
["San Fierro"] = ", SF",
["Los Santos"] = ", LS",
["Las Venturas"] = ", LV",
["Whetstone"] = ", WS",
["Flint Count"] = ", FC",
["Red Country"] = ", RC"
}


function openFraktionMenu ()
if getElementClicked() == false then
	showCursor(true)
	local fraktion = tonumber ( getElementData ( lp, "fraktion" ) )
	local rang = tonumber ( getElementData ( lp, "rang" ) )
	if rang == 4 then
		rang = "Co-Leader (4)"
    end
    if rang == 5 then
        rang = "Leader (5)"
    end
	setElementClicked ( true )
	FrakiGui.window[1] = dgsCreateWindow(0.35, 0.28, 0.31, 0.45, "", true)
    dgsWindowSetMovable(FrakiGui.window[1], false)
    dgsWindowSetSizable(FrakiGui.window[1], false)
	close = dgsCreateButton(0.93, 0.05, 0.05, 0.05, "X", true, FrakiGui.window[1])    
    FrakiGui.tabpanel[1] = dgsCreateTabPanel(0.02, 0.07, 0.96, 0.92, true, FrakiGui.window[1])
 
    FrakiGui.tab[1] = dgsCreateTab("Übersicht", FrakiGui.tabpanel[1])

    FrakiGui.gridlist[1] = dgsCreateGridList(0.02, 0.02, 0.70, 0.95, true, FrakiGui.tab[1])
    membersname = dgsGridListAddColumn(FrakiGui.gridlist[1], "Name", 0.3)
    membersrang = dgsGridListAddColumn(FrakiGui.gridlist[1], "Rang", 0.3)
    membersstatus = dgsGridListAddColumn(FrakiGui.gridlist[1], "Letzter Login", 0.3)
  --  memberswarns = guiGridListAddColumn(FrakiGui.gridlist[1], "Verwarnungen", 0.2)
    FrakiGui.label[1] = dgsCreateLabel(0.74, 0.02, 0.24, 0.08, "        Ausgewählte\n----------------------------------", true, FrakiGui.tab[1])
    FrakiGui.button[1] = dgsCreateButton(0.74, 0.11, 0.14, 0.09, "Rang setzen", true, FrakiGui.tab[1])
    FrakiGui.edit[1] = dgsCreateEdit(0.90, 0.11, 0.08, 0.08, "", true, FrakiGui.tab[1])
    FrakiGui.button[2] = dgsCreateButton(0.74, 0.21, 0.24, 0.09, "Uninviten", true, FrakiGui.tab[1])
    FrakiGui.button[3] = dgsCreateButton(0.74, 0.32, 0.24, 0.09, "Verwarnen", true, FrakiGui.tab[1])
    FrakiGui.edit[2] = dgsCreateEdit(0.74, 0.42, 0.24, 0.08, "Grund", true, FrakiGui.tab[1])
    FrakiGui.edit[3] = dgsCreateEdit(0.74, 0.53, 0.24, 0.08, "Zeit in Tagen (0=un.)", true, FrakiGui.tab[1])
    FrakiGui.label[2] = dgsCreateLabel(0.74, 0.62, 0.24, 0.04, "----------------------------------", true, FrakiGui.tab[1])
    FrakiGui.button[4] = dgsCreateButton(0.74, 0.67, 0.24, 0.09, "Inviten", true, FrakiGui.tab[1])
    FrakiGui.edit[4] = dgsCreateEdit(0.74, 0.78, 0.24, 0.08, "Name", true, FrakiGui.tab[1])
    FrakiGui.button[5] = dgsCreateButton(0.74, 0.89, 0.24, 0.09, "Aktualisieren", true, FrakiGui.tab[1])
    FrakiGui.label[3] = dgsCreateLabel(0.74, 0.85, 0.24, 0.04, "----------------------------------", true, FrakiGui.tab[1])

    FrakiGui.tab[2] = dgsCreateTab("Fahrzeuge", FrakiGui.tabpanel[1])

    FrakiGui.gridlist[2] = dgsCreateGridList(0.02, 0.02, 0.70, 0.95, true, FrakiGui.tab[2])
	
	
	vehiclesid =  dgsGridListAddColumn(FrakiGui.gridlist[2], "ID", 0.2)
    vehiclesveh =  dgsGridListAddColumn(FrakiGui.gridlist[2], "Fahrzeug", 0.2)
    vehiclesrang =  dgsGridListAddColumn(FrakiGui.gridlist[2], "Rang", 0.2)
    vehiclesgps =  dgsGridListAddColumn(FrakiGui.gridlist[2], "Ort", 0.3)
	
    FrakiGui.label[4] = dgsCreateLabel(0.74, 0.02, 0.24, 0.08, "        Ausgewählte\n----------------------------------", true, FrakiGui.tab[2])
    FrakiGui.button[6] = dgsCreateButton(0.74, 0.11, 0.14, 0.09, "Rang setzen", true, FrakiGui.tab[2])
    FrakiGui.edit[5] = dgsCreateEdit(0.90, 0.11, 0.08, 0.08, "", true, FrakiGui.tab[2])
    FrakiGui.button[7] = dgsCreateButton(0.74, 0.21, 0.24, 0.09, "Orten", true, FrakiGui.tab[2])
    FrakiGui.button[8] = dgsCreateButton(0.74, 0.32, 0.24, 0.09, "Verkaufen", true, FrakiGui.tab[2])
    FrakiGui.label[5] = dgsCreateLabel(0.74, 0.85, 0.24, 0.04, "----------------------------------", true, FrakiGui.tab[2])
    FrakiGui.button[9] = dgsCreateButton(0.74, 0.89, 0.24, 0.09, "Fahrzeuge kaufen", true, FrakiGui.tab[2])

    FrakiGui.tab[3] = dgsCreateTab("Notiz", FrakiGui.tabpanel[1])

    FrakiGui.button[10] = dgsCreateButton(0.02, 0.89, 0.20, 0.09, "Bearbeiten", true, FrakiGui.tab[3])
    FrakiGui.button[11] = dgsCreateButton(0.78, 0.89, 0.20, 0.09, "Speichern", true, FrakiGui.tab[3])
    FrakiGui.memo[1] = dgsCreateMemo(0.02, 0.02, 0.97, 0.85, "", true, FrakiGui.tab[3])
    FrakiGui.button[12] = dgsCreateButton(0.40, 0.89, 0.20, 0.09, "Löschen", true, FrakiGui.tab[3])

    FrakiGui.tab[4] = dgsCreateTab("Verwarnungen", FrakiGui.tabpanel[1])

    FrakiGui.gridlist[3] = dgsCreateGridList(0.02, 0.02, 0.70, 0.95, true, FrakiGui.tab[4])
    warnsid = dgsGridListAddColumn(FrakiGui.gridlist[3], "ID", 0.2)
    warnsname = dgsGridListAddColumn(FrakiGui.gridlist[3], "Name", 0.2)
    warnsreason = dgsGridListAddColumn(FrakiGui.gridlist[3], "Grund", 0.2)
	warnsexpiration = dgsGridListAddColumn(FrakiGui.gridlist[3], "Ablaufzeitpunkt", 0.3)
	
    FrakiGui.label[6] = dgsCreateLabel(0.74, 0.02, 0.24, 0.08, "        Ausgewählte\n----------------------------------", true, FrakiGui.tab[4])
    FrakiGui.button[13] = dgsCreateButton(0.74, 0.11, 0.24, 0.09, "Löschen", true, FrakiGui.tab[4])
    FrakiGui.label[7] = dgsCreateLabel(0.73, 0.90, 0.24, 0.08, "----------------------------------\nVerwarnen -> Übersicht", true, FrakiGui.tab[4])

    FrakiGui.tab[5] = dgsCreateTab("Log", FrakiGui.tabpanel[1])

	logtext = dgsCreateMemo(0.02, 0.01, 0.96, 0.80,"",true,FrakiGui.tab[5])
	dgsGridListClear (FrakiGui.gridlist[3])
	dgsGridListClear (FrakiGui.gridlist[2])
	onlyAllowedButtons()
	refreshLog ()
	refreshMembers ()
	refreshVehicles ()
	refreshMemo ()
	refreshWarns ()
	dgsSetInputEnabled ( false )
	dgsMemoSetReadOnly( FrakiGui.memo[1], true )
	dgsMemoSetReadOnly(logtext, true)
	addEventHandler("onDgsMouseClickUp", close, function()
        dgsSetVisible(FrakiGui.window[1], false)
        showCursor(false)
		setElementClicked ( false )
		dgsSetInputEnabled ( true )
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[5], function()
			refreshMembers ()
			refreshVehicles ()
			refreshMemo ()
			refreshWarns ()
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[1], function()
        local name = dgsGridListGetItemText(FrakiGui.gridlist[1], dgsGridListGetSelectedItem(FrakiGui.gridlist[1]), 1)
		if name then
			local rang = tonumber(dgsGetText(FrakiGui.edit[1]))
			triggerServerEvent("fraktionsMenu_setRang", getLocalPlayer(), name, rang)
			refreshMembers ()
		end
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[2], function()
		local name = dgsGridListGetItemText(FrakiGui.gridlist[1], dgsGridListGetSelectedItem(FrakiGui.gridlist[1]), 1)
		if name then
			triggerServerEvent("fraktionsMenu_uninvite", getLocalPlayer(), name)
			refreshMembers ()
		end
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[3], function()
        local name = dgsGridListGetItemText(FrakiGui.gridlist[1], dgsGridListGetSelectedItem(FrakiGui.gridlist[1]), 1)
        local time = tonumber(dgsGetText(FrakiGui.edit[3]))
		local grund = dgsGetText(FrakiGui.edit[2])
		if name then
			triggerServerEvent("fraktionsMenu_warn", getLocalPlayer(), name, time, grund)
			refreshMembers ()
		--	refreshWarns ()
		end
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[4], function()
        local name = dgsGetText(FrakiGui.edit[4])
		if name then
			triggerServerEvent("fraktionsMenu_invite", getLocalPlayer(), name)
			refreshMembers ()
		end
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[6], function()
        local id = dgsGridListGetItemText(FrakiGui.gridlist[2], dgsGridListGetSelectedItem(FrakiGui.gridlist[2]), 1)
		local carname = dgsGridListGetItemText(FrakiGui.gridlist[2], dgsGridListGetSelectedItem(FrakiGui.gridlist[2]), 2)
		if id then
			local rang = tonumber(dgsGetText(FrakiGui.edit[5]))
			triggerServerEvent("fraktionsMenu_setCarRang", getLocalPlayer(), id, rang, carname )
			refreshVehicles ()
		end
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[7], function()
        local id = dgsGridListGetItemText(FrakiGui.gridlist[2], dgsGridListGetSelectedItem(FrakiGui.gridlist[2]), 1)
		if id then
			triggerServerEvent("fraktionsMenu_orten", getLocalPlayer(), id )
		end
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[10], function()
		if dgsGetText(FrakiGui.button[10]) == "Bearbeiten" then
			lastText[FrakiGui.memo[1]] = dgsGetText(FrakiGui.memo[1])
			dgsMemoSetReadOnly( FrakiGui.memo[1], false )
			dgsSetEnabled(FrakiGui.button[11], true)
			dgsSetText(FrakiGui.button[10],"Abbrechen")
		else
			dgsMemoSetReadOnly( FrakiGui.memo[1], true )
			dgsSetEnabled(FrakiGui.button[11], false)
			dgsSetText(FrakiGui.button[10],"Bearbeiten")
			dgsSetText(FrakiGui.memo[1],"")
			dgsSetText(FrakiGui.memo[1],lastText[FrakiGui.memo[1]])
		end
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[11], function()
		
			triggerServerEvent("setMemo", getLocalPlayer(), dgsGetText(FrakiGui.memo[1]))
			dgsMemoSetReadOnly( FrakiGui.memo[1], true )
			dgsSetEnabled(FrakiGui.button[11], false)
			dgsSetText(FrakiGui.button[10],"Bearbeiten")
			lastText[FrakiGui.memo[1]] = nil
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[13], function()
		
		
        local id = dgsGridListGetItemText(FrakiGui.gridlist[3], dgsGridListGetSelectedItem(FrakiGui.gridlist[3]), 1)
		if id then
			
			triggerServerEvent("fraktionsMenu_deleteWarn", getLocalPlayer(), id )
			refreshWarns ()
		end
    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[9], function()
			dgsSetVisible(FrakiGui.window[1], false)
			showFactionCarBuyPanel ()

    end, false)
	
	addEventHandler("onDgsMouseClickUp", FrakiGui.button[8], function()
			local id = dgsGridListGetItemText(FrakiGui.gridlist[2], dgsGridListGetSelectedItem(FrakiGui.gridlist[2]), 1)
			local carname = dgsGridListGetItemText(FrakiGui.gridlist[2], dgsGridListGetSelectedItem(FrakiGui.gridlist[2]), 2)
			if id then

				triggerServerEvent("fraktionsMenu_sellCar", getLocalPlayer(), id, carname )
				refreshVehicles ()
				
		end

    end, false)
	end
end
addEvent( "openFraktionMenu", true )
addEventHandler( "openFraktionMenu", getRootElement(), openFraktionMenu )


function refreshMemo ()
	dgsSetText(FrakiGui.memo[1],"")
	triggerServerEvent("loadMemo",getRootElement(),getLocalPlayer())
end

function refreshLog ()
	dgsSetText(logtext,"")
	triggerServerEvent("loadLog",getRootElement(),getLocalPlayer())

end


function refreshVehicles ()
	dgsGridListClear (FrakiGui.gridlist[2])
	triggerServerEvent("loadFraktionVehicles",getRootElement(),getLocalPlayer())
end

function refreshMembers ()
	dgsGridListClear (FrakiGui.gridlist[1])
	triggerServerEvent("loadFraktionMember",getRootElement(),getLocalPlayer())
end

function refreshWarns ()
	dgsGridListClear (FrakiGui.gridlist[3])
	triggerServerEvent("loadWarns",getRootElement(),getLocalPlayer())
end

function onlyAllowedButtons()
	local fraktion = tonumber ( getElementData ( lp, "fraktion" ) )
	local rang = vioClientGetElementData ( "rang" )
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[1], true)
	else
		dgsSetEnabled(FrakiGui.button[1], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[2], true)
	else
		dgsSetEnabled(FrakiGui.button[2], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[3], true)
	else
		dgsSetEnabled(FrakiGui.button[3], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[4], true)
	else
		dgsSetEnabled(FrakiGui.button[4], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[8], true)
	else
		dgsSetEnabled(FrakiGui.button[8], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[6], true)
	else
		dgsSetEnabled(FrakiGui.button[6], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[9], true)
	else
		dgsSetEnabled(FrakiGui.button[9], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[10], true)
	else
		dgsSetEnabled(FrakiGui.button[10], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[11], false)
	else
		dgsSetEnabled(FrakiGui.button[11], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.button[12], true)
	else
		dgsSetEnabled(FrakiGui.button[12], false)
	end
	if rang >= 4 then
		dgsSetEnabled(FrakiGui.tab[5], true)
	else
		dgsSetEnabled(FrakiGui.tab[5], false)
	end
end

function loadLog (text)

	
	dgsSetText(logtext,text)
	
	
end
addEvent( "loadLog", true )
addEventHandler( "loadLog", getRootElement(), loadLog )

function loadFraktionMember (name, rang, status)
	
	memberlist[name] = dgsGridListAddRow(FrakiGui.gridlist[1])
	dgsGridListSetItemText(FrakiGui.gridlist[1], memberlist[name], membersname, name, false, false)
	dgsGridListSetItemText(FrakiGui.gridlist[1], memberlist[name], membersrang, rang, false, true)
	if status == "on" then
		dgsGridListSetItemText(FrakiGui.gridlist[1], memberlist[name], membersstatus, "Online", false, true)
		dgsGridListSetItemColor ( FrakiGui.gridlist[1], memberlist[name], membersstatus, 75,242,24 )
	else
		dgsGridListSetItemText(FrakiGui.gridlist[1], memberlist[name], membersstatus, getData(status), false, true)
		dgsGridListSetItemColor ( FrakiGui.gridlist[1], memberlist[name], membersstatus, 250,19,19 )
	end

	
end
addEvent( "loadFraktionMember", true )
addEventHandler( "loadFraktionMember", getRootElement(), loadFraktionMember )

function loadFraktionVehicles (id, model, Rang, Level, SX, SY, SZ, SXR, SYR, SZR)

	local zone = getZoneName ( SX, SY, SZ )
	local city = getZoneName ( SX, SY, SZ, true )
	local location = zone..(cityabk[city] or "")
	vehiclelist[id] = dgsGridListAddRow(FrakiGui.gridlist[2])
	
	dgsGridListSetItemText(FrakiGui.gridlist[2], vehiclelist[id], vehiclesid, id, false, false)
	dgsGridListSetItemText(FrakiGui.gridlist[2], vehiclelist[id], vehiclesveh, getVehicleNameFromModel(model), false, false)
	dgsGridListSetItemText(FrakiGui.gridlist[2], vehiclelist[id], vehiclesrang, Rang, false, true)
	dgsGridListSetItemText(FrakiGui.gridlist[2], vehiclelist[id], vehiclesgps, location, false, true)
	
end
addEvent( "loadFraktionVehicles", true )
addEventHandler( "loadFraktionVehicles", getRootElement(), loadFraktionVehicles )

function loadWarns (id, name, reason, ExpirationDate, Expiration)

	

	warnlist[id] = dgsGridListAddRow(FrakiGui.gridlist[3])
	
	dgsGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsid, id, false, false)
	dgsGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsname, name, false, false)
	dgsGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsreason, reason, false, true)
	if tonumber(Expiration) == 0 then
		dgsGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsexpiration, getData (ExpirationDate), false, true)
	else
		dgsGridListSetItemText(FrakiGui.gridlist[3], warnlist[id], warnsexpiration, "Abgelaufen", false, true)
		dgsGridListSetItemColor ( FrakiGui.gridlist[3], warnlist[id], warnsexpiration, 250,19,19 )
	end
	

	
end
addEvent( "loadWarns", true )
addEventHandler( "loadWarns", getRootElement(), loadWarns )

function setMemo (text)

	dgsSetText(FrakiGui.memo[1],text)
end
addEvent( "setMemo", true )
addEventHandler( "setMemo", getRootElement(), setMemo )