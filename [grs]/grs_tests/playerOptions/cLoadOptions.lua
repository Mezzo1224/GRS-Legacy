function saveOptions (player)
    outputConsole("Client-Einstellungen gespeichert.")
    saveClientSettings(player)
    saveKeybinds(player)
end

function loadOptions (player)
    outputConsole("Client-Einstellungen geladen. "..getPlayerName(player))
    loadClientSettingsFile (player)
    loadKeybinds(player)
end


addEventHandler("onClientResourceStart", root, function ( startedRes )
    local player = getLocalPlayer()
    loadOptions ( player )
end)


addEventHandler("onClientResourceStop", root, function ( startedRes  )
    local player = getLocalPlayer()
    saveOptions ( player )
end)--]]
--loadOptions (getLocalPlayer())

-- // Dev-Shit