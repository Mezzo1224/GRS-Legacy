local helpmenuUI = {}

-- // In Settings rüber machen
helpmenuLinks = {
    ["trello"] = "https://trello.com/b/enlrE9qG",
    ["forum"] = "https://www.mta-sa.org",
    ["rules"] = "https://www.mta-sa.org/cms/sc-terms-of-use/"
}
helpmenuRequestLinks = {
    ["trello"] = "www.trello.com",
    ["forum"] = "www.mta-sa.org"
}

requestBrowserDomains(helpmenuRequestLinks)

function createHelpmenu ()
    createHelpmenuUI ()
end
addEvent ( "createHelpmenu", true)
addEventHandler ( "createHelpmenu", getRootElement(), createHelpmenu)

function createHelpmenuUI ()

    helpmenuUI["window_main"] = DGS:dgsCreateWindow(0.34, -0.2, 0.41, 0.59, "Hilfemenü", true)
    DGS:dgsMoveTo( helpmenuUI["window_main"],0.34, 0.26,true,"OutQuad",2000)
    DGS:dgsWindowSetMovable ( helpmenuUI["window_main"], false )
    DGS:dgsWindowSetSizable ( helpmenuUI["window_main"], false )
    DGS:dgsWindowSetCloseButtonEnabled(helpmenuUI["window_main"], true)
    showCursor(true)
    helpmenuUI["tabpanel"] = DGS:dgsCreateTabPanel (0.02, 0.02, 0.96, 0.92,true, helpmenuUI["window_main"])
    DGS:dgsSetProperty( helpmenuUI["tabpanel"],"tabGapSize",{0.03,true})
    DGS:dgsSetProperty( helpmenuUI["tabpanel"],"tabAlignment","center")
    helpmenuUI["tabpanel_helpmenu"] = DGS:dgsCreateTab("Hilfemenü", helpmenuUI["tabpanel"])

    helpmenuUI["tabpanel_helpmenu_helps"] = DGS:dgsCreateGridList(0.01, 0.02, 0.25, 0.95, true, helpmenuUI["tabpanel_helpmenu"])
    DGS:dgsSetProperty(helpmenuUI["tabpanel_helpmenu_helps"],"rowHeight",30)
    DGS:dgsSetProperty(helpmenuUI["tabpanel_helpmenu_helps"],"rowColor",{tocolor(13, 90, 110, 255),tocolor(16, 109, 133, 255),tocolor(10, 67, 82, 255)})
    helpmenuUI["tabpanel_helpmenu_helps_name"] =  DGS:dgsGridListAddColumn(  helpmenuUI["tabpanel_helpmenu_helps"], "Name", 1)

    helpmenuUI["tabpanel_helpmenu_helptitle"] = DGS:dgsCreateLabel(0.28, 0.02, 0.25, 0.04, "TITEL", true, helpmenuUI["tabpanel_helpmenu"])
    helpmenuUI["tabpanel_helpmenu_helptext"] = DGS:dgsCreateLabel(0.28, 0.07, 0.44, 0.93, "TEXT", true,  helpmenuUI["tabpanel_helpmenu"])
    -- // Subcategory
   -- createSubcategoryElements ()
    addHelpToList ()
    if getElementData ( lp, "fraktion" ) > 0 then
        helpmenuUI["tabpanel_faction"] = DGS:dgsCreateTab("Deine Fraktion", helpmenuUI["tabpanel"])
        if  factionText[ getElementData ( lp, "fraktion" )] then factionHelpText =  factionText[ getElementData ( lp, "fraktion" )] else factionHelpText = "Keine Hilfe vorhanden." end
        helpmenuUI["tabpanel_faction_memo"] = DGS:dgsCreateMemo(0.02, 0.02, 0.96, 0.95, factionHelpText.."\n\n"..basicFactionInfo, true, helpmenuUI["tabpanel_faction"])
        DGS:dgsMemoSetReadOnly(helpmenuUI["tabpanel_faction_memo"], true)
    end
    local job = vioClientGetElementData ( "job" )
    if job ~= "none" then
        helpmenuUI["tabpanel_job"] = DGS:dgsCreateTab("Deine Job", helpmenuUI["tabpanel"])
        helpmenuUI["tabpanel_job_memo"] = DGS:dgsCreateMemo(0.02, 0.02, 0.96, 0.95, jobText[job], true, helpmenuUI["tabpanel_job"])
        DGS:dgsMemoSetReadOnly(helpmenuUI["tabpanel_job_memo"], true)
    end
    helpmenuUI["tabpanel_update"] = DGS:dgsCreateTab("Update", helpmenuUI["tabpanel"])
    helpmenuUI["tabpanel_trello"] = DGS:dgsCreateTab("Trello", helpmenuUI["tabpanel"])

    helpmenuUI["tabpanel_update_memo"] = DGS:dgsCreateMemo(0.02, 0.02, 0.96, 0.95, "XD", true, helpmenuUI["tabpanel_update"])
    DGS:dgsMemoSetReadOnly(helpmenuUI["tabpanel_update_memo"], true)
   helpmenuUI["tabpanel_forum"] = DGS:dgsCreateTab("Forum", helpmenuUI["tabpanel"])
   helpmenuUI["tabpanel_rules"] = DGS:dgsCreateTab("Regeln", helpmenuUI["tabpanel"])

   -- // Links
   helpmenuUI["trello"] = DGS:dgsCreateBrowser(0.02, 0.02, 0.96, 0.95,true, helpmenuUI["tabpanel_trello"] ,true)
   helpmenuUI["forum"] = DGS:dgsCreateBrowser(0.02, 0.02, 0.96, 0.95,true, helpmenuUI["tabpanel_forum"] ,false)
   helpmenuUI["rules"] = DGS:dgsCreateBrowser(0.02, 0.02, 0.96, 0.95,true, helpmenuUI["tabpanel_rules"] ,false)
   

   helpmenuUI["tabpanel_team"] = DGS:dgsCreateTab("Das Team", helpmenuUI["tabpanel"])    


   -- // Events
   triggerServerEvent("fetchUpdateDetailsForHelpmenu", getLocalPlayer())
  
   -- // Klick-Events bei Sub-Kategorien
   addEventHandler( "onDgsMouseClick",  root, 
   function(button, state, x, y)
       if button == 'left' and state == 'up' and source == helpmenuUI["tabpanel_helpmenu_subhelps"] then
           local Selected, selectedCol = DGS:dgsGridListGetSelectedItem( helpmenuUI["tabpanel_helpmenu_subhelps"] )
           if Selected ~= -1 then 
               local clickedRowData =  DGS:dgsGridListGetItemData ( helpmenuUI["tabpanel_helpmenu_subhelps"], Selected, helpmenuUI["tabpanel_helpmenu_subhelps_name"] )
               DGS:dgsSetText( helpmenuUI["tabpanel_helpmenu_subhelptitle"], clickedRowData.title)
               DGS:dgsSetText( helpmenuUI["tabpanel_helpmenu_subhelptext"],  clickedRowData.text)
           end
       end
   end)


   -- // Klick-Events bei Kategorien
   addEventHandler( "onDgsMouseClick", helpmenuUI["tabpanel_helpmenu_helps"], 
   function(button, state, x, y)
       if button == 'left' and state == 'up' and source ==  helpmenuUI["tabpanel_helpmenu_helps"] then
               local Selected, selectedCol = DGS:dgsGridListGetSelectedItem( helpmenuUI["tabpanel_helpmenu_helps"])
               if Selected ~= -1 then 
                local theTable = DGS:dgsGridListGetItemData( helpmenuUI["tabpanel_helpmenu_helps"],Selected, helpmenuUI["tabpanel_helpmenu_helps_name"])
               -- // Hat es Sub Kategorien ?
                if theTable.subCategorys then
                    local selectedCategory = theTable.subCategorys.startSubCategory
                    createSubcategoryElements ()
                    -- // Hinzufügen
                    DGS:dgsGridListClear(helpmenuUI["tabpanel_helpmenu_subhelps"])
                    for i,theSubTable in ipairs(theTable.subCategorys) do
                        local row = DGS:dgsGridListAddRow (  helpmenuUI["tabpanel_helpmenu_subhelps"] )
                        DGS:dgsGridListSetItemText (  helpmenuUI["tabpanel_helpmenu_subhelps"], row,  helpmenuUI["tabpanel_helpmenu_subhelps_name"], theSubTable.title, false, false )
                        DGS:dgsGridListSetItemData (  helpmenuUI["tabpanel_helpmenu_subhelps"], row,  helpmenuUI["tabpanel_helpmenu_subhelps_name"], theSubTable )
                    end
                    if selectedCategory then

                        DGS:dgsGridListSelectItem( helpmenuUI["tabpanel_helpmenu_subhelps"], selectedCategory, helpmenuUI["tabpanel_helpmenu_subhelps_name"], true )
                    end
                else
                    -- // Sub elemente löschen (wenn da)
                    deleteSubcategoryElements ()
                    DGS:dgsSetVisible(  helpmenuUI["tabpanel_helpmenu_helptitle"], true)
                    DGS:dgsSetVisible(  helpmenuUI["tabpanel_helpmenu_helptext"], true)
                    -- // Text setzen (Kategorie)
                    local title = DGS:dgsGridListGetItemText(helpmenuUI["tabpanel_helpmenu_helps"],Selected, helpmenuUI["tabpanel_helpmenu_helps_name"])
                    DGS:dgsSetText( helpmenuUI["tabpanel_helpmenu_helptitle"], title)
                    DGS:dgsSetText( helpmenuUI["tabpanel_helpmenu_helptext"], theTable.text)
                end
            end
        end
   end)
   


