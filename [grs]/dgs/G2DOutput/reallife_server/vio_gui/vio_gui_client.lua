
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

mouseSet = "CGUI-Images"
mouseName = "OUT"
showVioGUIMouse = true

_guiCreateButton = dgsCreateButton
_guiCreateWindow = dgsCreateWindow
_guiCreateMemo = dgsCreateMemo
_guiCreateEdit = dgsCreateEdit
_guiCreateStaticImage = dgsCreateImage
_guiCreateLabel = dgsCreateLabel
_guiCreateCheckBox = dgsCreateCheckBox
_guiCreateComboBox = dgsCreateComboBox
_guiCreateGridList = dgsCreateGridList
_guiCreateProgressBar = dgsCreateProgressBar
_guiCreateRadioButton = dgsCreateRadioButton
_guiCreateScrollBar = dgsCreateScrollBar
_guiCreateScrollPane = dgsCreateScrollPane
_guiCreateTabPanel = dgsCreateTabPanel
_guiCreateTab = dgsCreateTab
_guiSetInputEnabled = dgsSetInputEnabled

numberFieldData = {}
progressBarData = {}

function vioGuiCreateProgressBar ( x, y, width, height, bool, startValue, parent )

	if not parent then
		parent = nil
	end
	if startValue then
		startValue = math.abs ( tonumber ( startValue ) )
	end
	if not startValue then
		startValue = 0
	end
	
	-- Relative --
	if bool then
		width = width * screenwidth
		height = height * screenheight
	end
	-- Relative --
	
	local pxSizeW = width / 72 * 5
	local pxSizeH = height / 15 * 3
	
	local base = dgsCreateImage ( x, y, width, height, "images/gui/bar/bar_c1.png", false, parent )
	dgsCreateImage ( 0, 0, width, pxSizeH, "images/colors/c_black.jpg", false, base ) -- upper bar
	dgsCreateImage ( 0, height - pxSizeH, width, pxSizeH, "images/colors/c_black.jpg", false, base ) -- bottom bar
	dgsCreateImage ( 0, 0, pxSizeW, height, "images/colors/c_black.jpg", false, base ) -- left bar
	dgsCreateImage ( width - pxSizeW, 1, pxSizeW, height, "images/colors/c_black.jpg", false, base ) -- right bar
	
	progressBarData[base] = dgsCreateImage ( pxSizeW, pxSizeH * 2, ( width - 2 * ( pxSizeW ) ) * startValue, height - 2 * ( pxSizeH ) - 1, "images/gui/bar/bar_c2.png", false, base ) -- progress from 0 to 1
	
	return base
end

function vioGuiSetProgressBarFuelState ( bar, fuelState )

	width, height = dgsGetSize ( bar, false )
	
	destroyElement ( progressBarData[bar] )
	
	local pxSizeW = width / 72 * 5
	local pxSizeH = height / 15 * 3
	
	progressBarData[bar] = dgsCreateImage ( pxSizeW, pxSizeH, ( width - 2 * ( pxSizeW ) ) * fuelState, height - 2 * ( pxSizeH ) - 1, "images/gui/bar/bar_c2.png", false, bar )
end

function guiCreateNumberField ( x, y, width, height, startValue, bool, parent, integer, abs )

	startValue = tonumber ( startValue )
	if integer == nil then
		integer = true
	end
	if abs == nil then
		abs = true
	end
	if not startValue then
		startValue = 0
	end
	if integer then
		startValue = math.floor ( startValue + 0.5 )
	end
	if abs then
		startValue = math.abs ( startValue )
	end
	local edit = dgsCreateEdit ( x, y, width, height, tostring ( startValue ), bool, parent )
	if edit then
		numberFieldData[edit] = {}
			numberFieldData[edit]["oldValue"] = startValue
			numberFieldData[edit]["abs"] = abs
			numberFieldData[edit]["integer"] = integer
		addEventHandler ( "onDgsTextChange-C", edit, 
			function ()
				local ctext = tonumber ( dgsGetText ( source ) )
				if ctext then
					local int = numberFieldData[source]["integer"]
					local abs = numberFieldData[source]["abs"]
					if abs then
						if not ( math.abs ( ctext ) == ctext ) then
							dgsSetText ( source, tostring ( numberFieldData[source]["oldValue"] ) )
						end
					end
					if int then
						if not ( math.floor ( ctext + 0.5 ) == ctext ) then
							dgsSetText ( source, tostring ( numberFieldData[source]["oldValue"] ) )
						end
					end
				elseif dgsGetText ( source ) == "" then
					dgsSetText ( source, "0" )
				else
					dgsSetText ( source, tostring ( numberFieldData[source]["oldValue"] ) )
				end
				numberFieldData[edit]["oldValue"] = tonumber ( dgsGetText ( source ) )
			end
		)
	end
	return edit
end

function guiDebugClick ()

	if getChessSurface () == source then
	elseif getElementType ( source ) == "gui-staticimage" and not internetImages[source] and not ( colorSelectionImage == source ) then
		dgsMoveToBack ( source )
	end
end
addEventHandler ( "onDgsMouseClickUp", getRootElement(), guiDebugClick )

function guiSetFontSize ( element, size )

	return dgsSetProperty ( element, "", size )
end

function setHudLessModeEnabled ( bool )

end

function dgsSetInputEnabled ( bool )

	toggleControl ( "chatbox", bool )
end

function guiSetToolTip ( element, toolTip )

	--return guiSetProperty ( element, "Tooltip", toolTip )
end

