
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

function showCashPoint_func ()

	if gWindow["cashPoint"] then
		dgsSetVisible ( gWindow["cashPoint"], true )
		dgsSetInputMode ( "no_binds_when_editing")
	else
		dgsSetInputMode ( "no_binds_when_editing")
		--gWindow["cashPoint"] = guiCreateWindow(screenwidth/2-352/2,screenheight/2-367/2,352,367,"Geldautomat",false)
		gWindow["cashPoint"] = dgsCreateImage(screenwidth/2-352/2,screenheight/2-500/2,357,450,"images/gui/geldautomat.png",false)
		dgsSetAlpha ( gWindow["cashPoint"], 1 )
		
		gButton["cashPointClose"] = dgsCreateButton(0.345,0.83,0.26,0.106,"Schließen",true,gWindow["cashPoint"])
		dgsSetFont(gButton["cashPointClose"],"default-bold-small")
		addEventHandler ( "onDgsMouseClickUp", gButton["cashPointClose"],
			function ()
				dgsSetVisible ( gWindow["cashPoint"], false )
				setElementClicked ( false )
				showCursor ( false )
				dgsSetInputMode ( "allow_binds")
			end,
		false )

		gTabPanel["cashPoint"] = dgsCreateTabPanel(0.022,0.15,0.943,0.65,true,gWindow["cashPoint"])

			gTab["cashPointPayOut"] = dgsCreateTab("Ein/Auszahlen",gTabPanel["cashPoint"])
				gButton["cashPointPayOut"] = dgsCreateButton(41,173,94,45,"Auszahlen",false,gTab["cashPointPayOut"])
				gButton["cashPointPayIn"] = dgsCreateButton(191,171,94,45,"Einzahlen",false,gTab["cashPointPayOut"])
				gEdit["cashPointPayAmount"] = dgsCreateEdit(102,88,130,33,"0",false,gTab["cashPointPayOut"])
				gLabel[1] = dgsCreateLabel(143,71,45,19,"Betrag",false,gTab["cashPointPayOut"])
				dgsLabelSetColor(gLabel[1],255,255,255)
				dgsLabelSetVerticalAlign(gLabel[1],"top")
				dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
				dgsSetFont(gLabel[1],"default-bold-small")
				gLabel[2] = dgsCreateLabel(236,97,14,23,"$",false,gTab["cashPointPayOut"])
				dgsLabelSetColor(gLabel[2],0,125,0)
				dgsLabelSetVerticalAlign(gLabel[2],"top")
				dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
				dgsSetFont(gLabel[2],"default-bold-small")

				addEventHandler ( "onDgsMouseClickUp", gButton["cashPointPayIn"],
					function ()
						local amount = tonumber ( dgsGetText ( gEdit["cashPointPayAmount"] ) )
						triggerServerEvent ( "cashPointPayIn", lp, amount )
						setTimer ( refreshStatementLabels, 2000, 1 )
					end,
				false )
				addEventHandler ( "onDgsMouseClickUp", gButton["cashPointPayOut"],
					function ()
						local amount = tonumber ( dgsGetText ( gEdit["cashPointPayAmount"] ) )
						triggerServerEvent ( "cashPointPayOut", lp, amount )
						setTimer ( refreshStatementLabels, 2000, 1 )
					end,
				false )

			gTab["cashPointTransfer"] = dgsCreateTab("Ueberweisung",gTabPanel["cashPoint"])
				gImage["cashPointTransferBG"] = dgsCreateImage(4,10,325,211,"images/colors/c_white.jpg",false,gTab["cashPointTransfer"])
				gImage["cashPointTransferBGHead"] = dgsCreateImage(0,0,325,19,"images/colors/c_red.jpg",false,gImage["cashPointTransferBG"])
				gLabel[3] = dgsCreateLabel(102,1,127,14,"Ueberweisungsformular",false,gImage["cashPointTransferBGHead"])
				dgsLabelSetColor(gLabel[3],255,255,255)
				dgsLabelSetVerticalAlign(gLabel[3],"top")
				dgsLabelSetHorizontalAlign(gLabel[3],"left",false)
				dgsCreateImage(0,192,325,19,"images/colors/c_red.jpg",false,gImage["cashPointTransferBG"])
				gLabel[4] = dgsCreateLabel(2,32,150,20,"Name des Beguenstigten",false,gImage["cashPointTransferBG"])
				dgsLabelSetColor(gLabel[4],0,0,0)
				dgsLabelSetVerticalAlign(gLabel[4],"top")
				dgsLabelSetHorizontalAlign(gLabel[4],"left",false)
				gLabel[5] = dgsCreateLabel(2,81,148,34,"Summe, die Überwiesen\nwerden soll",false,gImage["cashPointTransferBG"])
				dgsLabelSetColor(gLabel[5],0,0,0)
				dgsLabelSetVerticalAlign(gLabel[5],"top")
				dgsLabelSetHorizontalAlign(gLabel[5],"left",false)
				gLabel[6] = dgsCreateLabel(306,91,12,22,"$",false,gImage["cashPointTransferBG"])
				dgsLabelSetColor(gLabel[6],0,200,0)
				dgsLabelSetVerticalAlign(gLabel[6],"top")
				dgsLabelSetHorizontalAlign(gLabel[6],"left",false)
				gLabel[7] = dgsCreateLabel(1,144,124,39,"Verwendungszweck \n/ Betreff",false,gImage["cashPointTransferBG"])
				dgsLabelSetColor(gLabel[7],0,0,0)
				dgsLabelSetVerticalAlign(gLabel[7],"top")
				dgsLabelSetHorizontalAlign(gLabel[7],"left",false)
				gEdit["cashPointTransferTo"] = dgsCreateEdit(165,23,153,35,"Name",false,gImage["cashPointTransferBG"])
				gEdit["cashPointTransferAmount"] = dgsCreateEdit(165,83,135,35,"0",false,gImage["cashPointTransferBG"])
				gMemo["cashPointTransferReason"] = dgsCreateMemo(146,124,174,62,"Grund",false,gImage["cashPointTransferBG"])
				gButton["cashPointTransferSend"] = dgsCreateButton(129,224,66,35,"Senden",false,gTab["cashPointTransfer"])
				dgsSetFont(gButton["cashPointTransferSend"],"default-bold-small")
				addEventHandler ( "onDgsMouseClickUp", gButton["cashPointTransferSend"],
					function ()
						local amount = tonumber ( dgsGetText ( gEdit["cashPointTransferAmount"] ) )
						local target = dgsGetText ( gEdit["cashPointTransferTo"] )
						local reason = dgsGetText ( gMemo["cashPointTransferReason"] )
						triggerServerEvent ( "cashPointTransfer", lp, amount, target, false, reason )
						setTimer ( refreshStatementLabels, 2000, 1 )
					end,
				false )

			gTab["cashPointPrint"] = dgsCreateTab("Kontoauszug",gTabPanel["cashPoint"])
				gImage["cashPointPrintBG"] = dgsCreateImage(4,5,325,220,"images/colors/c_white.jpg",false,gTab["cashPointPrint"])
				gImage["cashPointPrintBGHead"] = dgsCreateImage(0,1,325,19,"images/colors/c_red.jpg",false,gImage["cashPointPrintBG"])
				gLabel[8] = dgsCreateLabel(125,0,75,17,"Kontoauszug",false,gImage["cashPointPrintBGHead"])
				dgsLabelSetColor(gLabel[8],255,255,255)
				dgsLabelSetVerticalAlign(gLabel[8],"top")
				dgsLabelSetHorizontalAlign(gLabel[8],"left",false)
				dgsSetFont(gLabel[8],"default-bold-small")
				gImage["cashPointPrintBGBottom"] = dgsCreateImage(0,200,325,19,"images/colors/c_red.jpg",false,gImage["cashPointPrintBG"])
				dgsCreateImage(101,170,210,2,"images/colors/c_black.jpg",false,gImage["cashPointPrintBG"])
				gLabel[12] = dgsCreateLabel(17,177,69,17,"Total",false,gImage["cashPointPrintBG"])
				dgsLabelSetColor(gLabel[12],200,0,0)
				dgsLabelSetVerticalAlign(gLabel[12],"top")
				dgsLabelSetHorizontalAlign(gLabel[12],"left",false)
				gLabel[15] = dgsCreateLabel(16,30,73,19,"Grund",false,gImage["cashPointPrintBG"])
				dgsLabelSetColor(gLabel[15],0,187,0)
				dgsLabelSetVerticalAlign(gLabel[15],"top")
				dgsLabelSetHorizontalAlign(gLabel[15],"left",false)
				gLabel[16] = dgsCreateLabel(130,30,73,19,"Betrag",false,gImage["cashPointPrintBG"])
				dgsLabelSetColor(gLabel[16],0,187,0)
				dgsLabelSetVerticalAlign(gLabel[16],"top")
				dgsLabelSetHorizontalAlign(gLabel[16],"left",false)
				gLabel[17] = dgsCreateLabel(235,30,73,19,"Sonstiges",false,gImage["cashPointPrintBG"])
				dgsLabelSetColor(gLabel[17],0,187,0)
				dgsLabelSetVerticalAlign(gLabel[17],"top")
				dgsLabelSetHorizontalAlign(gLabel[17],"left",false)
				gLabel[9] = dgsCreateLabel(274,2,48,12,getDateAsOneString(),false,gImage["cashPointPrintBGHead"])
				dgsLabelSetColor(gLabel[9],255,255,255)
				dgsLabelSetVerticalAlign(gLabel[9],"top")
				dgsLabelSetHorizontalAlign(gLabel[9],"left",false)
				dgsSetFont(gLabel[9],"default-small")
				
				gLabel["cashPointWhy"] = dgsCreateLabel(17,50,85,121,"Barauszahlung\n\n\nLas Venturas\nCasino\n\nEinzahlung\nLos Santos",false,gImage["cashPointPrintBG"])
				dgsLabelSetColor(gLabel["cashPointWhy"],0,0,0)
				dgsLabelSetVerticalAlign(gLabel["cashPointWhy"],"top")
				dgsLabelSetHorizontalAlign(gLabel["cashPointWhy"],"left",false)
				gLabel["cashPointAmount"] = dgsCreateLabel(114,62,86,118,"-400 $\n\n\n-200 $\n\n\n+ 25 $",false,gImage["cashPointPrintBG"])
				dgsLabelSetColor(gLabel["cashPointAmount"],0,0,0)
				dgsLabelSetVerticalAlign(gLabel["cashPointAmount"],"top")
				dgsLabelSetHorizontalAlign(gLabel["cashPointAmount"],"right",false)
				gLabel["cashPointWhere"] = dgsCreateLabel(212,50,107,107,"SF Bahnhof\n\n\nFour Dragons\n\n\nMarket Station",false,gImage["cashPointPrintBG"])
				dgsLabelSetColor(gLabel["cashPointWhere"],0,0,0)
				dgsLabelSetVerticalAlign(gLabel["cashPointWhere"],"top")
				dgsLabelSetHorizontalAlign(gLabel["cashPointWhere"],"right",false)
				
				gLabel["cashPointTotal"] = dgsCreateLabel(99,176,101,16,"+ "..vioClientGetElementData ( "bankmoney" ).." $",false,gImage["cashPointPrintBG"])
				dgsLabelSetColor(gLabel["cashPointTotal"],0,0,0)
				dgsLabelSetVerticalAlign(gLabel["cashPointTotal"],"top")
				dgsLabelSetHorizontalAlign(gLabel["cashPointTotal"],"right",false)
				--gButton["cashPointPrintPageUp"] = guiCreateButton(198,231,21,21,">",false,gTab["cashPointPrint"])
				--gButton["cashPointPrintPageDown"] = guiCreateButton(104,231,21,21,"<",false,gTab["cashPointPrint"])
	end
	refreshStatementLabels ( )
