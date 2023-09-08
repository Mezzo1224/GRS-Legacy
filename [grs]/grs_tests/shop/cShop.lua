shopUI = {}
shopUI.package = {}
packageUI = {}
local defaultColorBtn, hoveringColorBtn, selectedColorBtn = tocolor(14, 194, 17, 255), tocolor(11, 153, 13, 255), tocolor(14, 207, 17, 255)

local function removeHex (s)
    if type (s) == "string" then
        while (s ~= s:gsub ("#%x%x%x%x%x%x", "")) do
            s = s:gsub ("#%x%x%x%x%x%x", "")
        end
    end
    return s or false
end

function showShopUI ()
    local defaultColor, hoveringColor, selectedColor = tocolor(23,94,165),  tocolor(29, 119, 209),  tocolor(18, 74, 130)
    shopUI["window"] = DGS:dgsCreateWindow(0.38, 0.11, 0.25, 0.34, "Shop", true)
    DGS:dgsCenterElement(shopUI["window"], false, true) 
    DGS:dgsWindowSetSizable(shopUI["window"], false)
    DGS:dgsWindowSetMovable(shopUI["window"], false)
    DGS:dgsSetProperty(shopUI["window"],"ignoreTitle", true)

    shopUI["coins"] = DGS:dgsCreateLabel(0.02, 0.08, 0.27, 0.05, "Coins: ZAHL", true, shopUI["window"])    
    shopUI["vip"] = DGS:dgsCreateLabel(0.65, 0.08, 0.31, 0.05, "VIP-Stufe: Titan bis zum 01.01.2940", true, shopUI["window"])    
    DGS:dgsLabelSetHorizontalAlign( shopUI["vip"], "center" )

    shopUI["tabpanel"] = DGS:dgsCreateTabPanel (0.02, 0.15, 0.97, 0.83,true, shopUI["window"])
    DGS:dgsSetProperty(shopUI["tabpanel"],"tabPadding",{0.03,true})
    DGS:dgsSetProperty( shopUI["tabpanel"],"tabAlignment","center")
    DGS:dgsSetProperty(shopUI["tabpanel"],"tabColor",{defaultColor,hoveringColor,selectedColor})
    shopUI["info"] = DGS:dgsCreateTab("Information",shopUI["tabpanel"])
    shopUI["vipLevels"] = DGS:dgsCreateTab("VIP-Stufen",shopUI["tabpanel"])
    shopUI["packages"] = DGS:dgsCreateTab("Pakete",shopUI["tabpanel"])
    shopUI["sendPSC"] = DGS:dgsCreateTab("Paysafecard einschicken",shopUI["tabpanel"])
    shopUI["shopHistory"] = DGS:dgsCreateTab("Verlauf",shopUI["tabpanel"])
    -- // VIP-Stufe
    intVIPLevelTabs ()
    -- // Packages
    intPackageTab ()
    -- // Informationen
    shopUI["infoImage"] = DGS:dgsCreateImage(0.03, 0.04, 0.40, 0.93, ":grs_tests/placeholder.png", true, shopUI["info"])
    -- // Verlauf
    intShopHistory ()
    -- // Paysafecard
    shopUI.pins = {}
    shopUI.pins["pin_1"] = DGS:dgsCreateEdit(0.24, 0.35, 0.12, 0.10, "", true, shopUI["sendPSC"])
    shopUI.pins["pin_2"] = DGS:dgsCreateEdit(0.38, 0.35, 0.12, 0.10, "", true, shopUI["sendPSC"])
    shopUI.pins["pin_3"] = DGS:dgsCreateEdit(0.51, 0.35, 0.12, 0.10, "", true, shopUI["sendPSC"])
    shopUI.pins["pin_4"] = DGS:dgsCreateEdit(0.65, 0.35, 0.12, 0.10, "", true, shopUI["sendPSC"])

    -- DEBUG
    DGS:dgsSetSelectedTab(shopUI["tabpanel"] ,shopUI["packages"])

    for k, v in pairs( shopUI.pins) do
        DGS:dgsSetProperty(v,"placeHolder","PIN")
        DGS:dgsSetProperty(v,"enableTabSwitch", true)
        DGS:dgsSetProperty(v,"maxLength", 4)
        DGS:dgsSetProperty(v,"alignment",{"center","center"})
    end 

    shopUI["pinCredits"] = DGS:dgsCreateEdit(0.44, 0.49, 0.12, 0.08, "", true, shopUI["sendPSC"])
    DGS:dgsSetProperty(shopUI["pinCredits"],"placeHolder","Guthaben")
    DGS:dgsSetProperty(shopUI["pinCredits"],"alignment",{"center","center"})
    DGS:dgsSetProperty(shopUI["pinCredits"],"maxLength", 3)
    shopUI["sendPSCBtn"] =  DGS:dgsCreateButton(0.38, 0.60, 0.25, 0.12, "PIN einsenden", true, shopUI["sendPSC"])

    shopUI["sendPSCWaitingInfo"] = DGS:dgsCreateLabel(0.25, 0.76, 0.51, 0.07, "Das Gutschreiben des Guthabens dauert bis zu 72 Stunden", true, shopUI["sendPSC"])
    DGS:dgsLabelSetHorizontalAlign( shopUI["sendPSCWaitingInfo"], "center", false)
    DGS:dgsLabelSetVerticalAlign( shopUI["sendPSCWaitingInfo"], "center")

