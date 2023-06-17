-- // Hilfe Tabs
helpCategory = {}


helpCategory["Erste Schritte"] = {
    text = [[
        Das Hud kann durch Drücken von \"B\" geändert werden.
        An Geldautomaten kann man Geld  vom Konto abheben (s.h. \"Geld\" bzw. \"Clicksystem\")
        In der Stadthalle ( gelber Punkt\nauf der Minimap ) kannst du dir Scheine\n, Ausweise und Fahrzeugslots erwerben oder\nnach einem Job suchen.
        Fahrzeuge findest du am Auto-, Skins am T-Shirt- und Jobs am blauen-Männchen-Symbol auf der Karte".
    ]],
    subCategorys = nil
}

helpCategory["Serverregeln"] = {
    text = [[
        Um jedem Spieler ein faires und spaßiges Spielerlebnis zu bieten besitzt unser Server Regeln
        bezg. Fraktionen, Verhalten gegenüber Spielern undsoweiter. Du kannst die Regeln mit einem
        Klick auf den oberen Reiter "Regeln" um die Regeln zu lesen.
    ]],
    subCategorys = nil
}

helpCategory["Forum"] = {
    text = nil,
    subCategorys = {
        [1] = {title = "Register", text= "REG"},
        [2] = {title = "Login", text= "LOG"},
        [3] = {title = "Bann", text= "Bann"},
        startSubCategory = 1
    },
    startSubCategory = 1
}


-- // Frakktionstexte
factionText = { 
                    [2] = "Cosa Nostra\n\nDie Cosa Nostra besitzt die Pizzeria und verdient nebenbei dadurch Geld. Sie ist die reichste Gang in San Andreas und ist hauptsächlich für Aktionen gegen Polizisten zuständig.",
                    [3] = "Triaden\n\nDie Triaden haben eine der mächtigsten Waffen, die Katana, und eine sehr gute Basis mitten in der Stadt. Sie sind zusammen eine mächtige Gang, die gegen jeden bestehen kann. Befehle können durch /fraktioncommands eingesehen werden.",
                    [4] = "Terroristen\n\nErklärung folgt ..  Befehle können durch /fraktioncommands eingesehen werden.",
                    [7] = "Los Aztecas\n\nLos Aztecas sind die Drogen- und Matsbosse unter den bösen Fraktionen. Sie können bei Töten von Gegnern Materialien einsammeln und diese zu Waffen umbauen. Befehle können durch /fraktioncommands eingesehen werden.",
                    [9] = "Angels of Death\n\nDie Angels of Death sind die Biker unter den Gangs. Sie können mit /formation und ihren Freeways sehr schnell fahren und jeden überholen oder abschütteln. Befehle können durch /fraktioncommands eingesehen werden.",
                    [12] = "",
                    [13] = "",
					[1] = "San Fierro Police Department\n\nDeine Aufgabe als Polizist ist es,\nfür Ordnung auf der Strasse zu sorgen.\nUm den Polizeicomputer zu verwenden,\ndrücke die Spez. Missionen-Taste\nin einem Polizeifahrzeug oder\nklicke einen Computer an.\n\nBefehle:\n/tazer (Hotkey: 1)\n/(c)arrest [Name] [Zeit] [Geldstrafe] [Kaution]\n/takeweapons [Name] - Entwaffnen\n/cuff [Name]\n/takeillegal [Name] /frisk [Name]\n/duty /swat /offduty\n/t /g /mv /barricade\n/ticket /fstate /fdraw",
					[6] = "Federal Bureau of Investigation\n\nDeine Aufgabe als Agent ist es,\nAktionen aufzuhalten und Verbrecher zu fassen.\nUm den Polizeicomputer zu verwenden,\ndrücke die Spez. Missionen-Taste\nin einem SFPD/FBI Fahrzeug oder\nklicke einen Computer an. Befehle können durch /fraktioncommands eingesehen werden.", }
basicFactionInfo = [[
    -- Fraktionsverwaltung --
    Mit /fraktion kann du das Fraktionsfenster öffnen. 
    Dort kannst du Fahrzeuge erwerben, als Leiter Mitglieder verwalten oder Fraktionsinterne Notizen schreiben.


]]



-- // Jobtexte
    jobText = {  [0] = "Jobs\n\nBei Ultimate-Reallife verschiedene Arten, an Geld\nzu kommen. Am Anfang ist es am besten, sich\neinen Job zu suchen. Dazu trete in der\nStadthalle in den entsprechenden Kegel-\nnun hast du eine Markierung auf dem Radar,\nwo sich der Arbeitgeber befindet.\n\nInfo: Tippe /job, wenn du sie\nlöschen willst!",
    ["fischer"] = "Job - Fischer\n\nDu bist im Moment Fischer - das heißt, du\nkannst Geld dadurch verdienen, indem du mit den\nFischerbooten, die durch ein Ankersymbol auf der\nKarte vermerkt sind, Checkpoints abfährst.\nJe mehr Fische gefangen werden, desto geringer ist der\nPreis, der für weitere Fische gezahlt wird -\mjedoch steigt dieser pro Stunde wieder an.\nBefehle können per /commands eingesehen werden!",
    ["taxifahrer"] = "Job - Taxifahrer\n\nDu bist im Moment Taxifahrer - das heißt, du\nkannst Gelyd dadurch verdienen, indem du mit dem\nTexi ( erhältlich am $-Symbol auf der Karte )\nLeute von Ort zu Ort transportierst.\nDazu drücke die Spezialmissionen-Taste und\ndein Taxischild leutet auf. Nun zahlt dir jeder,\nder in dein Taxi steigt pro Zeit Geld.\nBefehle können per /commands eingesehen werden!",
    ["dealer"] = "Job - Dealer\n\nDu bist im Moment Dealer - das heißt, du\nkannst Geld dadurch verdienen, indem du Drogen\nan deine Mitspieler verkaufst ( /givedrugs oder\nim Clickmenü unter \"Geben\" ). Neue\n\"Ware\" bekomsmt du, in dem du entweder\nfür Geld auf der Farm\nStoff kaufst oder aber Minimissionen\nmachst ( Lila Figur auf der Minimap ).\nBefehle können per /commands eingesehen werden!",
    ["mechaniker"] = "Job - Mechaniker\n\nDu bist im Moment Mechaniker, d.h. du\nbist in der Lage, mit /repair [Name] [Preis]\nFahrzeuge deiner Mitspieler gegen Geld zu\nreparieren. Ausserdem kannst du Fahrzeuge von\nanderen Spielern Nitro einbauen.\nBefehle können per /commands eingesehen werden!",
    ["wdealer"] = "Job - Waffendealer\n\nDu bist im Moment Waffendealer, d.h. du\nbist in der Lage, dir alle 10 Minuten\nneue Materialien mit /buymats beim Jobicon\nzu kaufen. Wenn du genug Materialien hast,\nkannst du mit /gunhelp eine Liste\nvon mgl. Waffen anzeigen, die du\ndann mit /sellgun [Name]\n[Gegenstand] verkaufen kannst.\nBefehle können per /commands eingesehen werden!",
    ["trucker"] = "Job - Trucker\n\nDu bist im Moment Trucker, d.h. du\nkannst dir einen Truck gegen Vorschuss bei\ndem Truck-Icon mieten, und zu den ange-\ngebenen Koordinaten bringen - dort erhaelst\ndu dann dein Geld. Besser bezahlte\nAuftraege kannst du mit hoeherem Trucker-\nLevel ausfuehren (steigt bei erfolgreichen\nTransporten), jedoch nimmt der Schwierigkeitsgrad\nzu.\nBefehle können per /commands eingesehen werden!",
    ["pizzaboy"] = "Job - Pizzabote\n\nDu bist im Moment Pizzabote, d.h. du kannst dein Geld durch das Beliefern von Pizza verdienen.\nBefehle können per /commands eingesehen werden!",
    ["airport"] = "Job - Flughafenmitarbeiter\n\nDu arbeitest im Moment am Flughafen\nvon San Fierro.\nJe höher dein Flughafen-Level ist,\ndesto besser bezahlt kannst du arbeiten\n- vom Kofferpacker bis zum Jet-Pilot!\nUm einen Auftrag anzunehmen, gehe\nin das \"i\"-Symbols unterhalb des Terminals\nbeim Eingang des Parkhauses, um\nAufträge anzunehmen.\nBefehle können per /commands eingesehen werden!",
    ["hitman"] = "Job - Hitman\n\nDu arbeitest im Moment als Profikiller.\nBefehle können per /commands eingesehen werden!",
    ["hotdog"] = "Job - Hotdogverkäufer\n\nDu arbeitest im Moment als Hotdog-\nverkaeufer. Begib dich zum Besteck-Symbol,\nschnapp dir einen Hotdogwagen, belade ihn\nund klicken auf einen Spieler,\nwährend du im Truck sitzt und waehle \"geben\"\n->\"job\".\n\nBefehle können per /commands eingesehen werden!",
    ["streetclean"] = "Job - Straßenreinigung\n\nDu arbeitest im Moment als\nStraßenreiniger; Begib dich zum\nSchrottplatz am Fuße des Mt. Chilliard,\num mit der Arbeit zu beginnen.\nBefehle können per /commands eingesehen werden!",
    ["farmer"] = "Job - Farmer\n\nDu arbeitest im Moment als\nFarmer. Begib dich zur\nFarm an der Grenze von SF\nund LV nahe der Fleischberg-\nFabrik für mehr Infos.\nBefehle können per /commands eingesehen werden!",
    ["bauarbeiter"] = "Job - Bauarbeiter\n\nDu arbeitest im Moment als Bauarbeiter.\nAb bestimmten Leveln kannst du besser verdienen.\nBefehle können per /commands eingesehen werden!",
    ["busfahrer"] = "Job - Busfahrer\n\nDu bist Busfahrer, das heißt dein Job ist es\nvon Busstation zu Busstation\nzu fahren und falls vorhanden Passanten\nmitzunehmen.\nBefehle können per /commands eingesehen werden!",
    ["transporteur"] = "\nBefehle können per /commands eingesehen werden!",
    ["zugfuehrer"] = "Job - Zugführer\n\nDein Job ist es von Station zu Station\nzu fahren und\nfalls möglich Passanten mitzunehmen.\nBefehle können per /commands eingesehen werden!",

    ["tramfuehrer"] = "Job - Tramführer\n\nAls Tramführer ist es\ndeine Aufgabe durch San Fierro\nzu fahren und Leute\neinsteigen zu lassen.\nBefehle können per /commands eingesehen werden!" }

    --[[
for i,theTable in pairs(helpCategory) do
    print(theTable, i, theTable.text)
    if theTable.subCategorys then
        print("Sub von "..i..", startSubCategory: "..theTable.startSubCategory)
        for subI,theSubTable in pairs(theTable.subCategorys) do
          print(subI, theSubTable )
        end
  end
end--]]