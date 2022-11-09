function newInfobox (player, msg, type, r, g, b, alpha, showTimeInSec, ownTypeText, tr, tg, tb)
    if not r then
        r = 255
    end
    if not g then
        g = 255
    end
    if not b then
        b = 255
    end
    triggerClientEvent ( player, "newInfobox", getRootElement(), msg, type, r, g, b, alpha, showTimeInSec, ownTypeText, tr, tg, tb )
end

