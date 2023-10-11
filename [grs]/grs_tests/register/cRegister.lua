function intRegister ()

    showRegisterUI ()
    showCursor(true)

    -- // Kamera setzen
    fadeCamera(true)
    intCam ()

end
addEvent ( "intRegister", true )
addEventHandler ( "intRegister", getRootElement(), intRegister )

--intRegister ()



-- Überprüft ob der Geburtstag gültig ist.
function isBirthdayValid(tag, monat, jahr)
    tag = tonumber(tag)
    monat = tonumber(monat)
    jahr = tonumber(jahr)

    if not (tag and monat and jahr) then
        return false
    end

    if monat < 1 or monat > 12 then
        return false
    end

    local aktuellesJahr = tonumber(os.date("%Y")) -- Aktuelles Jahr ermitteln

    if jahr < 1920 or jahr > aktuellesJahr then
        return false
    end

    local schaltjahr = false
    if (jahr % 4 == 0 and jahr % 100 ~= 0) or (jahr % 400 == 0) then
        schaltjahr = true
    end

    local tageImMonat = {
        31, (schaltjahr and 29 or 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
    }

    if tag < 1 or tag > tageImMonat[monat] then
        return false
    end

    return true
end

-- // Sicherheit des Passwords berechnen.
function calculateSafety(password)
    local reasons = {}
    local safety = 0

    local function checkCondition(condition, reason)
        if not condition then
            table.insert(reasons, reason)
        else
            safety = safety + 25
        end
    end

    local hasNumber = password:match('%d')
    local hasUppercase = password:match('%u')
    local hasSpecialChar = password:match('[!@#$%^&*()]')
    local numCount = select(2, password:gsub('%d', ''))
    local length = #password

    checkCondition(hasNumber and numCount >= 2, "Passwort braucht 2 Nummern.")
    checkCondition(hasUppercase, "Passwort braucht einen Großbuchstaben.")
    checkCondition(hasSpecialChar, "Passwort hat kein Sonderzeichen.")
    checkCondition(length >= 8 and length <= 12, "Passwort muss 8-12 Zeichen haben.")

    return safety, reasons
end

-- // Gibt gewisse Farbcodes wieder, falls man so und so viel "Sicherheit" (siehe oben) hat
function getColorCode(safety)
    if safety >= 100 then
        return 60, 181, 13 -- Grün
    elseif safety >= 75 then
        return 214, 214, 21 -- Gelb
    elseif safety >= 50 then
        return 181, 93, 16 -- Orange
    elseif safety >= 25 then
        return 181, 27, 16 -- Rot
    else
        return 0, 0, 255 -- Blau
    end
end

-- // Überprüft ob es eine richtige E-Mail ist
function isValidEmail(email)
    -- Überprüfen, ob die E-Mail-Adresse das @-Zeichen enthält
    if not email:match("@") then
        return false
    end

    local localPart, domainPart = email:match("([^@]+)@(.+)")

    if not localPart or not domainPart then
        return false
    end

    if not domainPart:match("%.") then
        return false
    end

    return true
end

