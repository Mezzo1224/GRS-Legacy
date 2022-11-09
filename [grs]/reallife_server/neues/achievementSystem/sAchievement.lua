socialName = "N.a"


function hasAchievement ( player, id )
    if dbExist ( "achievements", "achievmentID LIKE '"..id.."' AND UID LIKE '"..playerUID[getPlayerName(player)].."'") then
        return true
    else
        return false
    end
end

function giveAchievement( player, id )
    if tonumber(achievement[id]) then
        if not hasAchievement ( player, id ) then
			local rt = getRealTime ()
			local timesamp = rt.timestamp
            dbExec ( handler, "INSERT INTO ?? (??,??,??) VALUE (?,?,?)", "achievements", "UID", "achievmentID", "data", playerUID[getPlayerName(player)], id, timesamp )
            givePlayerXP( player, achievement[id].xp )
            vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + achievement[id].money )
			local social = socialStateID[achievement[id].socialID]
            if social then
                 giveSocialState (player, achievement[id].socialID)
			end
            triggerClientEvent ( player, "showAchievment", getRootElement(), id, achievement[id].name,achievement[id].desc, achievement[id].xp, achievement[id].money,achievement[id].pic, achievement[id].socialID )

        end
    end
end
addEvent ( "giveAchievement", true )
addEventHandler ( "giveAchievement", getRootElement(),  giveAchievement )


function checkAchievments (player)
    local faction =  tonumber ( vioGetElementData ( player, "fraktion" ) )
    local rank =  tonumber ( vioGetElementData ( player, "rang" ) )
    local geld = tonumber ( vioGetElementData ( player, "money" ) ) + tonumber( vioGetElementData ( player, "bankmoney" ) )
    if geld and rank and faction then
        if faction > 0  then
            giveAchievement( player, 6 )
        end

        if faction > 0 and rank >= 4 then
            giveAchievement( player, 7 )
        end

        if geld >= 5000000 then
            giveAchievement( player, 11 )
        end

        if geld >= 10000000 then
            giveAchievement( player, 12 )
        end
    end
end

function loadAchievements (player)

    local pname = getPlayerName( player )
    local result = dbQuery ( handler, "SELECT ??,?? FROM ?? WHERE ??=?", "achievmentID", "data", "achievements", "UID",  playerUID[getPlayerName(player)] )
    if result then
        local rows, numrows = dbPoll(result, -1)
        triggerClientEvent ( player, "setAchievementClientData", getRootElement(), #achievement, #rows)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                    local id = rows.achievmentID
                    local date = rows.data
                    local name = achievement[id].name
                    local desc, xp, money, socialID, pic =  achievement[id].desc,  achievement[id].xp, achievement[id].money, achievement[id].socialID, achievement[id].pic
                    if socialID > 0 then
                        socialID = socialState[socialID].name
                    else
                        socialID = "N.a"
                    end
                    local achData = "|"..desc.."|"..xp.."|"..money.."|"..socialID.."|"..getData(date).."|"..pic.."|"
                    triggerClientEvent ( player, "fillAchievementList", getRootElement(), name, achData)
                    
                    
            end
        end
    end
end
addEvent ( "loadAchievements", true )
addEventHandler ( "loadAchievements", getRootElement(),  loadAchievements )


