infoboxes = {}
infoboxTypes = {
    ["success"] = {
        label = "EROLG",
        image = "images/infobox/success.png",
        color = {17, 168, 37},
        sound = 31,
    },
    ["info"] = {
        label = "HINWEIS",
        image = "images/infobox/info.png",
        color = {35, 170, 232 },
        sound = 31,
    },
    ["warning"] = {
        label = "WARNUNG",
        image = "images/infobox/warning.png",
        color = {235, 189, 52},
        sound = 31,
    },
    ["error"] = {
        label = "FEHLER",
        image = "images/infobox/error.png",
        color = {232, 35, 45},
        sound = 31
    },
}

-- // Abwärtskompatibel
infoboxTypesOld = {
    [1] = "info",
    [2] = "warning",
    [3] = "error",
    [4] = "success"
}

infoboxesInSession = 0
infoboxesInQueue = 0
addYperWaiters = 70
local x, y = guiGetScreenSize()
--local sx, sy = x/2560, y/1440
local sx, sy = x/2560, y/1080
local FrontSize = sy*1.5 


function newInfobox (text, type)
    infobox (text, infoboxTypesOld[type], 15)
end

function infobox (text, type, showTimeInSec)

    infoboxID = #infoboxes + 1
    infoboxesInSession = (infoboxesInSession + 1)
    infoboxesInQueue = (infoboxesInQueue + 1)
    if not showTimeInSec then
        showTimeInSec = 10000
    else
        showTimeInSec = (showTimeInSec*1000)
    end
    
    infoboxes[infoboxID] = {
        text = text,
        type = type,
        timer = setTimer ( finishInfobox, showTimeInSec, 1, infoboxID ),
        queuePlace = infoboxesInQueue,
        enable = true,
        animationProgress = 0,
    }
    playSoundFrontEnd(32)

    return infoboxID
end
addEvent("infobox", true)
addEventHandler("infobox", getRootElement(), infobox)

function renderInfobox ()
    for i, var in ipairs(infoboxes) do 
        if infoboxes[i].enable == true then
            local type = infoboxes[i].type
            if not infoboxTypes[type] then
                type = "info"
            end
            if inNoDMZone == true  and  hud ~= "on"  then
                dmZonePlus = -210
            elseif hud ~= "on" then
                dmZonePlus = -270
            elseif inNoDMZone == true  then
                dmZonePlus = 69
            else
                dmZonePlus = 0
            end
            local addValue = (infoboxes[i].queuePlace*addYperWaiters) - addYperWaiters + dmZonePlus

            if infoboxes[i].animationProgress < 1 then
                infoboxes[i].animationProgress = infoboxes[i].animationProgress + 0.02
                if infoboxes[i].animationProgress == 1 then
                    playSoundFrontEnd(32)
                end
            end
            local image = infoboxTypes[type].image
            local labeln = infoboxTypes[type].label
            local r,g,b = infoboxTypes[type].color[1], infoboxTypes[type].color[2], infoboxTypes[type].color[3] 
            dxDrawRectangle(2132/infoboxes[i].animationProgress*sx, 286+(addValue)*sy, 418*sx, 52*sy, tocolor(1, 0, 0, 120), false)
            dxDrawRectangle(2132/infoboxes[i].animationProgress*sx, 286+(addValue)*sy, 10*sx, 52*sy, tocolor(r, g, b, 255), false)
            dxDrawImage(2152/infoboxes[i].animationProgress*sx, 296+(addValue)*sy, 32*sx, 32*sy, image, 0, 0, 0, tocolor(255, 255, 255, 255), false)
            dxDrawText(labeln, 2194/infoboxes[i].animationProgress*sx, 292+(addValue)*sy, 2346*sx, 310*sy, tocolor(255, 255, 255, 255), 1.10, "default-bold", "left", "top", false, false, false, false, false)
            dxDrawText(infoboxes[i].text, 2195/infoboxes[i].animationProgress*sx, 311+(addValue)*sy, 2489*sx, 328*sy, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, false, false, false)
        end
    end
end
addEventHandler("onClientRender", root, renderInfobox)




function finishInfobox (infoboxID)
    infoboxes[infoboxID].enable = false
    infoboxesInQueue = infoboxesInQueue - 1

    for i, var in ipairs(infoboxes) do 
        if infoboxes[i].enable == true then
            infoboxes[i].queuePlace = (infoboxes[i].queuePlace - 1)
        end
    end
    table.remove(infoboxes[infoboxID] )
end

function testInfobox ()
    infobox("Du hast 100.00 $ auf deinem Bankkonto", "info", 10)
    infobox("Du bist nicht befugt.", "error", 10)
    infobox("Dein Bankkonto ist voll.", "warning", 10)
    infobox("Du hast Geld überwiesen.", "success", 10)
end
-- testInfobox ()


function infobox_start_func ( text, timetoshow, r, g, b, type )
	-- // Abärtskompatibilität
   -- print (text, timetoshow, r, g, b, type)
    if not type then
        type = "info"
    end
    infobox (text, type, timetoshow)
end
addEvent ( "infobox_start", true )
addEventHandler ( "infobox_start", getRootElement(), infobox_start_func )
