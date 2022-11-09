
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

addEvent( "onBankPedGetsCool", true )
function cancelPedDamageBank ( attacker )
	
	if not fac then return end
	
	if not attacker then
		cancelEvent ()
	end
	
	local fac = getElementData ( attacker, "fraktion" )
	
	if fac == 2 or fac == 3 or fac == 7 or fac == 9 or fac == 12 or fac == 13 then
	else
		cancelEvent ()
	end	

end

function makeTheBankPedCool ( ped )

	addEventHandler ( "onClientPedDamage", ped, cancelPedDamageBank )

end

addEventHandler( "onBankPedGetsCool", getRootElement(), makeTheBankPedCool )