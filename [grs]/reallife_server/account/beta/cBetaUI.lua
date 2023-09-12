betaUI = {}

function showBetaKeyUI ()
    betaUI["window"] = DGS:dgsCreateWindow(0.43, 0.41, 0.14, 0.18, "Betakey", true)
    DGS:dgsWindowSetSizable(betaUI["window"], false)
    DGS:dgsWindowSetSizable(betaUI["window"], false)
    DGS:dgsSetProperty(betaUI["window"],"ignoreTitle", true)
    DGS:dgsWindowSetCloseButtonEnabled(betaUI["window"], false)

    betaUI["howToPlay"] = DGS:dgsCreateLabel(0.02, 0.13, 0.95, 0.21, "Um auf diesem Server zu spielen, brauchst du einen gültigen Betakey. \n", true, betaUI["window"])
    betaUI["whatIsAKey"] = DGS:dgsCreateLabel(0.03, 0.33, 0.94, 0.19, "Ein Key besteht aus 5 verschiedenen zufallsgenerierten Zeichen. Du erhältst einen Key auf Discord.", true, betaUI["window"])
    DGS:dgsSetProperty(betaUI["howToPlay"],"wordBreak",true)
    DGS:dgsSetProperty(betaUI["whatIsAKey"],"wordBreak",true)
    DGS:dgsSetFont ( betaUI["howToPlay"], "clear" )
    DGS:dgsSetFont ( betaUI["whatIsAKey"], "clear" )
    -- // Key
    betaUI.keySegments = {}
    betaUI.keySegments[1] = DGS:dgsCreateEdit(0.22, 0.58, 0.17, 0.13, "", true, betaUI["window"])
    betaUI.keySegments[2] = DGS:dgsCreateEdit(0.42, 0.58, 0.17, 0.13, "", true, betaUI["window"])
    betaUI.keySegments[3] = DGS:dgsCreateEdit(0.61, 0.58, 0.17, 0.13, "", true, betaUI["window"])
    for k, v in pairs( betaUI.keySegments ) do
        DGS:dgsSetProperty(v,"placeHolder","Key")
        DGS:dgsSetProperty(v,"enableTabSwitch", true)
        DGS:dgsSetProperty(v,"maxLength", 5)
        DGS:dgsSetProperty(v,"alignment",{"center","center"})
        DGS:dgsSetProperty(v,"placeHolderFont","clear")
    end 

    betaUI["useKey"] = DGS:dgsCreateButton(0.25, 0.77, 0.25, 0.15, "Key benutzen", true, betaUI["window"])
    betaUI["getKey"] = DGS:dgsCreateButton(0.52, 0.77, 0.25, 0.15, "Key anfragen", true, betaUI["window"])    
    DGS:dgsSetFont ( betaUI["useKey"], "clear" )
    DGS:dgsSetFont ( betaUI["getKey"], "clear" )
    -- // Einstellungen
    DGS:dgsSetProperty(betaUI["howToPlay"],"alignment", {"center", "center"})

    addEventHandler( "onDgsMouseClick", betaUI["useKey"], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source ==  betaUI["useKey"] then
            local key1, key2, key3 = DGS:dgsGetText(betaUI.keySegments[1]),DGS:dgsGetText(betaUI.keySegments[2]) ,DGS:dgsGetText(betaUI.keySegments[3])
            local betakey = key1.."-"..key2.."-"..key3
            if string.len(key1) == 5 and string.len(key2) == 5 and string.len(key3) == 5  then
                triggerServerEvent("submitBetaKey", getLocalPlayer(), betakey)
            else
                infobox ("Key ungültig.", "error", 15)
            end
        end
    end)

    addEventHandler( "onDgsMouseClick", betaUI["getKey"], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source ==  betaUI["getKey"] then
            setClipboard( SharedConfig["network"].discordInviteURL )
            infobox ("Discord-Link ist nun in der Zwischenablage.", "success", 15)
        end
    end)

end
addEvent ( "showBetaWindow", true)
addEventHandler ( "showBetaWindow", getRootElement(), showBetaKeyUI )