registerUI = {}
local loginMusicURL = "https://vgmsite.com/soundtracks/sim-city/vifjdqfbbz/01%20-%20SimCity%20Theme.mp3"


function showRegisterUI ()
        registerMusic = playSound(loginMusicURL, true, false) 
        setSoundVolume(registerMusic, 0.5)
        registerUI["window"]  = DGS:dgsCreateWindow(0.44, 0.37, 0.12, 0.27, "", true)
        DGS:dgsCenterElement(registerUI["window"], false, true) 
        DGS:dgsWindowSetSizable(registerUI["window"], false)
        DGS:dgsWindowSetMovable(registerUI["window"], false)
        showChat(false)
        showCursor(true)
        DGS:dgsSetInputEnabled ( true )
        DGS:dgsSetInputMode( "no_binds_when_editing" )
        DGS:dgsWindowSetCloseButtonEnabled(registerUI["window"], false)
        registerUI["musicNotice"] = DGS:dgsCreateLabel(0.46, 0.64, 0.08, 0.01, "\"L\" zum ein-/ausschalten der Musik", true)   
        DGS:dgsSetProperty(registerUI["musicNotice"],"textColor",tocolor(36, 166, 10))
        addEventHandler("onDgsWindowClose", registerUI["window"], function() 
            destroyElement(registerUI["musicNotice"])
        end)
        registerUI["tabpanel"] = DGS:dgsCreateTabPanel(0.03, 0.04, 0.94, 0.85, true, registerUI["window"])

        registerUI["tabpanel_account"] = DGS:dgsCreateTab("Account", registerUI["tabpanel"])
        -- // Account
        registerUI["tabpanel_account_scrollpanel"] = DGS:dgsCreateScrollPane(0.03, 0.04, 0.93, 0.91, true, registerUI["tabpanel_account"])
        -- // Benutzername
        registerUI["usernameTitle"] = DGS:dgsCreateLabel(0.02, 0.02, 0.94, 0.10, "Benutzername", true, registerUI["tabpanel_account_scrollpanel"])
        DGS:dgsLabelSetVerticalAlign(registerUI["usernameTitle"], "center")
        registerUI["username"] = DGS:dgsCreateEdit(0.02, 0.17, 0.64, 0.11, "Benutzname", true, registerUI["tabpanel_account_scrollpanel"])
        DGS:dgsSetText(registerUI["username"], getPlayerName(getLocalPlayer()))
        DGS:dgsSetProperty(registerUI["username"],"readOnly",true)

        addEventHandler("onDgsMouseDoubleClick", registerUI["username"] ,function(button, state)
            if button == "left" and state == "down" then
              local isReadOnly =  DGS:dgsGetProperty(registerUI["username"],"readOnly")
              if isReadOnly == true then
                DGS:dgsSetProperty(registerUI["username"],"readOnly",false)
              else
                DGS:dgsSetProperty(registerUI["username"],"readOnly", true)
                DGS:dgsSetText(registerUI["username"], getPlayerName(getLocalPlayer()))
              end
            end
        end)

        -- // Passwort
        registerUI["passwordTitle"] = DGS:dgsCreateLabel(0.02, 0.34, 0.21, 0.10, "Passwort", true, registerUI["tabpanel_account_scrollpanel"])
        DGS:dgsLabelSetVerticalAlign(registerUI["passwordTitle"], "center")
        registerUI["password"] = DGS:dgsCreateEdit(0.02, 0.48, 0.41, 0.11, "", true, registerUI["tabpanel_account_scrollpanel"])
        DGS:dgsSetProperty(registerUI["password"],"allowCopy", false)
        DGS:dgsSetProperty(registerUI["password"],"masked", true)
        DGS:dgsSetProperty(registerUI["password"],"placeHolder","Passwort")
        registerUI["passwordRepeat"] = DGS:dgsCreateEdit(0.02, 0.64, 0.41, 0.11, "", true, registerUI["tabpanel_account_scrollpanel"])
        DGS:dgsSetProperty(registerUI["passwordRepeat"],"allowCopy", false)
        DGS:dgsSetProperty(registerUI["passwordRepeat"],"masked", true)
        DGS:dgsSetProperty(registerUI["passwordRepeat"],"placeHolder","Passwort Wdh.")

        registerUI["passwordToggleMask"] = DGS:dgsCreateImage(0.27, 0.34, 0.07, 0.10, "images/register/eye.png", true, registerUI["tabpanel_account_scrollpanel"])
        registerUI["passwordToggleMaskTooltip"] = DGS:dgsCreateToolTip()
        DGS:dgsTooltipApplyTo(registerUI["passwordToggleMaskTooltip"], registerUI["passwordToggleMask"],"Zum Anzeigen/Verbergen des Passworts hier klicken")
        
        registerUI["passwordSafety"] = DGS:dgsCreateProgressBar(0.02, 0.80, 0.97, 0.14, true, registerUI["tabpanel_account_scrollpanel"])

        registerUI["passwordSafetyText"] = DGS:dgsCreateLabel(0.39, 0.23, 0.22, 0.54, "0 / 100", true, registerUI["passwordSafety"])
        DGS:dgsSetProperty(registerUI["passwordSafetyText"], "textColor",tocolor(0, 0, 0))

        registerUI["passwordInfo"] = DGS:dgsCreateLabel(0.48, 0.48, 0.52, 0.27, "- 8 Zeichen\n- Zwei Nummern\n- Ein Sonderzeichen\n- Ein Großbuchtabe\n", true, registerUI["tabpanel_account_scrollpanel"])
        DGS:dgsSetSize(registerUI["passwordInfo"], 0.6)
        DGS:dgsSetProperty(registerUI["passwordInfo"],"textSize",{0.85,0.85})

        addEventHandler("onDgsMouseClick", registerUI["passwordToggleMask"] ,function(button, state)
            if button == "left" and state == "down" then
                if source == registerUI["passwordToggleMask"] then
                    local isMasked = DGS:dgsGetProperty(registerUI["password"], "masked")
                    if isMasked then
                        DGS:dgsSetProperty(registerUI["password"],"masked", false)
                        DGS:dgsSetProperty(registerUI["passwordRepeat"],"masked", false)
                        DGS:dgsImageSetImage ( registerUI["passwordToggleMask"], "images/register/eye-off.png" )
                    else
                        DGS:dgsSetProperty(registerUI["password"],"masked", true)
                        DGS:dgsSetProperty(registerUI["passwordRepeat"],"masked", true)
                        DGS:dgsImageSetImage ( registerUI["passwordToggleMask"], "images/register/eye.png" )

                    end
                end
            end
        end)

        local function progressAnimation (targetProgress)
            local currentProgress =  DGS:dgsGetProperty(registerUI["passwordSafety"],"progress")
            local currentProgress =  DGS:dgsGetProperty(registerUI["passwordSafety"],"progress")
            addEventHandler ( "onClientRender", root, function()
                if currentProgress < targetProgress then 
                    currentProgress = currentProgress + 1
                    DGS:dgsSetProperty(registerUI["passwordSafety"],"progress",currentProgress)
                elseif currentProgress > targetProgress then
                    currentProgress = currentProgress - 1
                    DGS:dgsSetProperty(registerUI["passwordSafety"],"progress",currentProgress)
                else
                    cancelEvent()
                end
            end)
        end

        addEventHandler("onDgsTextChange", registerUI["password"], function() 
            local text = DGS:dgsGetText(source)
            local safety, reasons = calculateSafety(text)
            local r, g, b = getColorCode(safety)
         --   for _, reason in ipairs(reasons) do
          --      print("-", reason)    
          --  end
            progressAnimation (safety)
            DGS:dgsSetProperty(registerUI["passwordSafety"],"indicatorColor",tocolor(r, g, b))
           


            DGS:dgsSetText(registerUI["passwordSafetyText"], safety.." / 100")
           
        end)

        -- // Daten
        registerUI["tabpanel_data"] = DGS:dgsCreateTab("Daten", registerUI["tabpanel"])

        registerUI["tabpanel_data_scrollpanel"] = DGS:dgsCreateScrollPane(0.03, 0.04, 0.93, 0.91, true, registerUI["tabpanel_data"])

        -- // E-Mail
        registerUI["emailTitle"] = DGS:dgsCreateLabel(0.02, 0.02, 0.94, 0.10, "E-Mail-Adresse", true, registerUI["tabpanel_data_scrollpanel"])
        DGS:dgsLabelSetHorizontalAlign(registerUI["emailTitle"], "center", false)
        DGS:dgsLabelSetVerticalAlign(registerUI["emailTitle"], "center")
        registerUI["email"] = DGS:dgsCreateEdit(0.02, 0.17, 0.61, 0.11, "", true, registerUI["tabpanel_data_scrollpanel"])
        DGS:dgsSetProperty(registerUI["email"],"allowCopy", false)
        DGS:dgsSetProperty(registerUI["email"],"placeHolder","E-Mail-Adresse")
        registerUI["emailRepeat"] = DGS:dgsCreateEdit(0.02, 0.33, 0.61, 0.11, "", true, registerUI["tabpanel_data_scrollpanel"])
        DGS:dgsSetProperty(registerUI["emailRepeat"],"allowCopy", false)
        DGS:dgsSetProperty(registerUI["emailRepeat"],"placeHolder","E-Mail-Adresse Wdh.")
        registerUI["birthdayTitle"] = DGS:dgsCreateLabel(0.02, 0.49, 0.94, 0.10, "Geburtsdatum (tt/mm/jjjj)", true, registerUI["tabpanel_data_scrollpanel"])
        DGS:dgsLabelSetHorizontalAlign(registerUI["birthdayTitle"], "center", false)
        DGS:dgsLabelSetVerticalAlign(registerUI["birthdayTitle"], "center")
        registerUI["birthdayDay"] = DGS:dgsCreateEdit(0.02, 0.62, 0.23, 0.14, "", true, registerUI["tabpanel_data_scrollpanel"])
        registerUI["birthdayMonth"] = DGS:dgsCreateEdit(0.29, 0.62, 0.23, 0.14, "", true, registerUI["tabpanel_data_scrollpanel"])
        registerUI["birthdayYear"] = DGS:dgsCreateEdit(0.56, 0.62, 0.23, 0.14, "", true, registerUI["tabpanel_data_scrollpanel"])
        DGS:dgsSetProperty(registerUI["birthdayDay"],"maxLength",2)
        DGS:dgsSetProperty(registerUI["birthdayDay"],"placeHolder","Tag")
        DGS:dgsSetProperty(registerUI["birthdayMonth"],"maxLength",2)
        DGS:dgsSetProperty(registerUI["birthdayMonth"],"placeHolder","Monat")
        DGS:dgsSetProperty(registerUI["birthdayYear"],"maxLength",4)
        DGS:dgsSetProperty(registerUI["birthdayYear"],"placeHolder","Jahr")

        -- // Geschlecht
        registerUI["gender"] = DGS:dgsCreateLabel(0.02, 0.80, 0.94, 0.10, "Geschlecht", true, registerUI["tabpanel_data_scrollpanel"])
        DGS:dgsLabelSetHorizontalAlign(registerUI["gender"], "center", false)
        DGS:dgsLabelSetVerticalAlign(registerUI["gender"], "center")
        registerUI["genderMale"] = DGS:dgsCreateRadioButton(0.02, 0.95, 0.27, 0.09, "Männlich", true, registerUI["tabpanel_data_scrollpanel"])
        registerUI["genderFemale"] = DGS:dgsCreateRadioButton(0.33, 0.95, 0.27, 0.09, "Weiblich", true, registerUI["tabpanel_data_scrollpanel"])
        registerUI["genderOther"] = DGS:dgsCreateRadioButton(0.64, 0.95, 0.27, 0.09, "Divers", true, registerUI["tabpanel_data_scrollpanel"])
        DGS:dgsRadioButtonSetSelected(registerUI["genderMale"], true)
        DGS:dgsSetProperty(registerUI["genderMale"],"textSize",{0.8,0.8})
        DGS:dgsSetProperty(registerUI["genderFemale"],"textSize",{0.8,0.8})
        DGS:dgsSetProperty(registerUI["genderOther"],"textSize",{0.8,0.8})

        registerUI["tabpanel_optional"]  = DGS:dgsCreateTab("Optional",registerUI["tabpanel"])

        registerUI["tabpanel_optional_scrollpanel"] = DGS:dgsCreateScrollPane(0.03, 0.04, 0.93, 0.91, true, registerUI["tabpanel_optional"])

        -- // Bonuscode
        registerUI["bonuscodeTitle"] = DGS:dgsCreateLabel(0.02, 0.02, 0.94, 0.10, "Bonuscode", true, registerUI["tabpanel_optional_scrollpanel"])
        DGS:dgsLabelSetHorizontalAlign(registerUI["bonuscodeTitle"], "center", false)
        DGS:dgsLabelSetVerticalAlign(registerUI["bonuscodeTitle"], "center")
        registerUI["bonuscode"] = DGS:dgsCreateEdit(0.02, 0.17, 0.46, 0.10, "", true, registerUI["tabpanel_optional_scrollpanel"])
        registerUI["bonuscodeInfo"] = DGS:dgsCreateLabel(0.02, 0.32, 0.94, 0.23, "Wenn du über einen Bonuscode verfügst, kannst du bei der Anmeldung lukrative Boni erhalten.", true, registerUI["tabpanel_optional_scrollpanel"])
        DGS:dgsLabelSetHorizontalAlign(registerUI["bonuscodeInfo"], "left", true)
        DGS:dgsSetProperty(registerUI["bonuscodeInfo"],"textSize",{0.8,0.8})
        DGS:dgsSetProperty(registerUI["passwordInfo"],"textSize",{0.8,0.8})
        DGS:dgsSetProperty(registerUI["bonuscode"],"placeHolder","Code")
        -- // Werber
        registerUI["advertiserTitle"] = DGS:dgsCreateLabel(0.02, 0.59, 0.94, 0.10, "Werber", true, registerUI["tabpanel_optional_scrollpanel"])
      --  DGS:dgsSetFont(registerUI["advertiserTitle"], "default-bold-small")
        DGS:dgsLabelSetHorizontalAlign(registerUI["advertiserTitle"], "center", false)
        DGS:dgsLabelSetVerticalAlign(registerUI["advertiserTitle"], "center")
        registerUI["advertiser"] = DGS:dgsCreateEdit(0.02, 0.74, 0.46, 0.10, "", true, registerUI["tabpanel_optional_scrollpanel"])
        registerUI["advertiserTitleInfo"] = DGS:dgsCreateLabel(0.01, 0.89, 0.94, 0.23, "Wenn du von einem Spieler über den Server erfahren hast, kannst du ihn hier angeben, um dir Boni zu verdienen.", true, registerUI["tabpanel_optional_scrollpanel"])
        DGS:dgsLabelSetHorizontalAlign(registerUI["advertiserTitleInfo"], "left", true)
        DGS:dgsSetProperty(registerUI["advertiserTitleInfo"],"textSize",{0.8,0.8})
        DGS:dgsSetProperty(registerUI["advertiser"],"placeHolder","Werber")

        -- // Account erstellen
        registerUI["tabpanel_create"] = DGS:dgsCreateTab("Erstellen", registerUI["tabpanel"])

        registerUI["infoCreation"] = DGS:dgsCreateLabel(0.03, 0.03, 0.93, 0.17, "Vergewissere dich, dass alle Daten korrekt ausgefüllt sind.", true, registerUI["tabpanel_create"])
        DGS:dgsLabelSetHorizontalAlign(registerUI["infoCreation"], "center", true)
        registerUI["acceptServerrules"] = DGS:dgsCreateCheckBox(0.03, 0.66, 0.90, 0.12, " Regeln gelesen & akzeptiert ?", false, true, registerUI["tabpanel_create"])    
        registerUI["dataCorrect"] = DGS:dgsCreateCheckBox(0.03, 0.53, 0.90, 0.12, " Alle Daten Korrekt?", false, true, registerUI["tabpanel_create"])    
        registerUI["error"] = DGS:dgsCreateMemo(0.03, 0.21, 0.93, 0.27, "", true, registerUI["tabpanel_create"] )
        DGS:dgsSetProperty(registerUI["error"],"readOnly",true)
        DGS:dgsSetProperty(registerUI["error"],"bgColor",tocolor(0, 0, 0, 0))
        DGS:dgsSetProperty(registerUI["error"],"textColor",tocolor(171, 12, 12))
        local registerIcon, rulesIcon = dxCreateTexture("images/register/enter.png"), dxCreateTexture("images/register/book.png")
        registerUI["registerButton"] = DGS:dgsCreateButton(0.03, 0.80, 0.44, 0.17, "Registrieren", true, registerUI["tabpanel_create"])
        
        DGS:dgsSetProperty(registerUI["registerButton"],"iconImage",{registerIcon,registerIcon,registerIcon})
        DGS:dgsSetProperty(registerUI["registerButton"],"iconAlignment",{"left","center"})
        DGS:dgsSetProperty(registerUI["registerButton"],"iconOffset",{0.02,0,true})
        DGS:dgsSetProperty(registerUI["registerButton"],"iconSize",{24,24,false})
        DGS:dgsSetProperty(registerUI["registerButton"],"iconRelative",false)
        DGS:dgsSetProperty(registerUI["registerButton"],"textOffset",{0.1,0,true})
        DGS:dgsSetProperty(registerUI["registerButton"],"color",{tocolor(21, 156, 11),tocolor(27, 199, 14),tocolor(16, 117, 8)})
        DGS:dgsSetProperty(registerUI["registerButton"],"colorTransitionPeriod",500)
        registerUI["seeRules"] = DGS:dgsCreateButton(0.53, 0.80, 0.44, 0.17, "Regeln\nansehen", true, registerUI["tabpanel_create"])
        
        DGS:dgsSetProperty(registerUI["seeRules"],"iconImage",{rulesIcon,rulesIcon,rulesIcon})
        DGS:dgsSetProperty(registerUI["seeRules"],"iconAlignment",{"left","center"})
        DGS:dgsSetProperty(registerUI["seeRules"],"iconOffset",{0.02,0,true})
        DGS:dgsSetProperty(registerUI["seeRules"],"iconSize",{24,24,false})
        DGS:dgsSetProperty(registerUI["seeRules"],"iconRelative",false)
        DGS:dgsSetProperty(registerUI["seeRules"],"textOffset",{0.1,0,true})
        DGS:dgsSetProperty(registerUI["seeRules"],"colorTransitionPeriod",500)
        DGS:dgsSetProperty(registerUI["seeRules"],"color",{tocolor(171, 123, 12),tocolor(214, 154, 15),tocolor(161, 116, 11)})
        addEventHandler ( "onDgsMouseClick", registerUI["registerButton"], registerPlayer  )
        bindKey ("enter","down", function()
            DGS:dgsSimulateClick( registerUI["registerButton"], "left")
        end, registerUI["registerButton"], "left" )
        bindKey ("l","down", toggleMusic)
