isDatabaseConneced = false
local needACLAdminGroup = true --// Braucht man für das Verbinden der Datenbank die ACL Gruppe Admin ?
local defaultMySQLData= {
    host = "localhost",
    port = 3306,
    user = "root",
    password = "",
    database = "grs"
}
connectedDatabase = nil

function connectDatabase ()
    local MySQLFile = xmlLoadFile(":reallife_server/mysql/mysql.xml")
    if MySQLFile then
        print("mysql daten geladen")
    end
    local host = xmlNodeGetValue( xmlFindChild( MySQLFile, "host", 0 ) )
    local port = xmlNodeGetValue( xmlFindChild( MySQLFile, "port", 0 ) )
    local user = xmlNodeGetValue( xmlFindChild( MySQLFile, "user", 0 ) )
    local password = xmlNodeGetValue( xmlFindChild( MySQLFile, "password", 0 ) )
    local database = xmlNodeGetValue( xmlFindChild( MySQLFile, "database", 0 ) )
    local errorCount = tonumber(xmlNodeGetValue( xmlFindChild( MySQLFile, "errorCount", 0 ) ))
    outputDebugString ( "[MySQL] Eine MySQL Verbindung wird versucht aufzubauen.", 3 )
    connectedDatabase = dbConnect( "mysql", "dbname="..database..";host="..host..";charset=utf8", user, password)
    if connectedDatabase then
        outputDebugString ( "[MySQL] Eine MySQL Verbindung wurde aufgebaut.", 3 )
        isDatabaseConneced = true
        xmlNodeSetValue (   xmlFindChild ( MySQLFile, "initialized", 0 ), "true"  )
        -- // Zeit
        local time = getRealTime()
        local hours = time.hour
        local minutes = time.minute
        local seconds = time.second
        local monthday = time.monthday
        local month = time.month
        local year = time.year
        local formattedTime = string.format("%04d-%02d-%02d %02d:%02d:%02d", year + 1900, month + 1, monthday, hours, minutes, seconds)
        xmlNodeSetValue (   xmlFindChild ( MySQLFile, "intDate", 0 ), formattedTime  )
    else
        outputDebugString ( "[MySQL] Eine MySQL Verbindung konnte nicht aufgebaut werden.", 1 )
        outputDebugString ( "[MySQL] Solltest du ACL Rechte besitzen, kannst du die Verbindungsdaten Ingame erneut eingeben.", 1 )
        isDatabaseConneced = false
        xmlNodeSetValue (   xmlFindChild ( MySQLFile, "errorCount", 0 ), (errorCount + 1)  )
    end
    xmlSaveFile(MySQLFile)
    xmlUnloadFile(MySQLFile)
end

local function intMySQL ()
    local MySQLFile = xmlLoadFile(":reallife_server/mysql/mysql.xml")
    -- // Beim nicht laden wird die Datei erstellt
    if not MySQLFile then
        local MySQLFile = xmlCreateFile(":reallife_server/mysql/mysql.xml","mysql")
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "initialized"), "false" )

        --// Verbindungsinformationen
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "host"), defaultMySQLData.host )
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "port"), defaultMySQLData.port )
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "user"), defaultMySQLData.user )
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "password"), defaultMySQLData.password )
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "database"), defaultMySQLData.database )
        
        -- // Andere Daten
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "intUsername"), "none" )
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "intSerial"), "none" )
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "intDate"), "none" )
        xmlNodeSetValue (xmlCreateChild ( MySQLFile, "errorCount"), "0" )
        xmlSaveFile(MySQLFile)
        xmlUnloadFile(MySQLFile)
        connectDatabase ()
    else
        connectDatabase ()
    end
end
--intMySQL () -- // War nur zum testen

