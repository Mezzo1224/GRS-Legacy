


function loadCooperations()

    local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ??", "cooperations" ), -1 )
	for i=1, #result do
        -- // Werte Abfragen
        local id =  tonumber ( result[i]["ID"] )
        if result[i]["isDisabled"] == 0 then
            
            local leaderUID =  tonumber ( result[i]["leaderUID"] )
            dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "coopID", id, "coopRang", 4, "UID", leaderUID ) 
            local name =   result[i]["name"]
            local nameShort =  result[i]["nameShort"]
            local coopType =  tonumber ( result[i]["coopType"])
            local leaderUID =  tonumber ( result[i]["leaderUID"] )
            local storedMoney,storedDrugs, storedMats =  tonumber ( result[i]["storedMoney"] ), tonumber ( result[i]["storedDrugs"] ), tonumber ( result[i]["storedMats"] )
            local level =  tonumber ( result[i]["level"] )
            local tuningLevel =  tonumber ( result[i]["tuningLevel"] )
            local maxVehicles =  tonumber ( result[i]["maxVehicles"] )
            local Rang1, Rang2, Rang3, Rang4 = result[i]["Rang1"],result[i]["Rang2"],result[i]["Rang3"],result[i]["Rang4"]
            local r, g, b =  tonumber ( result[i]["R"] ), tonumber ( result[i]["G"] ), tonumber ( result[i]["B"] )
            local picture =  tostring ( result[i]["image"] )
            -- // Firma erstellen
            -- // Hausabfrage
            local housePickup = houses["pickup"][playerUIDName[leaderUID]]
            local houseID = houses["id"][housePickup]
            local houseX, houseY, houseZ = getElementPosition ( housePickup )
            vioSetElementData(housePickup, "cooperationOwner", id)
            if coopType == 1 then
                vioSetElementData(housePickup, "cooperationName", "der Gang\n  \""..name.."" )
            elseif coopType == 2 then
                vioSetElementData(housePickup, "cooperationName", "der Firma\n \""..name.."" )
            end
            
            cooperationVehicleList[id] = {}
            cooperation[id] = {
                name = name,
                leaderUID = leaderUID,
                nameShort = nameShort,
                coopType = coopType,
                storedMoney = storedMoney,
                storedDrugs = storedDrugs,
                storedMats = storedMats,
                coopLevel = level,
                coopTuningLevel = tuningLevel,
                coopMaxVehicles = maxVehicles,
                payday = setTimer(coopPayday, coopPaydayTimer, 0, id ),
                payDayTogether = 0,
                members = {},
                vehicles = 0,
                -- // Hausmarker
                houseID = houseID,
                -- // Spawnarea
                SpawnX = houseX,
                SpawnY = houseY,
                SpawnZ = houseZ,
                -- // Stocks
                isStockCoop = true, -- // MySQL
                stockPenalty = 0,
                -- // Farbe
                r = r,
                g = g,
                b = b,
                -- // Bild
                picture = picture
            }
            -- // Ränge setzen
            cooperationRanks[id] = {
                [1] = Rang1,
                [2] = Rang2,
                [3] = Rang3,
                [4] = Rang4
            }
            -- // Payday
            cooperationRanks[id]["payday"] = {}
            local p1, p2,p3,p4 = getRankPaydays ( id )
            cooperationRanks[id]["payday"][1] = p1
            cooperationRanks[id]["payday"][2] = p2
            cooperationRanks[id]["payday"][3] = p3
            cooperationRanks[id]["payday"][4] = p4
            -- // Member
            intCoopMember ( id )

            if level == 0 then
                cooperation[id].SpawnRadius = 100
            else
                cooperation[id].SpawnRadius = 20
            end
            cooperation[id].SpawnCol = createColCircle(houseX, houseY, cooperation[id].SpawnRadius )
            -- // Fahrzeuge laden
            loadCooperationVehicles ( id )
        else
            local deleteDate = tonumber( result[i]["deleteDate"] )
            if not deleteDate then deleteDate = 1 end -- // Löscht es direkt
            -- Wann wird es gelöscht nach Antrag ?  (getTimestamp () + 604800) = 7 Tage
            print("Das Unternehmen "..result[i]["name"].." ist deaktiviert.")
            if getTimestamp ()  >= deleteDate and deleteDate > 0 then
                outputAdminLog ( "Das Unternehmen "..result[i]["name"].." wurde gelöscht." )	
                dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "cooperations", "ID", id )
                dbExec ( handler, "DELETE FROM ?? WHERE ??=?", "cooperations_vehicles", "coopID", id )
            end
        end
    end
    printDebug(#result.." Unternehmen geladen.")
end



function intCoopMember ( id )
    local result = dbPoll ( dbQuery ( handler, "SELECT ??, ?? FROM ?? WHERE ??=?", "UID", "LastLogin",  "userdata", "coopID", id ), -1 )
	for i=1, #result do
        local uid =  tonumber ( result[i]["UID"] )
        cooperation[id].members[playerUIDName[uid]] = tonumber ( result[i]["LastLogin"] )
	end
    printDebug(#result.."Member.")
end


function loadCooperationVehicles ( coopIDAll )
    local result =  dbQuery(handler,"SELECT * FROM cooperations_vehicles")
    if result and devMode < 2 then
        local rows, numrows = dbPoll(result, -1)
        if(numrows > 0) then
            for k, rows in ipairs(rows) do
                if rows.coopID == coopIDAll then
                    local id = rows.ID
                    local coopID =  tonumber (   rows.coopID )
                    local model =   tonumber ( rows.model )
                    local x,y,z = tonumber (rows.X), tonumber (rows.Y), tonumber (rows.Z)
                  --  local rx,ry,rz = tonumber (rows.RX), tonumber (rows.RY), tonumber (rows.RZ)
                  local rx,ry,rz = tonumber (0), tonumber (0), tonumber (rows.RZ)
                    local rang  =tonumber (  rows.Rang )
                    local fuel = tonumber ( rows.fuel )
                    local paintjob = rows.paintjob
                    local color = rows.color
                    
                    createCooperationVehicle (id, coopID, model, x,y,z, rx,ry,rz,rang,fuel, color,paintjob )
                end
            end
        end
    end
end

function updateCoopData ()

   
    for i, coop in pairs(cooperation) do 
        local money, drugs, mats = coop.storedMoney, coop.storedDrugs, coop.storedMats
        local r1, r2, r3, r4 = cooperationRanks[i][1], cooperationRanks[i][2], cooperationRanks[i][3], cooperationRanks[i][4]
        dbExec ( handler, "UPDATE ?? SET ??=?,??=?,??=? WHERE ??=?", "cooperations", "storedMoney",money ,"storedDrugs",drugs ,"storedMats", mats, "ID", i )
        dbExec ( handler, "UPDATE ?? SET ??=?,??=?,??=?, ??=? WHERE ??=?", "cooperations", "Rang1",r1 ,"Rang2",r2 ,"Rang3", r3,"Rang4", r4, "ID", i )
        if getCooperationCurrentVehicles(i) > 0 then
            for i, veh in pairs(cooperationVehicleList[i]) do 
                local id = cooperationVehicle[veh].id
                local x,y,z, rz = getVehicleRespawnPosition (veh), getVehicleRespawnRotation(veh)
                dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "cooperations_vehicles", "fuel", vioGetElementData ( veh, "fuelstate") ,"ID", id )
                -- Rotation wurde auf rx,0,0 geändert
                dbExec ( handler, "UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=? WHERE ?? = ?", "cooperations_vehicles", "X", x, "Y", y,"Z", z,"RX", 0,"RY", 0,"RZ", rz, "ID", id )
            end
        end
        
    end
    outputDebugString ( "Unternehmen wurden aktualisiert!" )

    
end

-- // Da die Funktion extern von der mysql_start.lua ist, muss die Funktion hier mit einem Timer versehen werden
-- // Und wegen den Hausmarkern
setTimer ( loadCooperations, 5000, 1 )



