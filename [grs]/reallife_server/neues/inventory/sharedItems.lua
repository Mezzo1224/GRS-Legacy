items = {
    ["Zeitung"] = {
        maxamount = 1,
        cmd = "readnewspaper",
        text = "Eine neue Ausgabe\ndes \"Liberty Tree\"-\nThe Truth is, what\nyou make of it!",
        type = false,
        image = "liberty_tree.bmp",
    },
    ["Kanister"] = {
        maxamount = 0,
        cmd = "fill",
        text = "Ein Kanister erlaubt\nes dir, mit /fill ein beliebi-\nges Fahrzeug mit 15 \nLitern Benzin zu fuellen.",
        type = "fuel",
        image = "liberty_tree.bmp",
    },
    ["Materialien"] = {
        maxamount = 0,
        cmd = "mats",
        text = "Materialien bilden den\nGrundstoff fuer Waffen,\nsie sind - ebenso wie\nDrogen - illegal.\n\nBefehl: /sellgun",
        type = false,
        image = "benzin.bmp"
    },
    ["Drogen"] = {
        maxamount = 0,
        cmd = "usedrugs",
        text = "Mit einem Wuerfel kannst\neine Beliebige Zahl\nzwischen 1 und 6\nerzeugen.\n\nBefehl:\n/dice",
        type = false,
        image = "drugs.bmp"
    },
    ["Zigaretten"] = {
        maxamount = 0,
        cmd = "smoke",
        text = "Zigaretten kannst du mit\n/smoke rauchen.",
        type = "zigaretten",
        image = "cigaretts.bmp"
    }, 
    ["Erste Hilfe"] = {
        maxamount = 0,
        cmd = "eat",
        text = "Auch als Medikit bekannt\nund stellt sofort 15\nHP wieder her.\nBefehle: /eat",
        type = false,
        image = "aid.bmp"
    },
    --- // WEITER
    ["Bier"] = {
        maxamount = 0,
        cmd = "eat",
        text = "Es ist kein Radler, also nicht weg schmeißen!",
        type = false,
        image = "beer.bmp"
    },
    ["Burger"] = {
        maxamount = 0,
        cmd = "eat",
        text = "Natürlich Rein pfanzlich.",
        type = false,
        image = "burger.bmp"
    },
    ["Snack"] = {
        maxamount = 0,
        cmd = "eat",
        text = "Am besten um 9:30 genießen.",
        type = false,
        image = "snack.bmp"
    },
    ["Suessigkeiten"] = {
        maxamount = 0,
        cmd = "eat",
        text = "Happy Halloween!\nMoegliche Nebenwirkung:\nKopfschmerz, Haemo-\nrieden oder kurz-\nzeitiges Erblinden.\nNicht fuer Kinder unter\n20 Jahren geeignet!",
        type = false,
        image = "suess.bmp"
    },
    ["Ehre"] = {
        maxamount = 1,
        cmd = false,
        text = "Verliehen fuer\nbesondere Verdienste\nim Berreich\nLuftwaffe.",
        type = false,
        image = "orden_1.bmp"
    },
    ["Luftwaffe"] = {
        maxamount = 1,
        cmd = false,
        text = "Verliehen fuer\nbesondere Verdienste\nim Berreich\nLuftwaffe.",
        type = false,
        image = "orden_2.bmp"
    },
    ["Verdienst"] = {
        maxamount = 1,
        cmd = false,
        text = "Verliehen fuer\nbesondere Verdienste.",
        type = false,
        image = "orden_3.bmp"
    },
    ["Notebook"] = {
        maxamount = 1,
        cmd = "internet",
        text = "Ein brandneues Notebook\nder Firma \"Fruit\"- mit\nW-Lan und Internet-\nzugang!",
        type = false,
        image = "fruit.bmp"
    },
    ["Handheld"] = {
        maxamount = 1,
        cmd = "blocks",
        text = "Zeitlose Klassiker\nueberall geniessen!\nZum starten tippe\n/blocks [1-10]",
        type = false,
        image = "gbc.bmp"
    },
    ["Chips"] = {
        maxamount = 0,
        cmd = false,
        text = "Chips aus einem\nder Casinos.\nJe einen Dollar wert.",
        type = false,
        image = "chip.png"
    },
    --- FFFF
    ["Hufeisen"] = {
        maxamount = 0,
        cmd = false,
        text = "Hufeisen sind in ganz\nLas Venturas versteckt.\nFinde alle 25 fuer eine\nspezielle Belohnung...",
        type = false,
        image = "horseshoe.png"
    },
    ["Geschenk"] = {
        maxamount = 1,
        cmd = "presents",
        text = "Dieses Paeckchen enthaelt\netwas zufaelliges -\nvon Geld bis zu\nAutos ist alles\ndabei!",
        type = false,
        image = "present.bmp"
    },
    ["Schach"] = {
        maxamount = 1,
        cmd = false,
        text = "Tippe /chess [Name],\num jemanden zu einer\nPartie Schach herauszu-\nfordern.",
        type = false,
        image = "chess.png"
    },
    ["Angel"] = {
        maxamount = 1,
        cmd = "fish",
        text = "Mit einer Angel kannst\ndu Fische oder anderes\naus dem Meer fangen.\nJe nach Skill hast\ndu unterschiedliche\nChancen.\nAlternativ: /fish",
        type = false,
        image = "fishing/pole.png"
    },
    ["Haken"] = {
        maxamount = 0,
        cmd = false,
        text = "Zum Angeln brauchst\ndu Haken.",
        type = false,
        image = "chip.png"
    },
    ["Koeder"] = {
        maxamount = 0,
        cmd = false,
        text = "Ohne Keoder kannst\ndu keine Fische\nfangen.",
        type = false,
        image = "fishing/worm.png"
    },
    ["Fernglas"] = {
        maxamount = 1,
        cmd = "fglass",
        text = "/fglass zur schnelleren\nBenutzung.",
        type = false,
        image = "chip.png"
    },
    ["Geld"] = {
        maxamount = 1,
        cmd = false,
        text = "Geld ist das Blut der Erde,\nkomm schenk mir einnnn!",
        type = false,
        image = "chip.png"
    },

}

