
-- Investieren ( in Firmen )
-- Berechnen Aktie: Wert festgelegt durch Leader + 5% der Wert der Firma
-- Jede Aktie bringt beim Verkauf von Fahrzeugen oder beim abgeben des Geldtrucks dem Investor 3% der Einnahmen, diese werden aber nicht von
-- den einnahmen der Aktion abgezogen, eine Art Dividente.
-- 100.000 Grundkosten (bzw. "cooperationCreateCosts") + 1.600.000$ (Level 3 ) = Davon 5% == 85.000$ -- Leaderkosten: 30.000$
-- Die Firma bekommst 20% der Aktie + Das Geld der Leaderkosten
-- Der Leader bekommst pro Firmen-Payday für Jede Aktie 1% des Aktien wertes

local percFromCompany = 5 -- // Wieviel % des Firmenwertes


local function calculateStocks (coopID, stocks)
    local coopLevel = cooperation[coopID].coopLevel
    local stockValueByLeader = 1000
    local coopValue = 0
    for i, var in pairs (cooperationLevelCosts) do
        if i <= coopLevel then
            coopValue = coopValue + var
        end
    end

    -- // Weiter rechnen
    local coopValue = coopValue + cooperationCreateCosts
    print("Erste "..coopValue)
    local coopValue = (((coopValue/100) * percFromCompany) + stockValueByLeader) * stocks
    print("Preis nach "..stocks.." Stocks "..coopValue)
    print("Preis mit einem Stock "..(coopValue/stocks))
    return coopValue

end

local function buyCoopStocks (player, coopID, stocks, isSure)
    local price = calculateStocks ( coopID, stocks)
    local bankmoney = vioGetElementData ( player, "money" )
    if bankmoney > price then

    else
        newInfobox(player,"Du hast nicht genug Geld auf deinem Bankkonto.", 3)
    end
end
addEvent ( "buyCoopStocks", true )
addEventHandler ( "buyCoopStocks", getRootElement(),  buyCoopStocks )


local function listCompanysForStocks ()
    for i, coop in pairs(cooperation) do 
       if coop.coopType == 2 then
        -- // Firma hinzufügen
            local price = calculateStocks ( i, 1)
            print(i, coop.name, price.." Preis pro Aktie" )
       end
    end
end
addEvent ( "listCompanysForStocks", true )
addEventHandler ( "listCompanysForStocks", getRootElement(),  listCompanysForStocks )


-- setTimer(listCompanysForStocks, 10000, 1)