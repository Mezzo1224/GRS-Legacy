vipPackageName= {
    [1] = "#8A2908Bronze",
    [2] = "#A4A4A4Silber",
    [3] = "#AEB404Gold",
    [4] = "#D8D8D8Platin",
    [5] = "#848484Titan"
}

vipPackageSocialTime= {
    [1] = (604800*4),
    [2] = (604800*2),
    [3] = (604800*1),
    [4] = 86400,
    [5] = 60
}

vipPackageTeleTime= {
    [1] = (604800*4),
    [2] = (604800*2),
    [3] = (604800*1),
    [4] = 86400,
    [5] = 60
}

vipPackagePremCarGive= {
    [1] = false,
    [2] = false,
    [3] = false,
    [4] = true,
    [5] = true
}

vipPackagePremCarGiveTime= {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 604800,
    [5] = 604800/2
}

ziviTimeReduction= {
    [0] = 0,
    [1] = 0,
    [2] = 2,
    [3] = 5,
    [4] = 7,
    [5] = 10
}

vipPayDayExtra= {
    [0] = 0,
    [1] = 50,
    [2] = 100,
    [3] = 150,
    [4] = 200,
    [5] = 300
}

vipEPtoMoney = {
    [0] = 10,
    [1] = 8,
    [2] = 6,
    [3] = 4,
    [4] = 2,
    [5] = 1,
}


maxPackages = tonumber(#vipPackageName)
changeCarLockedIDs= {[432] = true,[476] = true,[447] = true,[464] = true, [425] = true}


local rt = getRealTime ()
local timesamp = rt.timestamp

function isPremium ( player )
    return  vioGetElementData ( player, "premium" )
end
function checkPremium ( player )
    local PremiumData = vioGetElementData ( player, "PremiumData" )
    local paket = vioGetElementData ( player, "Paket" )
    local pname = getPlayerName(player)
    if PremiumData ~= 0 then
        if PremiumData > timesamp then
            if paket > 0  then
                outputChatBox ( "Premium: Aktiv. Bis zum "..getData (PremiumData), player, 0, 125, 0,true )
                giveAchievement( player, 9 )
                outputChatBox ( "Stufe: "..vipPackageName[paket], player, 0, 125, 0,true )
                vioSetElementData ( player, "premium", true )
            else
                outputChatBox("Premium-Status: Stufe nicht gefunden, bitte Projektleiter kontaktieren.", player, 125, 0, 0)
                vioSetElementData ( player, "premium", false )
            end

        else
            outputChatBox("Premium-Status: Abgelaufen.", player, 125, 0, 0)
            dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "PremiumPaket", 0, "PremiumData", 0,  "UID", playerUID[pname] )
            vioSetElementData ( player, "PremiumData", 0 )
            vioSetElementData ( player, "Paket", 0 )
            vioSetElementData ( player, "premium", false )
        end
    else
        outputChatBox("Premium-Status: Nicht Aktiv.", player, 125, 0, 0)
        dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "PremiumPaket", 0, "PremiumData", 0,  "UID", playerUID[pname] )
        vioSetElementData ( player, "PremiumData", 0 )
        vioSetElementData ( player, "Paket", 0 )
        vioSetElementData ( player, "premium", false )
    end
end

function showPremiumFunctions (player, cmd, specLevel)
    if vioGetElementData ( player, "premium" ) == true or specLevel then
        local paket = vioGetElementData ( player, "Paket" )
        if not specLevel then
            specLevel = 0
        end
        if tonumber ( specLevel ) > 0 then
            paket = tonumber ( specLevel )
        end
        outputChatBox ( "Features von Stufe: "..vipPackageName[paket], player, 0, 125, 0,true )
        outputChatBox("/status [STATUS] - Ändert deinen Status - Alle "..math.floor(vipPackageSocialTime[paket]/86400).." Tag(e) möglich.", player, 0, 125, 0)
        outputChatBox("/tele [NUMMER] - Ändert deine Nummer - Alle "..math.floor(vipPackageTeleTime[paket]/86400).." Tag(e) möglich.", player, 0, 125, 0)
        outputChatBox("/pcar [SLOT] [ID/NAME] - Setzt dir ein Premium Fahrzeug. (Verfügbar:  "..vioGetElementData ( player, "PremiumCars")..")", player, 0, 125, 0)
        outputChatBox("Sonstige Features:", player, 0, 125, 0)
        if vipPackagePremCarGive[paket] == true then
            outputChatBox("Alle "..math.floor(vipPackagePremCarGiveTime[paket]/86400).."  Tag(e) ein gratis Premium Fahrzeug.", player, 0, 125, 0)
        end
        if vipPayDayExtra[paket] > 0 then
            outputChatBox(vipPayDayExtra[paket].."% mehr unversteurte Einnahmen beim Payday.", player, 0, 125, 0)
        end
        if ziviTimeReduction[paket] > 0 then
            outputChatBox(ziviTimeReduction[paket].."% weniger Zivilzeit.", player, 0, 125, 0)
        end
        outputChatBox("EP zu $ Kurs: "..vipEPtoMoney[paket].." zu 1.", player, 0, 125, 0)
    else
        newInfobox (player, "Du bist nicht befugt.\nProbiere /phelp [1-"..#vipPackageName.."]", 3)
    end
end
addCommandHandler("phelp", showPremiumFunctions )


function setPremiumData (player, tage,package)
    local pname = getPlayerName(player)
    local PremiumData = tonumber(vioGetElementData ( player, "PremiumData" ))
    local rt = getRealTime ()
    local timesamp = rt.timestamp
    vioSetElementData ( player, "Paket", tonumber(package) )
    vioSetElementData ( player, "PremiumData", timesamp+86400*tage )
    dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "PremiumPaket", package, "PremiumData", timesamp+86400*tage,  "UID", playerUID[pname] )
    checkPremium ( player )
