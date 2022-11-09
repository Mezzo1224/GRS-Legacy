
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

trailerMarker = createMarker ( -911.3271484375, -486.00863647461, 24.89, "cylinder", 3, 150, 0, 0, 150 )
createBlip ( -911.3271484375, -486.00863647461, 24.89, 55, 1, 0, 0, 0, 255, 0, 200 )

function showWohnwagenMenue ( hit, dim )

	if hit == lp and dim then
		if not getPedOccupiedVehicle ( lp ) then
			showCursor ( true )
			setElementClicked ( true )
			if gWindow["wohnwagen"] then
				dgsSetVisible ( gWindow["wohnwagen"], true )
			else
				gWindow["wohnwagen"] = dgsCreateWindow(screenwidth/2-307/2,screenheight/2-205/2,307,205,"Wohnwagen",false)
				dgsWindowSetMovable ( gWindow["wohnwagen"], false )
				dgsWindowSetSizable ( gWindow["wohnwagen"], false )
				
				dgsSetAlpha(gWindow["wohnwagen"],1)
				gLabel["wohnmobilInfo1"] = dgsCreateLabel(12,27,289,78,"Hier kannst du einen Wohnwagen erwerben,\nan dem du Spawnen und essen kannst.\n\nAusserdem kannst du ihm - wie jedem Fahrzeug -\neinen Kofferraum einbauen.",false,gWindow["wohnwagen"])
				dgsSetAlpha(gLabel["wohnmobilInfo1"],1)
				dgsLabelSetColor(gLabel["wohnmobilInfo1"],200,200,0)
				dgsLabelSetVerticalAlign(gLabel["wohnmobilInfo1"],"top")
				dgsLabelSetHorizontalAlign(gLabel["wohnmobilInfo1"],"left",false)
				dgsSetFont(gLabel["wohnmobilInfo1"],"default-bold-small")
				gButton["trailerBuy"] = dgsCreateButton(92,125,87,44,"Kaufen",false,gWindow["wohnwagen"])
				dgsSetAlpha(gButton["trailerBuy"],1)
				dgsSetFont(gButton["trailerBuy"],"default-bold-small")
				gLabel[2] = dgsCreateLabel(20,100,44,18,"Kosten:",false,gWindow["wohnwagen"])
				dgsSetAlpha(gLabel[2],1)
				dgsLabelSetColor(gLabel[2],125,0,0)
				dgsLabelSetVerticalAlign(gLabel[2],"top")
				dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
				dgsSetFont(gLabel[2],"default-bold-small")
				gLabel[3] = dgsCreateLabel(13,114,63,15,"50.500 $",false,gWindow["wohnwagen"])
				dgsSetAlpha(gLabel[3],1)
				dgsLabelSetColor(gLabel[3],0,125,0)
				dgsLabelSetVerticalAlign(gLabel[3],"top")
				dgsLabelSetHorizontalAlign(gLabel[3],"left",false)
				dgsSetFont(gLabel[3],"default-bold-small")
				gLabel[4] = dgsCreateLabel(10,136,71,21,"Zahlen per...",false,gWindow["wohnwagen"])
				dgsSetAlpha(gLabel[4],1)
				dgsLabelSetColor(gLabel[4],255,255,255)
				dgsLabelSetVerticalAlign(gLabel[4],"top")
				dgsLabelSetHorizontalAlign(gLabel[4],"left",false)
				dgsSetFont(gLabel[4],"default-bold-small")
				gRadio["trailerPayEC"] = dgsCreateRadioButton(9,157,68,14,"EC Karte",false,gWindow["wohnwagen"])
				dgsSetAlpha(gRadio["trailerPayEC"],1)
				dgsSetFont(gRadio["trailerPayEC"],"default-bold-small")
				gRadio["trailerPayBar"] = dgsCreateRadioButton(9,176,68,14,"Bargeld",false,gWindow["wohnwagen"])
				dgsSetAlpha(gRadio["trailerPayBar"],1)
				dgsRadioButtonSetSelected(gRadio["trailerPayEC"],true)
				dgsSetFont(gRadio["trailerPayBar"],"default-bold-small")
				gImage[1] = dgsCreateImage(193,113,95,74,"images/gui/trailer.png",false,gWindow["wohnwagen"])
				dgsSetAlpha(gImage[1],1)
				gButton["trailerClose"] = dgsCreateButton(280,24,18,19,"x",false,gWindow["wohnwagen"])
				dgsSetAlpha(gButton["trailerClose"],1)
				dgsSetFont(gButton["trailerClose"],"default-bold-small")
				
				addEventHandler ( "onDgsMouseClickUp", gButton["trailerClose"],
					function ()
						dgsSetVisible ( gWindow["wohnwagen"], false )
						showCursor ( false )
						setElementClicked ( false )
					end,
				false )
				addEventHandler ( "onDgsMouseClickUp", gButton["trailerBuy"],
					function ()
						dgsSetVisible ( gWindow["wohnwagen"], false )
						showCursor ( false )
						setElementClicked ( false )
						if dgsRadioButtonGetSelected ( gRadio["trailerPayEC"] ) then
							ec = true
						else
							ec = false
						end
						triggerServerEvent ( "buyTrailer", lp, ec )
					end,
				false )
			end
		end
	end
end
addEventHandler ( "onClientMarkerHit", trailerMarker, showWohnwagenMenue )
--<marker id="marker (cylinder) (1)" type="cylinder" color="#0000ff99" size="3" interior="0" dimension="0" posX="-911.3271484375" posY="-486.00863647461" posZ="24.896272659302" rotX="0" rotY="0" rotZ="0" />