
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

local isintuninggarage = false

function showPremiumWindow ()

	--if getElementData ( lp, "premium" ) then
		if gWindow["tuningPremium"] then
			dgsSetVisible ( gWindow["tuningPremium"], true )
		else
			gWindow["tuningPremium"] = dgsCreateWindow(410,0,177,211,"Lichtfarbe",false)
			dgsSetAlpha(gWindow["tuningPremium"],1)
			dgsWindowSetMovable(gWindow["tuningPremium"],false)
			dgsWindowSetSizable(gWindow["tuningPremium"],false)
			gButton["submitLightColor"] = dgsCreateButton(48,162,91,38,"Übernehmen",false,gWindow["tuningPremium"])
			dgsSetAlpha(gButton["submitLightColor"],1)
			addEventHandler ( "onDgsMouseClickUp", gButton["submitLightColor"], 
				function ( btn, state )
					local red = math.floor ( dgsScrollBarGetScrollPosition ( redScroll ) * 2.55 )
					local green = math.floor ( dgsScrollBarGetScrollPosition ( greenScroll ) * 2.55 )
					local blue = math.floor ( dgsScrollBarGetScrollPosition ( blueScroll ) * 2.55 )
					triggerServerEvent ( "applyLightValues", lp, red, green, blue )
				end,
			false )
			gLabel["tuningLightColor"] = dgsCreateLabel(59,24,60,16,"Lichtfarbe",false,gWindow["tuningPremium"])
			dgsSetAlpha(gLabel["tuningLightColor"],1)
			dgsLabelSetColor(gLabel["tuningLightColor"],255,255,255)
			dgsLabelSetVerticalAlign(gLabel["tuningLightColor"],"top")
			dgsLabelSetHorizontalAlign(gLabel["tuningLightColor"],"left",false)
			dgsSetFont(gLabel["tuningLightColor"],"default-bold-small")
			
			redScroll = dgsCreateScrollBar ( 16, 42, 147, 34, true, false, gWindow["tuningPremium"] )
			greenScroll = dgsCreateScrollBar ( 16, 78, 147, 34, true, false, gWindow["tuningPremium"] )
			blueScroll = dgsCreateScrollBar ( 16, 114, 147, 34, true, false, gWindow["tuningPremium"] )
			
			addEventHandler ( "onDgsElementScroll", gWindow["tuningPremium"], 
				function ()
					local red = math.floor ( dgsScrollBarGetScrollPosition ( redScroll ) * 2.55 )
					local green = math.floor ( dgsScrollBarGetScrollPosition ( greenScroll ) * 2.55 )
					local blue = math.floor ( dgsScrollBarGetScrollPosition ( blueScroll ) * 2.55 )
					dgsLabelSetColor ( gLabel["tuningLightColor"], red, green, blue )
				end
			)
		end
		local red, green, blue = getVehicleHeadLightColor ( getPedOccupiedVehicle ( lp ) )
		dgsScrollBarSetScrollPosition ( redScroll, red )
		dgsScrollBarSetScrollPosition ( greenScroll, green )
		dgsScrollBarSetScrollPosition ( blueScroll, blue )
		addEventHandler ( "onDgsMouseClickUp", getRootElement(), partChange )
	--end
end

