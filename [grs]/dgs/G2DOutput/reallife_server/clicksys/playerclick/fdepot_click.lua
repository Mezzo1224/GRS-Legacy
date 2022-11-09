
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

function showFDepot_func ( fmoney, fmats, fdrugs )

	if gWindow["gangDepot"] then
		dgsSetVisible ( gWindow["gangDepot"], true )
	else
		gWindow["gangDepot"] = dgsCreateWindow(screenwidth/2-180/2, screenheight/2-131/2,180,131,"Gang Depot",false)
		dgsSetAlpha(gWindow["gangDepot"],1)

		gButton["DepotTake"] = dgsCreateButton(0.0556,0.65,0.3278,0.2748,"Nehmen",true,gWindow["gangDepot"])
		dgsSetAlpha(gButton["DepotTake"],1)
		gButton["DepotPut"] = dgsCreateButton(0.4222,0.65,0.3111,0.2672,"Einlagern",true,gWindow["gangDepot"])
		dgsSetAlpha(gButton["DepotPut"],1)
		gButton["closeGangDepot"] = dgsCreateButton(0.7778,0.65,0.1667,0.2672,"X",true,gWindow["gangDepot"])
		dgsSetAlpha(gButton["closeGangDepot"],1)
		
		addEventHandler("onDgsMouseClickUp", gButton["DepotPut"],
			function ()
				local money = dgsGetText ( gEdit["moneyDepot"] )
				local mats = dgsGetText ( gEdit["matsDepot"] )
				local drugs = dgsGetText ( gEdit["drugsDepot"] )
				triggerServerEvent ( "fDepotServer", getRootElement(), getLocalPlayer(), false, money, drugs, mats )
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["DepotTake"],
			function ()
				local money = dgsGetText ( gEdit["moneyDepot"] )
				local mats = dgsGetText ( gEdit["matsDepot"] )
				local drugs = dgsGetText ( gEdit["drugsDepot"] )
				triggerServerEvent ( "fDepotServer", getRootElement(), getLocalPlayer(), true, money, drugs, mats )
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["closeGangDepot"],
			function ()
				dgsSetVisible ( gWindow["gangDepot"], false )
				showCursor(false)
				triggerServerEvent ( "cancel_gui_server", getLocalPlayer() )
			end
		)

		gEdit["moneyDepot"] = dgsCreateEdit(0.05,0.4275,0.3278,0.1756,"0",true,gWindow["gangDepot"])
		dgsSetAlpha(gEdit["moneyDepot"],1)
		gEdit["matsDepot"] = dgsCreateEdit(0.4111,0.4275,0.2556,0.1756,"0",true,gWindow["gangDepot"])
		dgsSetAlpha(gEdit["matsDepot"],1)
		gEdit["drugsDepot"] = dgsCreateEdit(0.7,0.4275,0.25,0.1756,"0",true,gWindow["gangDepot"])
		dgsSetAlpha(gEdit["drugsDepot"],1)
		gLabel["moneyDepotInfo"] = dgsCreateLabel(0.0444,0.1832,0.2389,0.1145,"Geld:",true,gWindow["gangDepot"])
		dgsSetAlpha(gLabel["moneyDepotInfo"],1)
		dgsLabelSetColor(gLabel["moneyDepotInfo"],200,200,020)
		dgsLabelSetVerticalAlign(gLabel["moneyDepotInfo"],"top")
		dgsLabelSetHorizontalAlign(gLabel["moneyDepotInfo"],"left",false)
		dgsSetFont(gLabel["moneyDepotInfo"],"default-bold-small")
		gLabel["moneyMatsInfo"] = dgsCreateLabel(0.4278,0.1832,0.2389,0.1111,"Mats:",true,gWindow["gangDepot"])
		dgsSetAlpha(gLabel["moneyMatsInfo"],1)
		dgsLabelSetColor(gLabel["moneyMatsInfo"],200,200,020)
		dgsLabelSetVerticalAlign(gLabel["moneyMatsInfo"],"top")
		dgsLabelSetHorizontalAlign(gLabel["moneyMatsInfo"],"left",false)
		dgsSetFont(gLabel["moneyMatsInfo"],"default-bold-small")
		gLabel["moneyDrugsInfo"] = dgsCreateLabel(0.6944,0.1832,0.2389,0.1111,"Drogen:",true,gWindow["gangDepot"])
		dgsSetAlpha(gLabel["moneyDrugsInfo"],1)
		dgsLabelSetColor(gLabel["moneyDrugsInfo"],200,200,020)
		dgsLabelSetVerticalAlign(gLabel["moneyDrugsInfo"],"top")
		dgsLabelSetHorizontalAlign(gLabel["moneyDrugsInfo"],"left",false)
		dgsSetFont(gLabel["moneyDrugsInfo"],"default-bold-small")
		gLabel["moneyValue"] = dgsCreateLabel(0.0444,0.2977,0.3389,0.1069,"0 $",true,gWindow["gangDepot"])
		dgsSetAlpha(gLabel["moneyValue"],1)
		dgsLabelSetColor(gLabel["moneyValue"],000,120,20)
		dgsLabelSetVerticalAlign(gLabel["moneyValue"],"top")
		dgsLabelSetHorizontalAlign(gLabel["moneyValue"],"left",false)
		gLabel["matsValue"] = dgsCreateLabel(0.4278,0.2977,0.2722,0.1298,"0 St.",true,gWindow["gangDepot"])
		dgsSetAlpha(gLabel["matsValue"],1)
		dgsLabelSetColor(gLabel["matsValue"],125,020,020)
		dgsLabelSetVerticalAlign(gLabel["matsValue"],"top")
		dgsLabelSetHorizontalAlign(gLabel["matsValue"],"left",false)
		gLabel["drugsValue"] = dgsCreateLabel(0.6944,0.2977,0.2833,0.1145,"0 g",true,gWindow["gangDepot"])
		dgsSetAlpha(gLabel["drugsValue"],1)
		dgsLabelSetColor(gLabel["drugsValue"],030,030,120)
		dgsLabelSetVerticalAlign(gLabel["drugsValue"],"top")
		dgsLabelSetHorizontalAlign(gLabel["drugsValue"],"left",false)
	end
	setDepotEntrys ( fmoney, fmats, fdrugs )
end
addEvent ( "showFDepot", true )
addEventHandler ( "showFDepot", getRootElement(), showFDepot_func )

function setDepotEntrys ( fmoney, fmats, fdrugs )

	dgsSetText ( gLabel["moneyValue"], fmoney.." $" )
	dgsSetText ( gLabel["matsValue"], fmats.." St." )
	dgsSetText ( gLabel["drugsValue"], fdrugs.." g" )
	
	dgsSetText ( gEdit["moneyDepot"], "0" )
	dgsSetText ( gEdit["matsDepot"], "0" )
	dgsSetText ( gEdit["drugsDepot"], "0" )
end