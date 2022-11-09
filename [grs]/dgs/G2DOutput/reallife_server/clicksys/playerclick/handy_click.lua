
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

function handyanrufen ()

	if gWindow["anrufen"] then
		dgsSetVisible ( gWindow["anrufen"], true )
		dgsSetVisible ( gWindow["handybg"], false )
		dgsSetVisible ( gWindow["sms"], false )
	else
		dgsSetVisible ( gWindow["sms"], false )
		dgsSetVisible ( gWindow["handybg"], false )

		gWindow["anrufen"] = dgsCreateWindow(screenwidth/2-156/2,120,156,66,"Anrufen",false)
		dgsSetAlpha(gWindow["anrufen"],1)
		dgsWindowSetMovable(gWindow["anrufen"],false)
		dgsWindowSetSizable(gWindow["anrufen"],false)
		gButton["callbtn"] = dgsCreateButton(0.5833,0.4091,0.359,0.4545,"Anrufen",true,gWindow["anrufen"])
		dgsSetAlpha(gButton["callbtn"],1)
		gEdit["callnr"] = dgsCreateEdit(0.0577,0.3788,0.4744,0.4545,"",true,gWindow["anrufen"])
		dgsSetAlpha(gEdit["callnr"],1)
		addEventHandler("onDgsMouseClickUp", gButton["callbtn"],
			function ()
				if dgsGetText ( gEdit["callnr"] ) ~= "" and tonumber ( dgsGetText ( gEdit["callnr"] ) ) then
					triggerServerEvent ( "callSomeone", getLocalPlayer(), getLocalPlayer(), dgsGetText ( gEdit["callnr"] ) )
					SelfCancelBtn ()
				end
			end
		)
	end
end

function handysmsschreiben ( number )

	if gWindow["sms"] then
		dgsSetVisible ( gWindow["anrufen"], false )
		dgsSetVisible ( gWindow["handybg"], false )
		dgsSetVisible ( gWindow["sms"], true )
	else
		dgsSetVisible ( gWindow["anrufen"], false )
		dgsSetVisible ( gWindow["handybg"], false )
		
		gWindow["sms"] = dgsCreateWindow(screenwidth/2-191/2,120,191,128,"SMS schreiben",false)
		dgsSetAlpha(gWindow["sms"],1)
		dgsWindowSetMovable(gWindow["sms"],false)
		dgsWindowSetSizable(gWindow["sms"],false)
		
		gEdit["smsnr"] = dgsCreateEdit(0.0419,0.3516,0.4136,0.2422,"",true,gWindow["sms"])
		dgsSetAlpha(gEdit["smsnr"],1)
		
		gLabel["nrtext"] = dgsCreateLabel(0.0419,0.1953,0.2932,0.1328,"Nummer:",true,gWindow["sms"])
		dgsSetAlpha(gLabel["nrtext"],1)
		dgsLabelSetColor(gLabel["nrtext"],200,200,0)
		dgsLabelSetVerticalAlign(gLabel["nrtext"],"top")
		dgsLabelSetHorizontalAlign(gLabel["nrtext"],"left",false)
		dgsSetFont(gLabel["nrtext"],"default-bold-small")
		gLabel["smstext"] = dgsCreateLabel(0.4817,0.2031,0.1885,0.1328,"Text:",true,gWindow["sms"])
		dgsSetAlpha(gLabel["smstext"],1)
		dgsLabelSetColor(gLabel["smstext"],200,200,0)
		dgsLabelSetVerticalAlign(gLabel["smstext"],"top")
		dgsLabelSetHorizontalAlign(gLabel["smstext"],"left",false)
		dgsSetFont(gLabel["smstext"],"default-bold-small")
		
		gMemo["smstext"] = dgsCreateMemo(0.4817,0.3359,0.4555,0.5625,"",true,gWindow["sms"])
		dgsSetAlpha(gMemo["smstext"],1)
		
		gButton["sendsms"] = dgsCreateButton(0.0471,0.625,0.4084,0.2734,"Senden",true,gWindow["sms"])
		dgsSetAlpha(gButton["sendsms"],1)
		
		addEventHandler("onDgsMouseClickUp", gButton["sendsms"],
			function ()
				if dgsGetText ( gEdit["smsnr"] ) ~= "" and tonumber ( dgsGetText ( gEdit["smsnr"] ) ) then
					if dgsGetText ( gMemo["smstext"] ) ~= "" then
						local sendnr = tonumber ( dgsGetText ( gEdit["smsnr"] ) )
						local sendtext = dgsGetText ( gMemo["smstext"] )
						triggerServerEvent ( "SMS", getLocalPlayer(), getLocalPlayer(), sendnr, sendtext )
					end
				end
			end
		)
	end
	dgsSetText ( gEdit["smsnr"], number )
