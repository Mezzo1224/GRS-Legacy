
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

-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

createObject ( 1285, -2017.1163330078, 454.44692993164, 34.750946044922 )

function showNewspaper_func ( text )

	hideInventory()
	setElementClicked ( true )
	showCursor ( true )
	if gWindow["newspaper"] then
		dgsSetVisible ( gWindow["newspaper"], true )
	else
		gWindow["newspaper"] = dgsCreateWindow(screenwidth/2-313/2,screenheight/2-380/2,313,380,"Zeitung",false)
		dgsWindowSetMovable(gWindow["newspaper"],false)
		dgsWindowSetSizable(gWindow["newspaper"],false)
		
		gImage["newspaper"] = dgsCreateImage(18,23,281,73,"images/liberty_tree.png",false,gWindow["newspaper"])
		
		gMemo["newspaper"] = dgsCreateMemo(15,95,286,272,text,false,gWindow["newspaper"])
		dgsMemoSetReadOnly(gMemo["newspaper"],true)
		
		gButton["newspaperClose"] = dgsCreateButton(280,22,24,24,"X",false,gWindow["newspaper"])
		
		addEventHandler("onDgsMouseClickUp", gButton["newspaperClose"],
			function ()
				setElementClicked ( false )
				showCursor ( false )
				dgsSetVisible ( gWindow["newspaper"], false )
			end,
		false )
	end
	dgsSetText ( gMemo["newspaper"], text )
end
addEvent ( "showNewspaper", true )
addEventHandler ( "showNewspaper", getRootElement(), showNewspaper_func )

function showNewspaperReporter_func ( text )

	setElementClicked ( true )
	showCursor ( true )
	toggleControl ( "chatbox", false )
	if gWindow["newspaperEdit"] then
		dgsSetVisible ( gWindow["newspaperEdit"], true )
	else
		gWindow["newspaperEdit"] = dgsCreateWindow(screenwidth/2-313/2,screenheight/2-380/2,313,380,"Zeitung",false)
		dgsWindowSetMovable(gWindow["newspaperEdit"],false)
		dgsWindowSetSizable(gWindow["newspaperEdit"],false)
		
		gImage["newspaperEdit"] = dgsCreateImage(18,23,281,73,"images/liberty_tree.png",false,gWindow["newspaperEdit"])
		
		gMemo["newspaperEdit"] = dgsCreateMemo(15,95,286,272,text,false,gWindow["newspaperEdit"])
		
		gButton["newspaperCloseEdit"] = dgsCreateButton(200,22,100,24,"Speichern",false,gWindow["newspaperEdit"])
		
		addEventHandler("onDgsMouseClickUp", gButton["newspaperCloseEdit"],
			function ()
				setElementClicked ( false )
				showCursor ( false )
				dgsSetVisible ( gWindow["newspaperEdit"], false )
				triggerServerEvent ( "redoNewspaperServer", lp, dgsGetText ( gMemo["newspaperEdit"] ) )
				toggleControl ( "chatbox", true )
			end,
		false )
	end
	dgsSetText ( gMemo["newspaperEdit"], text )
end
addEvent ( "showNewspaperReporter", true )
addEventHandler ( "showNewspaperReporter", getRootElement(), showNewspaperReporter_func )