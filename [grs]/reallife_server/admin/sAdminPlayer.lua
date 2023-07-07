--[[
    // Hier sind sämtliche Spieler-Spezifischen Adminfunktionen.
    // Also Funktionen wie Bannen, Kicken oder Adminlevel setzen.
]]


function setPlayerAdminLevelCMD (player, cmd, target, newLevel)
	-- // Hat der Benutzer die ACL-Admin Gruppe ?
	if (isGuestAccount(getPlayerAccount(player)) == false) then
		hasAdminGroup =  isObjectInACLGroup ( "user."..getAccountName (getPlayerAccount(player)), aclGetGroup ( "Admin" ) )
	else
		hasAdminGroup =  false
	end

	if hasPermission ( player, "setAdminLevel" ) or getElementType ( player ) == "console" or hasAdminGroup == true then
		if target then 
			local pName = getPlayerName(player)
			local newLevel = tonumber ( newLevel )
			if newLevel and adminLevels[newLevel]  and newLevel > -1 then
				if getPlayerFromName(target) and getElementData ( getPlayerFromName(target), "loggedin" ) == 1 then -- // Online
					local target = getPlayerFromName(target)
					local tName = getPlayerName(target)
					if getAdminLevel ( player ) >= getAdminLevel ( target ) or hasAdminGroup then
						sendMsgToAdmins (pName.." hat den Teamrang von "..tName.." auf "..adminLevels[newLevel].."#63B8FF ("..newLevel..") gesetzt.")
						infobox (player, "Du hast den Teamrang von "..tName.." auf "..newLevel.." gesetzt.", "success", 15)
						infobox (target, "Du hast den Teamrang "..newLevel.." von "..pName.." gesetzt bekommen.", "info", 15)
						vioSetElementData(target, "adminlvl", newLevel)
						dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Adminlevel", newLevel, "UID", playerUID[target] )
						if newLevel == 0 then
							adminsIngame[target] = nil
						else
							adminsIngame[target] = newLevel
						end
					else
						infobox (player, tName.." hat ein höheres Adminlevel als du.", "error", 15)
					end
					
				else -- // Offline
					if playerUID[target] then
						local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "Adminlevel", "userdata", "UID", playerUID[target] ), -1 )
						local tAdminlevel = result[1].Adminlevel
						if tAdminlevel <=  getAdminLevel ( player ) or hasAdminGroup then
							sendMsgToAdmins (pName.." hat den Teamrang von "..target.." auf "..adminLevels[newLevel].."#63B8FF ("..newLevel..") gesetzt.")
							dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Adminlevel", newLevel, "UID", playerUID[target] )
							infobox (player, "Du hast den Rang von "..target.." auf "..newLevel.." gesetzt.", "error", 15)
						else
							infobox (player, target.." hat ein höheres Adminlevel als du.", "error", 15)
						end
					else
						infobox (player, "Dieser Spieler existiert nicht.", "error", 15)
					end
				end
			else
				infobox (player, "Ungültiges Adminlevel.", "error", 15)
			end
		else
			infobox (player, "Du musst einen Spieler angeben.\n/adminlevel [NAME] [LEVEL]", "error", 15)
		end
	else
		infobox (player, "Du bist nicht befugt.", "error", 15)
	end
end
addCommandHandler ( "adminlevel", setPlayerAdminLevelCMD )