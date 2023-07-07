

local function checkSolvency (player, cost)
    local money = vioGetElementData ( player, "money" )
    local bankmoney = vioGetElementData ( player, "bankmoney" )
    
    if money >= cost then
        return "money"
    elseif bankmoney >= cost then
        return "bankmoney"
    else
        return false
    end
end

local function isNameAvailable (name, isShort)
    print("Checke Verfügbarkeit", name, isShort)
    if isShort == true then
        print(name, "ist abkürzung")
        if dbExist ( "cooperations", "nameShort LIKE '"..name.."'") then
            return false
        else
            return true
        end
    else
        if dbExist ( "cooperations", "name LIKE '"..name.."'") then
            return false
        else
            return true
        end
    end
end

--- // Neue UI
function isFactionCreateable(player, data)
   if player == source then
        result = {}
        -- Debug
        for i,line in pairs(data) do
            print(i, line)
        end
        local canPay =  checkSolvency (player, SharedConfig["costumFactions"].creationCost)
        if canPay ~= false then
            result.paymentMethode = canPay
        else
            result.failed = true
        end
        local money = vioGetElementData ( player, "money" )
        local bankmoney = vioGetElementData ( player, "bankmoney" )
        result.costs = SharedConfig["costumFactions"].creationCost
        result.bankmoney, result.money = bankmoney, money
        -- // Name zu lang ?
        if string.len(data.name) > SharedConfig["costumFactions"].nameMaxLengh then 
            result.nameToLong = true
            result.failed = true
        else
            result.nameToLong = false

            -- // Checken ob Name verfügbar
            if isNameAvailable (data.name, false) then
                result.nameTaken = false
            else
                result.nameTaken = true
                result.failed = true
            end
        end

        -- // Abkürzung zu lang ?
        if string.len(data.nameshort) > SharedConfig["costumFactions"].nameshortMaxLengh then 
            result.nameshortToLong = true
            result.failed = true
        else
            result.nameshortToLong = false

            -- // Checken ob Abkürzung verfügbar
            if isNameAvailable (data.nameshort, true) then
                result.nameshortTaken = false
            else
                result.nameshortTaken = true
                result.failed = true
            end
        end

        if data.RGB then
            result.validRGB = true
        else
            result.validRGB = false
        end
        
        local housekey = vioGetElementData ( player, "housekey" )
     --   if getPlayerFaction ( player ) == 0 then
      --      if not isInCoop(player) then
        if housekey > 0 then
            result.hasHouse = true
        else
            result.hasHouse = false
            result.failed = true
        end

        triggerClientEvent ( player, "createFinalizeFaction", getRootElement(), result )	
    end
end
addEvent ( "isFactionCreateable", true )
addEventHandler ( "isFactionCreateable", getRootElement(),  isFactionCreateable )