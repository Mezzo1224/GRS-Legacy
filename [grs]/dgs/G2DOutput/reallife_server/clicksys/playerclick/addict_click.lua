
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

addAddictPickup = createPickup ( -2651.09, 696.99, 27.58, 3, 1239, 0, 0 )

function showRemoveAddict ( player, matchdim )
	if player == getLocalPlayer() and matchdim then
		showCursor ( true )
		setElementClicked ( true )
		if gWindow["removeAddict"] then
			dgsSetVisible ( gWindow["removeAddict"], true )
		else
			gWindow["removeAddict"] = dgsCreateWindow(screenwidth/2-329/2,screenheight/2-155/2,329,155,"Krankenhaus",false)
			dgsWindowSetMovable ( gWindow["removeAddict"], false )
			dgsWindowSetSizable ( gWindow["removeAddict"], false )
			dgsSetAlpha(gWindow["removeAddict"],1)
			
			gLabel[1] = dgsCreateLabel(9,27,279,33,"Herzlich Willkommen!\nHier kannst du dir deine Sucht austreiben lassen!",false,gWindow["removeAddict"])
			dgsSetAlpha(gLabel[1],1)
			dgsLabelSetColor(gLabel[1],200,200,0)
			dgsLabelSetVerticalAlign(gLabel[1],"top")
			dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
			dgsSetFont(gLabel[1],"default-bold-small")
			gLabel[2] = dgsCreateLabel(109,77,119,16,"Kosten des Entzuges:",false,gWindow["removeAddict"])
			dgsSetAlpha(gLabel[2],1)
			dgsLabelSetColor(gLabel[2],0,200,0)
			dgsLabelSetVerticalAlign(gLabel[2],"top")
			dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
			dgsSetFont(gLabel[2],"default-bold-small")
			
			gButton["removeAddictClose"] = dgsCreateButton(304,25,16,19,"x",false,gWindow["removeAddict"])
			dgsSetAlpha(gButton["removeAddictClose"],1)
			dgsSetFont(gButton["removeAddictClose"],"default-bold-small")
			gButton["removeAddictBuy"] = dgsCreateButton(130,105,79,36,"- $",false,gWindow["removeAddict"])
			dgsSetAlpha(gButton["removeAddictBuy"],1)
			dgsSetFont(gButton["removeAddictBuy"],"default-bold-small")
			
			addEventHandler ( "onDgsMouseClickUp", gButton["removeAddictClose"],
				function ()
					showCursor ( false )
					setElementClicked ( false )
					dgsSetVisible ( gWindow["removeAddict"], false )
				end
			)
			
			addEventHandler ( "onDgsMouseClickUp", gButton["removeAddictBuy"],
				function ()
					if getTotalAddictLevel ( player ) > 0 then
						showCursor ( false )
						setElementClicked ( false )
						dgsSetVisible ( gWindow["removeAddict"], false )
						
						triggerServerEvent ( "removeAddicts", lp )
					end
				end
			)
		end
		dgsSetText ( gButton["removeAddictBuy"], ( getTotalAddictLevel ( player ) * addictRemoveCost ).." $" )
	end
end
addEventHandler ( "onClientPickupHit", addAddictPickup, showRemoveAddict )

