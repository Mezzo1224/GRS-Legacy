-- // Neue Einstellungen
local defaultUserSettings = {
    settings = {
		-- // UI
		["joinmessage"] = true,
		["newInfobox"] = 0,
		["newInfoboxNotice"] = 0,
		["showForenReg"] = true,
		["selfMenuOnClick"] = false,
		["showXPBoostNotice"] = false,
		["showVersionNotice"] = false,
		["showGreenzoneWarning"] = true,
		-- // Spieleinstellungen
		["betamapstream"] = false,
		["fogdistance"] = math.floor(getFogDistance()),
		["clouds"] = 1,
		["renderdistance"] = math.floor(getFarClipDistance()),
		["fps"] = 60,

		-- // Forum
		["syncForumState"] = 0,
		["syncForumGroups"] = 0,
		["getForumConversations"] = 0,

		-- // Sonstiges
		["autoSaveSettings"] = 600

	},
	keybinds = {
		["Helpmenu"] = "F1",
		["Ticketmenu"] = "F2",
		["Selfmenu"] = "-",
		["Togglehud"] = "B",
	}
}
local jsonSettings = toJSON( defaultUserSettings, true, "tabs" )
local userSettings = nil
local filePath = ":grs_cache/settingsV2_"..getPlayerName (lp)..".xml"

function loadSettings () 
    local node = xmlLoadFile ( filePath )
    if node then
        local settingsChild = xmlFindChild ( node, "settings", 0 )
        local settings = xmlNodeGetValue ( settingsChild )
		userSettings =  fromJSON ( settings ) 
		applySettings () 
        xmlSaveFile(node)
        xmlUnloadFile(node)
	end
end 

function createSettings ()

	local settingsFile = xmlCreateFile(filePath,"settingsFile")
	xmlNodeSetValue (xmlCreateChild ( settingsFile, "settings"), jsonSettings )
	print("Einstellungen wurden erstellt.")
	xmlSaveFile(settingsFile)
	xmlUnloadFile(settingsFile)
	intSettings () 
end

function intSettings () 
	local settingsFile = xmlLoadFile ( filePath )
	if settingsFile then
		xmlUnloadFile( settingsFile )
		loadSettings ()
	else
		createSettings ()
	end
end

function applySettings () 
	-- // Einstellungen
	getSetting2 ("joinmessage")
	getKeybind ("Helpmenu")
	-- // Keybinding
	bindKey( userSettings.keybinds.Helpmenu , "down", createHelpmenu  )
	bindKey ( userSettings.keybinds.Ticketmenu, "down", function(key,state)
    	print(key, state)
		triggerServerEvent ( "startReport", lp, lp )
    end)

	bindKey( userSettings.keybinds.Selfmenu, "down",  showSelfMenu, false )
	bindKey( userSettings.keybinds.Togglehud, "down", switchHUD)

	setTimer ( saveSettings, 1000*getSetting2("autoSaveSettings"), 0)
end

function saveSettings ()
	local settingsToSave = toJSON( userSettings, true, "tabs" )
	print ( "Save-Settings", settingsToSave)

	local settingsFile = xmlLoadFile ( filePath )
	if settingsFile then
		xmlNodeSetValue ( xmlFindChild ( settingsFile, "settings", 0 ), settingsToSave )
		outputConsole("Einstellungen abgespeichert.")
		xmlSaveFile(settingsFile)
		xmlUnloadFile(settingsFile)
	end
end
addEventHandler( "onClientResourceStop", getRootElement( ), saveSettings ) 
-- // Set
function changeKeybind (func, key)
	local keybinds = userSettings.keybinds
	userSettings.keybinds[func] = key


end

function changeSetting (setting, value)

	userSettings.settings[setting] = value
end


-- // Get
function getKeybind ( func )
	local returnKeybind = userSettings.keybinds[func]
	print( "Keybind", userSettings.keybinds,  returnKeybind )

	return returnKeybind
end

function getSetting2 (setting)
	local getSetting = userSettings.settings[setting]
	print( "Settings", userSettings.settings, getSetting )

	return getSetting
end

function getSetting (setting)
	-- // Placeholder
	return 0
end