end
function intShopHistory ()
    shopUI["shopHistoryList"] = DGS:dgsCreateGridList(0.02, 0.04, 0.97, 0.92, true, shopUI["shopHistory"])
    shopUI["shopHistoryList_item"] = DGS:dgsGridListAddColumn(shopUI["shopHistoryList"], "Gegenstand", 0.2)
    shopUI["shopHistoryList_price"] = DGS:dgsGridListAddColumn(shopUI["shopHistoryList"], "Preis", 0.2)
    shopUI["shopHistoryList_currency"] = DGS:dgsGridListAddColumn(shopUI["shopHistoryList"], "Währung", 0.2)
    shopUI["shopHistoryList_date"] = DGS:dgsGridListAddColumn(shopUI["shopHistoryList"], "Datum", 0.2)
    DGS:dgsSetProperty(shopUI["shopHistoryList"],"rowHeight",20)
    DGS:dgsSetProperty(shopUI["shopHistoryList"],"bgColor",tocolor(69, 74, 77))
    DGS:dgsSetProperty(shopUI["shopHistoryList"],"colorCoded",true)
end

function intPackageTab ()
    shopUI.package["packageScrollbar"] = DGS:dgsCreateScrollPane(0.02, 0.05, 0.97, 0.93, true, shopUI["packages"])
    triggerServerEvent ( "getPackages", root ) 
end

