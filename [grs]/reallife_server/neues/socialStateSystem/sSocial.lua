function hasStatus ( player, id )
    if dbExist ( "socialstates", "socialStateID LIKE '"..id.."' AND UID LIKE '"..playerUID[getPlayerName(player)].."'") then
        return true
    else
        return false
    end
end

function giveSocialState (player, id, byName)
    if not hasStatus ( player, id ) then
        local rt = getRealTime ()
        local timesamp = rt.timestamp
        dbExec ( handler, "INSERT INTO ?? (??,??,??) VALUE (?,?,?)", "socialstates", "UID", "socialStateID", "data", playerUID[getPlayerName(player)], id, timesamp )
    end
end
addEvent ( "giveSocialState", true )
addEventHandler ( "giveSocialState", getRootElement(),  giveSocialState )

function removeSocialState (player, id)
    if  hasStatus ( player, id ) and tonumber(id) then
        local rt = getRealTime ()
        local timesamp = rt.timestamp
        dbExec ( handler, "DELETE FROM ?? WHERE ??=? AND ??=?", "socialstates", "UID", playerUID[getPlayerName(player)], "socialStateID", id  )
    end
end
addEvent ( "removeSocialState", true )
addEventHandler ( "removeSocialState", getRootElement(), removeSocialState )

local socialStates = {
    [1]="Flüchtling",
    [2]="Illegaler Immigrant",
    [3]="Immigrant",
    [4]="Bürger",
    [5]="Arbeiter",
    [6]="Neuling",
    [7]="Aufsteiger",
    [8]="Dealer",
    [9]="Waffenschieber",
    [10]="Hausbesitzer",
    [11]="Finanzhai",
    [12]="Millionär",
    [13]="Multimillionär",
    [14]="Fädenzieher",
    [15]="Geschäftsmann",
    [16]="Wirtschaftsboss",
    [17]="Reich & Schön",
    [18]="God of Ultimate",
    [19]="Rentner",
    [20]="Kettenraucher",
    [21]="Saufbruder",
    [22]="Junkie",
    [23]="Glücksschmied",
    [24]="Hasadeur",
    [25]="Blumenkind",
    [26]="Ferngesteuert",
    [27]="Silent Assasin"
   }


function debugSS ()
    for i, state in ipairs(socialStates) do 
        -- Sonderzeichen Wegradieren
         local state = string.gsub(state, "ö", "oe")
         local state = string.gsub(state, "ü", "ue")
         local state = string.gsub(state, "ß", "ss")
         local state = string.gsub(state, "ä", "ae")
         if not dbExist ( "socialstatelist", "Name LIKE '"..state.."'") then
             print(i.." "..state.." hinzugefügt.")
            dbExec ( handler, "INSERT INTO ?? (??,??) VALUE (?,?)", "socialstatelist", "Name", "Description", state, "TODO" )
         else
            print(state.." bereits verfügbar.")
        end

    end
end

-- debugSS ()

function loadSocialState (player)
    local pname = getPlayerName( player )
    local result = dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "socialStateID", "socialstates", "UID",  playerUID[getPlayerName(player)] )
    if result then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                    
                    local id = rows.socialStateID
                    local text = socialState[id].desc
                    local name = socialState[id].name
                    print(id, text, name)
                    triggerClientEvent ( player, "fillSocialStateList", getRootElement(), name, text)
                end
            end
        end
    end
addEvent ( "loadSocialState", true )
addEventHandler ( "loadSocialState", getRootElement(),  loadSocialState )  
-- Debug