end

function getGender()
    if DGS:dgsRadioButtonGetSelected(registerUI["genderFemale"]) == true then
        return 1
    elseif DGS:dgsRadioButtonGetSelected( registerUI["genderMale"]) == true then
        return 0
    elseif DGS:dgsRadioButtonGetSelected(registerUI["genderOther"]) == true then
        return math.random(0,1)
    end
end

function registerPlayer (button, state)
    if button == "left" and state == "up" and source == registerUI["registerButton"] then
        local pName = getPlayerName(getLocalPlayer())
        local name = DGS:dgsGetText(registerUI["username"])
        local newPlayerName = (name == pName) and false or name
        local text = DGS:dgsGetText(registerUI["password"])
        local safety, reasons = calculateSafety(text)
        local pwError = ""
        -- // Name ggf. ändernn.
        print("Neuer Name ?", newPlayerName)
        local password, passwordRepeat = DGS:dgsGetText(registerUI["passwordRepeat"]), DGS:dgsGetText(registerUI["password"])
        if password == passwordRepeat then
            if safety == 100 then
                local bDay, bMonth, bYear = DGS:dgsGetText( registerUI["birthdayDay"] ), DGS:dgsGetText( registerUI["birthdayMonth"] ), DGS:dgsGetText( registerUI["birthdayYear"] )
                if isBirthdayValid(bDay, bMonth, bYear) then
                    local email, emailRepeat = DGS:dgsGetText( registerUI["email"] ), DGS:dgsGetText( registerUI["emailRepeat"] )
                    if email == emailRepeat then
                        if isValidEmail(email) then
                            local acceptRules = DGS:dgsCheckBoxGetSelected(registerUI["acceptServerrules"])
                            if acceptRules == true then
                                local dataCorrect = DGS:dgsCheckBoxGetSelected(registerUI["dataCorrect"])
                                if dataCorrect == true then
                                    local bcode =  DGS:dgsGetText( registerUI["bonuscode"] )
                                    local advertiser = DGS:dgsGetText( registerUI["advertiser"] )
                                    local gender = getGender()
                                    triggerServerEvent ( "register", getLocalPlayer(),  getLocalPlayer(), hash ( "sha512", password ), bDay, bMonth, bYear, gender, bonuscode,email, advertiser)
                                else
                                    DGS:dgsSetText(registerUI["error"], "Gebe an ob die\nDaten richtig sind.")
                                end
                            else
                                DGS:dgsSetText(registerUI["error"], "Gebe an ob du die Regeln\ngelesen hast.")
                            end
                        else
                            DGS:dgsSetText(registerUI["error"], "Ungültige E-Mail")
                        end
                    else
                        DGS:dgsSetText(registerUI["error"], "E-Mails sind nicht gleich.")
                    end
                else
                    DGS:dgsSetText(registerUI["error"], "Geburtsdatum ungültig.")
                end
            else
                for _, reason in ipairs(reasons) do
                    local wordToAdd =  "- "..reason.."\n"
                    pwError = pwError .. " " .. wordToAdd
                end
                DGS:dgsSetText(registerUI["error"], tostring(pwError))
            end
        else
            DGS:dgsSetText(registerUI["error"], "Passwörter sind nicht gleich.")
        end
    end
end

function disableRegisterUI ()
    local close = DGS:dgsCloseWindow( registerUI["window"])
	if close then
        unbindKey ("enter","down", registerPlayer)
        unbindKey ("l","down", toggleMusic)
		showCursor(false)
	end

    -- // Musik stoppen
    setSoundPaused(registerMusic, true)
    destroyElement(registerMusic)
    -- // Kamera stoppen
    cancelCameraFlight()
end
addEvent ( "disableRegisterUI", true )
addEventHandler ( "disableRegisterUI", getRootElement(), disableRegisterUI )


function toggleMusic ()
    if isSoundPaused(registerMusic) then
        setSoundPaused(registerMusic, false)
        DGS:dgsSetProperty( registerUI["musicNotice"],"textColor",tocolor(36, 166, 10))
    else
        setSoundPaused(registerMusic, true)
        DGS:dgsSetProperty( registerUI["musicNotice"],"textColor",tocolor(171, 12, 12))
    end
end