
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

addEvent ( "makePedInvulnerable", true )

function createInvulnerablePed ( skin, x, y, z, r, int, dim )

	local ped = createPed ( skin, x, y, z )
	if not dim then
		dim = 0
	end
	setElementInterior ( ped, int )
	setElementDimension ( ped, dim )
	setPedRotation ( ped, r )
	addEventHandler ( "onClientPedDamage", ped,
		function ()
			cancelEvent()
		end
	)
	return ped
end

function makePedInvulnerable_func ( peds )
	for ped, _ in pairs ( peds ) do
		addEventHandler ( "onClientPedDamage", ped, _cancelEvent )
	end
end
addEventHandler ( "makePedInvulnerable", root, makePedInvulnerable_func )


function _cancelEvent ( )
	cancelEvent()
end