# GRS-Legacy 
Eine weiter Version des GRS-Reallife Gamemodes, basierend auf dem Ultimate-Reallife Gamemode (MTA:SA)
Trello: https://trello.com/b/enlrE9qG/grs (Informationen für zukünftige Updates)

Zur Installation benötigst du Folgendes:
- Eine MariaDB Datenbank (getestet mit Version 10.4.25) (andere Datenbank-Typen sind Fehlerhaft!)
- Basis LUA-Kenntnisse 
- Einen MTA:SA Server (getestet mit Version 1.5.9)
- DGS ( es empfielt sich die enthaltene Version zu nutzen, man kann aber auch die [aktuelle Version](https://github.com/thisdp/dgs) nutzen )

Step-By-Step Installation (Server sollte währenddessen gestoppt sein):

1) grs.sql in eine neue Datenbank importieren / ausführen
2) Den Ordner '[grs]' in den 'ressources' Ordner schieben.
3) 'reallife_server' und 'DGS' als Auto-Start in der 'mtaserver.conf' einfügen.
  <resource src="DGS" startup="1" protected="0" />
  <resource src="reallife_server" startup="1" protected="0" />
Bei den nächsten Schritten hilft auch ein kleines Installations-Tool. Dieses Überprüft immer wieder, ob alles richtig installiert ist bis es richtig installiert ist.

![installer](https://i.imgur.com/Q8IAw6S.png)

4) Folgenden Ressourcen ACL (Admin-) Rechte geben: 'DGS', 'grs_cache' und 'reallife_server'. 
5) Datenbank Login-Informationen unter 'mysql/mysql_start.lua' angeben.
6) Server starten.

Basis-Anpassungen am Gamemode können unter 'settings/both_settings.lua' gemacht werden.
Youtube-Tutorials:
https://www.youtube.com/watch?v=2I-Yhufgwe8&t
https://www.youtube.com/watch?v=dkQEDSvFq1o
