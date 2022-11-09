-- // Gleichzeitig die Standardwerte
defaultConfig = {
    server = {
        VIPXP = 2,
        globalXPBoost = 2, -- // >= 1 = Ausgeschaltet
        forumsync = false,
        noobtime = 0,
        ageRestiction = false, -- Siehe:  Art. 8 DSGVO, zudem ist GTA eh erst ab 16 :)
        betasystem = true,
        sendPaysavecards = true,
        changeFactionCMD = true,
        compatibleDGS = "3.511",
        -- // Forum
        VIPGroupe = 13, 
        teamid = 12, -- ID der Teammitglieder Gruppe"
        betaGroupe = 14,
        adminForumRank = { -- Adminlevel, Gruppenid im Forum
            [8] = 4, 
            [7] = 5,
            [6] = 6,
            [5] = 7,
            [4] = 8,
            [3] = 9,
            [2] = 10,
            [1] = 11
        },
        adminForumView = { -- Aussehen bzw. Benutzerrang (unnötig)
            [8] = 1, 
            [7] = 9, 
            [6] = 10, 
            [5] = 11, 
            [4] = 12, 
            [3] = 13, 
            [2] = 14, 
            [1] = 15
        },
        bonuscodes = {
            ["grsfb"] = 100000,
            ["grsad"] = 100000
        }

    },
    client = {
        testClient = "FischerC",
        testClientBo = false
    },
    shared = {
        version = "1.0",
        isHalloween = true
    }
}




function loadServerConfig ()
    print("Config wird geladen.")
    local result = dbPoll ( dbQuery ( handler, "SELECT * FROM ??", "config"  ), -1 )
    for i=1, #result do
        local idcounter = tonumber ( result[i]["idcounter"])
        print((idcounter-1).." Spieler vorhanden.")
        if not ( result[i]["config"]) then
            dbExec ( handler, "UPDATE ?? SET ?? = ?", "config", "config", toJSON(defaultConfig) )
            print("Es wurde keine Config gefunden. Standardwerte werden hergestellt.")
            config = defaultConfig
        else
            local loadedConfig = toJSON(result[i]["config"], false, "tabs")
            config = loadedConfig
            print("Geladen:")
            print(loadedConfig)

            -- // Test
            print (config.client.." Client")
            print (config.server.." Server")
            print (config.shared.." Shared")
        end
    end
    -- // Standardwerte
end
--loadServerConfig ()


function sendClientConfig (player)
    -- // TODO: Trigger an die cConfig.lua mit der Tabelle config.client
end

function sendSharedConfig (player)
    -- // TODO: Trigger an die sharedConfig.lua mit der Tabelle config.shared
end