function showPlateWindow ()

	--if getElementData ( lp, "premium" ) then
		if gWindow["tuningPlate"] then
			dgsSetVisible ( gWindow["tuningPlate"], true )
		else
			gWindow["tuningPlate"] = dgsCreateWindow(410,214,177,183,"Nummernschild",false)
			dgsSetAlpha(gWindow["tuningPlate"],1)
			dgsWindowSetMovable(gWindow["tuningPlate"],false)
			dgsWindowSetSizable(gWindow["tuningPlate"],false)
			
			gLabel["tuningPlateColor"] = dgsCreateLabel(10,24,160,100,"Hier kannst du den Text\nauf deinem Numernschild\nändern, er darf maximal\n8 Zeichen lang sein.",false,gWindow["tuningPlate"])
			dgsSetAlpha(gLabel["tuningPlateColor"],1)
			dgsLabelSetColor(gLabel["tuningPlateColor"],255,255,255)
			dgsLabelSetVerticalAlign(gLabel["tuningPlateColor"],"top")
			dgsLabelSetHorizontalAlign(gLabel["tuningPlateColor"],"left",false)
			dgsSetFont(gLabel["tuningPlateColor"],"default-bold-small")
			
			gEdit["PlateText"] = dgsCreateEdit ( 16, 85, 147, 34, "", false, gWindow["tuningPlate"] )
			dgsEditSetMaxLength(gEdit["PlateText"], 8)
			
			gButton["submitPlate"] = dgsCreateButton(48,133,91,38,"Übernehmen",false,gWindow["tuningPlate"])
			dgsSetAlpha(gButton["submitPlate"],1)
			
			addEventHandler ( "onDgsMouseClickUp", gButton["submitPlate"], 
				function ( btn, state )
					local text = dgsGetText(gEdit["PlateText"])
					triggerServerEvent ( "applyPlate", lp, text )
				end,
			false )
		end
	--end
end

function SubmitLeaveTuningBtn (btn)

	if btn == "left" then
		isintuninggarage = false
		setElementCollisionsEnabled ( getPedOccupiedVehicle(lp), true )
		setElementFrozen ( getPedOccupiedVehicle(lp), false )
		destroyElement ( clientGarage )
		dgsSetVisible ( gWindow["tuningMenue"], false )
		addEventHandler ( "onDgsMouseClickUp", getRootElement(), partChange )
		if gWindow["tuningPremium"] then
			dgsSetVisible ( gWindow["tuningPremium"], false )
		end
		if gWindow["tuningPlate"] then
			dgsSetVisible ( gWindow["tuningPlate"], false )
		end
		showCursor ( false )
		setElementClicked ( false )
		local veh = getPedOccupiedVehicle ( lp )
		for i = 0, 16 do
			removeVehicleUpgrade ( veh, getVehicleUpgradeOnSlot ( veh, i ) )
		end
		for i = 0, 16 do
			_G["t"..i] = _G["upgradeSlot"..i.."MountedID"]
		end
		local c1, c2, c3, c4 = getVehicleColor ( veh )
		triggerServerEvent ( "CancelTuning", lp, lp, veh, c1, c2, c3, c4, curpainting, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16 )
	end
end
addEvent ( "SubmitLeaveTuningBtnAbbrechen", true)
addEventHandler ( "SubmitLeaveTuningBtnAbbrechen", getRootElement(), SubmitLeaveTuningBtn)

function SubmitPaintLeft ()

	curpainting = tonumber ( dgsGetText(gLabel["PaintingMiddle"]) )
	if curpainting == 0 then curpainting = 3 else
		curpainting = curpainting - 1
	end
	dgsSetText ( gLabel["PaintingMiddle"], curpainting )
	local veh = getPedOccupiedVehicle ( lp )
	setVehiclePaintjob ( veh, curpainting )
end
function SubmitPaintRight ()

	curpainting = tonumber ( dgsGetText(gLabel["PaintingMiddle"]) )
	if curpainting == 3 then curpainting = 0 else
		curpainting = curpainting + 1
	end
	dgsSetText ( gLabel["PaintingMiddle"], curpainting )
	local veh = getPedOccupiedVehicle ( lp )
	setVehiclePaintjob ( veh, curpainting )
end
function SubmitColorLeft ()

	curcolor = tonumber ( dgsGetText(gLabel["FarbeMiddle"]) )
	if curcolor == 0 then curcolor = 126 else
		curcolor = curcolor - 1
	end
	dgsSetText ( gLabel["FarbeMiddle"], curcolor )
	local veh = getPedOccupiedVehicle ( lp )
	local c1, c2, c3, c4 = getVehicleColor ( veh )
	setVehicleColor ( veh, curcolor, c2, c3, c4 )
