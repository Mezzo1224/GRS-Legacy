local logsArray = {}
local logsTypes = { ["allround"] = 1, ["admin"] = 2, ["damage"] = 3, ["Heilung"] = 4, ["Chat"] = 5, ["aktion"] = 6, ["Armor"] = 7, ["autodelete"] = 8, ["b-Chat"] = 9, ["casino"] = 10, 
					["death"] = 11, ["dmg"] = 12, ["drogen"] = 13, ["explodecar"] = 14, ["fguns"] = 15, ["fkasse"] = 16, ["gangwar"] = 17, ["Geld"] = 18, ["house"] = 19, ["kill"] = 20,
					["pwchange"] = 21, ["sellcar"] = 22, ["vehicle"] = 23, ["tazer"] = 24, ["Team-Chat"] = 25, ["weed"] = 26, ["werbung"] = 27,["fraktion"] = 28, ["factionmsg"] = 29 }

logNameFromType = {}
for i, log  in pairs(logsTypes) do 
	logNameFromType[log] = i
	
end
local logPath = ":grs_cache/logs/"
local logsMySQL = true

function deleteLogsFromMySQL ( player )
	if client == player then
		if isAdminLevel ( player, 8 ) then
			-- // Fraktionslog auch löschen 
			local deleteTime = (getTimestamp () - 604800)
			dbExec ( handler, "DELETE FROM ?? WHERE ?? LIKE '0' AND ?? <= "..deleteTime..";", "logs", "faction", "Timestamp" )
			newInfobox (player, "Logs wurden gelöscht.", 4)
			for playeritem, index in pairs(adminsIngame) do 			
				if index >= 2 then
					outputChatBox ( getPlayerName(playeritem).." hat die Logs gelöscht.", playeritem,200, 200, 0)
				end				
			end		
		else
			newInfobox (player, "Du bist nicht befugt.", 3)
		end
	else
		newInfobox (player, "Manipulation?!", 3)
	end
end
addEvent ( "deleteLogsFromMySQL", true )
addEventHandler ( "deleteLogsFromMySQL", getRootElement(), deleteLogsFromMySQL )

function outputFactionLog ( text, faction)

	outputLog(text, "fraktion", faction)
end

function outputLog ( text, logname, faction )
	
	if not logname or not logsTypes[logname] then
		logname = "allround"
	end
	if not faction then 
		faction = 0
	end
	if logsMySQL == false or logname == "fraktion" then
		logname = logname..".log"
		--local log = getLog ( logPath..logname )
	--	local log = fileOpen()
		local filesize = fileGetSize ( log )
		
		fileSetPos ( log, filesize )
		fileWrite ( log, " "..logTimestamp().." "..text.."  \n" )
		fileClose ( log )
		if logname == "fraktion" and logsMySQL == true then
			dbExec ( handler, "INSERT INTO ?? (??,??,??, ??) VALUE (?,?,?, ?)", "logs", "type", "Text", "Timestamp", "faction", logsTypes[logname], text, getTimestamp (), faction )
		end
	else
		--print("Log in SQL: "..text)
		dbExec ( handler, "INSERT INTO ?? (??,??,??, ??) VALUE (?,?,?, ?)", "logs", "type", "Text", "Timestamp", "faction", logsTypes[logname], text, getTimestamp (), faction )
	end
end

addEvent ( "outputLog", true )
addEventHandler ( "outputLog", getRootElement(), outputLog )

function getLog(type)
	print("Zeige logs von "..type)
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ?? WHERE ??=?", "logs", "type", type ), -1 )
	for i=1, #result do
		print( result[i]["Text"] )
		local timesampLog = getRealTime(result[i]["Timestamp"], true)

		local year = tostring ( timesampLog.year + 1900 )
		local month = tostring ( timesampLog.month + 1 )
		local day = tostring ( timesampLog.monthday )
		print(day.."."..month.."."..year)
	end
end



function logTimestamp ()
	local logtime = getRealTime()
	local year = tostring ( logtime.year + 1900 )
	local month = tostring ( logtime.month + 1 )
	local day = tostring ( logtime.monthday )
	local hour = tostring ( logtime.hour )
	local minute = tostring ( logtime.minute )
	local second = tostring ( logtime.second + 1 )
	
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
	
	return "["..day.."-"..month.."-"..year.." "..hour..":"..minute..":"..second.."]"
end

--[[
function putTheLogIntoMySQL ( )
	for i=1, #logsArray do
		dbExec ( handler, "INSERT INTO ?? (??,??,??, ??) VALUE (?,?,?, ?)", "logs", "Typ", "Text", "Timestamp", "faction", logsArray[i][1], logsArray[i][2], logsArray[i][3], logsArray[i][4] )
	end
	logsArray = {}
end 
setTimer ( putTheLogIntoMySQL, 1*60*1000, 0 )
addEventHandler ( "onResourceStop", resourceRoot, putTheLogIntoMySQL )
--]]

function outputAdminLog ( text )

	outputLog ( text, "admin" )
	
end