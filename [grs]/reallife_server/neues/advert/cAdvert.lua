
local advertWindow = {}
local advertWindowLTR = {}
local advertWindowShowContent = {}
local previewText = ""
function renderPreviewAdvert ()
    local screenW, screenH = guiGetScreenSize()
    dxDrawRectangle(screenW * 0.3402, screenH * 0.5157, screenW * 0.3004, screenH * 0.0250, tocolor(1, 0, 0, 109), false)
    dxDrawText("#FFFF00Werbung von #009900"..getPlayerName ( getLocalPlayer() ).."#FFFF00 [Handy: "..getElementData(getLocalPlayer(),"telenr").."]: "..DGS:dgsGetText(advertWindow[4]),   screenW * 0.3441, screenH * 0.5194, screenW * 0.6367, screenH * 0.5361, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, true, false, true, false)
end

function showAdvertWindow ( adcosts, adbasiscosts )
    
    advertWindow[1] = DGS:dgsCreateWindow(0.43, 0.29, 0.14, 0.22, "Werbung schalten", true)
    DGS:dgsWindowSetMovable (  advertWindow[1], false )
    DGS:dgsWindowSetSizable (  advertWindow[1], false )
    setElementClicked ( true )
    showCursor(true)
    DGS:dgsSetInputEnabled( true )
    advertWindow[2] = DGS:dgsCreateLabel(0.03, 0.05, 0.51, 0.11, "Wie willst du Werbung schalten?", true,  advertWindow[1])
    advertWindow[3] = DGS:dgsCreateComboBox(0.03, 0.17, 0.51, 0.12, "", true,  advertWindow[1])
    DGS:dgsComboBoxAddItem(advertWindow[3], "Chat")
    DGS:dgsComboBoxAddItem(advertWindow[3], "Oberer Bildschirm")
    advertWindow[4] = DGS:dgsCreateEdit(0.03, 0.48, 0.51, 0.15, "", true,  advertWindow[1])
    advertWindow[5] = DGS:dgsCreateLabel(0.04, 0.76, 0.25, 0.10, "Kosten: N.a", true,  advertWindow[1])
    advertWindow[6] = DGS:dgsCreateButton(0.30, 0.76, 0.23, 0.10, "Senden", true,  advertWindow[1])
    advertWindow[7] =  DGS:dgsCreateLabel(0.59, 0.12, 0.37, 0.79, "Deine Werbung wird von der LTR überprüft, sollte kein Mitglied der LTR verfügbar sein, wird deine Werbung automatisch gesendet. \n\nFür die Überprüfung fallen keine zusätzlichen kosten an.", true,  advertWindow[1])
    DGS:dgsSetProperty( advertWindow[7],"wordbreak", true)
    DGS:dgsLabelSetHorizontalAlign(advertWindow[7], "left", true)   
    DGS:dgsSetProperty(advertWindow[4],"placeHolder","Werbetext (70 Zeichen)")
    DGS:dgsSetProperty(advertWindow[4],"maxLength",70)
    
    -- Events

    addEventHandler( "onDgsMouseClick", advertWindow[6], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == advertWindow[6] then
            local text = DGS:dgsGetText(advertWindow[4])
            if string.len(text) > 0 then
                triggerServerEvent ( "addAdvert", lp,lp, text )
            else
                newInfobox ( "Schreibe einen Text.", 3)
            end
        end
    end)

     addEventHandler("onDgsTextChange", advertWindow[4], function() 
        -- // Kosten berechnen
        local costs = string.len(DGS:dgsGetText(advertWindow[4]))*adcosts+adbasiscosts
        DGS:dgsSetText(advertWindow[5], "Kosten: "..costs.."$")
     end)
     addEventHandler ( "onClientRender", root, renderPreviewAdvert )
     addEventHandler( "onDgsWindowClose",  advertWindow[1], 
     function()
         setElementClicked ( false )
         showCursor(false)
         DGS:dgsSetInputEnabled( false )
         removeEventHandler ( "onClientRender", root, renderPreviewAdvert )
     end)
     
end
addEvent ( "showAdvertWindow", true)
addEventHandler ( "showAdvertWindow", getLocalPlayer(),  showAdvertWindow)


function closeAdvertWindow ()
    DGS:dgsCloseWindow( advertWindow[1] )
end
addEvent ( "closeAdvertWindow", true)
addEventHandler ( "closeAdvertWindow", getLocalPlayer(),  closeAdvertWindow)


-- // Für LTR

