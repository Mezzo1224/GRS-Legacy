local sRes = getResourceFromName("reallife_server")
local x, y = guiGetScreenSize()
local sx, sy = x/2560, y/1440

function loadClientSettings ()
	experimanetelLoading()
	local var = getSetting (5, 1)
	if var == 1 then
		setCloudsEnabled(true)
	else
		setCloudsEnabled(false)
	end
	local var = getSetting (4, 1)
	setFogDistance(var)
	local var = getSetting (6, 1)
	setFarClipDistance(var)
	
	local var = getSetting (12, 1)
	if not tonumber(var) then
		outputChatBox ( "FPS-Einstellung Fehlerhaft! FPS maximum auf 45 gesetzt!", 224, 13, 13 )
		setFPSLimit(45)
	elseif tonumber(var) <= 30 then
		outputChatBox ( "FPS-Cap. ist 30 oder nierdriger! Dies kann zu einem schlechten Spielerlebnis führen.",  224, 13, 13 )
		setFPSLimit(var)
	else
		setFPSLimit(var)
	end

	if getSetting (17, 1) == 0 then
		-- Unnötig Ass Fuck, muss die Box eh neu machen 25.11.2021
		--[[changeSetting (17, 1, 1)
		newInfobox("Seit Version 1.2b benutzen wir eine neue Infobox.", 1, 255, 255, 255, 255, 5)
		newInfobox("Nachrichten nun hier eingeblendet.", 2, 255, 255, 255, 255, 10)
		newInfobox("Die alte (oben) kann jedoch noch eventuell genutzt werden.", 3, 255, 255, 255, 255, 15)
		addEventHandler("onClientRender", root, tutNewInfobox)
		setTimer ( function()
			removeEventHandler("onClientRender", root, tutNewInfobox)
		end, 15*1000, 1 )
		--]]
	end
end
addCommandHandler("reloadSettings",loadClientSettings)



function tutNewInfobox ()
	
	dxDrawRectangle(0*sx, 0*sy, 2005*sx, 1440*sy, tocolor(0, 0, 0, 183), true)
	dxDrawRectangle(2005*sx, 0*sy, 557*sx, 375*sy, tocolor(0, 0, 0, 183), true)
	dxDrawRectangle(2005*sx, 1069*sy, 557*sx, 375*sy, tocolor(0, 0, 0, 183), true)
end

function experimanetelLoading ()
	local var = getSetting (3, 1)
	if var == 1 then
		addEventHandler("onClientResourceStart", sRes, function()
			for i,v in pairs(getResourceDynamicElementRoot(sRes), "object") do 
				setElementStreamable(v, false)
			end
		end)
		newInfobox("Experimentel Map-Streaming ist aktiviert.\nDies kann zu lade & Performance Problemen führen!", 2)
	end
end