end
addCommandHandler("th", createHelpmenuUI)


addEventHandler("onClientBrowserCreated", root, function()
    if source == helpmenuUI["trello"] then
        loadBrowserURL(source,  "http://mta/local/htmlTest.html" )   
    end
    if source == helpmenuUI["rules"] then
       loadBrowserURL(source,  helpmenuLinks["rules"] )
    end
    if source == helpmenuUI["forum"] then
        loadBrowserURL(source,  helpmenuLinks["forum"] ) 
    end
end)

addEventHandler ( "onClientBrowserDocumentReady" , root , 
	function ( url ) 
		print(url, "wurde geladen")
	end 
)

function createSubcategoryElements ()
    if not helpmenuUI["tabpanel_helpmenu_subhelps"] then
        -- // Neue Elemente
        helpmenuUI["tabpanel_helpmenu_subhelps"] =  DGS:dgsCreateGridList(0.27, 0.02, 0.25, 0.95, true, helpmenuUI["tabpanel_helpmenu"])
        helpmenuUI["tabpanel_helpmenu_subhelps_name"] =  DGS:dgsGridListAddColumn(  helpmenuUI["tabpanel_helpmenu_subhelps"], "Name", 1)
        helpmenuUI["tabpanel_helpmenu_subhelptitle"] = DGS:dgsCreateLabel(0.54, 0.02, 0.25, 0.04, "TITEL SUB", true, helpmenuUI["tabpanel_helpmenu"])
    --  helpmenuUI["tabpanel_helpmenu_subhelptextscroll"] = DGS:dgsCreateScrollPane(0.54, 0.09, 0.44, 0.89, true, helpmenuUI["tabpanel_helpmenu"])
        helpmenuUI["tabpanel_helpmenu_subhelptext"] = DGS:dgsCreateLabel(0.54, 0.09, 0.44, 0.89, "TEXT", true,  helpmenuUI["tabpanel_helpmenu"])
        -- // Elemente Unsichtbar machen
        DGS:dgsSetVisible(  helpmenuUI["tabpanel_helpmenu_helptitle"], false)
        DGS:dgsSetVisible(  helpmenuUI["tabpanel_helpmenu_helptext"], false)

        addEventHandler("onDgsGridListSelect", helpmenuUI["tabpanel_helpmenu_subhelps"], function ( current, currentcolumn, previous, previouscolumn )
            outputChatBox("The item of list has been changed. ( Current: "..current.." )")
            end)
    end
