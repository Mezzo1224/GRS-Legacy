function setClientData ( name, value )

	if fileExists ( "stored_files/data/"..name..".val" ) then
		fileDelete ( "stored_files/data/"..name..".val" )
	end
	
	fileCreate ( "stored_files/data/"..name..".val" )
	
	local file	= fileOpen ( "stored_files/data/"..name..".val" )
	
	fileWrite ( file, tostring ( value ) )
	
	fileClose ( file )
	
	return true
end

function doesClientDataExists ( name )

	if fileExists ( "stored_files/data/"..name..".val" ) then
		return true
	end
	return false
end

function getClientData ( name )

	local file	= fileOpen ( "stored_files/data/"..name..".val" )
	if file then
		local fileData = fileRead ( file, fileGetSize ( file ) )
		fileClose ( file )
		
		if fileData == nil then
			fileData = ""
		end
	
		return fileData
	else
		return false
	end
end






























--[[function setClientData ( name, value )

	fileDelete ( "grs_cache/data/"..name..".typ" )
	fileDelete ( "grs_cache/data/"..name..".val" )
	
	local fileData	= fileCreate ( "grs_cache/data/"..name..".typ" )
	local fileTyp	= fileCreate ( "grs_cache/data/"..name..".val" )
	
	fileWrite ( fileData, tostring ( value ) )
	fileWrite ( fileTyp, getVariableTyp ( value ) )
	
	fileClose ( fileData )
	fileClose ( fileTyp )
	
	return true
end

function getClientData ( name )

	local fileData	= fileOpen ( "grs_cache/data/"..name..".typ" )
	local fileTyp	= fileOpen ( "grs_cache/data/"..name..".val" )
	
	fileData = fileRead ( fileData, fileGetSize ( fileData ) )
	fileTyp = tonumber ( fileRead ( fileTyp, fileGetSize ( fileTyp ) ) )
	
	if fileTyp == 0 then
		return fileData
	elseif fileTyp == 1 then
		if fileData == "true" then
			return true
		else
			return false
		end
	else
		return tonumber ( fileData )
	end
end

function loadClientData ( data )

	dataToSend = {}
	for key, index in pairs ( data ) do
		if not fileExists ( "grs_cache/data/"..name..".typ" ) or not fileExists ( "grs_cache/data/"..name..".val" ) then
			setClientData ( key, index )
		end
		dataToSend[key] = getClientData ( key )
	end
	triggerServerEvent ( "recieveClientFileData", getRootElement(), dataToSend[key] )
end]]