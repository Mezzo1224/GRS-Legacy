
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

createMarker ( -2667.78, -5.39, 5.05, "cylinder", 3, 255, 0, 0, 150 )
baumarktSphere = createColSphere ( -2667.78, -5.39, 5.05, 3 )
createBlip ( -2667.78, -5.39, 5.05, 11, 2, 255, 0, 0, 255, 0, 200 )
local clickedbut = nil

function showBaumarktMenue ( hit )

	if hit == lp then
		showCursor ( true )
		setElementClicked ( true )
		if gWindow["baumarkt"] then
			dgsSetVisible ( gWindow["baumarkt"], true )
		else
			gWindow["baumarkt"] = dgsCreateWindow(screenwidth/2-445/2,screenheight/2-294/2,445,294,"Baumarkt",false)
			dgsSetAlpha(gWindow["baumarkt"],1)
			
			gLabel[1] = dgsCreateLabel(10,26,418,32,"Herzlich Willkommen!\nHier kannst du Objekte erwerben, die du anschließend platzieren kannst.",false,gWindow["baumarkt"])
			dgsSetAlpha(gLabel[1],1)
			dgsLabelSetColor(gLabel[1],255,255,255)
			dgsLabelSetVerticalAlign(gLabel[1],"top")
			dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
			dgsSetFont(gLabel[1],"default-bold-small")
			
			gButton["closeBaumarkt"] = dgsCreateButton(419,23,16,17,"x",false,gWindow["baumarkt"])
			dgsSetAlpha(gButton["closeBaumarkt"],1)
			addEventHandler ( "onDgsMouseClickUp", gButton["closeBaumarkt"], hideBaumarktMenue, false )
			
			gButton[1] = dgsCreateButton(9,58,133,67,"",false,gWindow["baumarkt"])
			dgsSetAlpha(gButton[1],1)
			local btn = gButton[1]
			clickedbut = 841
			local img = dgsCreateImage(8,6,50,50,"images/inventory/placeable/campfire.png",false,btn)
			dgsSetAlpha(img,1)
			local label = dgsCreateLabel(63,10,65,52,"Lagerfeuer\n\n"..placeablePrices[clickedbut].." $",false,btn)
			dgsSetAlpha(label,1)
			dgsLabelSetColor(label,255,255,255)
			dgsLabelSetVerticalAlign(label,"top")
			dgsLabelSetHorizontalAlign(label,"left",false)
			dgsSetFont(label,"default-bold-small")
			
			gButton[2] = dgsCreateButton(157,58,133,67,"",false,gWindow["baumarkt"])
			dgsSetAlpha(gButton[2],1)
			local btn = gButton[2]
			clickedbut = 3461
			local img = dgsCreateImage(8,6,50,50,"images/inventory/placeable/torch.png",false,btn)
			dgsSetAlpha(img,1)
			local label = dgsCreateLabel(63,10,65,52,"Fackel\n\n"..placeablePrices[clickedbut].." $",false,btn)
			dgsSetAlpha(label,1)
			dgsLabelSetColor(label,255,255,255)
			dgsLabelSetVerticalAlign(label,"top")
			dgsLabelSetHorizontalAlign(label,"left",false)
			dgsSetFont(label,"default-bold-small")
			
			gButton[3] = dgsCreateButton(9,140,133,67,"",false,gWindow["baumarkt"])
			dgsSetAlpha(gButton[3],1)
			local btn = gButton[3]
			clickedbut = 1946
			local img = dgsCreateImage(8,6,50,50,"images/inventory/placeable/ball_a.png",false,btn)
			dgsSetAlpha(img,1)
			local label = dgsCreateLabel(63,10,65,52,"Basketball\n\n"..placeablePrices[clickedbut].." $",false,btn)
			dgsSetAlpha(label,1)
			dgsLabelSetColor(label,255,255,255)
			dgsLabelSetVerticalAlign(label,"top")
			dgsLabelSetHorizontalAlign(label,"left",false)
			dgsSetFont(label,"default-bold-small")
			
			gButton[4] = dgsCreateButton(157,140,133,67,"",false,gWindow["baumarkt"])
			dgsSetAlpha(gButton[4],1)
			local btn = gButton[4]
			clickedbut = 1598
			local img = dgsCreateImage(8,6,50,50,"images/inventory/placeable/ball_b.png",false,btn)
			dgsSetAlpha(img,1)
			local label = dgsCreateLabel(63,10,65,52,"Strandball\n\n"..placeablePrices[clickedbut].." $",false,btn)
			dgsSetAlpha(label,1)
			dgsLabelSetColor(label,255,255,255)
			dgsLabelSetVerticalAlign(label,"top")
			dgsLabelSetHorizontalAlign(label,"left",false)
			dgsSetFont(label,"default-bold-small")
			
			gButton[5] = dgsCreateButton(303,58,133,67,"",false,gWindow["baumarkt"])
			dgsSetAlpha(gButton[5],1)
			local btn = gButton[5]
			clickedbut = 1481
			local img = dgsCreateImage(8,6,50,50,"images/inventory/placeable/grill.png",false,btn)
			dgsSetAlpha(img,1)
			local label = dgsCreateLabel(63,10,65,52,"Grill\n\n"..placeablePrices[clickedbut].." $",false,btn)
			dgsSetAlpha(label,1)
			dgsLabelSetColor(label,255,255,255)
			dgsLabelSetVerticalAlign(label,"top")
			dgsLabelSetHorizontalAlign(label,"left",false)
			dgsSetFont(label,"default-bold-small")
			
			gButton[6] = dgsCreateButton(303,140,133,67,"",false,gWindow["baumarkt"])
			dgsSetAlpha(gButton[6],1)
			local btn = gButton[6]
			clickedbut = 1255
			local img = dgsCreateImage(8,6,50,50,"images/inventory/placeable/liege.png",false,btn)
			dgsSetAlpha(img,1)
			local label = dgsCreateLabel(63,10,65,52,"Liege\n\n"..placeablePrices[clickedbut].." $",false,btn)
			dgsSetAlpha(label,1)
			dgsLabelSetColor(label,255,255,255)
			dgsLabelSetVerticalAlign(label,"top")
			dgsLabelSetHorizontalAlign(label,"left",false)
			dgsSetFont(label,"default-bold-small")
			
			gButton[7] = dgsCreateButton(10,214,133,67,"",false,gWindow["baumarkt"])
			dgsSetAlpha(gButton[7],1)
			local btn = gButton[7]
			clickedbut = 1640
			local img = dgsCreateImage(8,6,50,50,"images/inventory/placeable/towel.png",false,btn)
			dgsSetAlpha(img,1)
			local label = dgsCreateLabel(63,10,65,52,"Handtuch\n\n"..placeablePrices[clickedbut].." $",false,btn)
			dgsSetAlpha(label,1)
			dgsLabelSetColor(label,255,255,255)
			dgsLabelSetVerticalAlign(label,"top")
			dgsLabelSetHorizontalAlign(label,"left",false)
			dgsSetFont(label,"default-bold-small")
			
			--[[gButton[8] = guiCreateButton(303,214,133,67,"",false,gWindow["baumarkt"])
			dgsSetAlpha(gButton[8],1)
			local btn = gButton[8]
			clickedbut = 2103
			local img = dgsCreateImage(8,6,50,50,"images/inventory/placeable/hi_fi.png",false,btn)
			dgsSetAlpha(img,1)
			local label = dgsCreateLabel(63,10,65,52,"Stereo-\nanlage\n\n"..placeablePrices[clickedbut].." $",false,btn)
			dgsSetAlpha(label,1)
			dgsLabelSetColor(label,255,255,255)
			dgsLabelSetVerticalAlign(label,"top")
			dgsLabelSetHorizontalAlign(label,"left",false)
			dgsSetFont(label,"default-bold-small")]]
			
			gRadio["colorSelect1"] = dgsCreateRadioButton(151,237,73,23,"Gruen",false,gWindow["baumarkt"])
			dgsSetAlpha(gRadio["colorSelect1"],1)
			dgsSetFont(gRadio["colorSelect1"],"default-bold-small")
			gRadio["colorSelect2"] = dgsCreateRadioButton(151,215,73,23,"Lila",false,gWindow["baumarkt"])
			dgsSetAlpha(gRadio["colorSelect2"],1)
			dgsSetFont(gRadio["colorSelect2"],"default-bold-small")
			gRadio["colorSelect3"] = dgsCreateRadioButton(229,238,73,23,"Rot",false,gWindow["baumarkt"])
			dgsSetAlpha(gRadio["colorSelect3"],1)
			dgsSetFont(gRadio["colorSelect3"],"default-bold-small")
			gRadio["colorSelect4"] = dgsCreateRadioButton(151,259,73,23,"Gelb",false,gWindow["baumarkt"])
			dgsSetAlpha(gRadio["colorSelect4"],1)
			dgsRadioButtonSetSelected(gRadio["colorSelect4"],true)
			dgsSetFont(gRadio["colorSelect4"],"default-bold-small")
			
			addEventHandler( "onDgsMouseClickUp", gWindow["baumarkt"], purchaseItem )
		end
	end
end
addEventHandler ( "onClientColShapeHit", baumarktSphere, showBaumarktMenue )

function hideBaumarktMenue ()

	dgsSetVisible ( gWindow["baumarkt"], false )
	showCursor ( false )
	setElementClicked ( false )
end

function purchaseItem ()

	if clickedbut then
		if clickedbut == 1640 then
			-- Radio Buttons
			if dgsRadioButtonGetSelected ( gRadio["colorSelect2"] ) then
				clickedbut = 1641
			elseif dgsRadioButtonGetSelected ( gRadio["colorSelect3"] ) then
				clickedbut = 1642
			elseif dgsRadioButtonGetSelected ( gRadio["colorSelect4"] ) then
				clickedbut = 1643
			end
		end
		triggerServerEvent ( "purchaseItem", lp, clickedbut )
	end
end