--[[
itemTexts = {

 ["Hufeisen"]="Hufeisen sind in ganz\nLas Venturas versteckt.\nFinde alle 25 fuer eine\nspezielle Belohnung...",
 ["Geschenk"]="Dieses Paeckchen enthaelt\netwas zufaelliges -\nvon Geld bis zu\nAutos ist alles\ndabei!",
 ["Schach"]="Tippe /chess [Name],\num jemanden zu einer\nPartie Schach herauszu-\nfordern.",
 ["Angel"]="Mit einer Angel kannst\ndu Fische oder anderes\naus dem Meer fangen.\nJe nach Skill hast\ndu unterschiedliche\nChancen.\nAlternativ: /fish",
 ["Haken"]="Zum Angeln brauchst\ndu Haken.",
 ["Koeder"]="Ohne Keoder kannst\ndu keine Fische\nfangen.",
 ["Fernglas"]="/fglass zur schnelleren\nBenutzung.",
 ["Kuerbis"]="Kann mit /halloween\nzum Einloesen fuer\nBoni verwendet werden.",
 ["Phosphor"]="Phosphor Munnition\nsetzt gegner kurz-\nzeitig in Brand.",
 ["Dum-Dum"]="Dum-Dum Geschosse\nverursachen zusaetzlichen\nSchaden an un-\ngepanzerten Zielen.",
 ["Panzerbrechend"]="Panzerbrechende\nGeschosse verursachen\nBonusschaden an\ngepanzerten Zielen.",
 ["Vulcano"]="Explosivgeschosse.",
 ["Pfeffer"]="Beim Einschlag wird\neine geringe Menge\nPfefferspray frei-\ngesetzt.",
 ["Halloween-Munition"]="Deine Ziele\n werden buchstaeblich\nden Kopf verlieren."
 }
 
itemImage = { 
 ["Notebook"]="fruit.bmp",
 ["Handheld"]="gbc.bmp",
 ["Chips"]="chip.png",
 ["Hufeisen"]="horseshoe.png",
 ["Geschenk"]="present.bmp",
 ["Schach"]="chess.png",
 ["Angel"]="fishing/pole.png",
 ["Haken"]="fishing/hook.png",
 ["Koeder"]="fishing/worm.png",
 ["Fernglas"]="binoculars.png",
 ["Kuerbis"]="easteregg.bmp",
 ["Phosphor"]="special_ammo.bmp",
 ["Dum-Dum"]="special_ammo.bmp",
 ["Panzerbrechend"]="special_ammo.bmp",
 ["Vulcano"]="special_ammo.bmp",
 ["Pfeffer"]="special_ammo.bmp",
 ["Halloween-Munition"]="special_ammo.bmp"
 }
 
itemCommand = { [
 ["Hanfsamen"]="grow",
 ["Notebook"]="internet",
 ["Handheld"]="blocks",
 ["Chips"]="chips",
 ["Geschenk"]="presents",
 ["Angel"]="fish",
 ["Fernglas"]="fglass",
 ["Kuerbis"]="halloween",
 ["Phosphor"]="useAmmo1",
 ["Dum-Dum"]="useAmmo2",
 ["Panzerbrechend"]="useAmmo3",
 ["Vulcano"]="useAmmo4",
 ["Pfeffer"]="useAmmo5",
 ["Halloween-Munition"]="useAmmo6"
 }

itemType = { ["Kanister"]="fuel",
 ["Drogen"]="drugs", 
 ["Wuerfel"]="dice",
 ["Zigaretten"]="zigaretten",
 ["Materialien"]="mats",
 ["Hanfsamen"]="grow",
 ["Notebook"]="notebook",
 ["Geschenk"]="presents",
 ["Schach"]="chess",
 ["Bonusei"]="easterEgg"
 }
]]