function intVIPLevelTabs ()
    triggerServerEvent ( "getVIPLevels", root )

    shopUI["vipLevelsList"] = DGS:dgsCreateGridList(0.02, 0.03, 0.38, 0.94, true, shopUI["vipLevels"])
    shopUI["vipLevelsList_level"] = DGS:dgsGridListAddColumn(shopUI["vipLevelsList"], "Stufe", 0.3)
    shopUI["vipLevelsList_price"] = DGS:dgsGridListAddColumn(shopUI["vipLevelsList"], "Preis", 0.3)
    shopUI["vipLevelsList_priceCoins"] = DGS:dgsGridListAddColumn(shopUI["vipLevelsList"], "Coins", 0.3)
    DGS:dgsSetProperty(shopUI["vipLevelsList"],"rowHeight",30)
    DGS:dgsSetProperty(shopUI["vipLevelsList"],"bgColor",tocolor(69, 74, 77))
    DGS:dgsSetProperty(shopUI["vipLevelsList"],"colorCoded",true)
    shopUI["vipLevelInfo"] =  DGS:dgsCreateMemo(0.42, 0.23, 0.56, 0.54, "", true, shopUI["vipLevels"])
    DGS:dgsSetProperty(shopUI["vipLevelInfo"],"readOnly", true)
    shopUI["BuyVipLevelMoney"] = DGS:dgsCreateButton(0.72, 0.82, 0.18, 0.11, "Kaufen mit Geld", true, shopUI["vipLevels"])
    shopUI["BuyVipLevelCoins"] = DGS:dgsCreateButton(0.51, 0.82, 0.18, 0.11, "Kaufen mit Coins", true, shopUI["vipLevels"])
    DGS:dgsSetProperty(shopUI["BuyVipLevelMoney"], "color", {tocolor(14, 194, 17, 255), tocolor(11, 153, 13, 255), tocolor(14, 207, 17, 255)})
    DGS:dgsSetProperty(shopUI["BuyVipLevelCoins"], "color", {tocolor(14, 194, 17, 255), tocolor(11, 153, 13, 255), tocolor(14, 207, 17, 255)})
    shopUI["vipLevelName"] = DGS:dgsCreateLabel(0.50, 0.05, 0.40, 0.14, "VIP-STUFE NAME", true, shopUI["vipLevels"])
    DGS:dgsSetProperty(shopUI["vipLevelName"],"textSize",{1.7,1.7})
    DGS:dgsSetProperty(shopUI["vipLevelName"],"colorCoded",true)
    DGS:dgsLabelSetHorizontalAlign(shopUI["vipLevelName"], "center", false)
    DGS:dgsLabelSetVerticalAlign(shopUI["vipLevelName"], "center")

    addEventHandler( "onDgsMouseClick", shopUI["vipLevelsList"], 
    function(button, state, x, y)
        if source == shopUI["vipLevelsList"] then
            if button == 'left' and state == 'up' then
                local Selected = DGS:dgsGridListGetSelectedItem(shopUI["vipLevelsList"])
				if Selected ~= -1 then 
					local name = DGS:dgsGridListGetItemText(shopUI["vipLevelsList"],Selected, 1)
                    local id = DGS:dgsGridListGetItemData(shopUI["vipLevelsList"],Selected, 1, "id")
					local desc = DGS:dgsGridListGetItemData(shopUI["vipLevelsList"],Selected, 1, "desc")
                    DGS:dgsSetText(shopUI["vipLevelName"], name)
					DGS:dgsClear(shopUI["vipLevelInfo"])
					DGS:dgsSetText(shopUI["vipLevelInfo"], desc.."\nDrücke Doppelt auf Kaufen um das Item zu kaufen.")

                    -- // Buttons ?
                    local moneyPrice = DGS:dgsGridListGetItemText(shopUI["vipLevelsList"],Selected, 2)
                    local coinsPrice = DGS:dgsGridListGetItemText(shopUI["vipLevelsList"],Selected, 3)
                    if tonumber(moneyPrice) > 0 then
                        DGS:dgsSetEnabled ( shopUI["BuyVipLevelMoney"], true )
                    else
                        DGS:dgsSetEnabled ( shopUI["BuyVipLevelMoney"], false )
                    end
                    if tonumber(coinsPrice) > 0 then
                        DGS:dgsSetEnabled ( shopUI["BuyVipLevelCoins"], true )
                    else
                        DGS:dgsSetEnabled ( shopUI["BuyVipLevelCoins"], false )
                    end
				end
            end
        end
    end)

end



local clientPackage = {}
function addPackageToTab (packageID, packageName, packageLabel, packagePrice, packageImage)
    local packageImage = (packageImage) and packageImage or ":grs_tests/placeholder.png"
    local calculatePackageID = (packageID-1)

    shopUI.package[packageID] = {}
    shopUI.package[packageID]["picture"] = DGS:dgsCreateImage(0.02+(0.39*calculatePackageID), 0.05, 0.21, 0.46, packageImage, true, shopUI.package["packageScrollbar"])
    shopUI.package[packageID]["labelTooltip"] = DGS:dgsCreateToolTip()
    DGS:dgsTooltipApplyTo(shopUI.package[packageID]["labelTooltip"],shopUI.package[packageID]["picture"],packageLabel)
    shopUI.package[packageID]["packageName"] = DGS:dgsCreateLabel(0.02+(0.39*calculatePackageID), 0.52, 0.21, 0.09, packageName, true, shopUI.package["packageScrollbar"])
    DGS:dgsLabelSetHorizontalAlign(shopUI.package[packageID]["packageName"], "center", false)
    DGS:dgsLabelSetHorizontalAlign(shopUI.package[packageID]["packageName"], "center")
    shopUI.package[packageID]["packageLabel"] = DGS:dgsCreateLabel(0.02+(0.39*calculatePackageID), 0.63, 0.21, 0.09, ""..packagePrice.." Coins", true, shopUI.package["packageScrollbar"])
    DGS:dgsLabelSetHorizontalAlign( shopUI.package[packageID]["packageLabel"], "center", false)
    DGS:dgsLabelSetHorizontalAlign( shopUI.package[packageID]["packageLabel"], "center")
    shopUI.package[packageID]["buyPackage"] = DGS:dgsCreateButton(0.04+(0.39*calculatePackageID), 0.75, 0.18, 0.14, "Paket ansehen", true, shopUI.package["packageScrollbar"])
    DGS:dgsSetProperty(shopUI.package[packageID]["buyPackage"] , "color", {defaultColorBtn, hoveringColorBtn, selectedColorBtn})
    addEventHandler( "onDgsMouseClick", shopUI.package[packageID]["buyPackage"], 
    function(button, state, x, y)
        if source == shopUI.package[packageID]["buyPackage"] then
            if button == 'left' and state == 'up' and not packageUI["window"] then
                showPackageInfo (packageID, packageName, packagePrice, packageImage)
            end
        end
    end)
