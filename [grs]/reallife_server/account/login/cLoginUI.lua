

local loginWindow = {}
local pwResetWindow = {}
local x, y = DGS:dgsGetScreenSize()
local sx, sy = x/2560, y/1440

function createLoginWindow ()
    if not joinmusic then
        joinmusic = playSound ("sounds/login.mp3", true)
    end
    if isSoundPaused(joinmusic) then
        setSoundPaused(joinmusic, false)
    end
    setSoundVolume(joinmusic,0.1)
    showCursor(true)
    if isElement(headerImage) then
        destroyElement(headerImage)
    end
    headerImage = DGS:dgsCreateImage (955*sx, -10*sy, 651*sx, 206*sy, ":reallife_server/images/header.jpg", false)    
    loginWindow["window"] = DGS:dgsCreateWindow(1115*sx, -10*sy, 330*sx, 258*sy, "Login", false)
    if cameFromResetWindow then
        DGS:dgsSetPosition ( headerImage, 955*sx, 377*sy, false )
        DGS:dgsSetPosition (  loginWindow["window"], 1115*sx, 593*sy, false )
    else
        DGS:dgsMoveTo( headerImage,955*sx, 377*sy,false,"OutQuad",4000)
        DGS:dgsMoveTo( loginWindow["window"],1115*sx, 593*sy,false,"OutQuad",5000)
    end
    cameFromResetWindow = nil
    DGS:dgsWindowSetSizable(loginWindow["window"],false)
    DGS:dgsWindowSetMovable(loginWindow["window"],false)
    DGS:dgsWindowSetCloseButtonEnabled(loginWindow["window"], false)
    loginWindow["password"] = DGS:dgsCreateEdit(70*sx, 24*sy, 191*sx, 35*sy, "", false, loginWindow["window"])
    DGS:dgsSetProperty(loginWindow["password"],"placeHolder","Passwort")
    DGS:dgsSetProperty(loginWindow["password"],"masked",true)
    loginWindow["savePassword"] = DGS:dgsCreateCheckBox(11*sx, 70*sy, 250*sx, 35*sy, "Passwort speichern ?", false, false, loginWindow["window"])
    loginWindow["autologin"] = DGS:dgsCreateCheckBox(11*sx, 115*sy, 250*sx, 35*sy, "Autologin de-/aktivieren", false, false, loginWindow["window"])
    loginWindow["loginBtn"] = DGS:dgsCreateButton(76*sx, 159*sy, 185*sx, 36*sy, "Einloggen", false, loginWindow["window"])
    loginWindow["resetpw"] = DGS:dgsCreateLabel(10*sx, 195*sy, 179*sx, 18*sy, "Passwort vergessen ?", false, loginWindow["window"])  
    loginWindow["forgotPasswordInfo"] = DGS:dgsCreateToolTip()
    DGS:dgsTooltipApplyTo(loginWindow["forgotPasswordInfo"], loginWindow["resetpw"],"Du kannst dein Passwort nur mit deinem Permanent Support Token zurücksetzen.")

    DGS:dgsSetProperty(loginWindow["resetpw"],"textColor",tocolor(235, 180, 16,255))
    DGS:dgsSetProperty(loginWindow["loginBtn"],"color",{tocolor(12, 133, 44,255),tocolor(15, 150, 51,255),tocolor(12, 133, 44,255)})
    DGS:dgsSetProperty(loginWindow["loginBtn"],"wordBreak",true)
    bindKey ( "enter", "down", loginPlayer )
    local safedPW = getPassword ()
    if safedPW == false then
        DGS:dgsSetText(loginWindow["password"], safedPW)
        DGS:dgsCheckBoxSetSelected(loginWindow["savePassword"], false)
    else
        DGS:dgsSetText(loginWindow["password"], safedPW)
        DGS:dgsCheckBoxSetSelected(loginWindow["savePassword"], true)
    end

    addEventHandler("onDgsTextChange", loginWindow["password"], function() 
        local passwort = DGS:dgsGetText( loginWindow["password"] )
        local savingPW, enableAutologin = DGS:dgsCheckBoxGetSelected(loginWindow["savePassword"]), DGS:dgsCheckBoxGetSelected(loginWindow["autologin"])
        if savingPW == true then
            safePassword (hash ( "sha512", passwort ))
        end
     end)

    addEventHandler ( "onDgsCheckBoxChange",loginWindow["savePassword"], 
    function(state)
        local passwort = DGS:dgsGetText( loginWindow["password"] )
        local savingPW, enableAutologin = DGS:dgsCheckBoxGetSelected(loginWindow["savePassword"]), DGS:dgsCheckBoxGetSelected(loginWindow["autologin"])
        if state == true then
            DGS:dgsSetEnabled(loginWindow["autologin"], true)
            safePassword (hash ( "sha512", passwort ))
        else
            DGS:dgsCheckBoxSetSelected(loginWindow["autologin"], false)
            DGS:dgsSetEnabled(loginWindow["autologin"], false)
            safePassword (nil)
        end
    end)

    addEventHandler ( "onDgsCheckBoxChange",loginWindow["autologin"], 
    function(state)
        toggleAutoLogin (state)
    end)

    addEventHandler ( "onDgsMouseClickDown", loginWindow["resetpw"], 
        function(button, state, x, y)
        if source == loginWindow["resetpw"] then
            DGS:dgsCloseWindow(loginWindow["window"])
            showResetPasswordWindow ()
            setSoundPaused(joinmusic, true)
        end
    end)

    addEventHandler ( "onDgsMouseClickDown",loginWindow["loginBtn"], 
        function(button, state, x, y)
        if source == loginWindow["loginBtn"] then
            loginPlayer ()
        end
    end)

    -- // Autologin-Check
    local autoLoginState = getAutoLogin ()

    if autoLoginState  == true then
        DGS:dgsCheckBoxSetSelected(loginWindow["autologin"], true)
        setTimer ( function()
            loginPlayer ()
        end, 100, 1 )
    end
