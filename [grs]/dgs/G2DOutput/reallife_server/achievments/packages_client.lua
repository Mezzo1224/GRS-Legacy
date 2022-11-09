
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

function hidePackages_func ( package )
	setElementDimension ( package, 95 )
end
addEvent ( "hidePackages", true )
addEventHandler ( "hidePackages", root, hidePackages_func )


function hidePackagesArray_func ( array )
	for i=1, #array do 
		setElementDimension ( array[i], 95 )
	end
end
addEvent ( "hidePackagesArray", true )
addEventHandler ( "hidePackagesArray", root, hidePackagesArray_func )


function showAchievmentBox_func ( achievename, punkte, sichtbarzeit )
	-- entfernt
end
addEvent ( "showAchievmentBox", true )
addEventHandler ( "showAchievmentBox", getRootElement(), showAchievmentBox_func )

function playPackageSound ()
	playSound("sounds/reached.mp3")
end
addEvent ( "playPackageSound", true )
addEventHandler ( "playPackageSound", getRootElement(), playPackageSound )
