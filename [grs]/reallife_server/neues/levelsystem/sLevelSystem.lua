
boosterXP = {}

function checkPlayerLevelUP (player)
   print("Funtion deaktiviert")
end
addEvent("checkPlayerLevelUP", true)
addEventHandler("checkPlayerLevelUP", getRootElement(), checkPlayerLevelUP)


function goPrestige ()
	local player = client
    local level	= tonumber(vioGetElementData ( player, "MainLevel" ))
	local pLevel = vioGetElementData ( player, "pLevel")
	if level == maxlevel then
		vioSetElementData ( player, "pLevel", pLevel + 1 )
		vioSetElementData ( player, "MainXP", 0 )
		vioSetElementData ( player, "MainLevel", 1 )
		return true
	else
		return false
	end
end
addEvent("goPrestige", true)
addEventHandler("goPrestige", getRootElement(), goPrestige)





function addPlayerXP ( player, xp)
    local level = tonumber(vioGetElementData ( player, "MainLevel" ))
    local xp = ServerConfig["main"].calculateBonus(player, xp)
    outputChatBox (xp.." bekommst du." )
    -- // XP wird nur gegeben wenn der Spieler unter dem Max. Level ist, sonst Geld. (2 zu 1 Kurs)
    if tonumber(maxLevel) ~= level then
        vioSetElementData ( player, "MainXP", tonumber(xp) + vioGetElementData ( player, "MainXP" ) )
        newInfobox (player, "Du hast "..xp.." Erfahrungspunkte erhalten.", 4, nil, nil, nil, nil, 5)
    else
        local paket = vioGetElementData ( player, "Paket" )
        local xpToMoney = math.floor(xp / xpToMoneyRate[paket]) 
        newInfobox (player, "Du hast das maximal Level erreicht.\nDeine erhaltenen EP wurden in "..xpToMoney.."$ umgerechnet", 4, nil, nil, nil, nil, 5)
        vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + xpToMoney )
    end


    --// Levelup ?
    local levelProgress = calculateLevelProgress( player )
    if tonumber(levelProgress) >= 1 then
        if tonumber(maxLevel) ~= level then
            vioSetElementData ( player, "MainXP", 0)
            vioSetElementData ( player, "MainLevel", level + 1)
            outputChatBox("[Levelsystem] Du bist soeben auf Level #FFFFFF"..tonumber(vioGetElementData ( player, "MainLevel" )).."#3ADF00 aufgestiegen.",player,58,223,0,true)
            triggerClientEvent ( player, "drawLevelUP", getRootElement() )
            checkForAdvertiser(player)
        end
    end

end




function testLvl (player, cmd, xp)
    if tonumber(xp) then
        addPlayerXP ( player, xp)
    else
        calculateLevelProgress ( player )
    end
end
addCommandHandler("tl", testLvl)