-- // Gleiche wie  fetchUpdateDetails ()

function fetchUpdateDetailsForHelpmenu ()
    if fileExists(":grs_cache/update/update_"..SharedConfig["main"].version..".txt") then
        local updateDetailsFile = fileOpen(":grs_cache/update/update_"..SharedConfig["main"].version..".txt")
        local txt = fileRead(updateDetailsFile,  fileGetSize(updateDetailsFile))
        fileClose(updateDetailsFile)
        local txt = "Version: "..SharedConfig["main"].version.."\n\nLegenden:\n+ = Neues Feature\n- = Entferntes Feature\n! = Behobener Fehler\n----------------------------\n"..txt
        triggerClientEvent(client, "updateUpdateTextForHelpmenu", client, txt )
    else
        local txt = "Keine Informationen verfügbar für die Version "..SharedConfig["main"].version
        triggerClientEvent(client, "updateUpdateTextForHelpmenu", client, txt )
    end
    

end
addEvent ( "fetchUpdateDetailsForHelpmenu", true )
addEventHandler ( "fetchUpdateDetailsForHelpmenu", getRootElement(), fetchUpdateDetailsForHelpmenu )


function openHelmenu (player)
    if not getElementClicked ( player ) and vioGetElementData ( player, "loggedin" ) == 1 then
        triggerClientEvent(player, "createHelpmenu", player)
    end
end
addCommandHandler("helpmenu", openHelmenu)