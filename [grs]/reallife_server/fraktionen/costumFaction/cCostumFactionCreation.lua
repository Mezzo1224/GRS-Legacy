--- // Neues UI

local coopExplainText = "FIRMA"
local gangExplainText = "GANG"
createFactionData = {}
createFactionSteps = {}
createFactionUI = {}
createFactionUI.navButtons = {}
createFactionUI.selectFaction = {}
createFactionUI.selectName = {}
createFactionUI.selectColor = {}
createFactionUI.finalizeFaction = {}
createFactionUI.blur = {}


function intFactionCreationUI ()
    createFactionUI.blur["main"] =   DGS:dgsCreateBlurBox(x, y)
    createFactionUI.blur["renderer"] = DGS:dgsCreateImage(0,0, x, y, createFactionUI.blur["main"],false)
    DGS:dgsSetLayer(createFactionUI.blur["renderer"],"bottom")
    unRenderHUD ()
    setElementClicked ( true )
    showCursor(true)
    DGS:dgsSetInputEnabled( true )
    showChat(false)
    createNavigationButtons ()
    createSelectFactionType ()

    --[[ // Debug check 
    createFactionData = {
        type = "gang",
        name = "Inzest",
        nameshort = "INZ",
        rgb = 0
    }--]]
 --   triggerServerEvent ( "isFactionCreateable", getLocalPlayer(), getLocalPlayer(), createFactionData ) 

end
addCommandHandler("cf", intFactionCreationUI)



function deleteCreateFactionUI ( all ) -- // FERTIG MACHEN
    for index,table in pairs(createFactionUI) do
    --    print("UI-TABLES", index, table)

        if table == createFactionUI.navButtons or table == createFactionUI.blur then
            if all == true then
                print("NavButtons oder Blur werden gelöscht", all )
                for i,line in pairs(table) do
                    destroyElement(line)
                end
            else
                print("NavButtons werden nicht gelöscht", all )
            end
        else
            for i,line in pairs(table) do
                if isElement(line) then
                    destroyElement(line)
                end
            end
        end
    end
    if all == true then
        setElementClicked ( false )
        showCursor( false )
        DGS:dgsSetInputEnabled( false )
        renderHUD ()
        showChat( true )
        createFactionData = {}
    end
    print("alles löschen?", all)
end


function checkName (name, isShort)
    if isShort then
        lengh = SharedConfig["costumFactions"].nameshortMaxLengh
        minLengh = SharedConfig["costumFactions"].nameshortMinLengh
    else
        lengh = SharedConfig["costumFactions"].nameMaxLengh
        minLengh = SharedConfig["costumFactions"].nameMinLengh
    end
    print("Checke Namen", name, isShort)
    if string.len(name) > 0 and string.len(name) <= lengh then
        if string.len(name) >= minLengh then
                print("Perfekt")
                return true
            else
                print("Du musst mindestens ", minLengh, "Zeichen haben.")
                return false
        end
    else
        print("Zu Lang")
        return false
    end
end

