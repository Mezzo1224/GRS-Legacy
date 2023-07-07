-- // Test von VIP-Paketen

function betaPackage (player)
    outputChatBox("PaySafeCard? "..tostring(ServerConfig["shop"].canSendPaysafecard))

    for k, v in pairs(ServerConfig["shop"].packages) do
        outputChatBox("["..v.sortOrder.."] Name: "..k.." - Preis "..v.creditCosts.."c / "..v.moneyCosts.."$" )
    end
    outputChatBox("Interesse? /bpa packageName")
end
addCommandHandler("tpa",betaPackage )

function buyBetaPackage (player, cmd, ...)
    local packageName = {...}
    local packageName = table.concat( packageName, " " )

    local packagesTable = ServerConfig["shop"].packages
    local package = packagesTable[packageName]
    if package then
        outputChatBox("Paket wird erworben...")
        package.onBuy(player)
    else
        outputChatBox("Paket "..packageName.." gibt es nicht.")
    end


end
addCommandHandler("bpa",buyBetaPackage) 

-- // Ende des testens

function hasPermission ( player, permission )
    local pLevel = vioGetElementData ( player, "adminlvl" )
    if pLevel > 0 and permission then
        local permissionTable = ServerConfig["admin"]["ranks"][pLevel].permissions
        local isOwner = permissionTable["isOwner"]
        local hasPerm = permissionTable[permission]
        if hasPerm == true or isOwner then
            print("[hasPermission] "..getPlayerName(player).." hat das Recht '"..permission.."'. (Owner? "..tostring(isOwner)..")")
            return true
        else
            print("[hasPermission] "..getPlayerName(player).." hat die Permission '"..permission.."' nicht.")
            return false
        end
    else
        print("[hasPermission] Level zu niedrig oder Permission gibt es nicht.")
        return false
    end
end


function tPermission (player)
    print ( hasPermission(player, "isOwner") )

end
addCommandHandler("tpp",tPermission )