end

function showHandy ()

	dgsSetInputEnabled ( false )
	if gWindow["handybg"] then
		dgsSetVisible ( gWindow["handybg"], true )
	else
		gWindow["handybg"] = dgsCreateWindow(screenwidth/2-125/2,120,125,184,"Handy",false)
		
		dgsSetAlpha(gWindow["handybg"],1)
		gLabel["eignummer"] = dgsCreateLabel(0.096,0.1413,0.752,0.1739,"Eigene Nummer:\n"..getElementData(getLocalPlayer(),"telenr"),true,gWindow["handybg"])
		dgsSetAlpha(gLabel["eignummer"],1)
		dgsLabelSetColor(gLabel["eignummer"],200,200,0)
		dgsLabelSetVerticalAlign(gLabel["eignummer"],"top")
		dgsLabelSetHorizontalAlign(gLabel["eignummer"],"left",false)
		dgsSetFont(gLabel["eignummer"],"default-bold-small")
		
		gButton["callfunc"] = dgsCreateButton(0.544,0.3207,0.384,0.1467,"Anrufen",true,gWindow["handybg"])
		dgsSetAlpha(gButton["callfunc"],1)
		gButton["smsfunc"] = dgsCreateButton(0.096,0.3207,0.384,0.1467,"SMS",true,gWindow["handybg"])
		dgsSetAlpha(gButton["smsfunc"],1)
		gButton["servicefunc"] = dgsCreateButton(0.544,0.5326,0.36,0.1467,"Service",true,gWindow["handybg"])
		dgsSetAlpha(gButton["servicefunc"],1)
		gButton["handyonoff"] = dgsCreateButton(0.096,0.7337,0.448,0.1739,"Ein/Aus-\nschalten",true,gWindow["handybg"])
		dgsSetAlpha(gButton["handyonoff"],1)
		gButton["telefonbuch"] = dgsCreateButton(0.096,0.5109,0.424,0.1848,"Telefon-\nbuch",true,gWindow["handybg"])
		dgsSetAlpha(gButton["telefonbuch"],1)
		
		dgsWindowSetMovable(gWindow["handybg"],false)
		dgsWindowSetSizable(gWindow["handybg"],false)
		
		addEventHandler("onDgsMouseClickUp", gButton["telefonbuch"],
			function ()
				outputChatBox ( "Bitte /number [Name] benutzen!", 200, 200, 0 )
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["handyonoff"],
			function ()
				triggerServerEvent ( "handychange", getLocalPlayer(), getLocalPlayer() )
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["smsfunc"],
			function ()
				handysmsschreiben ("")
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["callfunc"],
			function ()
				handyanrufen ()
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["servicefunc"],
			function ()
				outputChatBox ( "Notfall: 110, Sanitäter: 112, Taxi: 400, Mechaniker: 300, Guthaben: *100#", 200, 200, 0 )
			end
		)
		
		dgsWindowSetMovable ( gWindow["handybg"], false )
		dgsWindowSetSizable ( gWindow["handybg"], false )
	end
end
addCommandHandler ( "handy", showHandy )