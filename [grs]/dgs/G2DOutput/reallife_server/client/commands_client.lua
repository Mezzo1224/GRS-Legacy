
----------GUI To DGS Converted----------
if not getElementData(root,"__DGSDef") then
	setElementData(root,"__DGSDef",true)
	addEvent("onDgsEditAccepted-C",true)
	addEvent("onDgsTextChange-C",true)
	addEvent("onDgsComboBoxSelect-C",true)
	addEvent("onDgsTabSelect-C",true)
	function fncTrans(...)
		triggerEvent(eventName.."-C",source,source,...)
	end
	addEventHandler("onDgsEditAccepted",root,fncTrans)
	addEventHandler("onDgsTextChange",root,fncTrans)
	addEventHandler("onDgsComboBoxSelect",root,fncTrans)
	addEventHandler("onDgsTabSelect",root,fncTrans)
	loadstring(exports.dgs:dgsImportFunction())()
end
----------GUI To DGS Converted----------

local allCommands = {
	["account"] = { 	"/newpw [neuesPW] [neuesPW] - Ändert das Passwort",
						"/auto [0/1] - Speichert Passwort für nächsten Login",
						"/self - Zeigt das Selfmenü",
						"/shader - Öffnet das Shader-Fenster",
						"/save - Speichert Position & Waffen und geht Offline" },
					
	["fahrzeug"] = { 	"/race [Name] - Fordert jemanden zum Rennen heraus",
						"/eject [Name/all] - Schmeißt jemanden/alle aus dem Auto",
						"/userc - Benutzt ein RC-Fahrzeug",
						"/limit [Anzahl] - Benutzt das Tempomat",
						"/stoplimit - Stoppt das Tempomat",
						"/dellack - Löscht den Lack",
						"/navi - Benutzt das Navigationsgerät",
						"/fill - Benutzt einen Benzinkanister",
						"/vehhelp - Zeigt Befehle für Fahrzeuge" },
						
	["admin"] = { 		"/report - Öffnet das Report-Fenster",
						"/warns - Zeigt alle Warns an",
						"/checkwarns [Name] - Zeigt alle Warns eines Spielers an",
						"/admins - Zeigt alle Admins an",
						"/admincommands - Zeigt Adminbefehle für deinen Rang an" },
	
	["polizei"] = { 	"/ergeben - Stellen mit Wanteds am PD",
						"/jailtime - Zeigt die verbleibende Knastzeit an",
						"/bail - Bezahlt die Kaution falls vorhanden",
						"/accept test - Nimmt den Drogentest vom Polizisten an",
						"/accept ticket - Nimmt ein Ticket vom Polizisten an" },
						
	["spiele"] = {		"/blocks - Startet Tetris",
						"/stopblocks - Stoppt Tetris",
						"/chess - Startet Schach",
						"/accept chess - Nimmt Schachangebot an",
						"/dice - Würfelt" },
						
	["job"] = {			"/job - Nimmt einen Job an",
						"/quitjob - Legt einen Job ab",
						"/zugjob - Startet Zugjob",
						"/endjob - Bricht Mülljob ab",
						"/sellhotdog [Preis] [Ziel] - Verkauft jemandem Hotdogs",
						"/accepthotdog - Nimmt das Angebot für den Hotdog an",
						"/cancel job - Bricht einen Job ab",	
						"/fish - Benutzt die Angel",
						"/sellfish [Slot] - Verkauft Fisch"	},
						
	["taxi"] = {		"/service taxi - Das selbe wie /call 400",
						"/accept taxi - Nimmt einen Taxiauftrag an",
						"/cancel taxi - Bricht einen Taxiauftrag ab" },
						
	["mechaniker"] = {	"/repair [Name] [Preis] - Repariert das Auto von jemandem für Geld",
						"/acceptrepair - Nimmt das Angebot einer Reperatur an",
						"/tunen [Name] [Preis] - Bietet jemanden Nitro für sein Auto an",
						"/accepttune - Nimmt das Angebot für Nitro an" },
						
	["mats"] = {		"/buymats - Kauft Mats am Waffendealer-Jobmarker",
						"/gunhelp - Zeigt Matspreise der Waffen an",
						"/sellgun [Name] [Waffe] [Ammo] - Verkauft eine Waffen an jemanden" },
						
	["handy"] = {		"/handy - Zeigt das Handy",
						"/sms [Nummer] [Text] - Schreibt einer Nummer einen Text",
						"/call [Nummber] - Ruft eine Nummer an",
						"/hup - Legt auf",
						"/pup - Nimmt einen Anruf an",
						"/number [Name] - Ruft Nummer des Spielers auf" },
						
	["drogen"] = {		"/usedrugs - Benutzt Drogen",
						"/buydrugs [Anzahl] - Kauft Drogen",
						"/givedrugs [Ziel] [Anzahl] - Gibt jemandem Drogen", 
						"/grow weed - Pflanzt Drogen an" },
						
	["reporter"] = {	"/endlive - Beendet den Live-Chat",
						"/newspaper - Kauft eine Zeitung", 
						"/readnewspaper - Liest die Zeitung" },
	
	["sonstiges"] = {	"/ad [Text] - Schreibt eine Werbung",
						"/internet - Öffnet das Internet",
						"/animlist - Zeigt alle Animationen an",
						"/fglass - Benutzt das Fernglas",
						"/cselect - Zeigt Farbenpalette an",
						"/pay [Name] [Anzahl] - Zahlt jemandem Geld",
						"/rebind - Legt Nachladen auf R neu an",
						"/delmyobjects - Löscht alle eigenen platzierten Objekte",
						"/fraktioncommands - Zeigt alle Fraktionbefehle an",
						"/coin - Sammelt einen Coin bei einem Hausmarker ein",
						"/coinshop - Zeigt den Coinshop" },
	
	["haus"] = {		"/in - Betretet eine Wohnung",
						"/out - Verlässt eine Wohnung",
						"/rent - Mietet sich in eine Wohnung ein",
						"/unrent - Mietet sich aus einer Wohnung aus",
						"/sellhouse - Verkauft deine Wohnung",
						"/setrent [Preis/0] - Bestimmt die Miete deiner Wohnung",
						"/hlock - Öffnet/Schließt deine Wohnung",
						"/buyhouse [bar/bank] - Kauft eine Wohnung" },
						
	["club"] = {		"/quitclub - Kündigt Gartenclub-Mitgliedschaft",
						"/leaveclub - Kündigt Verein-/Club-Mitgliedschaft" },
						
	["schuss"] = {		"/reddot - Aktiviert Laservisier beim Zielen",
						"/hitglocke - Aktiviert Hitglocke beim Schießen" },
						
	["gang"] = {		"/creategang - Erstellt eine Gang",	
						"/leavegang - Verlässt die Gang",
						"/ganguninvite [Name] - Wirft jemanden aus der Gang (ab Rang 3)",
						"/ganginvite [Name] - Laded jemanden in die Gang ein (ab Rang 3)",
						"/ganggiverank [Name] [Rang] - Gibt jemandem in der Gang einen Rang (ab Rang 3)" },
						
	["aktion"] = {		"/payrob - Bezahlt das Geld bei einem Überfall",
						"/parachute - Geht Fallschirmspringen (Flughafen)",
						"/highscore - Zeigt Highscore vom Canyon-Rennen an",
						"/aufgeben - Gibt beim Boxer auf" },		
						
	["chat"] = {		"/meCMD [Text] - Benutzt einen violetten Chat",
						"/s [Text] - Schreit",
						"/l [Text] - Flüstert" },
						
	["prestige"] = {	"/buyprestige - Kauft ein Prestige-Objekt",
						"/sellprestige - Verkauft das Prestige-Objekt" },
						
	["biz"] = {			"/buybiz [bar/bank] - Kauft ein Biz",
						"/sellbiz - Verkauft ein Biz",
						"/bizhelp - Zeigt Infos über das Biz an",
						"/bizdraw [Anzahl] - Nimmt Geld aus der Biz-Kasse",
						"/bizstore [Anzahl] - Zahlt Geld in die Biz-Kasse" },
	["tramjob"] = {		"/tramjob - Nimmt den Tramjob an",
						"/tramjobstart - Startet den Tramjob" }
}