end
addEvent ( "showCashPoint", true )
addEventHandler ( "showCashPoint", getRootElement(), showCashPoint_func )

function showPaydayUI ()
 

	local window =DGS:dgsCreateWindow ( 0.43, 0.33, 0.13, 0.34, "Zahltag-Übersicht", true )
	local paydayList = DGS:dgsCreateGridList(0.04, 0.03, 0.92, 0.73, true, window)
	DGS:dgsSetProperty(paydayList,"rowHeight",25)
	local paydayListID = DGS:dgsGridListAddColumn( paydayList, "ID", 0.1 )
	local paydayListIncome = DGS:dgsGridListAddColumn( paydayList, "Einkommen", 0.3 )
	local paydayListDate = DGS:dgsGridListAddColumn( paydayList, "Datum", 0.6 )
	local showIncome =  DGS:dgsCreateButton(0.24, 0.75, 0.52, 0.12, "Anzeigen", true, window)
	DGS:dgsCenterElement(window)

	for var, payday in ipairs(paydayData) do 
		local row = DGS:dgsGridListAddRow (paydayList )
		DGS:dgsGridListSetItemText (  paydayList , row, paydayListID, paydayData[var]["id"], false)
		DGS:dgsGridListSetItemText (  paydayList , row, paydayListIncome, paydayData[var]["income"].."$", false)
		DGS:dgsGridListSetItemText (  paydayList , row, paydayListDate, getData(paydayData[var]["date"]), false)
		DGS:dgsGridListSetItemData ( paydayList , row, paydayListID, paydayData[var]["id"] )
	end
	addEventHandler ( "onDgsWindowClose",window, function()
		if source == window then
			setElementClicked ( false )
			showCursor ( false )
			dgsSetInputMode ( "allow_binds")
		end
	end)

	addEventHandler ( "onDgsMouseClickDown", showIncome, function()
		if source == showIncome then
			local row, column = DGS:dgsGridListGetSelectedItem ( paydayList )
			local id = DGS:dgsGridListGetItemData( paydayList, row, column )
			showPaydayData (id)

		end
	end)
