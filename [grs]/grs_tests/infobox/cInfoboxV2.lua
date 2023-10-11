local infoboxes = {} -- Tabelle zum Speichern der Infoboxen

-- Funktion zum Erstellen einer Infobox
function createInfobox(text, type, time)
    local infobox = {} -- Infobox-Objekt
    local time = (time >= 3000) and time or 5000

    -- Infobox-Eigenschaften
    infobox.text = text
    infobox.type = type
    infobox.duration = time -- Anzeigedauer in Millisekunden (5 Sekunden)

    -- Füge die Infobox zur Tabelle hinzu
    table.insert(infoboxes, infobox)

    -- Wenn es mehr als eine Infobox gibt, verschiebe die anderen nach unten
    local yOffset = 0
    for _, box in ipairs(infoboxes) do
        yOffset = yOffset + 40
    end

    infobox.y = yOffset

    -- Setze einen Timer zum Entfernen der Infobox nach der angegebenen Dauer
    setTimer(function()
        removeInfobox(infobox)
    end, infobox.duration, 1)
end

-- Funktion zum Entfernen einer Infobox
function removeInfobox(infobox)
    for i, box in ipairs(infoboxes) do
        if box == infobox then
            table.remove(infoboxes, i)
            break
        end
    end
end

-- Funktion zum Zeichnen der Infoboxen
function drawInfoboxes()
    for _, infobox in ipairs(infoboxes) do
        local r, g, b
        if infobox.type == "error" then
            r, g, b = 255, 0, 0 -- Rot für Fehler
        elseif infobox.type == "success" then
            r, g, b = 0, 255, 0 -- Grün für Erfolg
        elseif infobox.type == "warning" then
            r, g, b = 255, 255, 0 -- Gelb für Warnung
        else
            r, g, b = 255, 255, 255 -- Weiß für Information (Standard)
        end

        local textWidth, textHeight = dxGetTextSize(infobox.text, 0, 1, 1, "default-bold")
        -- Zeichne den transparenten Hintergrund
        dxDrawRectangle(10, infobox.y, textWidth + 20, textHeight + 10, tocolor(0, 0, 0, 150))

        -- Zeichne das Icon (zum Beispiel ein Text "I" für Information)
        dxDrawText("I", 15, infobox.y + 5, 0, 0, tocolor(r, g, b, 255), 1, "default-bold")

        -- Zeichne den Text
        dxDrawText(infobox.text, 35, infobox.y + 5, textWidth + 35, textHeight + infobox.y + 5, tocolor(255, 255, 255, 255), 1, "default-bold")

    end
end

-- Füge den Infoboxen-Renderer zum "onClientRender"-Event hinzu
addEventHandler("onClientRender", root, drawInfoboxes)

function testInfobox ()
    createInfobox("AFD", "error", 5000)
    createInfobox("AFD der Partei", "warning", 5000)
    createInfobox("AFD der Partei\nund ich liebe cock\n4real", "warning", 9000)

end
testInfobox ()
