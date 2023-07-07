
function newInfobox (player, text, ...)
    triggerClientEvent ( player, "infobox", getRootElement(), text, "info", 15)
end


function infobox (player, text, type, time)
    triggerClientEvent ( player, "infobox", getRootElement(), text, type, 15)
end