function showAddictInfo_func ( short )

	if gWindow["suchtInfo"] then
		dgsSetVisible ( gWindow["suchtInfo"], true )
	else
		gWindow["suchtInfo"] = dgsCreateWindow(1,1,307,295,"Sucht",false)
		dgsSetAlpha ( gWindow["suchtInfo"], 1 )
		dgsWindowSetMovable ( gWindow["suchtInfo"], false )
		dgsWindowSetSizable ( gWindow["suchtInfo"], false )
	
		gLabel[1] = dgsCreateLabel(11,25,288,80,"Hier kannst du ablesen, wonach du suechtig bist\nbzw. wieviel du vom jeweiligen Wirkstoff intus hast.\n\nSinkt der Pegel eines Wirkstoffes nach dem du sue-\nchtig bist zu stark, treten Entzugserscheinungen\nein.",false,gWindow["suchtInfo"])
		dgsLabelSetColor(gLabel[1],255,255,255)
		dgsLabelSetVerticalAlign(gLabel[1],"top")
		dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
		dgsSetFont(gLabel[1],"default-bold-small")
		gLabel[2] = dgsCreateLabel(11,113,86,17,"Wirkstoffpegel",false,gWindow["suchtInfo"])
		dgsLabelSetColor(gLabel[2],0,200,0)
		dgsLabelSetVerticalAlign(gLabel[2],"top")
		dgsLabelSetHorizontalAlign(gLabel[2],"left",false)
		dgsSetFont(gLabel[2],"default-bold-small")
		gLabel[4] = dgsCreateLabel(181,111,63,15,"Suchtlevel",false,gWindow["suchtInfo"])
		dgsLabelSetColor(gLabel[4],200,0,0)
		dgsLabelSetVerticalAlign(gLabel[4],"top")
		dgsLabelSetHorizontalAlign(gLabel[4],"left",false)
		dgsSetFont(gLabel[4],"default-bold-small")
		gLabel[6] = dgsCreateLabel(13,237,287,46,"Wenn du eine Sucht loswerden willst,\nkannst du dich im Krankenhaus behandeln lassen,\noder du wartest, bis die Sucht nachlaesst.",false,gWindow["suchtInfo"])
		dgsLabelSetColor(gLabel[6],200,200,0)
		dgsLabelSetVerticalAlign(gLabel[6],"top")
		dgsLabelSetHorizontalAlign(gLabel[6],"left",false)
		dgsSetFont(gLabel[6],"default-bold-small")

		gProgress["cigFlush"] = dgsCreateProgressBar(13,137,77,20,false,gWindow["suchtInfo"])
		gLabel[3] = dgsCreateLabel(18,2,49,16,"Nikotin",false,gProgress["cigFlush"])
		dgsLabelSetColor(gLabel[3],0,0,200)
		dgsLabelSetVerticalAlign(gLabel[3],"top")
		dgsLabelSetHorizontalAlign(gLabel[3],"left",false)
		dgsSetFont(gLabel[3],"default-bold-small")
		gProgress["alcFlush"] = dgsCreateProgressBar(13,171,77,20,false,gWindow["suchtInfo"])
		gLabel[3] = dgsCreateLabel(18,2,49,16,"Ethanol",false,gProgress["alcFlush"])
		dgsLabelSetColor(gLabel[3],0,0,200)
		dgsLabelSetVerticalAlign(gLabel[3],"top")
		dgsLabelSetHorizontalAlign(gLabel[3],"left",false)
		dgsSetFont(gLabel[3],"default-bold-small")
		gProgress["drugFlush"] = dgsCreateProgressBar(13,209,77,20,false,gWindow["suchtInfo"])
		gLabel[3] = dgsCreateLabel(18,2,49,16,"THC",false,gProgress["drugFlush"])
		dgsLabelSetColor(gLabel[3],0,0,200)
		dgsLabelSetVerticalAlign(gLabel[3],"top")
		dgsLabelSetHorizontalAlign(gLabel[3],"left",false)
		dgsSetFont(gLabel[3],"default-bold-small")

		gLabel["cigarettLevel"] = dgsCreateLabel(169,137,138,16,"Zigarettensuechtig",false,gWindow["suchtInfo"])
		dgsLabelSetColor(gLabel["cigarettLevel"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["cigarettLevel"],"top")
		dgsLabelSetHorizontalAlign(gLabel["cigarettLevel"],"left",false)
		dgsSetFont(gLabel["cigarettLevel"],"default-bold-small")
		gLabel["alcLevel"] = dgsCreateLabel(169,171,138,16,"Zigarettensuechtig",false,gWindow["suchtInfo"])
		dgsLabelSetColor(gLabel["alcLevel"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["alcLevel"],"top")
		dgsLabelSetHorizontalAlign(gLabel["alcLevel"],"left",false)
		dgsSetFont(gLabel["alcLevel"],"default-bold-small")
		gLabel["drugLevel"] = dgsCreateLabel(169,209,138,16,"Zigarettensuechtig",false,gWindow["suchtInfo"])
		dgsLabelSetColor(gLabel["drugLevel"],255,255,255)
		dgsLabelSetVerticalAlign(gLabel["drugLevel"],"top")
		dgsLabelSetHorizontalAlign(gLabel["drugLevel"],"left",false)
		dgsSetFont(gLabel["drugLevel"],"default-bold-small")

		gImage[1] = dgsCreateImage(119,137,31,26,"images/addict/cig.bmp",false,gWindow["suchtInfo"])
		gImage[1] = dgsCreateImage(119,171,31,26,"images/addict/alc.bmp",false,gWindow["suchtInfo"])
		gImage[1] = dgsCreateImage(119,209,31,26,"images/addict/drug.bmp",false,gWindow["suchtInfo"])
	end
	if short then
		dgsSetPosition ( gWindow["suchtInfo"], 1, 1 - ( 25 + 80 + 1 ), false )
		dgsSetSize ( gWindow["suchtInfo"], 307, 235, false )
		setTimer ( dgsSetVisible, 5000, 1, gWindow["suchtInfo"], false )
	else
		dgsSetPosition ( gWindow["suchtInfo"], screenwidth / 2 - 307 / 2, 120, false )
		dgsSetSize ( gWindow["suchtInfo"], 307, 295, false )
	end
	updateAddictWindow ()
end
addEvent ( "showAddictInfo", true )
addEventHandler ( "showAddictInfo", getRootElement(), showAddictInfo_func )

function updateAddictWindow ()

	dgsSetText ( gLabel["cigarettLevel"], getCigarettAddictLevel ( lp ) )
	dgsSetText ( gLabel["alcLevel"], getAlcoholAddictLevel ( lp ) )
	dgsSetText ( gLabel["drugLevel"], getDrugAddictLevel ( lp ) )
	
	dgsProgressBarSetProgress ( gProgress["cigFlush"], getCigarettProgress () )
	dgsProgressBarSetProgress ( gProgress["alcFlush"], getAlcoholProgress () )
	dgsProgressBarSetProgress ( gProgress["drugFlush"], getDrugProgress () )
end

function getAlcoholProgress ()

	--local curAddict = vioGetElementData ( player, "alcoholFlushPoints" ) / addictLevelDivisors[2]
	local curFlush = vioClientGetElementData ( "alcoholAddictPoints" )
	--[[local lvl = ( curFlush / ( curAddict * 0.75 ) ) * 100
	if lvl > 100 then
		lvl = 100
	end]]
	local max = addictLevelDivisors[2] * 5 * 5
	local lvl = 100 - max / ( curFlush )
	if lvl > 100 then
		lvl = 100
	end
	return lvl
end

function getCigarettProgress ()

	local lvl = ( vioClientGetElementData ( "cigarettFlushPoints" ) ) * 10
	if lvl > 100 then
		lvl = 100
	end
	return lvl
end

function getDrugProgress ()

	local lvl = vioClientGetElementData ( "drugFlushPoints" ) * 5
	if lvl > 100 then
		lvl = 100
	end
	return lvl
end