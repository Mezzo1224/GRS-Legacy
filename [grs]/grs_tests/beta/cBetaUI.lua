betaUI = {}

function showBetaKeyUI ()
    betaUI["window"] = DGS:dgsCreateWindow(0.43, 0.41, 0.14, 0.18, "Betakey", true)
    DGS:dgsWindowSetSizable(betaUI["window"], false)
    DGS:dgsWindowSetSizable(betaUI["window"], false)
    DGS:dgsSetProperty(betaUI["window"],"ignoreTitle", true)
    DGS:dgsWindowSetCloseButtonEnabled(betaUI["window"], false)

    betaUI["howToPlay"] = DGS:dgsCreateLabel(0.02, 0.13, 0.95, 0.21, "Um auf diesem Server zu spielen, brauchst du einen gültigen Betakey.", true, betaUI["window"])
    betaUI["whatIsAKey"] = DGS:dgsCreateLabel(0.03, 0.33, 0.94, 0.19, "Ein Key besteht aus 4 verschiedenen zufallsgenerierten Zeichen. Du erhältst einen Key auf Discord.", true, betaUI["window"])
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
    DGS:dgsSetProperty(betaUI["useKey"], "color", {tocolor(14, 194, 17, 255), tocolor(11, 153, 13, 255), tocolor(14, 207, 17, 255)})
    DGS:dgsSetProperty(betaUI["getKey"], "color", {tocolor(14, 194, 17, 255), tocolor(11, 153, 13, 255), tocolor(14, 207, 17, 255)})
    -- // Einstellungen
    DGS:dgsSetProperty(betaUI["howToPlay"],"alignment", {"center", "center"})
    addEventHandler( "onDgsMouseClick", betaUI["useKey"], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' then
           print ("Key benutzen")
        end
    end)

    addEventHandler( "onDgsMouseClick", betaUI["getKey"], 
    function(button, state, x, y)
        if button == 'left' and state == 'up' then
            setClipboard( "https://discord.gg/RMKHHanaeq" )
            
        end
    end)

end
--showBetaKeyUI ()