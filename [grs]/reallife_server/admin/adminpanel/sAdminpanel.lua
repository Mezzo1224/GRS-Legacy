
function getBansFromMySQL (player, searchUID)
    if string.len(searchUID) == 0 then
        searchUID = 0 
    end
    print(searchUID)
    if tonumber(searchUID) > 0 then
        result = dbPoll ( dbQuery ( handler, "SELECT * FROM ?? WHERE ??=?", "ban", "UID", searchUID ), -1 )
    else
        result = dbPoll ( dbQuery ( handler, "SELECT * FROM ?? ", "ban"), -1 )
    end
    for i=1, #result do
        local id = tonumber ( result[i]["ID"])
        local uid, name, reason = tonumber (  result[i]["UID"]), playerUIDName[tonumber ( result[i]["UID"] )],result[i]["Grund"]
        local date, time, adminName = result[i]["Eintragsdatum"], tonumber ( result[i]["STime"] ),  playerUIDName[tonumber ( result[i]["AdminUID"] )]
        if time > 0 then
            local diff = math.floor ( ( ( time - getTBanSecTime ( 0 ) ) / 60 ) * 100 ) / 100
            time = 	diff
        end
        triggerClientEvent ( player, "addBanToList", getRootElement(), uid,adminName, name, reason, date, time )
    end
end
addEvent ( "getBansFromMySQL", true)
addEventHandler ( "getBansFromMySQL",getRootElement(),  getBansFromMySQL)

function convertDateToNumber (date)
    date = "1"..string.gsub ( tostring(date), "%.", "" )
    date = tonumber(date)
    return tonumber(date)
end
function getLogsFromMySQL (player, searchType, searchName, dateTo, dateFrom, doDeepLog)
    logsForClient = {}
    -- // Typ abfragen sonst SQL gefickt amana
    local searchName = string.lower(searchName)
    local refeshWithoutSearch = true
    if doDeepLog == true then
        maxLogs = 10000
        outputConsole("Deeplog aktiviert", player)
    else
        maxLogs = 500
    end
    local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ?? WHERE ??=? LIMIT ?", "logs", "type", searchType, maxLogs ), -1 )
	for i=1, #result do
    --    if tonumber (#logsForClient) < maxLogs then
            logsForClient[i] = {tonumber ( result[i]["faction"] ),  tonumber (  result[i]["type"] ),  tonumber (result[i]["Timestamp"] ), string.lower(result[i]["Text"]) }
    --    end
    end

    -- Sucheinstellung
    for i, log in pairs(logsForClient) do 
        -- // Textsuche
        if string.len(searchName) > 0 then
            if string.find(log[4],searchName) == nil then

                logsForClient[i] = nil
            end
        end
        -- // Datum
        if string.len(dateFrom) > 0 and string.len(dateTo) == 0 then
            -- Bestimmtes Datum
            print("Suche nur Bestimmtes Datum")
            local n1, n2 = convertDateToNumber(getDateForAdminpanel(log[3],false)), convertDateToNumber(dateFrom)
            if tonumber(n1) ~= tonumber(n2) then

                logsForClient[i] = nil
            end
        elseif string.len(dateFrom) > 0 and string.len(dateTo) > 0 then
            -- Genaues Datum
            local dataTimesamp = convertDateToNumber(getDateForAdminpanel(log[3],false)) 
            local to, from = convertDateToNumber(dateTo),  convertDateToNumber(dateFrom)
            -- if wert <= von or wert >= bis then
            if dataTimesamp < from  or dataTimesamp > to  then

                    logsForClient[i] = nil
            end
        end



    end 

    for i, log in pairs(logsForClient) do 
        triggerClientEvent ( player, "addLogsToList", getRootElement(), fraktionNames[log[1]], logNameFromType[log[2]], getDateForAdminpanel(log[3],true), log[4] )
    end
    logsForClient = nil
end
addEvent ( "getLogsFromMySQL", true)
addEventHandler ( "getLogsFromMySQL",getRootElement(),  getLogsFromMySQL)

function fillPaysafecardList (player)
    if player == client then
        for i, psc in pairs(paysafecard) do 	
        triggerClientEvent ( player, "addPscToList", getRootElement(),psc.uid,playerUIDName[psc.uid], psc.psc, psc.value )	
        end
    end
end
addEvent ( "fillPaysafecardList", true)
addEventHandler ( "fillPaysafecardList",getRootElement(),  fillPaysafecardList)

function fillCooperationList (player)
    for i, coop in pairs(cooperation) do 
        triggerClientEvent ( player, "addCooperationToList", getRootElement(), i, coop.name )			
    end
end
addEvent ( "fillCooperationList", true)
addEventHandler ( "fillCooperationList",getRootElement(),  fillCooperationList)

function getCooperationDetails (player, id)
    local id = tonumber(id)
    local money, drugs, mats =  cooperation[id].storedMoney, cooperation[id].storedDrugs, cooperation[id].storedMats
    local level, tlevel = cooperation[id].coopLevel, cooperation[id].coopTuningLevel
    triggerClientEvent ( player, "setCooperationDetails", getRootElement(),  "Geld: "..money.."$\nDrogen: "..drugs.."\nMats: "..mats.."\nLevel: "..level.." \nTuning-Level: "..tlevel )	
end
addEvent ( "getCooperationDetails", true)
addEventHandler ( "getCooperationDetails", getRootElement(),  getCooperationDetails)

function fillCooperationVehList (player, id)
    local id = tonumber(id)
    for i, veh in pairs(cooperationVehicle) do 
        if veh.coopID == id then
            local name = getVehicleName(veh.veh)
            triggerClientEvent ( player, "addCooperationVehToList", getRootElement(), name )	
        end
    end
end
addEvent ( "fillCooperationVehList", true)
addEventHandler ( "fillCooperationVehList", getRootElement(),  fillCooperationVehList)

function fillCooperationMemberList (player, id)
    local id = tonumber(id)
    for i, state in pairs(cooperation[id].members) do 
           triggerClientEvent ( player, "addCooperationMemberToList", getRootElement(), i, state  )	
       end
end
addEvent ( "fillCooperationMemberList", true)
addEventHandler ( "fillCooperationMemberList", getRootElement(),  fillCooperationMemberList)


function getDateForAdminpanel (timestamp, precise)

	local time = getRealTime(timestamp,true)
	local year = tostring( time.year + 1900 )
	local month = tostring( time.month + 1 )
	local day = tostring( time.monthday )
	local hour = tostring( time.hour )
	local minute = tostring( time.minute )
	local second = tostring ( time.second + 1 )
	if  #month == 13 then
		month = 1
	end
	if #month == 1 then
		month = "0"..month
	end
	if #day == 1 then
		day = "0"..day
	end
	if #hour == 1 then
		hour = "0"..hour
	end
	if #minute == 1 then
		minute = "0"..minute
	end
	if #second == 1 then
		second = "0"..second
	end
    if precise == true then
	    data = day.."."..month.."."..year.." "..hour..":"..minute..":"..second
    else
        data = day.."."..month.."."..year
    end
	return data
end