function createNavigationButtons () 
    createFactionUI.navButtons["continue"] = DGS:dgsCreateButton(1291, 789, 120, 37, "Weiter >>>>", false)
    createFactionUI.navButtons["back"] = DGS:dgsCreateButton(1161, 789, 120, 37, "<<<< Zurück", false)
    createFactionUI.navButtons["cancel"] = DGS:dgsCreateButton(1225, 836, 120, 37, "Abbrechen", false)   

    -- Farben dgsSetProperty(button,"color",{normalColor,hoveringColor,clickedColor}) -- IWAS : HELLER : DUNKLER
    DGS:dgsSetProperty(createFactionUI.navButtons["continue"],"color",{tocolor(22, 163, 18),tocolor(29, 199, 24),tocolor(20, 140, 17)})
    DGS:dgsSetProperty(createFactionUI.navButtons["back"],"color",{tocolor(22, 163, 18),tocolor(29, 199, 24),tocolor(20, 140, 17)})
    DGS:dgsSetProperty(createFactionUI.navButtons["cancel"],"color",{tocolor(140, 17, 17),tocolor(171, 21, 21),tocolor(112, 15, 15)})
    bindKey ("arrow_l","down",
    function(player,key,state)
        DGS:dgsSimulateClick(createFactionUI.navButtons["back"],"left")
    end)

    bindKey ("arrow_r","down",
    function(player,key,state)
        DGS:dgsSimulateClick(createFactionUI.navButtons["continue"],"left")
    end)
    
    addEventHandler( "onDgsMouseClick", getRootElement(), 
    function(button, state)
        if button == "left" and state == "down" then
            if source == createFactionUI.navButtons["cancel"] then
                --- TODO: SICHER ?
                createFactionData = nil
                createFactionData = {}
                createFactionSteps["prevstep"] = nil
                createFactionSteps["nextstep"] = createSelectFactionName 
                deleteCreateFactionUI ( true )
            end
        end
    end)

    
    addEventHandler( "onDgsMouseClick", getRootElement(), 
    function(button, state)
        if button == "left" and state == "down" then
            if source == createFactionUI.navButtons["continue"] then
                if createFactionSteps["nextstep"] then
                    print("Weiter gehts")
                    deleteCreateFactionUI ( false )
                    createFactionSteps["nextstep"]()
                end
            end
        end
    end)

    
    addEventHandler( "onDgsMouseClick", getRootElement(), 
    function(button, state)
        if button == "left" and state == "down" then
            if source == createFactionUI.navButtons["back"] then
                if createFactionSteps["prevstep"] then
                    deleteCreateFactionUI ( false )
                    createFactionSteps["prevstep"]()
                end


            end
        end
    end)
end


