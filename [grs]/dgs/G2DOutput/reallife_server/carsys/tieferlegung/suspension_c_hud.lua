
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

function CriarJanela() -- Create all windows necessary to suspension
	-- Create the window for the CTRL HOLD suspension controller
	janela_ctrl = dgsCreateWindow(639, 448, 151, 120, sk.."-Rl", false)
	dgsWindowSetSizable(janela_ctrl, false)
	dgsSetAlpha(janela_ctrl, 0.50)
	SuspensionUp = dgsCreateButton(12, 44, 122, 26, "˄", false, janela_ctrl)
	SuspensionDown = dgsCreateButton(12, 76, 122, 23, "˅", false, janela_ctrl)
	TxtHoldCtrl = dgsCreateLabel(12, 19, 127, 15, "", false, janela_ctrl)    
	dgsSetVisible ( janela_ctrl, false ) -- Set hold ctrl visible
 end


function EscondeMostra()
	 
	if (dgsGetVisible(janela_ctrl) == false) then -- Check if the GUI are visible	
		dgsSetVisible(janela_ctrl, true)				  
		bindKey("mouse_wheel_up", "down", Levanta) 
		bindKey("mouse_wheel_down", "down", Desce)
		bindKey("num_add", "down", Levanta) 
		bindKey("num_sub", "down", Desce)
		-- Falls es während der Fahrt nicht gehen soll -- 
		--[[if(movewith == "false") then
			bindKey("w", "down", EscondeJanela)
			bindKey("s", "down", EscondeJanela)
		end]]
	else
		EscondeJanela()
	end
end
			
function EscondeJanela() -- This function hide the GUI and unbind all the keys that i've pass before		
    dgsSetVisible(janela_ctrl, false)		
    unbindKey("mouse_wheel_up", "down", Levanta) 
	unbindKey("mouse_wheel_down", "down", Desce)
	unbindKey("num_add", "down", Levanta) 
	unbindKey("num_sub", "down", Desce)
			
	-- Falls es während der Fahrt nicht gehen soll --
	--[[if(movewith == "true") then
		unbindKey("w", "down", EscondeJanela)
		unbindKey("s", "down", EscondeJanela)
	end]]
end
addEventHandler( "onClientPlayerVehicleExit", getLocalPlayer(), EscondeJanela  )

			
function onGuiClick ()
    if (source == SuspensionUp) then
        triggerServerEvent("subir", getLocalPlayer())
    elseif (source == SuspensionDown) then
        triggerServerEvent("descer", getLocalPlayer())
    end
end
addEventHandler("onDgsMouseClickUp",root,onGuiClick)	  
addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource( ) ), CriarJanela )
