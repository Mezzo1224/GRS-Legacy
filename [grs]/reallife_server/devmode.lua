devMode = 0
devmode = devMode
--[[
	Aktiviert den Devmode, dieser sollte beim Livebetrieb ausgeschaltet sein.
	Er aktiviert je nach Stufe verschiedene Debug-Dinge, er kann zu vielen Fehler in der Konsole führen,
	aber auch den Script-Start Schneller machen.
	0 = Aus.
	1 = Aktiviert Debug Commands (/devmode), ermöglicht es unendlich viele Account zu erstellen, zeigt informationen über MySQL usw. im debugscript/Serverkonsole.
	2 = Das Laden der Fraktionsfahrzeuge u. Unternehmensfahrzeugen wird unterbunden (starker performanceschub beim starten des Servers).
	3 = Das Laden sämmtlicher Spielerinformationen abseits von "userdata" und "players" wird unterbunden.
]]

function printDebug (msg)
	if tonumber(devMode) > 0 then
		print(msg)
	end
end