-- // Warn haben Strafpunkte, aber einem gewissen Schwellwert (Threshold) wird gebannt/gejailt
--// Abkürzungen für die Zeit sind möglich.  d = Tage, w = Wochen, mo = monat, y = Jahre; Sekunden und Stunden sind nicht möglich.
predefinedWarns = {
        ["SDM"] = {
        reason = "SDM", -- // Das gleiche wie Oben
        time = "1d", -- // Die Zeit z.B 1d
        penaltyPoints == "0",   -- // Strafpunkte
        dependency = {}, -- // Erst möglich wenn es Warn XY gibt ?
        punishment = { -- // Freigeschaltete Bestrafung, unabhängig von den Strafpunkten. Werden nicht zwingend ausgeführt. Möglich: jail, ban, kick
            ["jail"] =
                {
                    time = 5 -- // Zeit in Minuten
                }
                --[[
                ["ban"] =
                {
                    time = 5 -- // Zeit in Stunden
                }
                ["kick"] = {}
                --]]    
            } 
        }
    }

   
--[[
    Notiz:
    Weitere Einstellungen, Erklärungen ggf. in den Datein zu finden:
        neues/inventory/sharedItems.lua <-- Neue Items erstellen
        neues/settingSystem/settingSystemMain.lua <-- Neue Einstellungen 
        neues/warnSystem/sWarnTables.lua <-- Vorgefertigte Warns
        neues/shopsystem.lua <-- Neue Items für den Shop erstellen
]]