function createSelectFactionType ()
        createFactionSteps["prevstep"] = nil
        createFactionSteps["nextstep"] = createSelectFactionName 
        local titleFont =  DGS:dgsCreateFont( ":reallife_server/fonts/tahoma.ttf", 20 )
        local factionTypeFont =  DGS:dgsCreateFont( ":reallife_server/fonts/BEBAS.ttf", 17 )
        createFactionUI.selectFaction["title"] = DGS:dgsCreateLabel(991, 198, 579, 40, "Wähle welche Art von Fraktion du gründen willst." ,false)
          

        -- // Gang
        createFactionUI.selectFaction["gang_image"] = DGS:dgsCreateImage(822, 294, 312, 492, ":reallife_server/images/customFaction/gang.png")
        createFactionUI.selectFaction["gang_label"] = DGS:dgsCreateLabel(130, 233, 52, 26, "Gang", false, createFactionUI.selectFaction["gang_image"])

        -- // Unternehmen
        createFactionUI.selectFaction["coop_image"] = DGS:dgsCreateImage(1430, 294, 312, 492, ":reallife_server/images/customFaction/cooperation.png")
        createFactionUI.selectFaction["coop_label"] = DGS:dgsCreateLabel(87, 233, 139, 26, "Unternehmen", false, createFactionUI.selectFaction["coop_image"])
        -- // Hilfetext
        createFactionUI.selectFaction["explain"] =  DGS:dgsCreateMemo(1146, 436, 269, 209, "", false)   
        DGS:dgsSetProperty(createFactionUI.selectFaction["explain"],"allowCopy",false)
        DGS:dgsSetEnabled(createFactionUI.selectFaction["explain"], false)
        DGS:dgsSetVisible(createFactionUI.selectFaction["explain"], false)
        -- // Fonts setzen
        DGS:dgsSetFont( createFactionUI.selectFaction["title"], titleFont ) 
        DGS:dgsSetFont( createFactionUI.selectFaction["coop_label"], factionTypeFont ) 
        DGS:dgsSetFont( createFactionUI.selectFaction["gang_label"], factionTypeFont ) 
        -- // Farben setzen
        DGS:dgsSetProperty( createFactionUI.selectFaction["coop_label"], "textColor", tocolor(255, 255, 255) ) 
        DGS:dgsSetProperty( createFactionUI.selectFaction["gang_label"], "textColor", tocolor(255, 255, 255) ) 
        -- // Buttons
        DGS:dgsSetEnabled(createFactionUI.navButtons["back"], false)
        if not createFactionData["type"] then
            DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], false)
        end
        -- // Einstellungen

        addEventHandler( "onDgsMouseClick", getRootElement(), 
        function(button, state)
            if button == "left" and state == "down" then
                if source == createFactionUI.selectFaction["gang_image"] then
                    DGS:dgsSetProperty( createFactionUI.selectFaction["coop_image"],"outline",nil)
                    DGS:dgsSetProperty(source,"outline",{"out",3,tocolor(57, 214, 9)})
                    createFactionData["type"] = "gang"
                    DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], true)
                    DGS:dgsSetProperty( createFactionUI.selectFaction["gang_label"], "textColor", tocolor(18, 128, 23) ) 
                end
                if source == createFactionUI.selectFaction["coop_image"] then
                    DGS:dgsSetProperty( createFactionUI.selectFaction["gang_image"],"outline",nil)
                    DGS:dgsSetProperty(source,"outline",{"out",3,tocolor(57, 214, 9)})
                    createFactionData["type"] = "firma"
                    DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], true)
                    DGS:dgsSetProperty( createFactionUI.selectFaction["coop_label"], "textColor", tocolor(18, 128, 23) ) 
                end
            end
        end)

        addEventHandler( "onDgsMouseEnter", getRootElement(), 
        function(aX, aY)
            if source == createFactionUI.selectFaction["gang_image"] then
                DGS:dgsImageSetImage(source, ":reallife_server/images/customFaction/gang_blur.png")
                DGS:dgsSetVisible(createFactionUI.selectFaction["explain"], true)
                DGS:dgsSetText( createFactionUI.selectFaction["explain"], "GANG")
            end
            if source == createFactionUI.selectFaction["coop_image"] then
                DGS:dgsImageSetImage(source, ":reallife_server/images/customFaction/cooperation_blur.png")
                DGS:dgsSetVisible(createFactionUI.selectFaction["explain"], true)
                DGS:dgsSetText( createFactionUI.selectFaction["explain"], "FIRMA")
            end
        end)

        addEventHandler( "onDgsMouseLeave", getRootElement(), 
        function(aX, aY)
            if source == createFactionUI.selectFaction["gang_image"] then
                DGS:dgsImageSetImage(source, ":reallife_server/images/customFaction/gang.png")
                DGS:dgsSetVisible(createFactionUI.selectFaction["explain"], false)
            end
            if source == createFactionUI.selectFaction["coop_image"] then
                DGS:dgsImageSetImage(source, ":reallife_server/images/customFaction/cooperation.png")
                DGS:dgsSetVisible(createFactionUI.selectFaction["explain"], false)
            end
        end)

    -- // Auf das vorher ausgewählte gehen
    if createFactionData["type"] == "gang" then
        DGS:dgsSimulateClick(createFactionUI.selectFaction["gang_image"],"left")
    elseif createFactionData["type"] == "firma" then
        DGS:dgsSimulateClick(createFactionUI.selectFaction["coop_image"],"left")
    end
end




