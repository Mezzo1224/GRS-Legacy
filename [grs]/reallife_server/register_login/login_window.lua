

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
 --   background = DGS:dgsCreateImage (0, 0, x, y, ":reallife_server/images/header.jpg", false)    
    headerImage = DGS:dgsCreateImage (955*sx, -10*sy, 651*sx, 206*sy, ":reallife_server/images/header.jpg", false)    
    DGS:dgsMoveTo( headerImage,955*sx, 377*sy,false,false,"OutQuad",4000)
    loginWindow["window"] = DGS:dgsCreateWindow(1115*sx, -10*sy, 330*sx, 258*sy, "Login", false)
    DGS:dgsMoveTo( loginWindow["window"],1115*sx, 593*sy,false,false,"OutQuad",5000)
    DGS:dgsWindowSetSizable(loginWindow["window"],false)
    DGS:dgsWindowSetMovable(loginWindow["window"],false)
    DGS:dgsWindowSetCloseButtonEnabled(loginWindow["window"], false)
    loginWindow["password"] = DGS:dgsCreateEdit(70*sx, 24*sy, 191*sx, 35*sy, "", false, loginWindow["window"])
    DGS:dgsSetProperty(loginWindow["password"],"placeHolder","Passwort")
    DGS:dgsSetProperty(loginWindow["password"],"masked",true)
    loginWindow["savePassword"] = DGS:dgsCreateCheckBox(11*sx, 70*sy, 250*sx, 35*sy, "Passwort speichern ?", false, false, loginWindow["window"])
    loginWindow["autologin"] = DGS:dgsCreateCheckBox(11*sx, 115*sy, 250*sx, 35*sy, "Autologin de-/aktivieren", false, false, loginWindow["window"])
    loginWindow["loginBtn"] = DGS:dgsCreateButton(76*sx, 159*sy, 185*sx, 36*sy, "Einloggen", false, loginWindow["window"])
    loginWindow["resetpw"] = DGS:dgsCreateLabel(10*sx, 205*sy, 179*sx, 18*sy, "P̲a̲s̲s̲w̲o̲r̲t̲ ̲v̲e̲r̲g̲e̲s̲s̲e̲n̲ ̲?̲", false, loginWindow["window"])  
    DGS:dgsSetProperty(loginWindow["resetpw"],"textColor",tocolor(235, 180, 16,255))
    DGS:dgsSetProperty(loginWindow["loginBtn"],"color",{tocolor(12, 133, 44,255),tocolor(15, 150, 51,255),tocolor(12, 133, 44,255)})
    DGS:dgsSetProperty(loginWindow["loginBtn"],"wordbreak",true)
    bindKey ( "enter", "down", loginPlayer )
    checkForPassword ()
    addEventHandler ( "onDgsCheckBoxChange",loginWindow["savePassword"], 
    function(state)

        local savingPW, enableAutologin = DGS:dgsCheckBoxGetSelected(loginWindow["savePassword"]), DGS:dgsCheckBoxGetSelected(loginWindow["autologin"])
        if state == true then
            DGS:dgsSetEnabled(loginWindow["autologin"], true)
        else
            DGS:dgsCheckBoxSetSelected(loginWindow["autologin"], false)
            DGS:dgsSetEnabled(loginWindow["autologin"], false)
        end
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

    -- // Autologin
    autoLoginCheck ()
    if autoLogin == 1 then

        DGS:dgsCheckBoxSetSelected(loginWindow["autologin"], true)
        -- // Timer ist für Debug
        setTimer ( function()
            loginPlayer ()
        end, 5000, 1 )
       
    end
end



function destroyLoginwindow ()
    local savingPW, enableAutologin = DGS:dgsCheckBoxGetSelected(loginWindow["savePassword"]), DGS:dgsCheckBoxGetSelected(loginWindow["autologin"])
    login_toggleAutoLogin(enableAutologin)
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
  --  findSettings () -- // Einstellungen laden
    loadClientSettings ()
    -- // Update ?
    checkNewUpdate ()
end

function loginPlayer ()
	local passwort = DGS:dgsGetText( loginWindow["password"] )
	triggerServerEvent ( "einloggen", lp, lp, hash ( "sha512", passwort ))
    local savingPW = DGS:dgsCheckBoxGetSelected(loginWindow["savePassword"])
	local file = xmlLoadFile ( ":grs_cache/pw.xml" )
	if savingPW == true then
		local psafe = xmlFindChild ( file, "pw", 0 )
		xmlNodeSetValue ( psafe, passwort  )
		xmlSaveFile ( file )
    else
		local psafe = xmlFindChild ( file, "pw", 0 )
		xmlNodeSetValue ( psafe, nil  )
		xmlSaveFile ( file )
	end
end


function checkForPassword ()
    local pwfile = xmlLoadFile ( ":grs_cache/pw.xml" )
    if not pwfile then
        pwfile = xmlCreateFile ( ":grs_cache/pw.xml", "PW" )
        xmlSaveFile ( pwfile )
        pwfile = xmlLoadFile ( ":grs_cache/pw.xml" )

        psafe = xmlCreateChild ( pwfile, "pw" )
        xmlSaveFile ( pwfile )
    else
        local psafe = xmlFindChild ( pwfile, "pw", 0 )
        success = xmlNodeGetValue ( psafe )
        DGS:dgsSetText(loginWindow["password"], success)
        DGS:dgsCheckBoxSetSelected(loginWindow["savePassword"], true)
    end
end


function login_toggleAutoLogin (state)
	-- // Lädt die Passwort Datei
    if state == false then
        if fileExists(":grs_cache/autologin.txt") then
            local deleteFile = fileDelete(":grs_cache/autologin.txt")
            if deleteFile then
                outputChatBox ( "Autologin deaktiviert.", 224, 13, 13 )
                autoLogin = 0
                fileClose(deleteFile)
            else
                outputChatBox ( "Versuche es später erneut.", 224, 13, 13 )
            end
        end
    elseif state == true then
        local createFile = fileCreate(":grs_cache/autologin.txt")
        if createFile then
            outputChatBox ( "Autologin aktiviert.", 224, 13, 13 )
            autoLogin = 1
            fileClose(createFile)
        else
            outputChatBox ( "Versuche es später erneut.", 224, 13, 13 )
        end
	end
end

  

-- // Passwort zurücksetzten
function showResetPasswordWindow ()    
    pwResetWindow["window"] = DGS:dgsCreateWindow(1137*sx, 569*sy, 286*sx, 303*sy, "Passwort zurücksetzen", false)
    DGS:dgsWindowSetSizable(pwResetWindow["window"],false)
    DGS:dgsWindowSetMovable(pwResetWindow["window"],false)
  --  pwResetWindow["helptext"] = DGS:dgsCreateMemo(11, 5, 265, 110, "Um dein Passwort zurückzusetzen musst du deinen Permanenten-Supporttoken angeben und dein neues Passwort, danach wird das Passwort geändert, aber auch ein neuer Token generiert.", false, pwResetWindow["window"])
    pwResetWindow["helptext"] = DGS:dgsCreateLabel(11*sx, 5*sy, 265*sx, 110*sy, "Um dein Passwort zurückzusetzen musst du deinen Permanenten-Supporttoken angeben und dein neues Passwort, danach wird das Passwort geändert, aber auch ein neuer Token generiert.", false, pwResetWindow["window"])
    DGS:dgsSetProperty(pwResetWindow["helptext"],"wordbreak",true)
    pwResetWindow["token"] = DGS:dgsCreateEdit(11*sx, 125*sy, 159*sx, 37*sy, "", false, pwResetWindow["window"])
    pwResetWindow["newpw"] = DGS:dgsCreateEdit(11*sx, 172*sy, 128*sx, 37*sy, "", false, pwResetWindow["window"])
    pwResetWindow["newpw_repeat"] = DGS:dgsCreateEdit(148*sx, 172*sy, 128*sx, 37*sy, "", false, pwResetWindow["window"])
    pwResetWindow["resetpwBtn"] = DGS:dgsCreateButton(76*sx, 235*sy, 134*sx, 38*sy, "Zurücksetzen", false, pwResetWindow["window"])    
    
    DGS:dgsSetProperty(pwResetWindow["token"],"placeHolder","Token")
    DGS:dgsSetProperty(pwResetWindow["newpw"],"placeHolder","Neues PW")
    DGS:dgsSetProperty(pwResetWindow["newpw_repeat"],"placeHolder","Neues PW Wdh.")

    addEventHandler ( "onDgsMouseClickDown", pwResetWindow["resetpwBtn"], 
        function(button, state, x, y)
        if source == pwResetWindow["resetpwBtn"] then
            print("Reset PW Click")
            local pw, pw2 = DGS:dgsGetText(pwResetWindow["newpw"]), DGS:dgsGetText(pwResetWindow["newpw_repeat"])
            local token = DGS:dgsGetText(pwResetWindow["token"])
            triggerServerEvent ( "resetPasswordFromLogin", lp, lp, token, pw, pw2)
        end
    end)

    addEventHandler( "onDgsWindowClose", pwResetWindow["window"], 
    function()
        createLoginWindow ()
    end)
end

-- // Events
addEvent ( "DisableLoginWindow", true )
addEventHandler ( "DisableLoginWindow", getRootElement(), destroyLoginwindow)
addEvent ( "ShowLoginWindow", true)
addEventHandler ( "ShowLoginWindow", getRootElement(), createLoginWindow)


-- // Check
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
    function ()
        local player = getLocalPlayer()
        for i = 1, 100 do
            outputChatBox (" ")
        end
        findSettings ()
        if ( x < 1920 ) and ( y < 1080 ) then 
            outputChatBox ( "WARNUNG: DEINE AUFLÖSUNG IST UNTER 1920x1080 ! DIES KANN ZU PROBLEMEN FÜHREN!" )
        end
        triggerServerEvent ( "regcheck", getLocalPlayer(), player )
    end
)