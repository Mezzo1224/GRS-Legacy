-- Erstellen einer Tabelle für die Keybinds mit IDs (wie zuvor)
local keybinds = {
    { id = 1, key = "lctrl", name = "Sprinten", description = "Sprinten aktivieren",  func = function(player)
        print("Springen 1")
    end },
    { id = 2, key = "space", name = "Springen", description = "Springen aktivieren",  func = function(player)
        print("Springen 2")
    end },
    -- Weitere Keybinds hier hinzufügen
}


function createKeybindsFile(player)
    local playerName = getPlayerName(player)
    local keybindsFileName = ":grs_cache/keybinds_" .. playerName .. ".json"
    
    if not fileExists(keybindsFileName) then
        local keybindsFile = fileCreate(keybindsFileName)
        if keybindsFile then
            local defaultKeybinds = {}
            for _, keybind in ipairs(keybinds) do
                defaultKeybinds[keybind.name] = { key = keybind.key }
            end
            local encodedKeybinds = toJSON(defaultKeybinds)
            fileWrite(keybindsFile, encodedKeybinds)
            fileClose(keybindsFile)
            loadKeybinds(player)
        end
    end
end

-- Funktion zum Laden der Keybinds aus einer JSON-Datei
function loadKeybinds(player)
    local playerName = getPlayerName(player)
    local keybindsFileName = ":grs_cache/keybinds_" .. playerName .. ".json"
    print("Binds laden")
    if fileExists(keybindsFileName) then
        local keybindsFile = fileOpen(keybindsFileName)
        
        if keybindsFile then
            local keybindsData = fileRead(keybindsFile, fileGetSize(keybindsFile))
            local decodedKeybinds = fromJSON(keybindsData)
            
            if decodedKeybinds then
                for _, keybind in ipairs(keybinds) do
                    local keybindName = keybind.name
                    if decodedKeybinds[keybindName] ~= nil then
                        keybind.key = decodedKeybinds[keybindName].key
                        setKeybindKey(keybind.name, keybind.key, true)
                    end
                end
            end
            
            fileClose(keybindsFile)
        end
    else
        createKeybindsFile(player)
    end
end

function setKeybindKey(keybindIdentifier, newKey, firstBind)
    for _, keybind in ipairs(keybinds) do
        if keybind.name == keybindIdentifier or keybind.id == keybindIdentifier then
            if firstBind == false then
                -- Alten Key Entfernen
                unbindKey ( keybind.key, "down", keybind.func )
            end
            -- Neuen Key hinzufügen
            keybind.key = newKey
            bindKey ( newKey,"down", keybind.func)
            return true -- Keybind gefunden und aktualisiert
        end
    end
    return false -- Keybind nicht gefunden
end

function getKeybindKeyValue(keybindIdentifier)
    for _, keybind in ipairs(keybinds) do
        if keybind.name == keybindIdentifier or keybind.id == keybindIdentifier then
            return keybind.key
        end
    end
    return nil -- Keybind nicht gefunden
end

-- Funktion zum Speichern der Keybinds in einer JSON-Datei
function saveKeybinds(player)
    local playerName = getPlayerName(player)
    local keybindsFileName = ":grs_cache/keybinds_" .. playerName .. ".json"
    local keybindsFile = fileOpen(keybindsFileName)
    
    if keybindsFile then
        local keybindsData = {}
        for _, keybind in ipairs(keybinds) do
            local keybindName = keybind.name
            keybindsData[keybindName] = { key = keybind.key }
        end
        
        local encodedKeybinds = toJSON(keybindsData)
        fileWrite(keybindsFile, encodedKeybinds)
        fileClose(keybindsFile)
    end
end
