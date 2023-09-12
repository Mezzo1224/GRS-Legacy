
function registerUserInForum (player, email)
    if ServerConfig["forum"].enableForumsynchronization == true then
		if not dbExist ( "forum_accounts", "email LIKE '"..email.."'") then
			local pname = getPlayerName(player)
			local pw = generateString ( math.random( 5,9 ) )
			register (pname, pw, email, 3, 3)
			local id = tonumber (getUserID(pname))
			dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "forum_accounts", "ForumID", id, "Password", pw, "UID", playerUID[pname] )
			outputChatBox ( "Dein Account mit dem Passwort "..pw.." und der E-Mail "..email.." wurde eingerichtet!", player, 0,139,0 )
			outputChatBox ( "Das Passwort nach dem Login ändern! Es wird momentan auf unseren Server gespeichert!", player, 0,139,0 )
			offlinemsg ( "Erinnerung: Dein Foren Passwort "..pw.." und deine E-Mail "..email, "Server", pname )
			offlinemsg ( "Das Passwort nach dem Login ändern! Es wird momentan auf unseren Server gespeichert!", "Server", pname )
			return true
		else
			outputChatBox ( "E-Mail bereits in benutzung. ", player, 0,139,0 )
			return false
		end
	end
end
addEvent ( "registerUserInForum", true)
addEventHandler ( "registerUserInForum", getRootElement(), registerUserInForum)

function checkTeammemberGroup( player ) 
	local forumID = vioGetElementData ( player, "ForumID")
	local adminlevel = getAdminLevel ( player )
	if adminlevel > 0 then
		if not isUserInGroup(forumID, teamid) then
			addUserToGroup(forumID, teamid)	
		end
	else
		if isUserInGroup(forumID, teamid) then
			removeUserFromGroup(forumID, teamid)	
		end
	end
end


function testg(player, cmd, id)
	local forumID = vioGetElementData ( player, "ForumID")
	if isUserInGroup(forumID, tonumber(id)) then
		print("Ist drinnen")
	end
	--for i, var in pairs(adminForumRank) do 
--		print(getGroupName(var))
--	end
end
--addCommandHandler("testg", testg)

function loadForumPermissions ( player )
	local forumID = vioGetElementData ( player, "ForumID")
	local adminlevel = getAdminLevel ( player )
	checkTeammemberGroup( player )
	if isAdminLevel(player, 1 ) then
		-- // Admingruppen geben
		if adminForumRank[adminlevel] and not isUserInGroup(forumID, adminForumRank[adminlevel]) then
			addUserToGroup(forumID, adminForumRank[adminlevel])
		end
		if adminForumView[adminlevel] then
			-- TODO
		end
	-- // Admingruppe löschen
	else
		for i, var in pairs(adminForumRank) do 
			if isUserInGroup(forumID, var) then
				removeUserFromGroup(forumID, var)
			end
		end
	end
	-- // Premiumcheck
	if isPremium(player) and not isUserInGroup(forumID, VIPGroupe) then
		addUserToGroup(forumID, VIPGroupe)
	elseif not isPremium(player) and isUserInGroup(forumID, VIPGroupe)  then
		removeUserFromGroup(forumID, VIPGroupe)
	end
	-- Status setzen TODO: Will der User das ?
	if isPremium(player) then
		local state = getElementData ( player, "socialState" )
		setUserTitle(forumID, state)
	end
	-- Betasystem
	if isBeta() then
		if not isUserInGroup(forumID, betaGroupe) then
			addUserToGroup(forumID, betaGroupe)
		end
	end
end