
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

gButton = {}

function fillSkinlist ()

	dgsGridListClear ( SkinauswahlGrid )
	for i = 1, 288 do
		if skinname[i] ~= false and skinname[i] ~= nil then
			if skinsex[i] == sex then
				if price == "cheap" then 
					if tonumber(skinpreis[i]) < 300 then
						local row = dgsGridListAddRow ( SkinauswahlGrid )
						dgsGridListSetItemText ( SkinauswahlGrid, row, skinnameColumn, tostring ( skinname[i] ), false, false )
						dgsGridListSetItemText ( SkinauswahlGrid, row, skinpreisColumn, tostring ( skinpreis[i].." $" ), true, false )
					end
				elseif tonumber(skinpreis[i]) >= 300 then
					local row = dgsGridListAddRow ( SkinauswahlGrid )
					dgsGridListSetItemText ( SkinauswahlGrid, row, skinnameColumn, tostring ( skinname[i] ), false, false )
					dgsGridListSetItemText ( SkinauswahlGrid, row, skinpreisColumn, tostring ( skinpreis[i].." $" ), true, false )
				end
			end
		end
	end
end

function skinshow ()

	if SkinauswahlWindow and dgsGetVisible ( SkinauswahlWindow ) == true then
		local rowindex, columnindex = dgsGridListGetSelectedItem ( SkinauswahlGrid )
		local selectedText = dgsGridListGetItemText ( SkinauswahlGrid, rowindex, skinnameColumn )
		local selectedPrice = dgsGridListGetItemText ( SkinauswahlGrid, rowindex, skinpreisColumn )
		if selectedText == false or selectedPrice == false then
		else
			for i = 1, 288 do
				if skinname[i] == selectedText then
					if tostring ( skinpreis[i].." $" ) == selectedPrice then
						setElementModel ( lp, i )
						curskinPrice = skinpreis[i]
						curskinID = i
					end
				end
			end
		end
	end
end
addEventHandler ( "onDgsMouseClickUp", getRootElement(), skinshow )

function sucessfullBuyed_func ()

	dgsSetVisible ( SkinauswahlWindow, false )
	showCursor(false)
	triggerServerEvent ( "cancel_gui_server", lp )
	setElementModel ( lp, vioClientGetElementData ( "skinid" ) )
	setElementPosition ( lp, 161.66276550293, -93.030876159668, 1001.453918457 )
	setCameraTarget ( lp )
end
addEvent ( "sucessfullBuyed", true )
addEventHandler ( "sucessfullBuyed", getRootElement(), sucessfullBuyed_func )

function _createSkinauswahlGui_func ()

	setPedRotation ( lp, 90 )
	if SkinauswahlWindow then
		dgsSetVisible ( SkinauswahlWindow, true )
	else
		sex = "male"
		price = "cheap"
		
		local screenwidth, screenheight = dgsGetScreenSize ()
		
		SkinauswahlWindow = dgsCreateWindow(0,screenheight-440,384,440,"Skinauswahl",false)
		dgsSetAlpha(SkinauswahlWindow,1)
		
		SkinauswahlGrid = dgsCreateGridList(0.0339,0.0727,0.625,0.8909,true,SkinauswahlWindow)
		dgsGridListSetSelectionMode(SkinauswahlGrid,2)
		skinnameColumn = dgsGridListAddColumn(SkinauswahlGrid,"Skin",0.6)
		skinpreisColumn = dgsGridListAddColumn(SkinauswahlGrid,"Preis",0.2)
		dgsSetAlpha(SkinauswahlGrid,1)
		
		gButton["clothesKaufen"] = dgsCreateButton(0.7,0.7091,0.2656,0.0977,"Kaufen",true,SkinauswahlWindow)
		dgsSetAlpha(gButton["clothesKaufen"],1)
		gButton["clothesCancel"] = dgsCreateButton(0.7,0.8591,0.2656,0.0977,"Abbrechen",true,SkinauswahlWindow)
		dgsSetAlpha(gButton["clothesCancel"],1)
		gButton["clothesFrauenskins"] = dgsCreateButton(0.7,0.2023,0.2682,0.0977,"Frauenskins",true,SkinauswahlWindow)
		dgsSetAlpha(gButton["clothesFrauenskins"],1)
		gButton["clothesMaennerskins"] = dgsCreateButton(0.7,0.075,0.2578,0.0977,"Maennerskins",true,SkinauswahlWindow)
		dgsSetAlpha(gButton["clothesMaennerskins"],1)
		gButton["clothesTeuer"] = dgsCreateButton(0.7,0.4545,0.2682,0.0977,"Teuer",true,SkinauswahlWindow)
		dgsSetAlpha(gButton["clothesTeuer"],1)
		gButton["clothesGuenstig"] = dgsCreateButton(0.7,0.3295,0.2682,0.0977,"Guenstig",true,SkinauswahlWindow)
		dgsSetAlpha(gButton["clothesGuenstig"],1)
		
		addEventHandler("onDgsMouseClickUp", gButton["clothesCancel"], 
			function ()
				dgsSetVisible ( SkinauswahlWindow, false )
				showCursor(false)
				triggerServerEvent ( "cancel_gui_server", lp )
				triggerServerEvent ( "clothesCancel", lp )
				setElementModel ( lp, vioClientGetElementData ( "skinid" ) )
				setElementPosition ( lp, 161.66276550293, -93.030876159668, 1001.453918457 )
				setCameraTarget ( lp )
			end
		)
		
		addEventHandler("onDgsMouseClickUp", gButton["clothesKaufen"],
			function ()
				triggerServerEvent ( "clothesBuyServer", lp, lp, curskinID, curskinPrice )
			end
		)
		
		addEventHandler("onDgsMouseClickUp", gButton["clothesFrauenskins"],
			function ()
				sex = "female"
				fillSkinlist ()
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["clothesMaennerskins"],
			function ()
				sex = "male"
				fillSkinlist ()
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["clothesTeuer"],
			function ()
				price = "expensive"
				fillSkinlist ()
			end
		)
		addEventHandler("onDgsMouseClickUp", gButton["clothesGuenstig"],
			function ()
				price = "cheap"
				fillSkinlist ()
			end
		)
		
		fillSkinlist ()
	end
end
addEvent ( "_createSkinauswahlGui", true )
addEventHandler ( "_createSkinauswahlGui", lp, _createSkinauswahlGui_func )