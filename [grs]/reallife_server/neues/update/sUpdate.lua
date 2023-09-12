updateCache = {}

function updateCacheFiles ()
    if not updateCache[curVersion] then
        updateCache[curVersion] = #updateCache
        local jsonuodate = toJSON(updateCache)
        local updateCacheFile = fileOpen(":grs_cache/update/update_cache.txt")
        fileWrite(updateCacheFile, jsonuodate)
        fileClose(updateCacheFile)
        fetchUpdateCache()
    end
end

function fetchUpdateCache ()
    if fileExists(":grs_cache/update/update_cache.txt") then
        local updateCacheFile = fileOpen(":grs_cache/update/update_cache.txt")
        local txt = fileRead(updateCacheFile,  fileGetSize(updateCacheFile))
        if string.len(txt) > 0 then
            updateCache = fromJSON(txt)
            fileClose(updateCacheFile)
            -- Tabelle auflisten test
            updateCacheFiles ()
        else
            updateCacheFiles ()
        end
    else
        local updateCacheFile = fileCreate(":grs_cache/update/update_cache.txt")                
        fileClose(updateCacheFile)                
        fetchUpdateCache ()               
    end
end
fetchUpdateCache ()


function fetchUpdateDetails ()
    if fileExists(":grs_cache/update/update_"..curVersion..".txt") then
        local updateDetailsFile = fileOpen(":grs_cache/update/update_"..curVersion..".txt")
        local txt = fileRead(updateDetailsFile,  fileGetSize(updateDetailsFile))
        fileClose(updateDetailsFile)
        local txt = "Legenden:\n+ = Neues Feature\n- = Entferntes Feature\n! = Behobener Fehler\n----------------------------\n"..txt
        triggerClientEvent(client, "updateUpdateText", client, txt )
    else
        local txt = "Keine Informationen verfügbar."
        triggerClientEvent(client, "updateUpdateText", client, txt )
    end
    

end
addEvent ( "fetchUpdateDetails", true )
addEventHandler ( "fetchUpdateDetails", getRootElement(), fetchUpdateDetails )


function createNewUpdate (player)
    if isAdminLevel ( player, 7 )  and not getElementClicked ( player )  then
        triggerClientEvent(player, "makeNewUpdate_window", player)
    else
        triggerClientEvent ( player, "infobox_start", getRootElement(), "Nicht berechtigt.", 5000, 125, 0, 0 )
    end
end
addCommandHandler("nupdate", createNewUpdate)


function makeNewUpdate (version, txt)
        if fileExists(":grs_cache/update/update_"..version..".txt") then
            fileDelete(":grs_cache/update/update_"..version..".txt")
        end
        local updateDetailsFile = fileCreate(":grs_cache/update/update_"..version..".txt")
        fileWrite(updateDetailsFile, txt)
        fileClose(updateDetailsFile)
        -- // Cache Update
        local updateCacheFile = fileOpen(":grs_cache/update/update_cache.txt")
        updateCache[version] = 1
        fileWrite(updateCacheFile, toJSON(updateCache) )
        fileClose(updateCacheFile)

        if version == curVersion then
            local players = getElementsByType ( "player" ) 
            for i,player in ipairs(players) do  
                if vioGetElementData ( player, "loggedin" ) == 1 then
                    outputChatBox("Neuer Changelog zur Version "..version, player, 200, 200, 0)
                    triggerClientEvent(player, "showNewUpdate", player)
                end
            end
        else
            for player, index in pairs(adminsIngame) do 			
                outputChatBox("Neuer Changelog zur Version "..version.." von "..getPlayerName(client), player, 200, 200, 0)
            end
    end
    outputLog ("Neuer Changelog zur Version "..version.." von "..getPlayerName(client), "admin" )
end
addEvent ( "makeNewUpdate", true )
addEventHandler ( "makeNewUpdate", getRootElement(), makeNewUpdate )

function getUpdateFile(version)
    if fileExists(":grs_cache/update/update_"..version..".txt") then
        local updateDetailsFile = fileOpen(":grs_cache/update/update_"..version..".txt")
        local txt = fileRead(updateDetailsFile,  fileGetSize(updateDetailsFile))
        triggerClientEvent(client, "updateNewUpdateText", client, txt )
        fileClose(updateDetailsFile)
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "Versionnummer existiert\nnicht.", 5000, 125, 0, 0 )
    end

end
addEvent ( "getUpdateFile", true )
addEventHandler ( "getUpdateFile", getRootElement(), getUpdateFile )