end
function SubmitColorRight ()

	curcolor = tonumber ( dgsGetText(gLabel["FarbeMiddle"]) )
	if curcolor == 126 then curcolor = 0 else
		curcolor = curcolor + 1
	end
	dgsSetText ( gLabel["FarbeMiddle"], curcolor )
	local veh = getPedOccupiedVehicle ( lp )
	local c1, c2, c3, c4 = getVehicleColor ( veh )
	setVehicleColor ( veh, curcolor, c2, c3, c4 )
end

function SubmitpaintLeft2 ()

	c2 = tonumber ( dgsGetText(gLabel["PaintingMiddle2"]) )
	if c2 == 0 then c2 = 126 else
		c2 = c2 - 1
	end
	dgsSetText ( gLabel["PaintingMiddle2"], c2 )
	local veh = getPedOccupiedVehicle ( lp )
	local c1, TAR, c3, c4 = getVehicleColor ( veh )
	setVehicleColor ( veh, c1, c2, c3, c4 )
end
function SubmitpaintRight2 ()

	c2 = tonumber ( dgsGetText(gLabel["PaintingMiddle2"]) )
	if c2 == 126 then c2 = 0 else
		c2 = c2 + 1
	end
	dgsSetText ( gLabel["PaintingMiddle2"], c2 )
	local veh = getPedOccupiedVehicle ( lp )
	local c1, TAR, c3, c4 = getVehicleColor ( veh )
	setVehicleColor ( veh, c1, c2, c3, c4 )
end
function SubmitpaintLeft3 ()

	c3 = tonumber ( dgsGetText(gLabel["PaintingMiddle3"]) )
	if c3 == 0 then c3 = 126 else
		c3 = c3 - 1
	end
	dgsSetText ( gLabel["PaintingMiddle3"], c3 )
	local veh = getPedOccupiedVehicle ( lp )
	local c1, c2, TAR, c4 = getVehicleColor ( veh )
	setVehicleColor ( veh, c1, c2, c3, c4 )
end
function SubmitpaintRight3 ()

	c3 = tonumber ( dgsGetText(gLabel["PaintingMiddle3"]) )
	if c3 == 126 then c3 = 0 else
		c3 = c3 + 1
	end
	dgsSetText ( gLabel["PaintingMiddle3"], c3 )
	local veh = getPedOccupiedVehicle ( lp )
	local c1, c2, TAR, c4 = getVehicleColor ( veh )
	setVehicleColor ( veh, c1, c2, c3, c4 )
end
function SubmitpaintLeft4 ()

	c4 = tonumber ( dgsGetText(gLabel["PaintingMiddle4"]) )
	if c4 == 0 then c4 = 126 else
		c4 = c4 - 1
	end
	dgsSetText ( gLabel["PaintingMiddle4"], c4 )
	local veh = getPedOccupiedVehicle ( lp )
	local c1, c2, c3, TAR = getVehicleColor ( veh )
	setVehicleColor ( veh, c1, c2, c3, c4 )
end
function SubmitpaintRight4 ()

	c4 = tonumber ( dgsGetText(gLabel["PaintingMiddle4"]) )
	if c4 == 126 then c4 = 0 else
		c4 = c4 + 1
	end
	dgsSetText ( gLabel["PaintingMiddle4"], c4 )
	local veh = getPedOccupiedVehicle ( lp )
	local c1, c2, c3, TAR = getVehicleColor ( veh )
	setVehicleColor ( veh, c1, c2, c3, c4 )
end

