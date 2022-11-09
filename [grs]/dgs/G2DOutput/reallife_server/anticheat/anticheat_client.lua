
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

validGunCheatProofs = { [1]=true, [2]=true, [3]=true, [4]=true, [5]=true, [6]=true, [7]=true, [8]=true, [9]=true, [10]=true }

player = lp

function start_anticheat ()

	aCheatRun = 0
	
	setTimer ( anticheat, 10000, 0 )
end
addEventHandler ( "onClientResourceStart", resourceRoot, start_anticheat )

function anticheat ()
	if isPedDead ( lp ) then
		showChat ( false )
		if isElement ( gLabels["InfoTextForum"] ) then
			dgsSetVisible ( gLabels["InfoTextForum"], false )
			dgsSetVisible ( gLabels["InfoTextForumShadow"], false )
		end
		setPlayerHudComponentVisible ( "radar", false )
	else
		if gLabels["InfoTextForum"] and not dgsGetVisible ( gLabels["InfoTextForum"] ) then
			if isElement ( gLabels["InfoTextForum"] ) then
				dgsSetVisible ( gLabels["InfoTextForumShadow"], true )
				dgsSetVisible ( gLabels["InfoTextForum"], true )
			end
		end
	end
end


function hasPlayerLicense ( _, id )
	if cars[id] then
		if tonumber ( vioClientGetElementData ( "carlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif lkws[id] then
		if tonumber ( vioClientGetElementData ( "lkwlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif bikes[id] then
		if tonumber ( vioClientGetElementData ( "bikelicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif helicopters[id] then
		if tonumber ( vioClientGetElementData ( "helilicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif planea[id] then
		if tonumber ( vioClientGetElementData ( "planelicensea" ) ) == 1 then
			return true
		else
			return false
		end
	elseif planeb[id] then
		if tonumber ( vioClientGetElementData ( "planelicenseb" ) ) == 1 then
			return true
		else
			return false
		end
	elseif motorboats[id] then
		if tonumber ( vioClientGetElementData ( "motorbootlicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif raftboats[id] then
		if tonumber ( vioClientGetElementData ( "segellicense" ) ) == 1 then
			return true
		else
			return false
		end
	elseif nolicense[id] then
		return true
	else
		return true
	end
end