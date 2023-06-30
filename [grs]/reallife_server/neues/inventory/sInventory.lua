inventory = {}

function intPlayerInventory (player)
    local pname = getPlayerName(player)
    if not inventory[pname] then
        inventory[pname] = {}
    end
end

function loadPlayerInventory (player)
    intPlayerInventory (player)
    local pname = getPlayerName(player)
    local result = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "inventar", "userdata", "UID",  playerUID[pname] ), -1 )
    if not result or not result[1] then
        inventory[pname] = fromJSON(result[1])
    end
end


function savePlayerInventory (player)
    local pname = getPlayerName(player)
    
    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "inventar",  toJSON ( inventory[pname] ), "UID", playerUID[pname] )
    outputDebugString("Inventar gespeichert.")
end

function addItem (player, cmd, item, amount )
    intPlayerInventory (player)
    local amount = tonumber(amount)
    local pname = getPlayerName(player)
    if items[item] then
        if not amount then
            amount = 1
        end
        if items[item].maxamount >= amount or tonumber(items[item].maxamount) == 0 then
            if  inventory[pname][item] then
                currentAmount =  inventory[pname][item]
            else
                currentAmount =  0
            end
            print(currentAmount.." bekommt er")
            if currentAmount < tonumber(items[item].maxamount) or tonumber(items[item].maxamount) == 0 then
                inventory[pname][item] = (amount + currentAmount)
                print( inventory[pname][item].." hat er jetzt")
            else
                print("Er hat schon die maximale menge")
            end
        else
            print("Zuviele Items")
        end
    else
        print("Item gibt es nicht.")
    end
end
addCommandHandler("ai", addItem)