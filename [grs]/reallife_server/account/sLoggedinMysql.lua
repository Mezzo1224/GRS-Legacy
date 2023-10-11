function setPlayerLoggedIn ( name )

	dbExec ( handler, "UPDATE loggedin SET ?? = ? WHERE UID=?", "Loggedin", "1", playerUID[name] )
end

function removePlayerFromLoggedIn ( name )

	dbExec ( handler, "DELETE FROM loggedin WHERE UID=?", playerUID[name] )
end

function deleteAllFromLoggedIn ()

	dbExec ( handler, "TRUNCATE TABLE loggedin" )
	local players = getElementsByType ( "player" ) 
	for theKey,thePlayer in ipairs(players) do 
		vioSetElementData ( thePlayer, "loggedin", 0 )
		setElementData ( thePlayer, "loggedin", 0 )
	end
end
deleteAllFromLoggedIn ()