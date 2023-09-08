vehTokenUI = {}


function showVehicleTokenInfo (nextDate, currentRank)

    vehTokenUI["window"] = DGS:dgsCreateWindow(1154, -40, 299, 355, "Fahrzeug-Token", false)
    DGS:dgsCenterElement(vehTokenUI["window"], false, true) 
    local windowX, windowY = DGS:dgsGetPosition( vehTokenUI["window"] )
    DGS:dgsMoveTo(vehTokenUI["window"], windowX ,369,false,"Linear",1000) --Set Animation
    DGS:dgsWindowSetSizable(vehTokenUI["window"], false)
    DGS:dgsWindowSetMovable(vehTokenUI["window"], false)
    DGS:dgsSetProperty(vehTokenUI["window"],"ignoreTitle", true)
    DGS:dgsWindowSetCloseButtonEnabled(vehTokenUI["window"], false)

    vehTokenUI["image"] = DGS:dgsCreateImage(119, 20, 61, 68, "/gotPremiumVehToken/vehicle.png", false,vehTokenUI["window"])
    vehTokenUI["infoText"] = DGS:dgsCreateLabel(35, 88, 228, 33, "Du hast aufgrund deines Premium-Ranges '"..currentRank.."' einen Fahrzeug-Token erhalten.", false, vehTokenUI["window"])
    vehTokenUI["whatTitle"] = DGS:dgsCreateLabel(10, 127, 91, 20, "Was bringt er ?", false, vehTokenUI["window"])
    vehTokenUI["what"] = DGS:dgsCreateLabel(10, 147, 279, 31, "Mit einem Fahrzeug-Token kannst du ein beliebiges Fahrzeug in deinem Besitz, in ein anderes verwandeln.", false, vehTokenUI["window"])
    vehTokenUI["howTitle"] = DGS:dgsCreateLabel(10, 189, 128, 20, "Wie verwende ich ihn ?", false, vehTokenUI["window"])
    vehTokenUI["how"] = DGS:dgsCreateLabel(10, 209, 284, 20, "Mit dem Befehl /pcar [SLOT] [ID/NAME]", false, vehTokenUI["window"])
    vehTokenUI["whenTitle"] = DGS:dgsCreateLabel(10, 223, 279, 20, "Wann erhalte ich meinen nächsten Token ?", false, vehTokenUI["window"])
    vehTokenUI["when"] = DGS:dgsCreateLabel(10, 243, 284, 47, "Sollte dein Premium-Rang bestehen bleiben, ist es der DATUM. Wir wünschen dir viel Spaß mit deinem neuen Fahrzeug!", false, vehTokenUI["window"])
    vehTokenUI["alrightButton"] = DGS:dgsCreateButton(94, 292, 110, 30, "Verstanden", false, vehTokenUI["window"])
    vehTokenUI["showAgain"] = DGS:dgsCreateCheckBox(10, 323, 279, 15, "Fenster ggf. wieder anzeigen", true, false, vehTokenUI["window"])    

    -- // Einstellungen
    DGS:dgsSetProperty(vehTokenUI["infoText"],"alignment", {"center", "center"})
    DGS:dgsSetProperty(vehTokenUI["image"],"alignment",  {"center", "center"})
    DGS:dgsSetProperty(vehTokenUI["infoText"],"wordBreak",true)

    DGS:dgsSetProperty(vehTokenUI["what"],"font","default-bold-small")
    DGS:dgsSetProperty(vehTokenUI["how"],"font","default-bold-small")
    DGS:dgsSetProperty(vehTokenUI["when"],"font","default-bold-small")

    DGS:dgsSetProperty(vehTokenUI["what"],"wordBreak",true)
    DGS:dgsSetProperty(vehTokenUI["how"],"wordBreak",true)
    DGS:dgsSetProperty(vehTokenUI["when"],"wordBreak",true)
    
    DGS:dgsSetProperty(vehTokenUI["alrightButton"], "color", {tocolor(14, 194, 17, 255), tocolor(11, 153, 13, 255), tocolor(14, 207, 17, 255)})

    addEventHandler ( "onDgsMouseClick", vehTokenUI["alrightButton"], closeTokenWindow  )
end

function closeTokenWindow ()
    local showAgain = DGS:dgsCheckBoxGetSelected(vehTokenUI["showAgain"])
    print(tostring(showAgain).. " zeigen?")
    DGS:dgsCloseWindow(vehTokenUI["window"])
end
--showVehicleTokenInfo ("18.08.2022", "Titan")