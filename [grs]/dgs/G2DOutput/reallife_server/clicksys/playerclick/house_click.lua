
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

eatSwitch = false

function showHouseGui_func ( amount )

	if source == lp then
		if gWindow["houseMenue"] then
			eatSwitch = false
			dgsSetVisible ( gWindow["houseMenue"], true )
			dgsSetText ( gLabel["houseAmount"], amount )
		else
			gWindow["houseMenue"] = dgsCreateWindow(screenwidth/2-173/2,screenheight/2-215/2,173,215,"Hausmenue",false)
			dgsSetAlpha(gWindow["houseMenue"],1)
			gImage["house$"] = dgsCreateImage(0.3295,0.1349,0.1734,0.1349,"images/dollar.png",true,gWindow["houseMenue"])
			dgsSetAlpha(gImage["house$"],1)
			gLabel["houseAmount"] = dgsCreateLabel(0.0578,0.1628,0.2717,0.0837,"5000",true,gWindow["houseMenue"])
			dgsSetAlpha(gLabel["houseAmount"],1)
			dgsLabelSetColor(gLabel["houseAmount"],000,125,010)
			dgsLabelSetVerticalAlign(gLabel["houseAmount"],"top")
			dgsLabelSetHorizontalAlign(gLabel["houseAmount"],"left",false)
			dgsSetFont(gLabel["houseAmount"],"default-bold-small")
			dgsSetText ( gLabel["houseAmount"], amount )
			gLabel["houseInfo"] = dgsCreateLabel(0.526,0.1209,0.4046,0.1721,"Befinden sich\nmomentan in\nder Hauskasse.",true,gWindow["houseMenue"])
			dgsSetAlpha(gLabel["houseInfo"],1)
			dgsLabelSetColor(gLabel["houseInfo"],255,255,255)
			dgsLabelSetVerticalAlign(gLabel["houseInfo"],"top")
			dgsLabelSetHorizontalAlign(gLabel["houseInfo"],"left",false)
			dgsSetFont(gLabel["houseInfo"],"default-small")
			gMemo["houseAmount"] = dgsCreateMemo(0.052,0.3674,0.4913,0.1488,"500",true,gWindow["houseMenue"])
			dgsSetAlpha(gMemo["houseAmount"],1)
			gButton["houseGive"] = dgsCreateButton(0.5838,0.3209,0.341,0.1116,"Einzahlen",true,gWindow["houseMenue"])
			dgsSetAlpha(gButton["houseGive"],1)
			gButton["houseTake"] = dgsCreateButton(0.5838,0.4651,0.341,0.1116,"Auszahlen",true,gWindow["houseMenue"])
			dgsSetAlpha(gButton["houseTake"],1)
			gButton["houseHeal"] = dgsCreateButton(0.0636,0.614,0.3988,0.1395,"Heilen",true,gWindow["houseMenue"])
			dgsSetAlpha(gButton["houseHeal"],1)
			gButton["houseEat"] = dgsCreateButton(0.5434,0.614,0.3988,0.1395,"Essen",true,gWindow["houseMenue"])
			dgsSetAlpha(gButton["houseEat"],1)
			--gButton["houseGuns"] = guiCreateButton(0.8786/2+0.0636,0.8,0.3988,0.1395,"Waffenbox",true,gWindow["houseMenue"])
			--guiSetAlpha(gButton["houseGuns"],1)
			gButton["houseGuns"] = dgsCreateButton(0.0636,0.8,0.3988,0.1395,"Waffenbox",true,gWindow["houseMenue"])
			dgsSetAlpha(gButton["houseGuns"],1)
			gButton["houseClose"] = dgsCreateButton(0.5434,0.8,0.3988,0.1395,"Schliessen",true,gWindow["houseMenue"])
			dgsSetAlpha(gButton["houseClose"],1)
			
			houseButtson = {
			 [gButton["houseClose"]]=true,
			 [gButton["houseGive"]]=true,
			 [gButton["houseTake"]]=true,
			 [gButton["houseHeal"]]=true,
			 [gButton["houseEat"]]=true,
			 [gButton["houseGuns"]]=true
			}
			
			addEventHandler( "onDgsMouseClickUp", gButton["houseClose"],
				function ()
					if houseButtson[source] then
						dgsSetVisible ( gWindow["houseMenue"], false )
						setElementClicked ( false )
						showCursor ( false )
					end
				end
			)
			
			addEventHandler( "onDgsMouseClickUp", gButton["houseGive"],
				function ()
					if houseButtson[source] then
						triggerServerEvent ( "houseClickServer", lp, lp, "give", tonumber ( dgsGetText ( gMemo["houseAmount"] ) ) )
					end
				end
			)
			addEventHandler( "onDgsMouseClickUp", gButton["houseTake"],
				function ()
					if houseButtson[source] then
						triggerServerEvent ( "houseClickServer", lp, lp, "take", tonumber ( dgsGetText ( gMemo["houseAmount"] ) ) )
					end
				end
			)
			addEventHandler( "onDgsMouseClickUp", gButton["houseHeal"],
				function ()
					if houseButtson[source] then
						triggerServerEvent ( "houseClickServer", lp, lp, "heal" )
					end
				end
			)
			addEventHandler( "onDgsMouseClickUp", gButton["houseEat"],
				function ()
					if houseButtson[source] then
						if not eatSwitch then
							eatSwitch = true
							triggerServerEvent ( "houseClickServer", lp, lp, "eat" )
						end
					end
				end
			)
			addEventHandler( "onDgsMouseClickUp", gButton["houseGuns"],
				function ()
					if houseButtson[source] then
						dgsSetVisible ( gWindow["houseMenue"], false )
						_createGunboxMenue ()
					end
				end
			)
		end
	end
end
addEvent ( "showHouseGui", true )
addEventHandler ( "showHouseGui", getRootElement(), showHouseGui_func )