function showAdvertWindowLTR ()

    advertWindowLTR[1] =  DGS:dgsCreateWindow(0.44, 0.35, 0.13, 0.31, "Werbung überprüfen", true)
    DGS:dgsWindowSetMovable (  advertWindowLTR[1], false )
    DGS:dgsWindowSetSizable (  advertWindowLTR[1], false )
    setElementClicked ( true )
    showCursor(true)
    DGS:dgsSetInputEnabled( true )
    advertWindowLTR[2] = DGS:dgsCreateGridList(0.03, 0.05, 0.94, 0.78, true, advertWindowLTR[1])
    advertWindowLTR[3] = DGS:dgsGridListAddColumn( advertWindowLTR[2], "Name", 0.6)
    advertWindowLTR[4] = DGS:dgsGridListAddColumn( advertWindowLTR[2], "Kosten", 0.4)    

    addEventHandler( "onDgsWindowClose",  advertWindowLTR[1], 
    function()
        setElementClicked ( false )
        showCursor(false)
        DGS:dgsSetInputEnabled( false )
        removeEventHandler ( "onClientRender", root, renderPreviewAdvert )
    end)

    addEventHandler( "onDgsMouseDoubleClick",  advertWindowLTR[2], 
                function(button, state, x, y)
                    if button == 'left' and state == 'up' and source ==  advertWindowLTR[2] then
                            local Selected, selectedCol = DGS:dgsGridListGetSelectedItem( advertWindowLTR[2])
                            if Selected ~= -1 then 
                                local name, costs,text = DGS:dgsGridListGetItemText( advertWindowLTR[2],Selected, advertWindowLTR[3]), DGS:dgsGridListGetItemText( advertWindowLTR[2],Selected, advertWindowLTR[4]), DGS:dgsGridListGetItemData( advertWindowLTR[2],Selected, advertWindowLTR[3])
                                print(name, costs, text)
                                DGS:dgsCloseWindow( advertWindowLTR[1])
                                showAdvertWindowContent(name, costs, text)
                                
                            end
                    end
                end)
    triggerServerEvent ( "fillAdsList", getLocalPlayer(), getLocalPlayer() ) 
end
addEvent ( "showAdvertWindowLTR", true)
addEventHandler ( "showAdvertWindowLTR", getLocalPlayer(),  showAdvertWindowLTR)

function addAdToList (name, cost, text)
    local row = DGS:dgsGridListAddRow ( advertWindowLTR[2] )
    DGS:dgsGridListSetItemText ( advertWindowLTR[2], row,  advertWindowLTR[3], name, false, false )
    DGS:dgsGridListSetItemText ( advertWindowLTR[2], row,  advertWindowLTR[4], cost, false, false )
    DGS:dgsGridListSetItemData ( advertWindowLTR[2], row, advertWindowLTR[3], text )
end
addEvent ( "addAdToList", true)
addEventHandler ( "addAdToList", getLocalPlayer(),  addAdToList)

function showAdvertWindowContent (name, costs, text)
    advertWindowShowContent[1] = DGS:dgsCreateWindow(0.44, 0.42, 0.12, 0.16, "Werbung von "..name, true)
    DGS:dgsWindowSetMovable (  advertWindowShowContent[1], false )
    DGS:dgsWindowSetSizable (  advertWindowShowContent[1], false )
    setElementClicked ( true )
    showCursor(true)
    DGS:dgsSetInputEnabled( true )
    advertWindowShowContent[2] = DGS:dgsCreateMemo(0.03, 0.14, 0.94, 0.41, text, true,  advertWindowShowContent[1])
    DGS:dgsSetProperty(advertWindowShowContent[2],"readOnly",true)
    -- // TODO: Farben für Buttons
    local dr,dg,db, sdr, sdg, sdb, cdr, cdg, cdb = 0, 84, 5, 4, 170, 4, 17, 153, 7 -- Wenn es AN ist
    local ar,ag,ab, sar, sag, sab, car, cag, cab = 227, 9, 9, 186, 9, 9, 148, 6, 6 -- Wenn es AUS ist
    advertWindowShowContent[3] = DGS:dgsCreateButton(0.04, 0.63, 0.41, 0.22, "Zulassen", true,  advertWindowShowContent[1], nil, nil, nil, nil, nil, nil, tocolor(dr,dg,db),tocolor(sdr, sdg, sdb),tocolor(cdr, cdg, cdb))
    advertWindowShowContent[4] = DGS:dgsCreateButton(0.52, 0.63, 0.41, 0.22, "Ablehnen", true,  advertWindowShowContent[1], nil, nil, nil, nil, nil, nil, tocolor(ar,ag,ab),tocolor(sar, sag, sab),tocolor(car, cag, cab))   

    addEventHandler( "onDgsMouseClick", advertWindowShowContent[3], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source ==  advertWindowShowContent[3] then
            print("DELETE")
        end
    end)

    addEventHandler( "onDgsMouseClick",advertWindowShowContent[4], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == advertWindowShowContent[4] then
            print("ALLOW")
        end
    end)

    addEventHandler( "onDgsWindowClose", advertWindowShowContent[1], 
    function()
        showAdvertWindowLTR ()
    end)
end
addEvent ( "showAdvertWindowContent", true)
addEventHandler ( "showAdvertWindowContent", getLocalPlayer(),  showAdvertWindowContent)