end
addEvent ( "addPackageToTab", true )
addEventHandler ( "addPackageToTab", getRootElement(), addPackageToTab )

function addVIPLevelToGrid (level, name, price, priceCoins, description)
    local row = DGS:dgsGridListAddRow ( shopUI["vipLevelsList"] )
    DGS:dgsGridListSetItemData ( shopUI["vipLevelsList"], row, shopUI["vipLevelsList_level"], "id", level )
    DGS:dgsGridListSetItemData ( shopUI["vipLevelsList"], row, shopUI["vipLevelsList_level"], "desc", description )
    DGS:dgsGridListSetItemText ( shopUI["vipLevelsList"], row, shopUI["vipLevelsList_level"], name )
    DGS:dgsGridListSetItemText ( shopUI["vipLevelsList"], row, shopUI["vipLevelsList_price"],  tostring(price) )
    DGS:dgsGridListSetItemText ( shopUI["vipLevelsList"], row, shopUI["vipLevelsList_priceCoins"],  tonumber(priceCoins) )
end
addEvent ( "addVIPLevelToGrid", true )
addEventHandler ( "addVIPLevelToGrid", getRootElement(), addVIPLevelToGrid )

--showShopUI ()

function showPackageInfo (packageID, packageName, packagePrice, packageImage)
    packageUI["window"] = DGS:dgsCreateWindow(0.45, 0.18, 0.10, 0.32, packageName.." - "..packagePrice.." Coins", true)
    DGS:dgsCenterElement(packageUI["window"], false, true) 
    DGS:dgsWindowSetSizable(packageUI["window"], false)
    DGS:dgsWindowSetMovable(packageUI["window"], false)
    DGS:dgsSetProperty(packageUI["window"],"ignoreTitle", true)

    packageUI["packageInfo"] = DGS:dgsCreateImage(0.26, 0.07, 0.48, 0.37, packageImage, true, packageUI["window"])
    
    packageUI["packageContentTitle"] = DGS:dgsCreateLabel(0.06, 0.47, 0.88, 0.06, "Paketinhalt", true, packageUI["window"])
    DGS:dgsSetProperty(packageUI["packageContentTitle"],"textSize",{1.2,1.2})
    DGS:dgsLabelSetHorizontalAlign( packageUI["packageContentTitle"], "center", false)
    DGS:dgsLabelSetHorizontalAlign( packageUI["packageContentTitle"], "center")
    packageUI["scrollpanel"] = DGS:dgsCreateScrollPane(0.06, 0.54, 0.88, 0.32, true, packageUI["window"])

    packageUI["packageContent"] = DGS:dgsCreateLabel(0.03, 0.02, 0.93, 0.89, "- DAS\n- DAS\n- UND DAS\n", true, packageUI["scrollpanel"])   
    packageUI["buyPackage"] = DGS:dgsCreateButton(0.26, 0.88, 0.49, 0.09, "Kaufen" , true, packageUI["window"])    
    DGS:dgsSetProperty(packageUI["buyPackage"], "color", {defaultColorBtn, hoveringColorBtn, selectedColorBtn})
    DGS:dgsSetProperty(packageUI["window"],"postGUI", false)
    addEventHandler( "onDgsWindowClose", packageUI["window"], 
    function()
        packageUI["window"] = nil
    end)

    addEventHandler( "onDgsMouseClick", packageUI["buyPackage"], 
    function(button, state, x, y)
        if source == packageUI["buyPackage"] then
            if button == 'left' and state == 'up' then
                print ( "KAUF", packageID, packageName, packagePrice, packageImage)
            end
        end
    end)
end