end

function destroyLoginwindow ()

    stopSound(joinmusic)
    DGS:dgsCloseWindow(loginWindow["window"])
    unbindKey ( "enter", "down", loginPlayer )
    showCursor(false)
    showChat(true)
    destroyElement(headerImage)
    if autoLogin == 1 then
        newInfobox ("Auto-Login aktiviert\nDu kannst es unter \"/self\" deaktivieren.", 2)
    end
    setTimer ( checkForSocialStateChanges, 10000, 0 )
    setTimer ( getPlayerSocialAvailableStates, 1000, 1 )
    if isTimer ( LVCamFlightTimer ) then
        killTimer ( LVCamFlightTimer )
    end
	setTempToken () -- // Supporttoken setzen
    intSettings () 
    addTextToATMs ()
    -- // Update ?
    checkNewUpdate ()
end

function loginPlayer ()
	local passwort = DGS:dgsGetText( loginWindow["password"] )
    local safedPW = getPassword ()
    local savingPW, enableAutologin = DGS:dgsCheckBoxGetSelected(loginWindow["savePassword"]), DGS:dgsCheckBoxGetSelected(loginWindow["autologin"])
    if safedPW ~= "" and savingPW == true then
	    triggerServerEvent ( "einloggen", lp, lp, safedPW)
    else
        triggerServerEvent ( "einloggen", lp, lp, hash ( "sha512", passwort ))
    end
end

-- // Passwort zurücksetzten
function showResetPasswordWindow ()    
    pwResetWindow["window"] = DGS:dgsCreateWindow(1137*sx, 569*sy, 286*sx, 303*sy, "Passwort zurücksetzen", false)
    DGS:dgsWindowSetSizable(pwResetWindow["window"],false)
    DGS:dgsWindowSetMovable(pwResetWindow["window"],false)

    pwResetWindow["helptext"] = DGS:dgsCreateLabel(11*sx, 5*sy, 265*sx, 110*sy, "Um dein Passwort zurückzusetzen musst du deinen Permanenten-Supporttoken angeben und dein neues Passwort, danach wird das Passwort geändert, aber auch ein neuer Token generiert.", false, pwResetWindow["window"])
    DGS:dgsSetProperty(pwResetWindow["helptext"],"wordbreak",true)
    pwResetWindow["token"] = DGS:dgsCreateEdit(11*sx, 125*sy, 159*sx, 37*sy, "", false, pwResetWindow["window"])
    pwResetWindow["newpw"] = DGS:dgsCreateEdit(11*sx, 172*sy, 128*sx, 37*sy, "", false, pwResetWindow["window"])
    pwResetWindow["newpw_repeat"] = DGS:dgsCreateEdit(148*sx, 172*sy, 128*sx, 37*sy, "", false, pwResetWindow["window"])
    pwResetWindow["resetpwBtn"] = DGS:dgsCreateButton(74*sx, 225*sy, 134*sx, 38*sy, "Zurücksetzen", false, pwResetWindow["window"])    
    DGS:dgsSetProperty(pwResetWindow["resetpwBtn"],"color",{tocolor(207, 152, 33,255),tocolor(240, 176, 38,255), tocolor(181, 132, 27,255)})
    DGS:dgsSetProperty(pwResetWindow["token"],"placeHolder","Token")
    DGS:dgsSetProperty(pwResetWindow["newpw"],"placeHolder","Neues PW")
    DGS:dgsSetProperty(pwResetWindow["newpw_repeat"],"placeHolder","Neues PW Wdh.")

    addEventHandler ( "onDgsMouseClickDown", pwResetWindow["resetpwBtn"], 
        function(button, state, x, y)
        if source == pwResetWindow["resetpwBtn"] then
            local pw, pw2 = DGS:dgsGetText(pwResetWindow["newpw"]), DGS:dgsGetText(pwResetWindow["newpw_repeat"])
            local token = DGS:dgsGetText(pwResetWindow["token"])
            triggerServerEvent ( "resetPasswordFromLogin", lp, lp, token, pw, pw2)
        end
    end)

    addEventHandler( "onDgsWindowClose", pwResetWindow["window"], 
    function()
        cameFromResetWindow = true
        createLoginWindow ()
    end)