function dgsCreateScrollPane ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateScrollPane ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateTabPanel ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateTabPanel ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateTab ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateTab ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end


function dgsCreateCheckBox ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateCheckBox ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateComboBox ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateComboBox ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateGridList ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateGridList ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateProgressBar ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateProgressBar ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateRadioButton ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateRadioButton ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateScrollBar ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateScrollBar ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateButton ( x, y, width, height, text, relative, parent )

	local btn = _guiCreateButton ( x, y, width, height, text, relative, parent )
	--guiSetProperty ( btn, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	dgsSetFont ( btn, "default-bold-small" )
	return btn
end

function dgsCreateWindow ( x, y, width, height, titleBarText, relative )

	local element = _guiCreateWindow ( x, y, width, height, titleBarText, relative )
	dgsSetProperty ( element, "CaptionColour", "FF770000" )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	
	dgsWindowSetSizable ( element, false )
	dgsWindowSetMovable ( element, false )
	
	return element
end

function dgsCreateMemo ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateMemo ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateEdit ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateEdit ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateImage ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateStaticImage ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end

function dgsCreateLabel ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )

	local element = _guiCreateLabel ( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 )
	--guiSetProperty ( element, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
	return element
end
--[[function mouse_over_nil ()

	local img = dgsCreateImage ( 0, 0, 1, 1, "images/black.bmp", true )
	white = img
	dgsSetAlpha ( img, 0 )
	dgsSetProperty ( img, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
end]]
--guiSetProperty ( img, "MouseCursorImage", "set:"..mouseSet.." image:"..mouseName )
--mouse_over_nil()

function slowDrawText ( string )

	local length = #string
	local totalTime = length * timeForEveryLetter + 2500
	addEventHandler ( "onClientRender", getRootElement(), slowDrawText_render )
	curTextDrawString = ""
	for i = 1, length do
		setTimer ( redoDrawString, i * timeForEveryLetter + 1, 1, string, i )
	end
	setTimer ( removeLetterDraw, totalTime, 1 )
end

function redoDrawString ( string, i )
	curTextDrawString = string.sub ( string, 1, i )
end

function removeLetterDraw ()
	removeEventHandler ( "onClientRender", getRootElement(), slowDrawText_render )
end

function slowDrawText_render ()
	
	left, top, right, bottom = 0, 0, screenwidth, screenheight
	dxDrawText ( curTextDrawString, left, top, right, bottom, tocolor ( 255, 255, 255, 255 ), 1.0, "bankgothic", "center", "center", false, false, true )
end

local guiElementToolTips = {}
local guiElementToolImages = {}

function guiGetScreenPosition ( element )

	local x, y = dgsGetPosition ( element, false )
	local parent = getElementParent ( element )
	if parent and not ( getElementType ( parent ) == "guiroot" ) then
		local nx, ny = guiGetScreenPosition ( parent, false )
		return x + nx, y + ny
	else
		return x, y
	end
end

function addToolTip ( guiElement, text )

	guiElementToolTips[guiElement] = text
	addEventHandler ( "onDgsMouseEnter", guiElement,
		function ()
			local x, y = guiGetScreenPosition ( source, false )
			local width, height = dgsGetSize ( source, false )
			
			x = x + width
			y = y + height
			
			local text = guiElementToolTips[source]
			guiElementToolImages[source] = dgsCreateImage(x,y,113,113,"images/colors/c_black.jpg",false)
			
			setElementParent ( guiElementToolImages[source], source )
			
			dgsSetAlpha ( guiElementToolImages[source], 0 )
			setTimer (
				function ( element )
					if isElement ( element ) then
						dgsSetAlpha ( element, dgsGetAlpha ( element ) + 0.2 )
					end
				end,
			50, 5, guiElementToolImages[source] )
			
			gImage[2] = dgsCreateImage(0,0,113,113,"images/colors/c_grey.jpg",false,guiElementToolImages[source])
			dgsSetAlpha(gImage[2],0.5)
			gImage[3] = dgsCreateImage(0,0,113,113,"images/colors/transparent.png",false,gImage[2])
			dgsSetAlpha(gImage[3],1)
			gLabel[4] = dgsCreateLabel(7,5,102,117,"Hier kannst du\num Hilfe fragen,\nwenn du schnelle\nHilfe benötigst -\nz.B. wenn du\nirgendwo hängen\nbleibst.",false,gImage[3])
			dgsSetAlpha(gLabel[4],1)
			dgsLabelSetColor(gLabel[4],0,0,0)
			dgsLabelSetVerticalAlign(gLabel[4],"top")
			dgsLabelSetHorizontalAlign(gLabel[4],"left",false)
			dgsSetFont(gLabel[4],"default-bold-small")
			
			setElementParent ( gImage[2], guiElementToolImages[source] )
			setElementParent ( gImage[3], guiElementToolImages[source] )
			setElementParent ( gLabel[4], guiElementToolImages[source] )
			
			addEventHandler ( "onDgsMouseLeave", source,
				function ()
					dgsSetAlpha ( guiElementToolImages[source], 1 )
					setTimer (
						function ( element )
							if isElement ( element ) then
								dgsSetAlpha ( element, dgsGetAlpha ( element ) - 0.2 )
								if dgsGetAlpha ( element ) < 0.2 then
									destroyElement ( element )
								end
							end
						end,
					50, 5, guiElementToolImages[source] )
				end,
			false )
			addEventHandler ( "onElementDestroy", source,
				function ()
					destroyElement ( guiElementToolImages[source] )
				end
			)
		end,
	false )
end