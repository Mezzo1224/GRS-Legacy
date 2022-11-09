-- // Gleiche wie  fetchUpdateDetails ()

function fetchUpdateDetailsForHelpmenu ()
    if fileExists(":grs_cache/update/update_"..curVersion..".txt") then
        local updateDetailsFile = fileOpen(":grs_cache/update/update_"..curVersion..".txt")
        local txt = fileRead(updateDetailsFile,  fileGetSize(updateDetailsFile))
        fileClose(updateDetailsFile)
        local txt = "Version: "..curVersion.."\n\nLegenden:\n+ = Neues Feature\n- = Entferntes Feature\n! = Behobener Fehler\n----------------------------\n"..txt
        triggerClientEvent(client, "updateUpdateTextForHelpmenu", client, txt )
    else
        local txt = "Keine Informationen verfügbar für die Version "..curVersion
        triggerClientEvent(client, "updateUpdateTextForHelpmenu", client, txt )
    end
    

end
addEvent ( "fetchUpdateDetailsForHelpmenu", true )
addEventHandler ( "fetchUpdateDetailsForHelpmenu", getRootElement(), fetchUpdateDetailsForHelpmenu )