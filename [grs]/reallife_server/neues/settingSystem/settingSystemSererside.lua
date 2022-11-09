-- // Einstellungen für die Serverseite, zB einmalige Popups etc.

serversideSetting = {}

function intPlayerServersideSettings (player)
     local pname = getPlayerName(player)
    if not serversideSetting[pname] then
        serversideSetting[pname] = {}
    end
    print("Settings.")
end

function loadPlayerServersideSettings (player)
    --[[intPlayerServersideSettings (player)
    local pname = getPlayerName(player)
    local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "settings", "userdata", "UID",  playerUID[pname] ), -1 )
    if not result or not result[1] then
        serversideSetting[pname] = fromJSON(result[1])
    end--]]
end

function saveServersideSettings ( player )
	local pname = getPlayerName( player )
    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "settings",  toJSON ( serversideSetting[pname] ), "UID", serversideSetting[pname] )
    outputDebugString("Inventar gespeichert.")
end


