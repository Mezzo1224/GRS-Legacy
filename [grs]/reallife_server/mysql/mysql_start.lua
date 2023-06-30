local gMysqlHost = "localhost"

local gMysqlUser = "root"
local gMysqlPass = ""
local gMysqlDatabase = "grs"

local hasACLrights = false -- // NICHT ÄNDERN
local hasDGSrunning = false -- // NICHT ÄNDERN
local hasDGSACLrights = false -- // NICHT ÄNDERN
handler = nil
playerUID = {}
playerUIDName = {}
playerToken = {}
playerTempToken = {}

--- // Neu
achievement = {}
socialState = {}

function getMilliSecond ( number )
	if tonumber(number) then
		if number > 0 then
			return number*1000
		end
	end
end



function MySQL_Startup ( ) 
		handler = dbConnect ( "mysql", "dbname=".. gMysqlDatabase .. ";host="..gMysqlHost..";port=3306", gMysqlUser, gMysqlPass )
		if not handler then
			outputDebugString("[MySQL_Startup] Couldn't run query: Unable to connect to the MySQL server!")
			outputDebugString("[MySQL_Startup] Please shutdown the server and start the MySQL server!")
			stopResource(getResourceName(getThisResource()))
			return
		else
			printDebug ("[MySQL_Startup] MySQL server connected!")
		end	
		local result = dbPoll ( dbQuery ( handler, "SELECT ??,??, ?? FROM ??", "UID", "Name", "permaSuppToken", "players" ), -1 )
		for i=1, #result do
			local id = tonumber ( result[i]["UID"] )
			local name = result[i]["Name"]
			local token = result[i]["permaSuppToken"]
			playerUID[name] = id
			playerUIDName[id] = name
			playerToken[name] = token
		end
	
	playerUIDName[0] = "none"
	playerUID["none"] = 0
end
MySQL_Startup()



function gamemodeReadyCheck (res)
	if enableStartDebug == true then
		if not fileExists ( ":reallife_server/ready.txt" )  then
			outputDebugString("---- STARTUP CHECK ----")
			if isObjectInACLGroup("resource."..getResourceName(res), aclGetGroup("Admin"))  then
				hasACLrights = true
			else
				outputDebugString("Der Gamemode ist nicht in der ACL Gruppe Admin, bearbeite bitte die 'ACL.xml'.")
				if not isObjectInACLGroup("resource.grs_cache", aclGetGroup("Admin")) then
					outputDebugString("Vergiss nicht ´grs_cache´ auch Rechte zu geben.")
				end
				outputDebugString("Start abgebrochen.")
			end
			if getResourceFromName ( "dgs" ) == false then
				outputDebugString("Du brauchst die dxLib `dgs` zum korrekten funktionieren des Gamemodes.")
				outputDebugString("https://github.com/thisdp/dgs")
				outputDebugString("Start abgebrochen.")
			else
				if getResourceState (getResourceFromName("dgs"))  == "loaded" then
					if startResource ( getResourceFromName ( "dgs" ) ) then
						outputDebugString("DGS wurde gestartet.")
						hasDGSrunning = true
					else
						outputDebugString("DGS konnte nicht gestartet werden. Überprüfe ob DGS installiert ist oder der Gamemode Rechte hat.")
						hasDGSrunning = false
					end
				end
				
				if not hasObjectPermissionTo ( getResourceFromName ( "dgs" ), "function.fetchRemote", true )  then
					outputDebugString("DGS hat keine ACL Rechte. Gebe in der Konsole folgendes ein:")
					outputDebugString("aclrequest allow dgs all")
					hasDGSACLrights = false
				else
					hasDGSACLrights = true
				end
			end
			local sqlCheck
			local dgsCheck
			local dgsACLCheck
			local gamemodeACLCheck
			local sqlCheck2
			if handler then sqlCheck = "Verbunden"  else sqlCheck =  "Nicht Verbunden" end
			if hasDGSrunning  then dgsCheck = "Gestartet." elseif getResourceFromName ( "dgs" )  then dgsCheck = "Nicht verfügbar." else dgsCheck = "Nicht gestartet" end
			if hasDGSACLrights then dgsACLCheck = "Hat Rechte" else  dgsACLCheck = "Keine Rechte" end
			if hasACLrights then gamemodeACLCheck = "Hat Rechte" else gamemodeACLCheck = "Keine Rechte" end
			if handler then
				local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ??", "idcounter" ), -1 )
				if #result > 0 then
					for i=1, #result do
						local id = tonumber ( result[i]["id"] )
						sqlCheck2 = "Funktioniert. Ergebnis der Abfrage ´idcounter´: "..id..""
					end
				else
					sqlCheck2 = "Funktioniert nicht. Bitte überprüfe die korrekte Importierung der Datenbank."
				end
			else
				sqlCheck2 = "Funktioniert nicht. Keine Verbindung."
			end
			outputDebugString("Ladevorbereitung abgeschlossen...")
			outputDebugString("DGS: "..dgsCheck)
			outputDebugString("DGS-ACL: ".. dgsACLCheck)
			outputDebugString("Script-ACL: "..gamemodeACLCheck)
			outputDebugString("MySQL: "..sqlCheck)
			outputDebugString("MySQL Datenbank: "..sqlCheck2)
			if hasACLrights == true and hasDGSrunning == true and handler and string.find(sqlCheck2,"Abfrage") then
				outputDebugString("Alles bereit.")
				local rFile = fileCreate(":reallife_server/ready.txt")
				fileWrite(rFile, "Script ist installiert.")
    			fileClose(rFile) 
				checkDGSVersion ()
			else
				outputDebugString("Installation Fehlerhaft!")
				cancelEvent()
			end
			outputDebugString("------------------------")
		else
			outputDebugString("Für ein erneuten Check, bitte die ready.txt löschen")
		end
	end
