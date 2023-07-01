print("Login Windows geladen")

-- ICONS VON https://iconscout.com/
loginUI = {}


function showLoginWindow ()
    local loginIcon = dxCreateTexture("login/login.png")
    -- // Fenster
    loginUI["window"] = DGS:dgsCreateWindow(1115, -10, 331, 180, "Login", false)
    DGS:dgsCenterElement(loginUI["window"], false, true) 
    DGS:dgsWindowSetSizable(loginUI["window"], false)
    DGS:dgsWindowSetMovable(loginUI["window"], false)
    DGS:dgsSetProperty(loginUI["window"],"ignoreTitle", true)
    DGS:dgsWindowSetCloseButtonEnabled(loginUI["window"], false)
    DGS:dgsMoveTo( loginUI["window"],1115, 443,false,"OutQuad",5000)

    -- // Passwort eingabe
    loginUI["password"] = DGS:dgsCreateEdit(32, 28, 267, 30, "", false, loginUI["window"])
    DGS:dgsSetProperty(loginUI["password"],"allowCopy", false)
    DGS:dgsSetProperty(loginUI["password"],"masked", true)
    DGS:dgsSetProperty(loginUI["password"],"placeHolder","Passwort")
    DGS:dgsEditMoveCaret(loginUI["password"],35)
    DGS:dgsSetProperty(loginUI["password"],"padding",{30,2})
    DGS:dgsSetProperty(loginUI["password"],"placeHolderOffset",{ 6, 0 })
    DGS:dgsCreateImage(6, 5, 21, 20, "login/key.png", false, loginUI["password"] )
    -- // Checkboxen
    loginUI["enableSavingPassword"] = DGS:dgsCreateCheckBox(31, 62, 268, 29, " Passwort speichern ?", false, false,loginUI["window"])
    loginUI["enableAutomaticLogin"] = DGS:dgsCreateCheckBox(31, 91, 268, 29, " Automatisch einloggen ?", false, false, loginUI["window"])

    -- // Login-Button
    loginUI["login"] = DGS:dgsCreateButton(97, 126, 138, 29, "Einloggen", false, loginUI["window"])
    DGS:dgsSetProperty(loginUI["login"], "iconImage",{loginIcon, loginIcon, loginIcon})
    DGS:dgsSetProperty(loginUI["login"], "iconOffset",{-10, 1,false})
    DGS:dgsSetProperty(loginUI["login"], "color", {tocolor(14, 194, 17, 255), tocolor(11, 153, 13, 255), tocolor(14, 207, 17, 255)})
    DGS:dgsSetProperty(loginUI["login"], "wordBreak",true)

    -- // Passwort vergessen
    loginUI["forgotPasswordLabel"] = DGS:dgsCreateLabel(32, 157, 116, 17, "Passwort vergessen ?", false, loginUI["window"])    
    loginUI["forgotPasswordInfo"] = DGS:dgsCreateToolTip()
    DGS:dgsTooltipApplyTo(loginUI["forgotPasswordInfo"], loginUI["forgotPasswordLabel"],"Du kannst dein Passwort nur mit deinem Permanent Support Token zurücksetzen.")
    DGS:dgsSetProperty(loginUI["forgotPasswordLabel"],"textColor",tocolor(235, 180, 16,255))
    -- debug
    showCursor(true)
end
--showLoginWindow ()