end

function deleteSubcategoryElements ()
    if helpmenuUI["tabpanel_helpmenu_subhelps"] then
        destroyElement( helpmenuUI["tabpanel_helpmenu_subhelps"] )
        destroyElement( helpmenuUI["tabpanel_helpmenu_subhelptitle"] )
        destroyElement( helpmenuUI["tabpanel_helpmenu_subhelptext"] )
        helpmenuUI["tabpanel_helpmenu_subhelps"] = nil
        helpmenuUI["tabpanel_helpmenu_subhelptitle"] = nil
        helpmenuUI["tabpanel_helpmenu_subhelptext"] = nil
    end
end


function addHelpToList ()
    DGS:dgsGridListClear(helpmenuUI["tabpanel_helpmenu_helps"])
    for i,theTable in pairs(helpCategory) do
        local row = DGS:dgsGridListAddRow (  helpmenuUI["tabpanel_helpmenu_helps"] )
        DGS:dgsGridListSetItemText (  helpmenuUI["tabpanel_helpmenu_helps"], row,  helpmenuUI["tabpanel_helpmenu_helps_name"], i, false, false )
        DGS:dgsGridListSetItemData (  helpmenuUI["tabpanel_helpmenu_helps"], row, helpmenuUI["tabpanel_helpmenu_helps_name"], theTable ) -- // Tabelle wird auf die Spalte gesetzt
        --[[
        if theTable.subCategorys then
            print("Sub von "..i..", startSubCategory: "..theTable.startSubCategory)
            for subI,theSubTable in pairs(theTable.subCategorys) do
                print(subI, theSubTable )
            end
        end--]]
    end
end

function updateUpdateTextForHelpmenu (text)
    DGS:dgsSetText(helpmenuUI["tabpanel_update_memo"], text )
end
addEvent ( "updateUpdateTextForHelpmenu", true )
addEventHandler ( "updateUpdateTextForHelpmenu", getRootElement(), updateUpdateTextForHelpmenu )
