advert = {}
canSendAdvert = true
advertTimer = nil

function addAdvert (player, ...)
    local pname = getPlayerName(player)
    local parametersTable = {...}
    local stringWithAllParameters = table.concat( parametersTable, " " )
    local length = #stringWithAllParameters
    local costs = length*adcosts+adbasiscosts
    if getFactionMembersOnline(5) == 1 then
        if not advert[player] then
            advert[player] = {
                text = stringWithAllParameters,
                type = 1,
                cost = costs
            }
            triggerClientEvent ( player, "closeAdvertWindow", getRootElement()  )
            newInfobox (player, "Deine Werbung wird überprüft.\nDas Geld wird beim zulassen abgebucht.", 2)
        else
            newInfobox (player, "Es wird bereits eine Werbung von dir überprüft.", 2)
        end
    else
        -- // Werbung automatisch schalten

       
        if vioGetElementData ( player, "money" ) >= costs then
            if vioGetElementData ( player, "playingtime" ) >= noobtime then
                newInfobox (player, "Es ist keiner von der LTR online.\nDeine Werbung wurde automatisch zugelassen.",1)
                showAdvert (player, ...)
                triggerClientEvent ( player, "closeAdvertWindow", getRootElement()  )	
                vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) - costs )
            else
                newInfobox (player, "Du hast zuwenig Spielzeit.", 2)
            end
        else
            newInfobox (player, "Du hast nicht genug Geld.", 2)
        end
    end
end
addEvent ( "addAdvert", true)
addEventHandler ( "addAdvert", getRootElement(),  addAdvert)

function playAdvert (reporter, cmd, advertiser)
    if getPlayerFromName(advertiser) then
        advertiser =  getPlayerFromName(advertiser)
    end
    if advert[advertiser] then
        if canSendAdvert == true then 
            local parametersTable = {advert[advertiser].text}
	        local stringWithAllParameters = table.concat( parametersTable, " " )
            -- // Werbung
            local adtext = "#FFFF00Werbung von #009900"..getPlayerName(advertiser).."#FFFF00 [Handy: "..vioGetElementData(advertiser,"telenr").."]: "..stringWithAllParameters
            outputLog ( adtext, "werbung" )
            outputChatBox ( adtext, getRootElement(), 255, 255, 0, true )
            vioSetElementData ( advertiser, "money", vioGetElementData ( advertiser, "money" ) - 1 )
            playSoundFrontEnd ( advertiser, 40 )
            newInfobox (advertiser, "Deine Werbung wurde zugelassen.", 2)
            -- // Werbung wird vorbereitet
            canSendAdvert = false
            advert[advertiser] = nil
            advertTimer = setTimer ( function()
                canSendAdvert = true
                sendMSGForFaction ( "Es kann eine neue Werbung zugelassen werden.", 5, 255, 125, 20 )
            end, 60000, 1 )
        else
            local remaining, executesRemaining, timeInterval = getTimerDetails(advertTimer)
            newInfobox (advertiser, "Bitte warte noch "..math.floor(remaining/1000).." Sekunden.", 3)
        end
    else
        newInfobox (advertiser, "Dieser Spieler hat keine Werbung geschaltet.", 3)
    end
end
addCommandHandler("pa", playAdvert)

function showAdvert (player, text)
	local adtext = "#FFFF00Werbung von #009900"..getPlayerName ( player ).."#FFFF00 [Handy: "..vioGetElementData(player,"telenr").."]: "..text
	outputLog ( adtext, "werbung" )
	outputChatBox ( adtext, getRootElement(), 255, 255, 0, true )
	playSoundFrontEnd ( player, 40 )
end


function makeAdvert(player)
    if vioGetElementData ( player, "loggedin" ) == 1 then
        triggerClientEvent ( player, "showAdvertWindow", player, adcosts, adbasiscosts)
    end
end
addCommandHandler("ad",makeAdvert )

function seeAdverts(player)
    if vioGetElementData ( player, "loggedin" ) == 1  and isReporter ( player ) then
        triggerClientEvent ( player, "showAdvertWindowLTR", player)
    end
end
addCommandHandler("ads",seeAdverts )

function fillAdsList (player)
    for i, name in pairs(advert) do 
        print(i, name)
        triggerClientEvent ( player, "addAdToList", getRootElement(), getPlayerName(i), name.cost, name.text )			
    end
end
addEvent ( "fillAdsList", true)
addEventHandler ( "fillAdsList",getRootElement(),  fillAdsList)
