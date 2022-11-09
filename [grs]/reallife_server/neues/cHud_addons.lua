-- ///////////////////////////
-- Andere Client-HUD Elemente
-- ///////////////////////////


-- // EP Boost
function renderEPBoost ()
    addEventHandler("onClientRender", root, epBoostUI)
end
addEvent("renderEPBoost", true)
addEventHandler("renderEPBoost", getRootElement(), renderEPBoost)

function epBoostUI ()
    if getSetting (21) == 1 then
        local x, y = guiGetScreenSize()
        local sx, sy = x/2560, y/1440 
        dxDrawRectangle(32*sx, 491*sy, 0*sx, 0*sy, tocolor(255, 255, 255, 255), false)
        dxDrawRectangle(1798*sx, 0*sy, 227*sx, 49*sy, tocolor(0, 0, 0, 192), false)
        dxDrawText("Du erhälst "..globalXPBoost.."x Erfahrungspunkte", 1826*sx, 24*sy, 2006*sx, 43*sy, tocolor(255, 255, 255, 255),  sy*1.0 , "default", "left", "top", false, false, false, false, false)
        dxDrawText("ERFAHRUNGS-BOOST", 1850*sx, 4*sy, 1983*sx, 24*sy, tocolor(4, 225, 14, 192), sy*1.10, "default-bold", "left", "top", false, false, false, false, false)
    end
end


-- Beta
function betaWarning ()
    if getSetting (22) == 1  then
        local x, y = guiGetScreenSize()
        local sx, sy = x/2560, y/1440
        local FrontSize = sy*2.0 
        dxDrawRectangle(895*sx, 0*sy, 773*sx, 38*sy, tocolor(3, 0, 0, 224), false)
        dxDrawText("GRS Beta Version "..curVersion.." - Bugs in Discord melden, Features nicht Final", 899*sx, 0*sy, 1662*sx, 38*sy, tocolor(255, 255, 255, 255), FrontSize, "default", "left", "top", false, false, false, false, false)
    end
end

function renderBetaWarningClient ()
    if getSetting (22) == 1  then
	    addEventHandler ( "onClientRender", root, betaWarning )
    end
end
addEvent ( "renderBetaWarning", true )
addEventHandler ( "renderBetaWarning", getRootElement(), renderBetaWarningClient )

-- // Animationstests
--[[
-- // Animationstest
targetProgress = 100 -- // Wohin soll es gehen
progress = 0 -- // Zwischenspeicher
w_calutlator =

addEventHandler("onClientRender", root,
    function()
        print(progress, targetProgress)
        -- animation
        if  tonumber(progress)  ~= tonumber(targetProgress) then
            progress = (progress + 1)
            w_calutlator = (739/100)*progress
        end
    --    if not w_calutlator then w_calutlator = 739 end
        -- Leer
        dxDrawImage(869, 446, 739, 45, ":reallife_server/images/gui/hunger_empty.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        -- Voll
        dxDrawImage(869, 446, w_calutlator, 45, ":reallife_server/images/gui/hunger_full.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
)


-- // Animationstest mit Damage
progress = 0
w_calutlator  =
addEventHandler("onClientRender", root,
    function()
        playerHealth = math.floor( getElementHealth ( localPlayer ))

        print(progress, playerHealth)
        -- animation
        if progress < playerHealth then
            progress = (progress + 1)
            w_calutlator = (739/100)*progress
        elseif progress > playerHealth then
            progress = (progress - 1)
            w_calutlator = (739/100)*progress
        end


        if not w_calutlator then w_calutlator = 739 end
        -- Leer
        dxDrawImage(869, 446, 739, 45, ":reallife_server/images/gui/hunger_empty.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        -- Voll
        dxDrawImage(869, 446, w_calutlator, 45, ":reallife_server/images/gui/hunger_full.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
)]]