end





function changeSocial ( player, cmd , ... )
    local paket = tonumber(vioGetElementData ( player, "Paket" ))
    local parametersTable = {...}
    local rt = table.concat( parametersTable, " " )
    local words = string.len(rt)
    if vioGetElementData ( player, "premium" ) == true then
        if vioGetElementData ( player, "lastSocialChange") < timesamp then
            if words >= 1 then
                if words <= 16 then
                    vioSetElementData ( player, "socialState", rt )
                    outputChatBox ( "Status zu "..rt.." geändert.", player, 0, 125, 0 )
                    vioSetElementData ( player, "lastSocialChange", timesamp + (vipPackageSocialTime[paket]) )
                    outputChatBox ( "Du kannst deinen Status am "..getData(timesamp + (vipPackageSocialTime[paket])).." wieder ändern.", player, 0, 125, 0 )
                else
                    outputChatBox("Zuviele Zeichen, es sind maximal 16 erlaubt. (Leerzeichen zählen mit)", player, 255, 155, 0 )
                end
            else
                outputChatBox("Zuwenig Zeichen, es ist minimal eins erlaubt. (Leerzeichen zählen mit)", player, 255, 155, 0 )

            end
        else
            outputChatBox ( "Du kannst deinen Status am "..getData(timesamp + (vipPackageSocialTime[paket])).." wieder ändern.", player, 0, 125, 0 )
        end
    else
        outputChatBox("Du bist kein Premium User." , player, 0, 200, 0 )
    end
end
addCommandHandler("status", changeSocial )



function changeNumber ( player, cmd, number )

    local paket = tonumber(vioGetElementData ( player, "Paket" ))
    if vioGetElementData ( player, "premium" ) == true then
        if vioGetElementData ( player, "lastNumberChange") < timesamp then
            if tonumber(number) then
                if tonumber(number) >= 100 then
                    if tonumber(number) <= 9999999 then
                        if tonumber ( number ) ~= 911 and tonumber ( number ) ~= 333 and tonumber ( number ) ~= 400 and tonumber (number ) ~= 666666 then
                            if not dbExist ( "userdata", "Telefonnr LIKE '"..number.."'") then
                                dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "userdata", "Telefonnr", number, "UID", playerUID[getPlayerName(player)] )
                                vioSetElementData ( player, "telenr", number )
                                outputChatBox ( "Nummer zu "..number.." geändert.", player, 0, 125, 0 )
                                vioSetElementData ( player, "lastNumberChange", timesamp + (vipPackageTeleTime[paket]) )
                                outputChatBox ( "Du kannst deine Nummer am "..getData(timesamp + (vipPackageTeleTime[paket])).." wieder ändern.", player, 0, 125, 0 )
                            else
                                outputChatBox("Ungültige Nummer." , player, 255, 155, 0 )
                            end
                        else
                            outputChatBox("Diese Nummer gibt es bereits." , player, 255, 155, 0 )
                        end
                    else
                        outputChatBox("Deine Nummer ist zu groß." , player, 255, 155, 0 )
                    end
                else
                    outputChatBox("Deine Nummer muss über 99 sein." , player, 255, 155, 0 )
                end

            else
                outputChatBox("/tele [deine gewünschte Nummer]" , player, 255, 155, 0 )
            end
        else
            outputChatBox ( "Du kannst deine Nummer am "..getData(timesamp + (vipPackageTeleTime[paket])).." wieder ändern.", player, 255, 155, 0 )
        end
    else
        outputChatBox("Du bist kein Premium User." , player, 255, 155, 0 )
    end
end
addCommandHandler("tele", changeNumber )