function createSelectFactionName ()
    createFactionSteps["prevstep"] = createSelectFactionType
    createFactionSteps["nextstep"] = createSelectFactionColor
    local titleFont =  DGS:dgsCreateFont( ":reallife_server/fonts/tahoma.ttf", 20 )
    if createFactionData["type"] == "gang" then
        titleText = "Wie soll deine Gang heißen?"
    else
        titleText = "Wie soll dein Unternehmen heißen?"
    end
    createFactionUI.selectName["title"] = DGS:dgsCreateLabel(991, 198, 579, 40, titleText ,false)


    createFactionUI.selectName["window"] = DGS:dgsCreateWindow(1150, 446, 261, 154, "", false)


    createFactionUI.selectName["name"] = DGS:dgsCreateEdit(46, 28, 170, 44, "", false, createFactionUI.selectName["window"])
    createFactionUI.selectName["nameshort"] = DGS:dgsCreateEdit(74, 82, 115, 44, "", false, createFactionUI.selectName["window"])  

    -- // Länge vom Namen checken
    addEventHandler("onDgsTextChange",  createFactionUI.selectName["name"], function() 
        createFactionData["name"] =  DGS:dgsGetText(source)
        local isValid = checkName (createFactionData["name"] , false)
        print("Text:",   createFactionData["name"])
        if isValid == true then
            DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], true)
        else
            DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], false)
        end
     end)
     local isValid = checkName (DGS:dgsGetText(createFactionUI.selectName["name"]) , false)
     if isValid then 
        DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], true)
     end

     -- // Länge von der Abkürzung checken
     addEventHandler("onDgsTextChange", createFactionUI.selectName["nameshort"], function() 
        createFactionData["nameshort"] =  DGS:dgsGetText(source)
        local isValid = checkName (createFactionData["nameshort"] , true)
        print("Text der Abkürzung:", createFactionData["nameshort"])

        if isValid == true then
            DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], true)
        else
            DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], false)
        end
     end)
     local isValid = checkName (DGS:dgsGetText(createFactionUI.selectName["nameshort"]) , true)
     if isValid then 
        DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], true)
     end
    -- // Einstellungen
    if createFactionData["name"] then
        DGS:dgsSetText( createFactionUI.selectName["name"], createFactionData["name"])
    end
    if createFactionData["nameshort"] then
        DGS:dgsSetText( createFactionUI.selectName["nameshort"], createFactionData["nameshort"])
    end
    DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], false)
    DGS:dgsSetProperty( createFactionUI.selectName["title"],"alignment",{"center","center"})
    DGS:dgsSetProperty( createFactionUI.selectName["window"],"closeButtonEnabled",false)
    DGS:dgsSetProperty(createFactionUI.selectName["window"],"ignoreTitle",true)
    DGS:dgsSetProperty(createFactionUI.selectName["window"],"titleHeight",0)
    DGS:dgsSetProperty(createFactionUI.selectName["window"],"movable",false)
    DGS:dgsSetProperty(createFactionUI.selectName["window"],"sizable",false) 
    DGS:dgsSetProperty(createFactionUI.selectName["name"],"maxLength",SharedConfig["costumFactions"].nameMaxLengh)
    DGS:dgsSetProperty(createFactionUI.selectName["nameshort"],"maxLength",SharedConfig["costumFactions"].nameshortMaxLengh)
    DGS:dgsSetProperty(createFactionUI.selectName["name"],"placeHolder","Name ("..SharedConfig["costumFactions"].nameMinLengh.." bis "..SharedConfig["costumFactions"].nameMaxLengh.." Zeichen)")
    DGS:dgsSetProperty(createFactionUI.selectName["nameshort"],"placeHolder","Abkürzung ("..SharedConfig["costumFactions"].nameshortMinLengh.." bis "..SharedConfig["costumFactions"].nameshortMaxLengh.." Zeichen)")
    DGS:dgsSetEnabled(createFactionUI.navButtons["back"], true)
    -- // Fonts setzen
    DGS:dgsSetFont( createFactionUI.selectName["title"], titleFont ) 
end


function createSelectFactionColor()
    createFactionSteps["prevstep"] = createSelectFactionName
    createFactionSteps["nextstep"] = checkFactionsData
    local name, nameshort = createFactionData["name"], createFactionData["nameshort"]
    local titleFont =  DGS:dgsCreateFont( ":reallife_server/fonts/tahoma.ttf", 20 )
    if createFactionData["type"] == "gang" then
        titleText = "Welche Farbe soll deine Gang haben?"
    else
        titleText = "Welche Farbe soll dein Unternehmen haben?"
    end
    createFactionUI.selectColor["title"] = DGS:dgsCreateLabel(991, 198, 579, 40, titleText ,false)
    createFactionUI.selectColor["colorpicker"] = DGS:dgsCreateColorPicker("HSLSquare", 1119, 355, 322, 314, false)
    createFactionUI.selectColor["preview"] = DGS:dgsCreateLabel(1152, 679, 254, 16, "["..nameshort.."] "..name.."", false)    

    -- // Einstellungen
    DGS:dgsSetEnabled(   createFactionUI.navButtons["continue"], true)
    DGS:dgsSetProperty(  createFactionUI.selectColor["title"],"alignment",{"center","center"})
    DGS:dgsSetProperty(  createFactionUI.selectColor["preview"],"alignment",{"center","center"})
    if not  createFactionData["RGB"] then
        DGS:dgsColorPickerSetColor(createFactionUI.selectColor["colorpicker"],62,188,192,255,"RGB")
    else
        DGS:dgsColorPickerSetColor(createFactionUI.selectColor["colorpicker"],createFactionData["RGB"][1], createFactionData["RGB"][2], createFactionData["RGB"][3],255,"RGB")
    end
    local R,G,B,A = DGS:dgsColorPickerGetColor(createFactionUI.selectColor["colorpicker"],"RGB")
    DGS:dgsLabelSetColor ( createFactionUI.selectColor["preview"],  R, G, B, A )

    addEventHandler("onDgsColorPickerChange",createFactionUI.selectColor["colorpicker"] ,function(RGB,HSL,HSV)
        local R,G,B,A = DGS:dgsColorPickerGetColor(createFactionUI.selectColor["colorpicker"],"RGB")
        DGS:dgsLabelSetColor ( createFactionUI.selectColor["preview"],  R, G, B, A )
        outputChatBox("New RGB:("..R..","..G..","..B..")")
        createFactionData["RGB"] = {R,G,B}
        print( createFactionData["RGB"], createFactionData["RGB"][1], createFactionData["RGB"][2], createFactionData["RGB"][3] )
      end,false)
    
    -- // Fonts setzen
    DGS:dgsSetFont(  createFactionUI.selectColor["title"], titleFont ) 