addCommandHandler ( "commands", function ( cmd, typ )
	if typ then
		if allCommands[typ] then
			outputChatBox ( "Befehle:", 200, 200, 200 )
			for i=1, #allCommands[typ] do
				outputChatBox ( allCommands[typ][i], 200, 200, 0 )
			end
		else
			outputChatBox ( "Gebrauch: /commands  [Kategorie]", 255, 0, 0 ) 
			outputChatBox ( "Möglich: account, fahrzeug, admin, polizei, spiele, job, taxi, mechaniker, mats, tramjob", 255, 0, 0 )
			outputChatBox ( "handy, drogen, reporter, sonstiges, haus, club, schuss, gang, aktion, chat, prestige, biz", 255, 0, 0 )
		end
	else
		outputChatBox ( "Gebrauch: /commands  [Kategorie]", 255, 0, 0 ) 
		outputChatBox ( "Möglich: account, fahrzeug, admin, polizei, spiele, job, taxi, mechaniker, mats, tramjob", 255, 0, 0 )
		outputChatBox ( "handy, drogen, reporter, sonstiges, haus, club, schuss, gang, aktion, chat, prestige, biz", 255, 0, 0 )
	end
end )



local allFactionCommands = {
	[1] = { 
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/g [Text] - Schreibt im Beamtenchat",
				"/arrest [Name] [0/1] - Knastet jemanden mit/ohne Kaution ein",
				"/defusebomb - Entschärft die Bombe in der Bank",
				"/geldtruck - Startet einen Geldruck",
				"/abnehmen - Nimmt Geld beim Bankraub ab",
				"/tazer - Tazert den nächsten Spieler",
				"/cuff [Name] - Legt einem Spieler Handschellen an",
				"/radarfalle - Aktiviert eine Radarfalle",
				"/needhelp - Bittet um Verstärkung", 
				"/ticket [Name] [Preis] - Bietet einem Wantler ein Ticket an",
				"/grab [Name] - Nimmt jemand getazerten ins Auto",
				"/fbank [Anzahl] - Zahlt Geld in die Fraktionskasse", 
				"/m [Text] - Benutzt das Megafon im Auto",
				"/givetest [Name] - Bietet jemandem ein Alkohol- & Drogentest an", 
				"/frisk [Name] - Durchsucht einen Spieler nach Illegalem",
				"/offduty - Geht Offduty", 
				"/takeillegal - Nimmt einem Spieler Illegales ab",
				"/duty - Geht Onduty", 
				"/rearm - Rüstet sich neu aus",
				"/su [Name] [Grund] - Gibt jemanden einen Wanted",
				"/suspect [Name] [Abk] - Gibt jemandem automatisch Wanteds",
				"/suspectgrund - Zeigt Abkürzungen für /suspect an",
				"/clear [Name] - Löscht alle Wanteds eines Spielers",
				"/stvopunkte [Name] [Grund] - Gibt jemandem einen StVO-Punkt",
				"/takeweapons [Name] - Entwaffnet einen Spieler", 
				"/barricade - Platziert eine Barrikade", 
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn", 
				"/fraktion - Zeigt das Fraktionspanel",
				"/fskin - Wechselt den Skin falls mit /allowfskin erlaubt wurde" },
		[1] = { "/stellen - Aktiviert/Deaktiviert das Stellen" },
		[2] = { "/ausknasten [Ziel] - Knastet jemanden aus",
				"/delstvo [Name] [Anzahl] [Grund] - Löscht jemanden die StVO-Punkte",
				"/frespawn - Startet einen Fraktionsrespawn",
				"/presikonvoi - Startet einen Präsidenten-Konvoi" },
		[3] = { "/takegunlicense [Ziel] - Nimmt jemanden den Waffenschein weg",
				"/swat - Geht in den SWAT Modus",
				"/ram - Betretet eine Wohnung unabhängig von hlock",
				"/nailload - Lädt Nagelbänder ins Auto",
				"/takenail [Anzahl] - Nimmt Nagelbänder aus dem Auto",
				"/nail - Legt ein Nagelband",
				"/rnail - Löscht das eigene Nagelband" },
		[4] = { "/rnail - Löscht ein bestimmtes Nagelband",
				"/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers", 
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/allowfskin - Erlaubt /fskin für 2 Minuten",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" },
		[5] = { "/cell - Öffnet alle Zellentüren",
				"/fdraw [Anzahl] - Nimmt Geld aus der Fraktionskasse",
				"/rnails - Löscht alle platzierten Nagelbänder"	}
	},
	[2] = {
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/b [Text] - Schreibt im böse-Fraktions-Chat",
				"/matstruck - Startet einen Matstruck für 5.000$",
				"/robbank - Raubt die Bank aus",
				"/rob [Name] - Raubt einen Zivilisten aus",
				"/drogentruck - Startet einen Drogentruck",
				"/gibwaffe - Gibt eine Waffe falls beim Casinorob gewonnen",
				"/carrob - Startet einen Carrob",
				"/bankrob - Startet einen Bankraub",
				"/gwbefehle - Zeigt alle Gangwarbefehle an",
				"/fguns - Öffnet das Fguns-Menü", 
				"/blacklist delete [Name] - Löscht jemanden aus der Blacklist",
				"/blacklist show - Zeigt die Blacklist an",
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/fskin - Zieht einen anderen Skin an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn", 
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[3] = { "/blacklist add [Name] [Grund] - Tut einen Zivilisten auf die Blacklist" },
		[4] = { "/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	},
	[3] = {
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/b [Text] - Schreibt im böse-Fraktions-Chat",
				"/matstruck - Startet einen Matstruck für 5.000$",
				"/robbank - Raubt die Bank aus",
				"/rob [Name] - Raubt einen Zivilisten aus",
				"/drogentruck - Startet einen Drogentruck",
				"/gibwaffe - Gibt eine Waffe falls beim Casinorob gewonnen",
				"/carrob - Startet einen Carrob",
				"/bankrob - Startet einen Bankraub",
				"/gwbefehle - Zeigt alle Gangwarbefehle an",
				"/fguns - Öffnet das Fguns-Menü",
				"/blacklist delete [Name] - Löscht jemanden aus der Blacklist",
				"/blacklist show - Zeigt die Blacklist an",
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/fskin - Zieht einen anderen Skin an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn",
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[3] = { "/blacklist add [Name] [Grund] - Tut einen Zivilisten auf die Blacklist" },
		[4] = { "/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	},
	[4] = {
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/b [Text] - Schreibt im böse-Fraktions-Chat",
				"/detonate - Zündet die Bombe", 
				"/equip - Rüstet sich aus",
				"/arm - Rüstet sich mit Bomben aus",
				"/robbank - Raubt die Bank aus",
				"/rob [Name] - Raubt einen Zivilisten aus",
				"/drogentruck - Startet einen Drogentruck",
				"/gibwaffe - Gibt eine Waffe falls beim Casinorob gewonnen",
				"/carrob - Startet einen Carrob",
				"/bankrob - Startet einen Bankraub",
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fskin - Zieht einen anderen Skin an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn",
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[4] = { "/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang", 
				"/katjuscha - Erstellt einen Katjuscha",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	},
	[5] = {
		[0] = { "/mv - Öffnet die Tore/Schranken", 
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/lift - Benutzt den Aufzug",
				"/news [Text] - Schreibt im News-Chat", 
				"/live [Name] - Schaltet jemanden in den Live-Chat", 
				"/endlive - Beendet den Live-Chat",
				"/reporterstart - Platziert einen Start-Blip an der Position",
				"/reporterende - Platziert einen Ende-Blip an der Position",
				"/delreporterstart - Löscht den Start-Blip",
				"/delreporterende - Löscht den Ende-Blip",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/fskin - Zieht einen anderen Skin an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn", 
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[3] = { "/edit - Bearbeitet die Zeitung" },
		[4] = { "/delallreporterblips - Löscht alle Reporter-Blips",
				"/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	},
	[6] = {
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/g [Text] - Schreibt im Beamtenchat",
				"/arrest [Name] [0/1] - Knastet jemanden mit/ohne Kaution ein",
				"/defusebomb - Entschärft die Bombe in der Bank",
				"/geldtruck - Startet einen Geldruck",
				"/abnehmen - Nimmt Geld beim Bankraub ab",
				"/tazer - Tazert den nächsten Spieler",
				"/cuff [Name] - Legt einem Spieler Handschellen an",
				"/needhelp - Bittet um Verstärkung",
				"/ticket [Name] [Preis] - Bietet einem Wantler ein Ticket an",
				"/grab [Name] - Nimmt jemand getazerten ins Auto", 
				"/fbank [Anzahl] - Zahlt Geld in die Fraktionskasse",
				"/m [Text] - Benutzt das Megafon im Auto",
				"/givetest [Name] - Bietet jemandem ein Alkohol- & Drogentest an",
				"/frisk [Name] - Durchsucht einen Spieler nach Illegalem", 
				"/offduty - Geht Offduty",
				"/takeillegal - Nimmt einem Spieler Illegales ab",
				"/duty - Geht Onduty",
				"/rearm - Rüstet sich neu aus",
				"/su [Name] [Grund] - Gibt jemanden einen Wanted",
				"/suspect [Name] [Abk] - Gibt jemandem automatisch Wanteds",
				"/suspectgrund - Zeigt Abkürzungen für /suspect an",
				"/clear [Name] - Löscht alle Wanteds eines Spielers",
				"/stvopunkte [Name] [Grund] - Gibt jemandem einen StVO-Punkt",
				"/takeweapons [Name] - Entwaffnet einen Spieler",
				"/wanze - Legt eine Wanze",
				"/barricade - Platziert eine Barrikade", 
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/fskin - Zieht einen anderen Skin an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn",
				"/fraktion - Zeigt das Fraktionspanel" },
		[1] = { "/stellen - Aktiviert/Deaktiviert das Stellen" },
		[2] = { "/ausknasten [Ziel] - Knastet jemanden aus",
				"/delstvo [Name] [Anzahl] [Grund] - Löscht jemanden die StVO-Punkte",
				"/swat - Geht in den SWAT Modus", 
				"/killwanze [1-3] - Löscht eine der Wanzen",
				"/frespawn - Startet einen Fraktionsrespawn",
				"/presikonvoi - Startet einen Präsidenten-Konvoi" },
		[3] = { "/takegunlicense [Ziel] - Nimmt jemanden den Waffenschein weg",
				"/ram - Betretet eine Wohnung unabhängig von hlock",
				"/nailload - Lädt Nagelbänder ins Auto",
				"/takenail [Anzahl] - Nimmt Nagelbänder aus dem Auto",
				"/nail - Legt ein Nagelband",
				"/rnail - Löscht das eigene Nagelband" },
		[4] = { "/rnail - Löscht ein bestimmtes Nagelband",
				"/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" },
		[5] = { "/cell - Öffnet alle Zellentüren",
				"/fdraw [Anzahl] - Nimmt Geld aus der Fraktionskasse",
				"/rnails - Löscht alle platzierten Nagelbänder" }
	},
	[7] = { 
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/b [Text] - Schreibt im böse-Fraktions-Chat",
				"/matstruck - Startet einen Matstruck für 5.000$",
				"/robbank - Raubt die Bank aus",
				"/rob [Name] - Raubt einen Zivilisten aus",
				"/drogentruck - Startet einen Drogentruck",
				"/gibwaffe - Gibt eine Waffe falls beim Casinorob gewonnen",
				"/carrob - Startet einen Carrob",
				"/bankrob - Startet einen Bankraub",
				"/gwbefehle - Zeigt alle Gangwarbefehle an",
				"/fguns - Öffnet das Fguns-Menü",
				"/blacklist delete [Name] - Löscht jemanden aus der Blacklist",
				"/blacklist show - Zeigt die Blacklist an",
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/fskin - Zieht einen anderen Skin an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn",
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[3] = { "/blacklist add [Name] [Grund] - Tut einen Zivilisten auf die Blacklist" },
		[4] = { "/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	},
	[8] = {
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/rearm - Rüstet sich neu aus",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/g [Text] - Schreibt im Beamtenchat",
				"/arrest [Name] [0/1] - Knastet jemanden mit/ohne Kaution ein",
				"/defusebomb - Entschärft die Bombe in der Bank", 
				"/geldtruck - Startet einen Geldruck",
				"/abnehmen - Nimmt Geld beim Bankraub ab",
				"/tazer - Tazert den nächsten Spieler",
				"/cuff [Name] - Legt einem Spieler Handschellen an",
				"/needhelp - Bittet um Verstärkung",
				"/ticket [Name] [Preis] - Bietet einem Wantler ein Ticket an",
				"/grab [Name] - Nimmt jemand getazerten ins Auto", 
				"/fbank [Anzahl] - Zahlt Geld in die Fraktionskasse",
				"/m [Text] - Benutzt das Megafon im Auto",
				"/givetest [Name] - Bietet jemandem ein Alkohol- & Drogentest an",
				"/frisk [Name] - Durchsucht einen Spieler nach Illegalem", 
				"/takeillegal - Nimmt einem Spieler Illegales ab",
				"/su [Name] [Grund] - Gibt jemanden einen Wanted",
				"/suspect [Name] [Abk] - Gibt jemandem automatisch Wanteds",
				"/suspectgrund - Zeigt Abkürzungen für /suspect an",
				"/clear [Name] - Löscht alle Wanteds eines Spielers",
				"/stvopunkte [Name] [Grund] - Gibt jemandem einen StVO-Punkt",
				"/takeweapons [Name] - Entwaffnet einen Spieler",
				"/barricade - Platziert eine Barrikade", 
				"/class [Klasse] - Setzt sich eine Klasse",
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/fskin - Zieht einen anderen Skin an und geht Onduty",
				"/offduty - Geht in den Ziviskin",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn", 
				"/fraktion - Zeigt das Fraktionspanel" },
		[1] = { "/stellen - Aktiviert/Deaktiviert das Stellen",
				"/sandbag - Platziert einen Sandbag (Pionier)",
				"/explosive - Platziert einen Explosive (Pionier)" },
		[2] = { "/ausknasten [Ziel] - Knastet jemanden aus",
				"/delstvo [Name] [Anzahl] [Grund] - Löscht jemanden die StVO-Punkte",
				"/frespawn - Startet einen Fraktionsrespawn",
				"/presikonvoi - Startet einen Präsidenten-Konvoi" },
		[3] = { "/takegunlicense [Ziel] - Nimmt jemanden den Waffenschein weg",
				"/ram - Betretet eine Wohnung unabhängig von hlock",
				"/nailload - Lädt Nagelbänder ins Auto", 
				"/takenail [Anzahl] - Nimmt Nagelbänder aus dem Auto",
				"/nail - Legt ein Nagelband",
				"/rnail - Löscht das eigene Nagelband" },
		[4] = { "/rnail - Löscht ein bestimmtes Nagelband",
				"/airstrike - Startet einen Luftanschlag",
				"/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" },
		[5] = { "/cell - Öffnet alle Zellentüren",
				"/fdraw [Anzahl] - Nimmt Geld aus der Fraktionskasse",
				"/rnails - Löscht alle platzierten Nagelbänder",
				"/setpermission [Name] [1-9] [0/1] - Gibt eine Permission",
				"/setpermission [Name] [10] [0-100] - Gibt eine GWD Note" }
	},
	[9] = {
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/b [Text] - Schreibt im böse-Fraktions-Chat",
				"/matstruck - Startet einen Matstruck für 5.000$",
				"/robbank - Raubt die Bank aus",
				"/rob [Name] - Raubt einen Zivilisten aus",
				"/drogentruck - Startet einen Drogentruck",
				"/gibwaffe - Gibt eine Waffe falls beim Casinorob gewonnen",
				"/carrob - Startet einen Carrob",
				"/bankrob - Startet einen Bankraub", 
				"/gwbefehle - Zeigt alle Gangwarbefehle an", 
				"/fguns - Öffnet das Fguns-Menü",
				"/blacklist delete [Name] - Löscht jemanden aus der Blacklist",	
				"/blacklist show - Zeigt die Blacklist an",
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",	
				"/fskin - Zieht einen anderen Skin an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn", 
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[3] = { "/blacklist add [Name] [Grund] - Tut einen Zivilisten auf die Blacklist",
				"/formation - Erstellt eine Formation mit einer Freeway" },
		[4] = { "/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	},
	[10] = {
		[0] = { "/mv - Öffnet die Tore/Schranken", 
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/g [Text] - Schreibt im Beamtenchat",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn",
				"/komme [Name] - Nimmt ein Hilferuf an",
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[4] = { "/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	},
	[11] = {
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/g [Text] - Schreibt im Beamtenchat",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn",
				"/komme [Name] - Nimmt ein Hilferuf an",
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[4] = { "/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	},
	[12] = {
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/b [Text] - Schreibt im böse-Fraktions-Chat",
				"/matstruck - Startet einen Matstruck für 5.000$",
				"/robbank - Raubt die Bank aus",
				"/rob [Name] - Raubt einen Zivilisten aus",
				"/drogentruck - Startet einen Drogentruck",
				"/gibwaffe - Gibt eine Waffe falls beim Casinorob gewonnen",
				"/carrob - Startet einen Carrob",
				"/bankrob - Startet einen Bankraub",
				"/gwbefehle - Zeigt alle Gangwarbefehle an",
				"/fguns - Öffnet das Fguns-Menü",
				"/blacklist delete [Name] - Löscht jemanden aus der Blacklist",
				"/blacklist show - Zeigt die Blacklist an",
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/fskin - Zieht einen anderen Skin an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn",
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[3] = { "/blacklist add [Name] [Grund] - Tut einen Zivilisten auf die Blacklist" },
		[4] = { "/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	},
	[13] = {
		[0] = { "/mv - Öffnet die Tore/Schranken",
				"/t [Text] - Schreibt im Teamchat (Fraktion)",
				"/b [Text] - Schreibt im böse-Fraktions-Chat",
				"/matstruck - Startet einen Matstruck für 5.000$",
				"/robbank - Raubt die Bank aus",
				"/rob [Name] - Raubt einen Zivilisten aus",
				"/drogentruck - Startet einen Drogentruck",
				"/gibwaffe - Gibt eine Waffe falls beim Casinorob gewonnen",
				"/carrob - Startet einen Carrob",
				"/bankrob - Startet einen Bankraub", 
				"/gwbefehle - Zeigt alle Gangwarbefehle an",
				"/fguns - Öffnet das Fguns-Menü", 
				"/blacklist delete [Name] - Löscht jemanden aus der Blacklist",
				"/blacklist show - Zeigt die Blacklist an",
				"/tie [Name] - Fesselt jemanden im Auto",
				"/fstate - Zeigt den Inhalt der Fraktionskasse an",
				"/fskin - Zieht einen anderen Skin an",
				"/selfuninvite - Verlässt die Fraktion", 
				"/stopfrespawn - Stoppt ein Fraktions-Respawn",
				"/fraktion - Zeigt das Fraktionspanel" },
		[2] = { "/frespawn - Startet einen Fraktionsrespawn" },
		[3] = { "/blacklist add [Name] [Grund] - Tut einen Zivilisten auf die Blacklist" },
		[4] = { "/invite [Name] - Nimmt jemanden in die Fraktion auf",
				"/uninvite [Name] - Wirft jemanden aus der Fraktion raus", 
				"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
				"/giverank [Name] [Rang] - Gibt einem Fraktionsmitglied ein Rang",
				"/frakpm [Text] - Schickt jedem Mitglied eine Nachricht (auch offline)" }
	}	
}


addCommandHandler ( "fraktioncommands", function ( cmd, rang )
	if rang then
		local rang = tonumber ( rang )
		local frac = getElementData ( localPlayer, "fraktion" )
		if frac > 0 then
			if rang and rang >= 0 and rang <= 5 then
				local wasthere = false
				outputChatBox ( "Befehle:", 200, 200, 200 )
				if allFactionCommands[frac][rang] then
					for i=1, #allFactionCommands[frac][rang] do
						outputChatBox ( allFactionCommands[frac][rang][i], 200, 200, 0 )
						wasthere = true
					end
				end
				if not wasthere then
					outputChatBox ( "Keine für diesen Rang spezifische!", 255, 0, 0 )
				end
			else
				outputChatBox ( "Gebrauch: /fraktioncommands  [0-5]", 255, 0, 0 ) 
			end
		else
			outputChatBox ( "Du bist in keiner Fraktion!", 255, 0, 0 )
		end
	else
		outputChatBox ( "Gebrauch: /fraktioncommands  [0-5]", 255, 0, 0 ) 
	end
end )


local allAdminCommands = {
	[1] = { "/a [Text] - Benutzt den VIP Chat (nur für VIP)",
			"/muted [Name] - (Ent-)Mutet einen Spieler (nur VIP)",
			"/premium - Öffnet das Premium-Panel", 
			"/status [Status] - Ändert den Status" },
	[2] = { "/tickets - Öffnet das Ticket-Fenster",
			"/getchangestate [Name] - Prüft letzten Invite/Uninvite des Spielers",
			"/ochat [Text] - Benutzt den öffentlichen Admin-Chat",
			"a [Text] - Benutzt den privaten Adminchat" },
	[3] = { "/aduty - Geht Adminduty",
			"/ausknasten [Ziel] - Knastet jemanden aus",
			"/pm [Name] [Nachricht] - Schreibt jemandem eine private Nachricht",
			"/delallreporterblips - Löscht alle Reporter-Blips",
			"/rnails - Löscht alle platzierten Nagelbänder",
			"/droller - Löscht alle Faggio-Roller vom Rollerverleih",
			"/warn [Name] [Tage] [Grund] - Gibt einen Warn", 
			"/mark [1-3] - Legt eine Markierung",
			"/gotomark [1-3] - Portet zu der Markierung",
			"/respawn [Typ] - Respawnt Fahrzeuge",
			"/freeze [Name] - Freezt einen Spieler",
			"/spec [Name] - Spectet jemanden",
			"/rkick [Name] [Grund] - Kick jemanden",
			"/tban [Name] [Zeit] [Grund] - Bannt jemanden für eine Zeit",
			"/goto [Name] - Portet zu einem Spieler",
			"/gethere [Name] - Portet einen Spieler zu sich",
			"/rmute [Name] - Mutet einen Spieler",
			"/unban [Name] - Entbannt einen selbstgebannten Spieler",
			"/crespawn [Radius] - Respawn Fahrzeuge im Radius",
			"/gotocar [Name] [Slot] - Portet zum Auto eines Spielers",
			"/getcar [Name] [Slot] - Portet ein Auto eines Spielers her",
			"/prison [Name] [Zeit] [Grund] - Steckt jemanden ins Prison" },
	[4] = { "/newhouse [Preis] [Interior] - Erstellt einen Interior",
			"/iraum [Interior] - Portet in einen Interior",
			"/setnailmax [Anzahl] - Ändert die max. Anzahl der Nagelbänder im Auto",
			"/intdim [Name] [Interior] [Dimension] - Setzt jemanden in Interior & Dimension", 
			"/cc - Säubert den Chat",
			"/setrank [Name] [Rang] - Settet jemandem den Rang in seiner Fraktion",
			"/makeleader [Name] [FraktionsID] - Setzt jemanden als Leader ein",
			"/rban [Name] [Grund] - Bannt jemanden Permanent" },
	[5] = { "/aweather - Ändert das Wetter",
			"/deletewarn [Name] - Löscht alle Warns", 
			"/nickchange [Name] [NeuerName] - Führt einen Nickchange aus",
			"/move [Richtung] - Portet dich etwas in die Richtung",
			"/pwchange [Name] [PW] - Führt eine Passwort-Änderung aus",
			"/shut - Notabschaltung",
			"/check [Name] - Überprüft einen Spieler",
			"/tunecar [Part] - Tunet ein Fahrzeug",
			"/getip [Name] - Fragt IP vom Spieler ab",
			"/ipban [IP] - Bannt jemandes IP",
			"/skydive [Name] - Skydivet einen Spieler",
			"/unban [Name] - Entbannt einen Spieler",
			"/astart - Startet ein Auto",
			"/aenter - Betretet ein Auto",
			"/makefft - Lässt ein Auto FFT werden (ohne Motor)",
			"/kickall [Grund] - Kickt alle Spieler" },
	[6] = { "/settestgeld [Anzahl] - Settet Testgeld", 
			"/gmx [Minuten] - Restartet den Server",
			"/setadmin [Name] [Rang] - Gibt jemandem Adminrang" }
}

--[[
addCommandHandler ( "admincommands", function ( cmd, rang )
	if rang then
		local rang = tonumber ( rang )
		if rang and rang >= 1 and rang <= 6 then
			outputChatBox ( "Befehle:", 200, 200, 200 )
			for i=1, #allAdminCommands[rang] do
				outputChatBox ( allAdminCommands[rang][i], 200, 200, 0 )
				wasthere = true
			end
		else
			outputChatBox ( "Gebrauch: /admincommands  [1-6]", 255, 0, 0 ) 
		end
	else
		outputChatBox ( "Gebrauch: /admincommands  [1-6]", 255, 0, 0 ) 
	end
end )
--]]