function SubmitBuyTuningBtn (btn)

	if btn == "left" then
		local veh = getPedOccupiedVehicle ( lp )
		local rowindex, columnindex = dgsGridListGetSelectedItem ( gGrid["tuningSelect"] )
		local selectedText = dgsGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPart"] )
		local mounted = dgsGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"] )
		local part = tonumber ( selectedText )
		local tdata = _G["tdata"..rowindex]
		if tdata then
			local data1 = tonumber(gettok ( tdata, 1, string.byte("|") ) ) 			-- Upgrade
			local data2 = tonumber(gettok ( tdata, 2, string.byte("|") ) )			-- Preis
			local data3 = gettok ( tdata, 3, string.byte("|") )						-- Fix ( "    [_]" v. "    [x]" 
			local data4 = tonumber(gettok ( tdata, 4, string.byte("|") ) )	
			if data2 <= mymoney then
				if mounted == "    [_]" then
					triggerServerEvent ( "buyTuningPart", lp, lp, veh, part, data2 )
					dgsGridListClear ( gGrid["tuningSelect"] )
					listfix (getElementModel(veh))
					dgsSetText ( gLabel["moneyAmount"], (mymoney-data2).." $" )
					dgsGridListSetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"], "    [x]", true, false )
					_G["upgradeSlot"..data4.."MountedID"] = data1
					dgsGridListSetSelectedItem ( gGrid["tuningSelect"], 0, 0 )
				else
					infobox_start ( "\n\nDieses Teil hast\ndu bereits!", 7500, 125, 0, 0 )
				end
			else
				infobox_start ( "\n\n\nDu hast zu\nwenig Geld!", 7500, 125, 0, 0 )
			end
		else
			local price = dgsGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPrice"] )
			local price = tonumber ( gettok ( price, 1, string.byte("$") ) )
			if price then
				local text = dgsGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPart"] )
				for i = 1, specialUpgrades do
					if specialUpgrade[i] == text then
						local upgrade = specialUpgrade[i]
						if mymoney >= price then
							local fix = dgsGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"] )
							if fix == "    [_]" then
								dgsSetText ( gLabel["moneyAmount"], mymoney-price.." $" )
								triggerServerEvent ( "addSpecialTuning", lp, i )
								dgsGridListSetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"], "    [x]", false, false )
							else
								infobox_start ( "\n\n\nDu hast dieses\nTeil bereits!", 7500, 125, 0, 0 )
							end
						end
						break
					end
				end
			else
				infobox_start ( "\n\n\nDu hast zu\nwenig Geld!", 7500, 125, 0, 0 )
			end
		end
	end
end
addEvent ( "SubmitBuyTuningBtnAbbrechen", true)
addEventHandler ( "SubmitBuyTuningBtnAbbrechen", getRootElement(), SubmitBuyTuningBtn)

function createTuningMenue ()

	isintuninggarage = true
	showCursor ( true )
	setElementClicked ( true )
	showPremiumWindow ()
	showPlateWindow ()
	local curcolor, c2, c3, c4 = getVehicleColor ( veh )
	local curpainting = getVehiclePaintjob ( veh )
	local i = getElementData ( veh, "usingdim" )
	clientGarage = createObject ( 14798, -2052.3671875, 143.50421142578, 29.126596450806, 0, 0, 0 )
	setElementDimension ( clientGarage, i )
	--setElementInterior ( clientGarage, i )
	setElementCollisionsEnabled ( getPedOccupiedVehicle(lp), false )
	setElementFrozen ( getPedOccupiedVehicle(lp), true )
	if gWindow["tuningMenue"] then
		dgsSetVisible ( gWindow["tuningMenue"], true )
	else
		local screenwidth, screenheight = dgsGetScreenSize ()
		gWindow["tuningMenue"] = dgsCreateWindow(0,0,406,397,"Tuningmenü",false)
		dgsSetAlpha(gWindow["tuningMenue"],1)
		dgsWindowSetMovable(gWindow["tuningMenue"],false)
		dgsWindowSetSizable(gWindow["tuningMenue"],false)
		gGrid["tuningSelect"] = dgsCreateGridList(0.0493,0.0932,0.7389,0.864,true,gWindow["tuningMenue"])
		dgsGridListSetSelectionMode(gGrid["tuningSelect"],0)
		gColumn["tuningPart"] = dgsGridListAddColumn(gGrid["tuningSelect"],"Tuningteil",0.43)
		gColumn["tuningPrice"] = dgsGridListAddColumn(gGrid["tuningSelect"],"Preis",0.2)
		gColumn["tuningIn"] = dgsGridListAddColumn(gGrid["tuningSelect"],"Eingebaut",0.17)
		gColumn["tuningID"] = dgsGridListAddColumn(gGrid["tuningSelect"],"",0)
		dgsSetAlpha(gGrid["tuningSelect"],1)
		gLabel["Geld"] = dgsCreateLabel(0.8177,0.0982,0.1281,0.0479,"Geld:",true,gWindow["tuningMenue"])
		dgsSetAlpha(gLabel["Geld"],1)
		dgsLabelSetColor(gLabel["Geld"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["Geld"],"top")
		dgsLabelSetHorizontalAlign(gLabel["Geld"],"left",false)
		
		gLabel["moneyAmount"] = dgsCreateLabel(0.8177,0.1461,0.17,0.0504,mymoney.." $",true,gWindow["tuningMenue"])
		dgsSetAlpha(gLabel["moneyAmount"],1)
		dgsLabelSetColor(gLabel["moneyAmount"],000,125,000)
		dgsLabelSetVerticalAlign(gLabel["moneyAmount"],"top")
		dgsLabelSetHorizontalAlign(gLabel["moneyAmount"],"left",false)
		
		gButton["buyUpgrade"] = dgsCreateButton(0.8177,0.2141,0.1527,0.0806,"Kaufen",true,gWindow["tuningMenue"])
		dgsSetAlpha(gButton["buyUpgrade"],1)
		gButton["delUpgrade"] = dgsCreateButton(0.8177,0.3123,0.1527,0.0806,"Loeschen",true,gWindow["tuningMenue"])
		dgsSetAlpha(gButton["delUpgrade"],1)
		addEventHandler ( "onDgsMouseClickUp", gButton["delUpgrade"], 
			function ()
				local rowindex, columnindex = dgsGridListGetSelectedItem ( gGrid["tuningSelect"] )
				local selectedText = dgsGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPart"] )
				local mounted = dgsGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"] )
				local part = tonumber ( selectedText )
				local tdata = _G["tdata"..rowindex]
				local data1 = tonumber(gettok ( tdata, 1, string.byte("|") ) ) 			-- Upgrade
				local data2 = tonumber(gettok ( tdata, 2, string.byte("|") ) )			-- Preis
				local data3 = gettok ( tdata, 3, string.byte("|") )						-- Fix ( "    [_]" v. "    [x]" 
				local data4 = tonumber(gettok ( tdata, 4, string.byte("|") ) )			-- Slot
				if mounted == "    [x]" and tdata then
					triggerServerEvent ( "buyTuningPart", lp, lp, veh, part, data2 )
					dgsGridListClear ( gGrid["tuningSelect"] )
					listfix (getElementModel(veh))
					dgsGridListSetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningIn"], "    [ ]", true, false )
					_G["upgradeSlot"..data4.."MountedID"] = false
					removeVehicleUpgrade ( veh, data1 )
					dgsGridListSetSelectedItem ( gGrid["tuningSelect"], 0, 0 )
					triggerServerEvent ( "removeTuningPart", lp, lp, veh, part, data2 )
				end
			end,
		false )
		gButton["closeUpgradeStore"] = dgsCreateButton(0.8177,0.4081,0.1527,0.0806,"Schliessen",true,gWindow["tuningMenue"])
		dgsSetAlpha(gButton["closeUpgradeStore"],1)
		addEventHandler("onDgsMouseClickUp", gButton["closeUpgradeStore"], SubmitLeaveTuningBtn, false)
		addEventHandler("onDgsMouseClickUp", gButton["buyUpgrade"], SubmitBuyTuningBtn, false)
	end
	local veh = getPedOccupiedVehicle ( lp )
	dgsGridListClear ( gGrid["tuningSelect"] )
	dgsSetText ( gLabel["moneyAmount"], mymoney.." $" )
	local vehID = getElementModel ( getPedOccupiedVehicle ( lp ) )
	for i = 0, 16 do
		_G["upgradeSlot"..i.."MountedID"] = false
	end
	listfix (vehID)
end
addEvent ( "createTuningMenue", true )
addEventHandler ( "createTuningMenue", getRootElement(), createTuningMenue )

function listfix(vehID)

	local row = dgsGridListAddRow ( gGrid["tuningSelect"] )
	dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], "Spezial", true, false )
	dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], "", true, false )
	dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], "", true, false )
	dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", true, false )
	for i = 1, specialUpgrades do
		local row = dgsGridListAddRow ( gGrid["tuningSelect"] )
		local fix = getElementData ( getPedOccupiedVehicle ( lp ), "stuning"..i )
		if fix then fix = "    [x]" else fix = "    [_]" end
		dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], specialUpgrade[i], false, false )
		dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], specialUpgradePrice[i].." $", false, false )
		dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], fix, false, false )
		dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", false, false )
	end
	local row = dgsGridListAddRow ( gGrid["tuningSelect"] )
	dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], "", false, false )
	dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], "", false, false )
	dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], "", false, false )
	dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", false, false )
	
	for upgradeSlot=0,16 do
		upin = 0
		local compatList = compatibleUpgrades[vehID][upgradeSlot]
		if compatList then
			for i, upgradeID in ipairs(compatList) do				
				upin = 1
			end
		end
		if upin == 1 then
			local row = dgsGridListAddRow ( gGrid["tuningSelect"] )
			dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], slotNames[upgradeSlot], true, false )
			dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], "", true, false )
			dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], "", true, false )
			dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", true, false )
			for i, upgradeID in ipairs(compatList) do				
				local row = dgsGridListAddRow ( gGrid["tuningSelect"] )
				dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], "  "..UpgradeNames[upgradeID], false, false )
				local data1 = tostring ( upgradeID )
				if upgradeSlot == 8 then
					if upgradeID == 1008 then price = 5*nitroprice end
					if upgradeID == 1009 then price = 2*nitroprice end
					if upgradeID == 1010 then price = 10*nitroprice end
				else
					price = tuningpartprice
				end
				local data2 = tostring ( price )
				dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], price.." $", false, false )
				if getVehicleUpgradeOnSlot ( getPedOccupiedVehicle ( lp ), upgradeSlot ) == upgradeID then 
					fix = "    [x]"
					_G["upgradeSlot"..upgradeSlot.."MountedID"] = upgradeID
				else
					fix = "    [_]" 
				end
				local data3 = fix
				local data4 = upgradeSlot
				local tdata = data1.."|"..data2.."|"..data3.."|"..data4.."|"
				_G["tdata"..row] = tdata
				dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], fix, false, false )
				dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], upgradeID, false, false )
			end
			local row = dgsGridListAddRow ( gGrid["tuningSelect"] )
			dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPart"], "", true, false )
			dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningPrice"], "", true, false )
			dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningIn"], "", true, false )
			dgsGridListSetItemText( gGrid["tuningSelect"], row, gColumn["tuningID"], "", true, false )
		end
	end