end
addEventHandler ( "onResourceStart", getResourceRootElement(), gamemodeReadyCheck )

function checkDGSVersion ()
	local currDgsVersion = getElementData(getResourceRootElement(getResourceFromName("dgs")), "Version" )
	if currDgsVersion then
		if currDgsVersion ~= compatibleDGS then
			outputDebugString("Achtung: Es läuft die DGS Version "..currDgsVersion.." Version, der Gamemode ist aber auf die Version "..compatibleDGS.." ausgelegt.")
			outputDebugString("Dies kann zu Fehler führen. Bitte verwende die Beigelegte DGS Version.")
		end
	else
		outputDebugString("DGS Version konnte nicht abgefragt werden.")
	end
end

function saveEverythingForScriptStop ( )
	saveDepotInDB()
	updateBizKasse()
end
addEventHandler ( "onResourceStop", resourceRoot, saveEverythingForScriptStop )

function dbExist(tablename, objekt)
	local result = dbQuery(handler,"SELECT * FROM "..tablename.." WHERE "..objekt)
	rows, numrows, err= dbPoll(result, -1)
		if rows[1] then
			return true
		else
			return false
		end
end




function loadSocialStats ( )
	local result = dbPoll ( dbQuery ( handler, "SELECT ??,??,?? FROM ??", "ID", "Name", "Description", "socialstatelist" ), -1 )
	for i=1, #result do
		local id = tonumber ( result[i]["ID"] )
		local name = result[i]["Name"]
		local desc = tostring(result[i]["Description"])
		-- Neu
		socialState[id] = {
			name = name,
			desc = desc
		}

		-- alt
		--[[socialStateID[id] = id
		socialStateName[id] = name
		socialStateDescription[id] = desc--]]
	end
		printDebug(#result.." socialStates geladen.")
end

function loadAchievements ( )
	local result = dbPoll ( dbQuery ( handler, "SELECT ??,??,??,??,??,??, ?? FROM ??", "ID", "Name", "Description", "image", "GainXP", "GainMoney", "socialStateID", "achievementlist" ), -1 )
	for i=1, #result do
		local id = tonumber ( result[i]["ID"] )
		local name = result[i]["Name"]
		local desc = result[i]["Description"]
		local pic = tostring ( result[i]["image"] )
		local xp = tonumber ( result[i]["GainXP"] )
		local money = tonumber ( result[i]["GainMoney"] )
		local socialID = tonumber ( result[i]["socialStateID"] )
		-- // Neue Lademethode seit 1.5b (23.2.21)
		achievement[id] = {
			name = name,
			desc = desc,
			xp = xp,
			money = money,
			socialID = socialID
		}

		if pic then
			achievement[id].pic = pic
		else
			achievement[id].pic = "error.png"
		end

	end
		printDebug(#result.." achievments geladen.")
end
--				TICKETSYSTEM		--
-- // Mir muss übrigens keiner sagen, dass das hier eine scheiß Nutzung von LUA-Tables ist, keine Ahnung was ich da gedacht habe
-- // Ticket Daten
waitingTickets = 0
ticket = {}
ticketID = {}
ticketUID = {}
ticketsUID = {}
ticketSupporter = {}
ticketType = {}
ticketState = {}
ticketSubject = {}
ticketText = {}
ticketRating = {}
ticketDate = {}
-- VIP
ticketDeleteable = {}
ticketHighPrio = {}

-- // Ticket Antworten Daten
ticketaID = {}
ticketaUID = {}
ticketaTicketID = {}
ticketaSUID = {}
ticketaText = {}
ticketaDate = {}

function loadTickets ()
    local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ??", "tickets" ), -1 )
	for i=1, #result do
		-- Ticket werden automatisch nach 30 Tage inaktvität oder nach 60 Tage gelöscht
		local result2 = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ?? LIKE ?", "LastLogin", "userdata", "UID", tonumber ( result[i]["UID"]) ), -1 )
		-- Rechnungen
		local playerLastLogin = tonumber ( result2[1]["LastLogin"] )
		local playerLastLoginCalculator = tonumber (( playerLastLogin - getTimestamp() )) /  60 / 60 / 24 
		local playerLastLoginCalculator = math.floor(playerLastLoginCalculator)
		local deleteCalucator = ( tonumber (     result[i]["date"] - getTimestamp() )   ) /  60 / 60 / 24 
		local deleteCalucator = math.floor(deleteCalucator)
		-- Zahlen (Tage) werden übeprüft
		if playerLastLoginCalculator <= 30 and deleteCalucator <= 30 then
			if deleteCalucator <= 60 then
				ticketID[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["ID"])
				ticketUID[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["UID"])
				ticketsUID[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["sUID"])
				ticketSupporter[ tonumber ( result[i]["ID"] ) ] = playerUIDName[ tonumber ( result[i]["sUID"] ) ]
				ticketType[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["type"])
				ticketState[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["state"])
				
				ticketSubject[ tonumber ( result[i]["ID"] )] =  result[i]["subject"]
				ticketText[ tonumber ( result[i]["ID"] )] =  result[i]["text"]
				ticketRating[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["rating"] )
				ticketDate[ tonumber ( result[i]["ID"] )] =  getDate ( result[i]["date"] ) 
				if  tonumber ( result[i]["state"]) == 1 or tonumber ( result[i]["state"]) == 4 then
					print("Da waret ein Ticket")
					waitingTickets = waitingTickets + 1
				end
				-- // VIP Features ?
				if  tonumber ( result[i]["notDeleteAble"]) == 1 then
					ticketDeleteable[tonumber ( result[i]["ID"])] = false
				else
					ticketDeleteable[tonumber ( result[i]["ID"])] = true
				end
				if  tonumber ( result[i]["highPrio"]) == 1 then
					ticketHighPrio[tonumber ( result[i]["ID"])] = true
				else
					ticketHighPrio[tonumber ( result[i]["ID"])] = false
				end
			else
				print("Das Ticket #"..result[i]["ID"].." wurde automatisch nach 60 Tagen gelöscht.")
				offlinemsg ( "Das Ticket #"..result[i]["ID"].." wurde automatisch nach 60 Tagen gelöscht.", "Server",playerUIDName[tonumber ( result[i]["sUID"])] )
				outputLog ( "Das Ticket #"..result[i]["ID"].." wurde automatisch nach 60 Tagen gelöscht.", "tickets" )
				-- DB löschen
				dbExec ( handler, "DELETE FROM ?? WHERE ?? = ?", "tickets", "ID", result[i]["ID"] )
				dbExec ( handler, "DELETE FROM ?? WHERE ?? = ?", "ticket_answers", "ticket_ID", result[i]["ID"] )
			
			end
		else
			print("Das Ticket #"..result[i]["ID"].." wurde automatisch (nach inaktivität) nach 30 Tagen gelöscht.")
			offlinemsg ( "Das Ticket #"..result[i]["ID"].." wurde automatisch  (nach inaktivität deinerseits) nach 30 Tagen gelöscht.", "Server",playerUIDName[tonumber ( result[i]["sUID"])] )
			outputLog ( "Das Ticket #"..result[i]["ID"].." wurde automatisch (nach inaktivität) nach 30 Tagen gelöscht.", "tickets" )
			-- DB löschen
			dbExec ( handler, "DELETE FROM ?? WHERE ?? = ?", "tickets", "ID", result[i]["ID"] )
			dbExec ( handler, "DELETE FROM ?? WHERE ?? = ?", "ticket_answers", "ticket_ID", result[i]["ID"] )
			

		end
	end
	printDebug(#ticketID.." Ticket geladen.")
	loadTicketAnswers ()
end

function loadTicketAnswers ()
	local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ??", "ticket_answers" ), -1 )
	for i=1, #result do
		ticketaID[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["ID"])
		ticketaUID[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["UID"])
		ticketaTicketID[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["ticket_ID"])
		ticketaSUID[ tonumber ( result[i]["ID"] )] = tonumber ( result[i]["sUID"]) -- TODO DELETE
		ticketaText[ tonumber ( result[i]["ID"] )] =  result[i]["text"]
		ticketaDate[ tonumber ( result[i]["ID"] ) ] = getDate ( result[i]["date"] ) 
	end
	printDebug(#result.." Ticket Antworten geladen.")
end

if handler then

	setTimer ( loadSocialStats, 500, 1 )
	setTimer ( loadAchievements, 500, 1 )
	setTimer ( loadTickets, 500, 1 )
	-- Ticket Antworten werden dann geladen WENN die Tickets geladen sind
end

function getSecturityToken ()
	local player = client 
	triggerClientEvent ( player, "setPermToken", getRootElement(), playerToken[getPlayerName(player)])
end
addEvent ( "getSecturityToken", true )
addEventHandler ( "getSecturityToken", getRootElement(), getSecturityToken )


function setTempToken (token)
	local player = client 
	playerTempToken[getPlayerName(player)] = token
end
addEvent ( "setTempToken", true )
addEventHandler ( "setTempToken", getRootElement(), setTempToken )