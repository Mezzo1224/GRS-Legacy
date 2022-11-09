-- // 1.12 Notice: Box ist oft zu klein. Design hässlich. Nächster Ansatz: Mit Icons und größer.

infobox = {}
-- // Bestimmt die Farben des oberen Falkesns
infoboxTypes = { -- // Name, R,G,B, playSound Nummer
    [1] = { "Hinweis", 26, 49, 176, 32  }, -- Hinweis in Blau
    [2] = { "Hinweis", 217, 140, 17, 32 }, -- Hinweis in Orang
    [3] = { "Fehler", 168, 30, 15, 32 },
    [4] = { "Hinweis", 32, 105, 10, 32 }, -- // Hinweis aber in Grün
}

infoboxesInSession = 0
infoboxesInQueue = 0
addYperWaiters = 90
local x, y = guiGetScreenSize()
local sx, sy = x/2560, y/1440
local FrontSize = sy*1.5 
-- // Anmerkung:
-- // Leider wende ich (Mezzo) erst hier die bessere Methode für Tabellen an, weil ich es vorher immer vergessen hab


function newInfobox (msg, type, r, g, b, alpha, showTimeInSec, ownTypeText, tr, tg, tb, ownPlaysound)

    infoboxID = #infobox + 1
    infoboxesInSession = (infoboxesInSession + 1)
    infoboxesInQueue = (infoboxesInQueue + 1)
    if not ownTypeText then
        ownTypeText = nil
    end
    if not type then
        type = 1
    end
    if not tr or not tg or not tb then
        tr, tg, tb = infoboxTypes[type][2], infoboxTypes[type][3], infoboxTypes[type][4]
    else
        tr, tg, tb =  tr, tg, tb
    end
    if not showTimeInSec then
        showTimeInSec = 10000
    else
        showTimeInSec = (showTimeInSec*1000)
    end
    if not alpha then
        alpha = 200
    end
    if not r then
        r = 255
    end
    if not g then
        g = 255
    end
    if not b then
        b = 255
    end
    
    infobox[infoboxID] = {
        msg = msg,
        r = r,
        g = g,
        b = b,
        alpha = alpha,
        type = type,
        timer = setTimer ( finishInfobox, showTimeInSec, 1, infoboxID ),
        queuePlace = infoboxesInQueue,
        ownTypeText = ownTypeText,
        tr = tr,
        tg = tg,
        tb = tb,
        enable = true
    }
    if not ownPlaysound then 
        playSoundFrontEnd(infoboxTypes[type][5])
    else
        playSoundFrontEnd(ownPlaysound)
    end

    return infoboxID
end
addEvent("newInfobox", true)
addEventHandler("newInfobox", getRootElement(), newInfobox)

function renderInfobox ()
    for i, var in ipairs(infobox) do 
        if infobox[i].enable == true then
            local type = infobox[i].type
            if inNoDMZone == true  and  hud ~= "on"  then
                dmZonePlus = -300
            elseif hud ~= "on" then
                dmZonePlus = -350
            elseif inNoDMZone == true  then
                dmZonePlus = 50
            else
                dmZonePlus = 0
            end
            local tr, tg, tb = infobox[i].tr, infobox[i].tg, infobox[i].tb
            local r, g, b = infobox[i].r, infobox[i].g, infobox[i].b
            local addValue = (infobox[i].queuePlace*addYperWaiters)
            -- Eigener Type oder ein vorgefertigter ?
            if not infobox[i].ownTypeText then
                typeText = infoboxTypes[type][1]
            else
                typeText = infobox[i].ownTypeText
            end

            dxDrawRectangle(2130*sx, (dmZonePlus+304+(addValue))*sy, 420*sx, 74*sy, tocolor(0, 0, 0, 146), false)
            dxDrawRectangle(2130*sx, (dmZonePlus+304+(addValue))*sy, 420*sx, 21*sy, tocolor(tr, tg, tb, 252), false)
            -- // Text = 3 Zeilen maximal
            dxDrawText(infobox[i].msg, 2134*sx, (dmZonePlus+327+(addValue))*sy, 2540*sx, 458*sy, tocolor(r, g, b, 255), FrontSize, "default", "left", "top", false, false, false, false, false)
            dxDrawText(typeText, 2317*sx, (dmZonePlus+306+(addValue))*sy, 2359*sx, 397*sy, tocolor(254, 254, 254, 255), FrontSize, "default", "left", "top", false, false, true, false, false)
        end
    end
end
addEventHandler("onClientRender", root, renderInfobox)




function finishInfobox (infoboxID)
    infobox[infoboxID].enable = false
    infoboxesInQueue = infoboxesInQueue - 1

    for i, var in ipairs(infobox) do 
        if infobox[i].enable == true then
            infobox[i].queuePlace = (infobox[i].queuePlace - 1)
        end
    end
    --infobox[infoboxID] = nil
    table.remove(infobox[infoboxID] )
end

function setInfoboxTime (infoboxID, newTime )
    if tonumber(infoboxID) and tonumber(newTime) then
        if infobox[infoboxID] then
            local newTime = (newTime*1000)
            killTimer(infobox[infoboxID].timer)
            infobox[infoboxID].timer =  setTimer ( finishInfobox, newTime, 1, infoboxID )
            print(infobox[infoboxID].msg)
            print(newTime.." Neue Zeit")
        end
    end
end


function testInfobox ()

   local infobox_Hello = newInfobox("Hallo was geht", 1)
   print(infobox_Hello.." Id")
   setInfoboxTime(infobox_Hello, 60)
end
--testInfobox ()
