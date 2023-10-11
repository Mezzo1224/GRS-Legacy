-- Erstellen einer Tabelle für die Einstellungen mit IDs
local clientSettings = {
    { id = 1, name = "Beitritts Nachricht", description = "Stellt ein, ob eine Nachricht in den Chat kommen soll, wenn ein Benutzer den Server betritt oder verlässt.", defaultValue = true, type = "boolean", category = "HUD" },
    { id = 2, name = "Eigenmenü durch Klicken des Charakters", description = "Stellt ein, ob beim Klicken auf seinen Charakter, das Eigendmenü bzw. /self, geöffnet werden soll", defaultValue = true, type = "boolean", category = "HUD" },
    -- Weitere Einstellungen hier hinzufügen
    { id = 3, name = "EP-Boost Info anzeigen", description = "Stellt ein, ob ggf. eine Information zu einem aktiven EP-Boost gezeigt werden soll.", defaultValue = true, type = "boolean", min = 0, max = 1, category = "HUD" },
    { id = 4, name = "Greenzone Info anzeigen", description = "Stellt ein, ob du dich ggf. in einer Greenzone befindest.", defaultValue = true, type = "boolean", category = "HUD" , category = "HUD"},

    { id = 5, name = "Experimentelles-Mapstreaming", description = "Map-Elemente werden nicht mehr Entladen, wenn man sich weit von ihnen Entfernt.", defaultValue = false, type = "boolean", category = "Grafik" },
    { id = 6, name = "Neben-Distanz", description = "Stellt die Distanz des Nebels ein.", defaultValue = math.floor(getFogDistance()), type = "number", min = 5, max = 100, category = "Grafik" },
    { id = 7, name = "Render-Distanz", description = "Stellt die Disanz ein, in der Elemente geladen/gerendert werden sollen", defaultValue = math.floor(getFarClipDistance()), type = "number", min = 100, max = 1000, category = "Grafik" },
    { id = 8, name = "Wolken", description = "Schaltet Wolken an/aus", defaultValue = true, type = "boolean", category = "Grafik" },
    { id = 9, name = "FPS", description = "Stellt die Bilder-pro-Sekunde (FPS) ein.", defaultValue = 65, type = "number", min = 30, max = 65, category = "Grafik"  },

    { id = 10, name = "Version Info anzeigen", description = "Stellt ein, ob  eine Information zur der Server-Version angezeigt werden soll.", defaultValue = true, type = "boolean", category = "HUD"  },
    { id = 11, name = "FPS-Zähler zeigen", description = "Stellt ein, ob  die Bilder-pro-Sekunde (FPS) angezeigt werden sollen..", defaultValue = false, type = "boolean", category = "HUD"  },
    { id = 12, name = "Passwort", description = "Dein Passwort, das du nicht siehst.", defaultValue = "", type = "string", category = "intern"  },
}

-- Funktion zum Erstellen einer JSON-Datei für die Einstellungen und Befüllen mit Standardwerten, falls nicht vorhanden
function createClientSettingsFile(player)
    local playerName = getPlayerName(player)
    local fileName = "client_settings_" .. playerName .. ".json"
    
    if not fileExists(fileName) then
        local settingsFile = fileCreate(fileName)
        if settingsFile then
            local defaultSettings = {}
            for _, setting in ipairs(clientSettings) do
                defaultSettings[setting.name] = setting.defaultValue
                print("File erstellt", setting.name, setting.defaultValue)
            end
            local encodedSettings = toJSON(defaultSettings)
            fileWrite(settingsFile, encodedSettings)
            fileClose(settingsFile)
            loadClientSettingsFile (player)
        end
    end
end

function loadClientSettingsFile (player)
    local playerName = getPlayerName(player)
    local fileName = "client_settings_" .. playerName .. ".json"
    local settingsFile = fileOpen(fileName)
    if settingsFile then
        local data = fileRead(settingsFile, fileGetSize(settingsFile))
        fileClose(settingsFile)
        local decodedSettings = fromJSON(data)
        if decodedSettings then
            for _, setting in ipairs(clientSettings) do
                local settingName = setting.name
                if decodedSettings[settingName] ~= nil then
                    setClientSetting(settingName, decodedSettings[settingName])
                else
                    print( settingName.." hat keinen Standard-Wert, setzen:", setting.defaultValue)
                    setClientSetting(settingName, setting.defaultValue) 
                end
            end
        end
    else
        createClientSettingsFile(player)
    end
end

function saveClientSettings(player)
    local playerName = getPlayerName(player)
    local fileName = "client_settings_" .. playerName .. ".json"
    local settingsFile = fileOpen(fileName)
    local settingsData = {}
    if settingsFile then
        for _, setting in ipairs(clientSettings) do
            local settingName = setting.name
            settingsData[settingName] = getClientSetting(settingName)
            print("SAVE", settingName, getClientSetting(settingName))
        end
        local encodedSettings = toJSON(settingsData)
        fileWrite(settingsFile, encodedSettings)


        fileClose(settingsFile)


    else
        outputConsole("Einstellungen konnten nicht gespeichert werden.")
    end
end


function setClientSetting(settingIdentifier, value)
    for _, setting in ipairs(clientSettings) do
        if setting.name == settingIdentifier or setting.id == settingIdentifier then
            local oldValue = setting.value
            if setting.type == "string" then
                setting.value = tostring(value)
            elseif setting.type == "number" then
                if type(value) == "number" then
                    -- Überprüfe den Wertebereich (min und max)
                    if value >= setting.min and value <= setting.max then
                        setting.value = value
                    else
                        print("Ungültiger Wert für " .. setting.name .. ". Der Wertebereich ist von " .. setting.min .. " bis " .. setting.max)
                    end
                else
                    print("Ungültiger Wert für " .. setting.name .. ". Der Wert muss eine Zahl sein.")
                end
            elseif setting.type == "boolean" then
                -- Überprüfe, ob der Wert true oder false ist
                if type(value) == "boolean" then
                    setting.value = value
                else
                    print("Ungültiger Wert für " .. setting.name .. ". Der Wert muss true oder false sein.")
                end
            end
            triggerEvent ( "onClientSettingChange", root, setting.name, oldValue, setting.value )
            return true -- Einstellung gefunden und aktualisiert
        end
    end
    return false -- Einstellung nicht gefunden
end

function getClientSetting(settingIdentifier)
    for _, setting in ipairs(clientSettings) do
        if setting.name == settingIdentifier or setting.id == settingIdentifier then
            return setting.value
        end
    end
    return nil -- Einstellung nicht gefunden
end


function onClientSettingChange (settingName, settingOldValue, settingNewValue)

    print("Settings-Geändert", settingName, settingOldValue, settingNewValue)
    applySetting (settingName, settingNewValue)
end
addEvent ( "onClientSettingChange", true )
addEventHandler ( "onClientSettingChange", root, onClientSettingChange )


function applySetting (settingName, value)
    if settingName == "FPS" then
        setFPSLimit(value)
        print("FPS gesetzt", value)
    end

end