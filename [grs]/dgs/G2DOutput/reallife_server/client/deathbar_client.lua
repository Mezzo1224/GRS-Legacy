
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

function showProgressBar_func ( time )

	if gWindow["reviveProgress"] then
		dgsSetVisible ( gWindow["reviveProgress"], true )
	else
		gWindow["reviveProgress"] = dgsCreateWindow(screenwidth/2-264/2,screenheight/2-344/2,264,344,"Krankenhaus",false)
		dgsSetAlpha(gWindow["reviveProgress"],1)
		gImage["death"] = dgsCreateImage(0.0758,0.0698,0.803,0.5349,"images/medic.jpg",true,gWindow["reviveProgress"])
		dgsSetAlpha(gImage["death"],1)
		gLabel["deathbarText1"] = dgsCreateLabel(0.0341,0.6076,0.9356,0.1366,"\nDu bist gestorben und wirst nun\nim Krankenhaus wieder zusammengeflickt.",true,gWindow["reviveProgress"])
		dgsSetAlpha(gLabel["deathbarText1"],1)
		dgsLabelSetColor(gLabel["deathbarText1"],200,200,000)
		dgsLabelSetVerticalAlign(gLabel["deathbarText1"],"top")
		dgsLabelSetHorizontalAlign(gLabel["deathbarText1"],"left",false)
		dgsSetFont(gLabel["deathbarText1"],"default-bold-small")
		gProgress["progressDeathtime"] = dgsCreateProgressBar(0.1705,0.8285,0.6667,0.1366,true,gWindow["reviveProgress"])
		dgsSetAlpha(gProgress["progressDeathtime"],1)
		dgsProgressBarSetProgress(gProgress["progressDeathtime"],0)
		gLabel["deathbarText2"] = dgsCreateLabel(0.2727,0.7733,0.5152,0.0523,"Behandlungsfortschritt:",true,gWindow["reviveProgress"])
		dgsSetAlpha(gLabel["deathbarText2"],1)
		dgsLabelSetColor(gLabel["deathbarText2"],125,125,200)
		dgsLabelSetVerticalAlign(gLabel["deathbarText2"],"top")
		dgsLabelSetHorizontalAlign(gLabel["deathbarText2"],"left",false)
		dgsSetFont(gLabel["deathbarText2"],"default-bold-small")
	end
	--setTimer ( updateDeathBar_func, time*10, 100 )
	--setTimer ( hideUpdateBar, time*1000, 1 )
end
addEvent ( "showProgressBar", true )
addEventHandler ( "showProgressBar", getRootElement(), showProgressBar_func )

function updateDeathBar_func ( new )

	local newBarSize = new
	dgsProgressBarSetProgress(gProgress["progressDeathtime"],newBarSize)
	if newBarSize >= 100 then
		hideUpdateBar ()
	end
end
addEvent ( "updateDeathBar", true )
addEventHandler ( "updateDeathBar", getRootElement(), updateDeathBar_func )

function hideUpdateBar ()

	dgsSetVisible ( gWindow["reviveProgress"], false )
end
addEvent ( "hideDeathBar", true )
addEventHandler ( "hideDeathBar", getRootElement(), hideUpdateBar )


addEventHandler ( "onClientPlayerWasted", localPlayer, function ( killer, weapon, bodypart )
	triggerServerEvent ( "onPlayerWastedTriggered", lp, killer, weapon, bodypart )
end )