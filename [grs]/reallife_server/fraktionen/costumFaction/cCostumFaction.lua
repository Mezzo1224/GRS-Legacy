
local x, y = guiGetScreenSize()
local sx, sy = x/2560, y/1440


function showCoopCreateMenu (price)

    setElementClicked ( true )
    showCursor(true)
    DGS:dgsSetInputEnabled( true )
    coopCreateMenu = DGS:dgsCreateWindow(788*sx, 595*sy, 567*sx, 251*sy, "", false)
    coopName =  DGS:dgsCreateEdit(15*sx, 14*sy, 191*sx, 37*sy, "", false, coopCreateMenu)
    coopNameShort =  DGS:dgsCreateEdit(15*sx,61*sy, 191*sx, 37*sy, "", false, coopCreateMenu)
    coopInfo = DGS:dgsCreateMemo(236*sx, 19*sy, 321*sx, 202*sy, "Gründe deine eigenes Firma, agiere als Gang oder als Firma. Beraube die Wirtschaft oder unterstütze sie.\nLade Mitglieder ein, kaufe Fahrzeuge und beherrche "..SharedConfig["main"].serverShort.." wie nie zuvor.\nFunktionen als Gang:\n- Drogentruck (Ab Level 1)\n- Ausrauben von Spielern\n- Mats-Truck (Ab Level 1)\nUnd mehr.\n\nFunktionen als Firma:\n- Erstelle dein eigenes Auto Unternehmen\n- Biete Autos mit Tunings zum Verkauf an\n- Geldtruck (Ab Level 1)", false, coopCreateMenu)
    createCoopBtn =  DGS:dgsCreateButton(25*sx, 189*sy, 181*sx, 32*sy, "Unternehmen gründen", false, coopCreateMenu)
    coopCosts =  DGS:dgsCreateLabel(27*sx, 162, 179*sx, 17*sy, "Kosten: "..formNumberToMoneyString ( price ) , false, coopCreateMenu) 
    isGang =  DGS:dgsCreateRadioButton(19*sx, 106*sy, 187*sx, 19*sy, "Gang", false, coopCreateMenu)
    isComp =  DGS:dgsCreateRadioButton(19*sx, 132*sy, 187*sx, 20*sy, "Firma", false, coopCreateMenu)
    -- // Propertys
    DGS:dgsSetProperty(coopInfo,"readOnly",true)
    DGS:dgsSetProperty(coopName,"placeHolder","Unternehmens-Name")
    DGS:dgsSetProperty(coopNameShort,"placeHolder","Unternehmens-Abkürzung")
    DGS:dgsSetProperty(coopName,"enableTabSwitch",true)
    DGS:dgsSetProperty(coopNameShort,"enableTabSwitch",true)


    -- // Farbe
    colorSelectWindow = DGS:dgsCreateWindow(1365*sx, 566*sy, 373*sx, 312*sy, "Unternehmensfarbe", false)
    DGS:dgsWindowSetCloseButtonEnabled(colorSelectWindow, false)

    colorSelect = DGS:dgsCreateColorPicker("HSLSquare",9*sx, 6*sy, 354*sx, 276*sy,false, colorSelectWindow)
    colorSelectHelptext = DGS:dgsCreateLabel(1404*sx, 534*sy, 314*sx, 32*sy, "Wähle eine Farbe für dein Unternehmen (Spielerliste)", false)    
    DGS:dgsWindowSetMovable ( colorSelectWindow, false )
    DGS:dgsWindowSetSizable ( colorSelectWindow, false )
    DGS:dgsWindowSetMovable ( coopCreateMenu, false )
    DGS:dgsWindowSetSizable ( coopCreateMenu, false )
    
    -- // Events
    addEventHandler( "onDgsMouseClick", createCoopBtn, 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == createCoopBtn then
                local name, nameshort =  DGS:dgsGetText(coopName), DGS:dgsGetText(coopNameShort)
                local gang, comp = DGS:dgsRadioButtonGetSelected( isGang ),  DGS:dgsRadioButtonGetSelected( isComp )           
                local r, g, b = DGS:dgsColorPickerGetColor  (colorSelect,"RGB")
                print(r,g,b)
                if string.len(name) > 0 and string.len(nameshort) > 0  then
                    if string.len(name) <= 10 and string.len(nameshort) <= 3  then
                        if gang == true or comp == true then
                            if r and g and b then
                                if gang == true then
                                    type = 1
                                elseif comp == true then
                                    type = 2
                                end
                                triggerServerEvent("makeNewCooperation", getLocalPlayer(), getLocalPlayer(),name, nameshort, type, r,g,b )
                    
                                
                            else 
                                infobox_start_func ( "Du musst eine Farbe auswählen.", 7500, 125, 0, 0 )
                            end
                        else 
                            infobox_start_func ( "Wähle einen Typ für das Unternehmen aus.", 7500, 125, 0, 0 )
                        end
                    else 
                        infobox_start_func ( "Zu langer Name/Abkürzung.", 7500, 125, 0, 0 )
                    end
                else 
                    infobox_start_func ( "Zu kleiner Name/Abkürzung.", 7500, 125, 0, 0 )
                end
		end
    end)


    addEventHandler( "onDgsWindowClose", coopCreateMenu, 
    function()
        closeCoopCreateMenu()
    end)

end
addEvent ( "showCoopCreateMenu", true )
addEventHandler ( "showCoopCreateMenu", getRootElement(), showCoopCreateMenu )


function closeCoopCreateMenu ()
    setElementClicked ( false )
    showCursor(false)
    DGS:dgsSetInputEnabled( false )
    if isElement(coopCreateMenu) then
        DGS:dgsCloseWindow(coopCreateMenu)
    end
    if isElement(colorSelectWindow) then
        DGS:dgsCloseWindow(colorSelectWindow)
    end
    if isElement(colorSelectHelptext) then
        destroyElement(colorSelectHelptext)
    end
end
addEvent ( "closeCoopCreateMenu", true )
addEventHandler ( "closeCoopCreateMenu", getRootElement(), closeCoopCreateMenu )

clientsideCoopData = {}

function sendCoopDataToClient (id, name, r,g,b)
    clientsideCoopData[id] = {
        name = name,
        r = r,
        g = g,
        b = b
    }
end
addEvent ( "sendCoopDataToClient", true )
addEventHandler ( "sendCoopDataToClient", getRootElement(), sendCoopDataToClient )