end

function partChange ()

	if isElement(gWindow["tuningMenue"]) and isintuninggarage then
		local rowindex, columnindex = dgsGridListGetSelectedItem ( gGrid["tuningSelect"] )
		local selectedText = dgsGridListGetItemText ( gGrid["tuningSelect"], rowindex, gColumn["tuningPart"] )
		if selectedText then
			local veh = getPedOccupiedVehicle ( lp )
			for i = 0, 16 do
				removeVehicleUpgrade ( veh, getVehicleUpgradeOnSlot ( veh, i ) )
			end
			for i = 0, 16 do
				if ( _G["upgradeSlot"..i.."MountedID"] == false ) then
				else
					addVehicleUpgrade ( veh, _G["upgradeSlot"..i.."MountedID"] )
				end
			end
			local tdata = _G["tdata"..rowindex]
			if tdata then
				local data1 = tonumber(gettok ( tdata, 1, string.byte("|") ) ) 			-- Upgrade
				if data1 then
					local data2 = tonumber(gettok ( tdata, 2, string.byte("|") ) )			-- Preis
					local data3 = gettok ( tdata, 3, string.byte("|") )						-- Fix ( "    [_]" v. "    [x]" 
					local data4 = tonumber(gettok ( tdata, 4, string.byte("|") ))			-- Slot
					local veh = getPedOccupiedVehicle ( lp )
					if getVehicleUpgradeOnSlot ( veh, data4 ) ~= data1 then
						addVehicleUpgrade ( veh, data1 )
					end
				end
			end
		end
	end
end