end

function checkFactionsData ()
    triggerServerEvent ( "isFactionCreateable", getLocalPlayer(), getLocalPlayer(), createFactionData ) 
end

function createFinalizeFaction (result)
    local validColor = {13, 133, 15}
    local notValidColor = {179, 40, 30} 
    local name, nameshort = createFactionData["name"], createFactionData["nameshort"]
    print("createFinalizeFaction")
    -- // Daten übermitteln
    for i,line in pairs(result) do
        print(i, line)
    end
   


    print(moneyText)


    -- // UI
    createFactionSteps["prevstep"] = createSelectFactionColor
    createFactionSteps["nextstep"] = nil

    local titleFont =  DGS:dgsCreateFont( ":reallife_server/fonts/tahoma.ttf", 20 )
    createFactionUI.finalizeFaction["title"] = DGS:dgsCreateLabel(991, 198, 579, 40, "Überprüfe ob deine Fraktion erstellbar ist." ,false)

    createFactionUI.finalizeFaction["window"] = DGS:dgsCreateWindow(1140, 398, 280, 284, "Angaben überprüfen", false)
    createFactionUI.finalizeFaction["name"] = DGS:dgsCreateLabel(10, 28, 285, 22, "Der Name ["..createFactionData["name"].."] ist verfügbar.", false, createFactionUI.finalizeFaction["window"])
    createFactionUI.finalizeFaction["nameshort"] = DGS:dgsCreateLabel(10, 55, 285, 22, "Die Abkürzung ["..createFactionData["nameshort"].."] ist verfügbar. ", false, createFactionUI.finalizeFaction["window"])
    createFactionUI.finalizeFaction["color"] = DGS:dgsCreateLabel(10, 87, 285, 22, "FARBE", false, createFactionUI.finalizeFaction["window"])
    createFactionUI.finalizeFaction["house"] = DGS:dgsCreateLabel(10, 119, 285, 22, "Haus verfügbar", false, createFactionUI.finalizeFaction["window"])
    createFactionUI.finalizeFaction["money"] = DGS:dgsCreateLabel(10, 151, 285, 22, moneyText, false, createFactionUI.finalizeFaction["window"])
    createFactionUI.finalizeFaction["placeholder"] = DGS:dgsCreateLabel(10, 183, 285, 22, moneyText, false, createFactionUI.finalizeFaction["window"])
    createFactionUI.finalizeFaction["finish"] = DGS:dgsCreateButton(79, 215, 148, 53, "Erstellen", false, createFactionUI.finalizeFaction["window"])

     -- // Einstellungen
     if result.failed == true then
        DGS:dgsSetEnabled(createFactionUI.finalizeFaction["finish"], false)
     else
        DGS:dgsSetEnabled(createFactionUI.finalizeFaction["finish"], true)
     end

     -- // Geld 
     local costs = result.costs
     if result.paymentMethode == "money" then
         moneyText = "Du bist mit deinem Bargeld zahlungsfähig."
         DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["money"],  validColor[1], validColor[2],validColor[3], 255 )
     elseif result.paymentMethode == "bankmoney" then 
         moneyText = "Du bist mit deinem Bankkonto zahlungsfähig."
         DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["money"],  validColor[1], validColor[2],validColor[3], 255 )
     else
         moneyText = "Du brauchst auf der "..formNumberToMoneyString ( costs )
         DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["money"],  notValidColor[1], notValidColor[2],notValidColor[3], 255 )
     end
     DGS:dgsSetProperty( createFactionUI.finalizeFaction["money"],"wordBreak",true)
     DGS:dgsSetText ( createFactionUI.finalizeFaction["money"], moneyText )
     
     -- // Farbe
     if result.validRGB == true then
        DGS:dgsSetText ( createFactionUI.finalizeFaction["color"], "Deine Farbe ist gültig." )
        DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["color"],  createFactionData["RGB"][1], createFactionData["RGB"][2], createFactionData["RGB"][3], 255 )
     else
        DGS:dgsSetText ( createFactionUI.finalizeFaction["color"], "Deine Farbe ist nicht gültig." )
        DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["color"],  notValidColor[1], notValidColor[2], notValidColor[3], 255 )
     end

    -- // Name
     if result.nameToLong == false then
        if result.nameTaken == false then
            DGS:dgsSetText ( createFactionUI.finalizeFaction["name"], "Der Name ["..createFactionData["name"].."] ist verfügbar." )
            DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["name"],  validColor[1], validColor[2],validColor[3], 255 )
        else
            DGS:dgsSetText ( createFactionUI.finalizeFaction["name"], "Der Name ist bereits vergeben." )
            DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["name"],  notValidColor[1], notValidColor[2],notValidColor[3], 255 )
        end
    else
        DGS:dgsSetText ( createFactionUI.finalizeFaction["name"], "Dein Name ist zu lang oder zu kurz." )
        DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["name"],  notValidColor[1], notValidColor[2],notValidColor[3], 255 )
    end

    -- // Abkürzung
    --  // FIX
    if result.nameshortToLong == false then
        if result.nameshortTaken == false then
            DGS:dgsSetText ( createFactionUI.finalizeFaction["nameshort"], "Die Abkürzung ["..createFactionData["nameshort"].."] ist verfügbar." )
            DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["nameshort"],  validColor[1], validColor[2],validColor[3], 255 )
        else
            DGS:dgsSetText ( createFactionUI.finalizeFaction["nameshort"], "Die Abkürzung ist bereits vergeben." )
            DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["nameshort"],  notValidColor[1], notValidColor[2],notValidColor[3], 255 )
        end
    else
        DGS:dgsSetText ( createFactionUI.finalizeFaction["nameshort"], "Die Abkürzung ist zu lang oder zu kurz." )
        DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["nameshort"],  notValidColor[1], notValidColor[2],notValidColor[3], 255 )
    end

    if result.hasHouse == true then
        DGS:dgsSetText ( createFactionUI.finalizeFaction["house"], "Du hast ein Haus." )
        DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["house"],  validColor[1], validColor[2],validColor[3], 255 )
    else
        DGS:dgsSetText ( createFactionUI.finalizeFaction["house"], "Du hast kein Haus." )
        DGS:dgsLabelSetColor ( createFactionUI.finalizeFaction["house"],  notValidColor[1], notValidColor[2],notValidColor[3], 255 )
    end

     DGS:dgsSetEnabled(createFactionUI.navButtons["continue"], false)
     DGS:dgsSetProperty( createFactionUI.finalizeFaction["window"],"closeButtonEnabled",false)
     DGS:dgsSetProperty(createFactionUI.finalizeFaction["window"],"ignoreTitle",true)
     DGS:dgsSetProperty(createFactionUI.finalizeFaction["window"],"movable",false)
     DGS:dgsSetProperty(createFactionUI.finalizeFaction["window"],"sizable",false)

     -- // Fonts
     DGS:dgsSetFont( createFactionUI.finalizeFaction["title"], titleFont ) 
end


addEvent ( "createFinalizeFaction", true)
addEventHandler ( "createFinalizeFaction", getLocalPlayer(),  createFinalizeFaction)