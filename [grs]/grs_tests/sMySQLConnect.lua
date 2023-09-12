function connect()
    db = dbConnect( "mysql", "dbname=grs;host=localhost;charset=utf8", "root", "" )
    if (not db) then
        outputDebugString("Error: Failed to establish connection to the MySQL database server")
    else
        outputDebugString("Success: Connected to the MySQL database server")
      --  startCaching ()
    end
end

addEventHandler("onResourceStart",resourceRoot, connect)


serverStatistics = {}
serverStatistics.money = {}
function startCaching ()
    print("Spieler Statistiken werden gesammelt.")
    -- // Geld
    cacheMoney ()
    cacheFactionMembers ()
    cachePlayerStats ()

end


function cacheMoney ()
    local query = dbQuery(db, "SELECT UID, (Geld + Bankgeld) AS geld FROM userdata WHERE keepStatsPrivate = 0 ORDER BY geld DESC LIMIT 25")

    if query then
        local result = dbPoll(query, -1)
        if result and #result > 0 then
            for i, row in ipairs(result) do
                local geld = row["geld"]
                local uid = row["UID"]
                print("Platz " .. i .. ": UID = " .. uid .. ", Gesamtguthaben = " ..  formatMoney(geld).."$")
                serverStatistics.money[i] = {
                    uid = uid,
                    money = formatMoney(geld)
                }
            end
        else
            outputChatBox("Keine Daten gefunden.")
        end

        dbFree(query)
    end
end

function cacheFactionMembers ()
    local query = dbQuery(db, "SELECT fraktion, COUNT(*) AS anzahl FROM userdata GROUP BY fraktion")

    if query then
        local result = dbPoll(query, -1)
        if result and #result > 0 then
            for i, row in ipairs(result) do
                local fraktion = row["fraktion"]
                local anzahl = row["anzahl"]
                print("Fraktion " .. fraktion .. ": Anzahl Einträge = " .. anzahl)
            end
        else
            print("Keine passenden Daten gefunden.")
        end

        dbFree(query)
    else
        print("Fehler beim Ausführen der SQL-Abfrage.")
    end
end

function cachePlayerStats ()
    local selectedColumns = {
        "AnzahlEingeknastet",
        "AnzahlImKnast",
        "AnzahlGangwars",
        "AnzahlGangwarsGewonnen",
        "AnzahlGangwarsVerloren",
        "Kills",
        "Tode",
        "GangwarKills",
        "GangwarTode",
        "HaeuserGekauft",
        "FahrzeugeGekauft",
        "FahrzeugeVerkauft",
        "DamageGemacht",
        "DamageBekommen",
        "GangwarDamageGemacht",
        "GangwarDamageBekommen",
        "FraktionenBetreten",
        "FraktionenVerlassen",
        "Eingeloggt"
    }


    local selectedColumnsStr = table.concat(selectedColumns, ", ")
    local queryStr = "SELECT " .. selectedColumnsStr .. " FROM statistics ORDER BY UID DESC LIMIT 25"

    local query = dbQuery(db, queryStr)

    if query then
        local result = dbPoll(query, -1)
        if result and #result > 0 then
            for i, row in ipairs(result) do
                print("Eintrag " .. i .. ":")
                for _, columnName in ipairs(selectedColumns) do
                    print(columnName .. " = " .. row[columnName])
                end
            end
        else
            print("Keine passenden Daten gefunden.")
        end

        dbFree(query)
    else
        outputChatBox("Fehler beim Ausführen der SQL-Abfrage.")
    end

end

function formatMoney(amount)
    local formatted = tostring(amount)
    local k

    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1.%2')
        if k == 0 then
            break
        end
    end

    return formatted
end
connect()