end

-- // Events
addEvent ( "DisableLoginWindow", true )
addEventHandler ( "DisableLoginWindow", getRootElement(), destroyLoginwindow)
addEvent ( "ShowLoginWindow", true)
addEventHandler ( "ShowLoginWindow", getRootElement(), createLoginWindow)


-- // Wird ausgeführt, wenn der Gamemode fertig geladen ist
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
    function ()
        for i = 1, 100 do
            outputChatBox (" ")
        end
        intLoginFile ()
        if ( x < 1920 ) and ( y < 1080 ) then 
            outputChatBox ( "WARNUNG: DEINE AUFLÖSUNG IST UNTER 1920x1080 ! DIES KANN ZU PROBLEMEN FÜHREN!" )
        end
        triggerServerEvent ( "regcheck", getLocalPlayer(),  getLocalPlayer() )


    end
)


-- // Login File
local filePath = ":grs_cache/"..getPlayerName(getLocalPlayer()).."_login.xml"
function intLoginFile ()
    local loginSettingsNode = xmlLoadFile ( filePath )
    if not loginSettingsNode then
        loginSettingsNode  = xmlCreateFile(filePath,"login")
        local passwordNode = xmlCreateChild(loginSettingsNode, "password")
        local autologinNode = xmlCreateChild(loginSettingsNode, "enableAutoLogin")
        xmlSaveFile(loginSettingsNode)
        xmlUnloadFile(loginSettingsNode)
    end
    loadLoginFile()
end


function loadLoginFile ()
    loginSettingsNode = xmlLoadFile ( filePath )
    local savedPassword =  xmlNodeGetValue(loginSettingsNode, "password")
    local enableAutologin =  xmlNodeGetValue(loginSettingsNode, "enableAutoLogin")
    xmlSaveFile(loginSettingsNode)
    xmlUnloadFile(loginSettingsNode)
end


function toggleAutoLogin (state)
    local loginSettingsNode = xmlLoadFile ( filePath )
    local autologinChild = xmlFindChild ( loginSettingsNode, "enableAutoLogin", 0 )
    if state == false then
        newInfobox ("Autologin deaktiviert.", 2)
        xmlNodeSetValue (  autologinChild, "0"  )
    else
        newInfobox ("Autologin aktiviert.", 2)
        xmlNodeSetValue (  autologinChild, "1"  )
    end
    xmlSaveFile(loginSettingsNode)
    xmlUnloadFile(loginSettingsNode)
end

function safePassword (password)
    local loginSettingsNode = xmlLoadFile ( filePath )
    local passwordChild = xmlFindChild ( loginSettingsNode, "password", 0 )
    if password == nil then
        xmlNodeSetValue (  passwordChild, ""  )
        newInfobox ("Passwort wird nicht mehr gespeichert.", 2)
    else
        xmlNodeSetValue (  passwordChild, password  )
        newInfobox ("Passwort wird gespeichert.", 2)
    end
    xmlSaveFile(loginSettingsNode)
    xmlUnloadFile(loginSettingsNode)
end

function getAutoLogin ()
    local loginSettingsNode = xmlLoadFile ( filePath )
    local autologinChild = xmlFindChild ( loginSettingsNode, "enableAutoLogin", 0 )
    local autologinValue =  xmlNodeGetValue ( autologinChild ) 
    if autologinValue == "1" then
        return true
    else
        return false
    end
    xmlSaveFile(loginSettingsNode)
    xmlUnloadFile(loginSettingsNode)
end

function getPassword ()
    local loginSettingsNode = xmlLoadFile ( filePath )
    local passwordChild = xmlFindChild ( loginSettingsNode, "password", 0 )
    local passwortValue =  xmlNodeGetValue ( passwordChild ) 
    if passwortValue ~= "" then
        return passwortValue
    else
        return false
    end
    xmlSaveFile(loginSettingsNode)
    xmlUnloadFile(loginSettingsNode)
end