end
addEvent ( "showPaydayUI", true )
addEventHandler ( "showPaydayUI", getRootElement(), showPaydayUI )

function showPaydayData (id)
	print(id)
	paydayDataWindow  = DGS:dgsCreateWindow ( 0.57, 0.33, 0.15, 0.34, "Zahltag vom "..getData(paydayData[id]["date"]), true )
	DGS:dgsCreateMemo(0.04, 0.03, 0.93, 0.91, "\n"..paydayData[id]["text"],true,paydayDataWindow )   
end

paydayData = {}
local id = 0
function loadPaydaylistClient (text, income, date)
	id = id + 1
	paydayData[id] = {}
	paydayData[id]["id"] = id
	paydayData[id]["text"] = text
	paydayData[id]["income"] = income
	paydayData[id]["date"] = date

end
addEvent( "loadPaydaylistClient", true )
addEventHandler( "loadPaydaylistClient", getRootElement(), loadPaydaylistClient )

function refreshStatementLabels ( )

	local money = vioClientGetElementData ( "bankmoney" )
	if money > 0 then
		money = "+ "..money.." $"
	elseif money < 0 then
		money = "- "..math.abs ( money ).." $"
	else
		money = "+- 0 $"
	end
	dgsSetText ( gLabel["cashPointTotal"], money )
	local c1, c2, c3 = getStatementEntry ( number )
	dgsSetText ( gLabel["cashPointWhy"], c1 )
	dgsSetText ( gLabel["cashPointAmount"], c2 )
	dgsSetText ( gLabel["cashPointWhere"], c3 )
end

function getDateAsOneString ()

	local time = getRealTime()
	local day = time.monthday
	local month = time.month + 1
	local year = time.year + 1900
	return day.."."..month.."."..year
end