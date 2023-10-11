-- // Tuning-Shop Generation


function tuningShopMarkerHit (hitElement, matchingDimension)
    if matchingDimension and getElementType(hitElement) == "player"  then
        local player = hitElement
        if isPedInVehicle(player) then
            local model = getElementModel( getPedOccupiedVehicle ( player ) )
            print("Enter-Marker")
            triggerClientEvent(player, "focusVehicle", player, model, tuningShop)
        else
            print("Du bist in keinen Fahrzeug.")
        end
    end
end


function createMarkerAndBlip(shopName)
    local shop = tuningShops[shopName]
    local markerPos = shop.position["marker"]
    local blipPos = shop.position["blip"]

    -- // Marker erstellen
    local marker = createMarker(markerPos[1], markerPos[2], markerPos[3], "cylinder", 2, 255, 0, 0, 150)
    addEventHandler("onMarkerHit", marker, function(hitElement, matchingDimension)
        if matchingDimension and getElementType(hitElement) == "player"  then
            local player = hitElement
            if isPedInVehicle(player) then
                print("Enter-Marker")
                triggerClientEvent(player, "focusVehicle", player, shopName)
            else
                print("Du bist in keinen Fahrzeug.")
            end
        end
    end)

    -- Erstellen Sie den Blip
    local blip = createBlip(blipPos[1], blipPos[2], blipPos[3], 0, 2, 255, 0, 0, 255, 0, 99999)

    -- Hier können Sie weitere Aktionen oder Funktionen für den Tuning Shop hinzufügen
end

function loadTuningShops ()
    for shopName, _ in pairs(tuningShops) do
        createMarkerAndBlip(shopName)
    end
end
loadTuningShops ()