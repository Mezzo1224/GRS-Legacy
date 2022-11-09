
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

local curTotalChips = 0
local lastRoulettFieldMoney = 0

function showRoulettWindow ()

	curTotalChips = vioClientGetElementData ( "casinoChips" )
	local curTotalEditChips = 0
	lastRoulettFieldMoney = 0
	showCursor ( true )
	if isElement ( gWindow["roulett"] ) then
		dgsSetVisible ( gWindow["roulett"], true )
	else
		gWindow["roulett"] = dgsCreateWindow(screenwidth/2-161/2,0,161,194,"Einsatz",false)
		dgsWindowSetMovable ( gWindow["roulett"], false )
		dgsWindowSetSizable ( gWindow["roulett"], false )
		dgsSetAlpha(gWindow["roulett"],1)
		
		gScroll["roulett"] = dgsCreateScrollBar ( 11, 26, 137, 30, true, false, gWindow["roulett"] )
		dgsScrollBarSetScrollPosition ( gScroll["roulett"], 0 )
				
		gButton["placeBet"] = dgsCreateButton(76,135,66,40,"Setzen",false,gWindow["roulett"])
		dgsSetAlpha(gButton["placeBet"],1)
		
		gEdit["roulett"] = dgsCreateEdit(12,85,86,35,"0",false,gWindow["roulett"])
		dgsSetAlpha(gEdit["roulett"],1)
		
		gLabel[1] = dgsCreateLabel(106,92,50,14,"$ / Chips",false,gWindow["roulett"])
		dgsSetAlpha(gLabel[1],1)
		dgsLabelSetColor(gLabel[1],0,200,0)
		dgsLabelSetVerticalAlign(gLabel[1],"top")
		dgsLabelSetHorizontalAlign(gLabel[1],"left",false)
		dgsSetFont(gLabel[1],"default-bold-small")
		gImage[1] = dgsCreateImage(16,135,37,40,"images/inventory/chip.png",false,gWindow["roulett"])
		dgsSetAlpha(gImage[1],1)
		
		addEventHandler ( "onDgsElementScroll", gScroll["roulett"], roulettScrollBarChanged )
		addEventHandler ( "onDgsTextChange-C", gEdit["roulett"], roulettEditChanged )
		addEventHandler ( "onDgsMouseClickUp", gButton["placeBet"], roulettPlaceBet )
	end
end

function roulettScrollBarChanged ()

	local money = math.floor ( curTotalChips / 100 * dgsScrollBarGetScrollPosition ( gScroll["roulett"] ) + 0.5 )
	
	scrollBarChanged = true
	dgsSetText ( gEdit["roulett"], money )
	
	--reanableRoulettEvents ()
end

function roulettEditChanged ()

	if scrollBarChanged then
		scrollBarChanged = false
	else
		if curTotalEditChips ~= dgsGetText ( gEdit["roulett"] ) then
			local money = tonumber ( dgsGetText ( gEdit["roulett"] ) )
			if money then
				if money <= curTotalChips then
					money = math.floor ( money + 0.5 )
					dgsSetText ( gEdit["roulett"], money )
					curTotalEditChips = money
					money = money / curTotalChips * 100
					dgsScrollBarSetScrollPosition ( gScroll["roulett"], money )
				else
					dgsSetText ( gEdit["roulett"], curTotalChips )
				end
			else
				dgsSetText ( gEdit["roulett"], curTotalEditChips )
			end
		end
	end
end

function roulettPlaceBet ()

	local money = tonumber ( dgsGetText ( gEdit["roulett"] ) )
	curTotalChips = curTotalChips + ( getBetOnField () - money )
	placeRoulettChips ( money )
	roulettMarkerOver ()
end

function roulettMarkerOver ()

	curTotalChips = curTotalChips - lastRoulettFieldMoney + getBetOnField ()
	dgsSetText ( gEdit["roulett"], getBetOnField () )
	lastRoulettFieldMoney = tonumber ( dgsGetText ( gEdit["roulett"] ) )
end