function changeCar ( player, cmd, slot, id)
    if not tonumber(id) and id then
        if getVehicleModelFromName(id) then
            print("ID von "..id)
            id = getVehicleModelFromName(id)
            print(id)
        else
            outputChatBox("Ungültiger Fahrzeugname. Du kannst auch IDs benutzen." , player, 255, 155, 0 )
        end
    end
    local pname = getPlayerName(player)
    if vioGetElementData ( player, "PremiumCars" ) >= 1 then
        if not changeCarLockedIDs[id] then
            if getVehicleNameFromModel(id) then
                local result = dbPoll ( dbQuery ( handler, "SELECT  ?? FROM ?? WHERE ??=? AND ??=?? ", "Typ", "vehicles", "Slot", slot, "UID", playerUID[pname] ), -1 )
                if result and result[1] then
                    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=? AND ??=??", "vehicles", "Typ", id, "Slot", slot, "UID", playerUID[pname] )
                    outputChatBox ( "Slot "..slot.." zum ID: "..id.." geändert.", player, 0, 125, 0 )
                    vioSetElementData ( player, "PremiumCars", vioGetElementData ( player, "PremiumCars" ) - 1 )
                    executeCommandHandler("towveh", player, slot)
                    if id == 520 then
                        outputChatBox ( "Das schießen der Hydra sorgt für das entziehen der Premium Rechte!", player, 0, 125, 0 )
                    end
                else
                    outputChatBox("Du besitzt kein Fahrzeug in diesem Slot." , player, 255, 155, 0 )
                end
            else
                outputChatBox("Ungültiges Fahrzeug. Benutze /pcar [SLOT] [ID/NAME]" , player, 255, 155, 0 )
            end
        else
            outputChatBox("Du darfst dir kein "..getVehicleNameFromModel(id).." geben." , player, 255, 155, 0 )
        end
    else
        outputChatBox("Du kannst momentan keine Premium Fahrzeuge setzen." , player, 255, 155, 0 )
    end
end
addCommandHandler("pcar", changeCar )



function giveFreePremiumCar ( player )
    local paket = tonumber(vioGetElementData ( player, "Paket" ))
    if vioGetElementData ( player, "premium" ) == true then
        if vipPackagePremCarGive[paket] == true then
            if vioGetElementData ( player, "lastPremCarGive" ) < timesamp then
                vioSetElementData ( player, "PremiumCars", vioGetElementData ( player, "PremiumCars" ) + 1 )
                vioSetElementData ( player, "lastPremCarGive", timesamp + (vipPackagePremCarGiveTime[paket]) )
                outputChatBox ( "Aufgrund deines Premium Paketes hast du ein gratis Premium Fahrzeug erhalten.", player, 0, 125, 0 )
                outputChatBox ( "Das nächste Premium Fahrzeug bekommst du, wenn dein Premium aktiv ist, am ", player, 0, 125, 0 )
                outputChatBox ( getData(timesamp + (vipPackagePremCarGiveTime[paket])), player, 0, 125, 0 )
            else
            --    outputChatBox ( "Das nächste Premium Fahrzeug bekommst du, wenn dein Premium aktiv ist, am ", player, 0, 125, 0 )
            --	outputChatBox ( getData(timesamp + (vipPackagePremCarGiveTime[paket])), player, 0, 125, 0 )
            end
        end
    end
end

function buystatus (player,cmd,...)
    local money = tonumber(vioGetElementData(player, "bankmoney"))
    local statusx = {...}
    local status = table.concat( statusx, " " )
    local words = string.len(status)
    local wordsmoney = words*10000
    local realmoney = wordsmoney+50000

    if words >= 1 then
        if words <= 21 then
            if tonumber(money) >= realmoney then
                if vioGetElementData ( player, "premium" ) == true then
                    realmoney = realmoney/2
                    outputChatBox("Du hast aufgrund deine Premium Status deinen Status zum halben Preis bekommen.", player, 255, 155, 0 )
                end
                vioSetElementData ( player, "socialState", status )
                vioSetElementData ( player, "bankmoney", vioGetElementData ( player, "bankmoney" ) - realmoney )
                outputChatBox ( "Der Satus "..status.." wurde erfolgreich für "..realmoney.."$ gekauft!", player, 0, 125, 0 )
            else
                outputChatBox("Du hast nicht genug Geld! Du brauchst "..realmoney.."$ auf der Bank!", player, 255, 155, 0 )
            end
        else
            outputChatBox("Zuviele Zeichen, es sind maximal 16 erlaubt. (Leerzeichen zählen mit)", player, 255, 155, 0 )
        end
    else
        outputChatBox("Zuwenig Zeichen, es ist minimal eins erlaubt. (Leerzeichen zählen mit)", player, 255, 155, 0 )
    end
end
addCommandHandler("buystatus" , buystatus )


-- Funktionen für den Shop

function getPremiumData (player)
	local premTime = vioGetElementData ( player, "PremiumData" )
    local pack = vioGetElementData ( player, "Paket")
    local pack = vipPackageName[pack]
    local premState = vioGetElementData ( player, "premium")
	local coins = tonumber( vioGetElementData ( player, "coins") )
    triggerClientEvent ( player, "setPremiumClientData", getRootElement(), coins, premTime, pack, premState)
end
addEvent ( "getPremiumData", true)
addEventHandler ( "getPremiumData", getRootElement(), getPremiumData)
