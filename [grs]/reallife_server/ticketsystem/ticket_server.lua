local autoDelete = 0
onCooldown = {}
fillCountdown = {}


function startReport (player)
    if not getElementClicked ( player ) and vioGetElementData ( player, "loggedin" ) == 1 then
        if isAdminLevel ( player, 2 ) then
      --  triggerClientEvent(player, "openTicketWindow_admin", player)
      
            triggerClientEvent(player, "openTicketWindow", player, true)
        else
            triggerClientEvent(player, "openTicketWindow", player, false)
        end
    end
end
addCommandHandler("report", startReport)
addCommandHandler("rep", startReport)
addCommandHandler("supp", startReport)
addCommandHandler("support", startReport)
addCommandHandler("tickets", startReport)

-- // Überprüft ob das Teammitglied das Ticket sehen kann
function isTicketPermitted (player, ticketID)
    if isAdminLevel(player, 2) then
        local uid = playerUID[getPlayerName(player)]
        if ticketsUID[ticketID] == uid or ticketsUID[ticketID] == 0 then
            return true
        else
            return false
        end
    else
        return false
    end
end

function fillTickets (filterRating, filterClosed, filterAllTickets, searchID, searchName)
    
    if not filterAllTickets then
        filterAllTickets = false
    end
    local player = source
    local uid = playerUID[getPlayerName(player)]
    if onCooldown[getPlayerName(player)] == false or isAdminLevel ( player, 2 )  then
        -- // Anti-Spam
        if not  isAdminLevel ( player, 2 )  then
            fillCountdown[getPlayerName(player)] = setTimer ( function()
                onCooldown[getPlayerName(player)] = false
            end, 5000, 1 )
            onCooldown[getPlayerName(player)] = true
        end

        if not searchID then
            if filterAllTickets == false then
                -- Ohne Filter
                if filterRating == false and filterClosed == false then
                    for i, ticket in ipairs(ticketID) do 
                        local tCreatore = playerUIDName[ticketUID[ticket]]
                        if ticketUID[ticket] == playerUID[ getPlayerName(player)] and ticketState[ticket] ~= 3  or isTicketPermitted(player, ticket) and ticketState[ticket] ~= 3 then
                            triggerClientEvent(source, "addTicket", source, ticket, ticketSubject[ticket], playerUIDName[ticketsUID[ticket]], ticketState[ticket], ticketType[ticket], ticketRating[ticket], ticketDate[ticket], tCreatore )
                        end
                    end
                end
                -- Filter für Bewertung
                if filterRating == true and filterClosed == false  then
                    for i, ticket in ipairs(ticketID) do 
                        local tCreatore = playerUIDName[ticketUID[ticket]]
                        if ticketUID[ticket] == playerUID[ getPlayerName(player)] and ticketRating[ticket] == 0 and ticketState[ticket] ~= 3 or isTicketPermitted(player, ticket) and ticketRating[ticket] == 0 and ticketState[ticket] ~= 3 then
                            triggerClientEvent(source, "addTicket", source, ticket, ticketSubject[ticket], playerUIDName[ticketsUID[ticket]], ticketState[ticket], ticketType[ticket], ticketRating[ticket], ticketDate[ticket], tCreatore )
                        end
                    end
                end
                -- Filter für Geschlossene
                if filterRating == false and filterClosed == true  then
                    for i, ticket in ipairs(ticketID) do 
                        local tCreatore = playerUIDName[ticketUID[ticket]]
                        if ticketUID[ticket] == playerUID[ getPlayerName(player)] and ticketState[ticket] == 3 or isTicketPermitted(player, ticket) and ticketState[ticket] == 3 then
                            triggerClientEvent(source, "addTicket", source, ticket, ticketSubject[ticket], playerUIDName[ticketsUID[ticket]], ticketState[ticket], ticketType[ticket], ticketRating[ticket], ticketDate[ticket], tCreatore )
                        end
                    end
                end
                -- Filter für Beides
                if filterRating == true and filterClosed == true  then
                    for i, ticket in ipairs(ticketID) do 
                        local tCreatore = playerUIDName[ticketUID[ticket]]
                        if ticketUID[ticket] == playerUID[ getPlayerName(player)] and ticketState[ticket] == 3 or ticketUID[ticket] == playerUID[ getPlayerName(player)] and ticketRating[ticket] == 0 or isTicketPermitted(player, ticket) and ticketState[ticket] == 3 and ticketRating[ticket] == 0 then
                            triggerClientEvent(source, "addTicket", source, ticket, ticketSubject[ticket], playerUIDName[ticketsUID[ticket]], ticketState[ticket], ticketType[ticket], ticketRating[ticket], ticketDate[ticket], tCreatore )
                        end
                    end
                end
            else
                -- Alle Tickets (für Admins)
                if isAdminLevel(player, 4)then
                    for i, ticket in ipairs(ticketID) do 
                        local tCreatore = playerUIDName[ticketUID[ticket]]
                            triggerClientEvent(source, "addTicket", source, ticket, ticketSubject[ticket], playerUIDName[ticketsUID[ticket]], ticketState[ticket], ticketType[ticket], ticketRating[ticket], ticketDate[ticket], tCreatore )
                        end
                else
                    triggerClientEvent ( client, "infobox_start", getRootElement(), "Du bist kein Moderator.", 5000, 125, 0, 0 )
                end
            end
        else
            
            searchForTicket(searchID)
        end
    else
        local remaining, executesRemaining, timeInterval = getTimerDetails(fillCountdown[getPlayerName(player)])
        triggerClientEvent ( client, "infobox_start", getRootElement(), "Bitte warte noch\n"..math.ceil(remaining/1000).." Sekunden...", 5000, 125, 0, 0 )
    end
end

function searchForTicket(id)
    local ticket = id
    print("Suche nach Ticket ID "..id)

    if ticketID[ticket] then
        local tCreatore = playerUIDName[ticketUID[ticket]]
        triggerClientEvent(source, "addTicket", source, ticket, ticketSubject[ticket], playerUIDName[ticketsUID[ticket]], ticketState[ticket], ticketType[ticket], ticketRating[ticket], ticketDate[ticket], tCreatore )
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "Ticket existiert nicht.", 5000, 125, 0, 0 )
    end
end

function fillTicketAnswers (id)
    local player = source
    for i, ticket in ipairs(ticketaID) do 
        if ticketaTicketID[ticket] == id then
            triggerClientEvent(source, "addTicketAnswer", source, ticket,  playerUIDName [ticketaUID[ticket] ],  ticketaDate[ticket]   )
        end
    end
end

function getAnswerTicket_Text (id)
    triggerClientEvent(source, "setTicketAnwer_Text", source,ticketaText[id])
end

function getTicketData (id) 


    triggerClientEvent(source, "updateTicketData", source, id,  playerUIDName [ticketUID[id]], ticketDate[id], ticketSupporter[id],  ticketState[id],ticketType[id], "N.a", ticketSubject[id], ticketText[id] )
end


function newTicket (creatore, subject, text, type)
    local newTicketID = (#ticketID + 1)
    local creatoreID = playerUID[creatore]
    ticketID[newTicketID] = newTicketID
    ticketUID[newTicketID] =  creatoreID
    ticketsUID[newTicketID] = tonumber(0)
    ticketSubject[newTicketID] = subject
    ticketText[newTicketID] = text
    ticketType[newTicketID] = type
    ticketSupporter[newTicketID] = "none"
    ticketRating[newTicketID] = tonumber (0)
    ticketState[newTicketID] =  tonumber (1)
    ticketDate[newTicketID] = getData ( getTimestamp () )
    waitingTickets = waitingTickets + 1
    outputChatBox ( "Ticket erfolgreich erstellt." , client, 200, 200, 0,true )
    adminlist ( client )
    if type == 3 then
        outputChatBox ( "Bitte beachte das Tickets an die Projektleitung auch Themen beinhalten sollten, die nur die Projektleitung beantworten kann." , client, 200, 200, 0,true )
        outputChatBox ( "Sollte dies nicht der Fall sein, schließe bitte das Ticket. Es kann ggf. eine Strafe folgen." , client, 200, 200, 0,true )
    end
    for playeritem, index in pairs(adminsIngame) do 			
        if index >= 2 and type ~= 3 then
            outputChatBox ( "Neues Ticket (#"..newTicketID..") von "..creatore.." erstellt." , playeritem, 200, 200, 0,true )
            playSoundFrontEnd ( playeritem, 5 )
        elseif index >= 7 then
            outputChatBox ( "Neues Ticket (#"..newTicketID..") von "..creatore.." erstellt. (Projektleitung)" , playeritem, 200, 200, 0,true )
            playSoundFrontEnd ( playeritem, 6 )
        end			
    end	



    dbExec ( handler, "INSERT INTO ?? ( ??,??,??,??,??,??,??,??,??) VALUES (?,?,?,?,?,?,?,?,?)", "tickets", "ID", "UID", "sUID", "type", "state", "subject", "text", "rating", "date", newTicketID, creatoreID, 0, type, "1", subject, text, "0"   , getTimestamp () )
end


function closeTicket(id)
    if ticketState[id] ~= 3 then
        ticketState[id] = 3
        local creatorName =  playerUIDName[ticketUID[id]]
        outputChatBox ( "Ticket (#"..id..") erfolgreich geschlossen." , client, 200, 200, 0,true )
        if getPlayerFromName ( creatorName ) then
            outputChatBox ( "Dein Ticket (#"..id..") wurde geschlossen." , getPlayerFromName ( creatorName ), 200, 200, 0,true )
        else
            offlinemsg ( "Dein Ticket (#"..id..") wurde geschlossen." , "Server", creatorName )
        end
        waitingTickets = waitingTickets - 1
        dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "tickets", "state", 3, "ID", id )
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "Ticket ist bereits geschlossen.", 5000, 125, 0, 0 )
    end
end

function rateTicket(id, rating)
    for playeritem, index in pairs(adminsIngame) do 			
        if index >= 2 then
            outputChatBox ( getPlayerName(client).." hat eine Bewertung zum Ticket #"..id.." abgegeben. ("..rating.."/5)" , playeritem, 200, 200, 0,true )
            playSoundFrontEnd ( playeritem, 5 )
        end
    end

    ticketRating[id] = rating
    dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "tickets", "rating", rating, "ID", id )
    triggerClientEvent ( client, "infobox_start", getRootElement(), "Danke für deine Bewertung.", 5000, 200, 200, 0 )
    

    if getPlayerFromName(ticketSupporter[id]) then
        local ticketSupp = getPlayerFromName(ticketSupporter[id])
        vioSetElementData ( ticketSupp, "ticketRating", vioGetElementData ( ticketSupp, "ticketRating" ) + rating )
        vioSetElementData ( ticketSupp, "ticketRatings",  vioGetElementData ( ticketSupp, "ticketRatings" ) + 1 ) 
        outputChatBox ( "Deine Bewertung: "..vioGetElementData ( ticketSupp, "ticketRatings" ).." Bewertungen mit einem Durchschnitt von "..math.floor(vioGetElementData ( ticketSupp, "ticketRating" )/vioGetElementData ( ticketSupp, "ticketRatings" ) ), ticketSupp, 200, 200, 0,true )
    else
        -- ticketRating = Wieviele Bewertungen er hat, allratings = Alle Wertungen zusammen
        local uid = ticketsUID[id]
        print("Offline bewertung an "..uid)
        local allratings = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "ticketRating", "userdata", "UID",uid ), -1 )[1]["ticketRating"]
        local ratings = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "ticketRatings", "userdata", "UID",uid ), -1 )[1]["ticketRatings"]
        dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "userdata", "ticketRating",(allratings+rating), "ticketRatings", (ratings+1), "UID", uid )
        offlinemsg ( "Deine Bewertung: "..allratings.." Bewertungen mit einem Durchschnitt von "..math.floor(allratings/ratings), "Server", ticketSupporter[id] )
    end

end



function newTicketAnswer (ticketID, text)
    if ticketState[tickedID] ~=  3 then
        local clientUID = playerUID[getPlayerName(client)]
        if ticketSupporter[ticketID] == getPlayerName(client)  or  ticketUID[ticketID] == clientUID then
            local allTicketAnswers = (#ticketaID + 1)
            ticketaID[allTicketAnswers] = allTicketAnswers
            ticketaUID[allTicketAnswers] = playerUID[getPlayerName(client) ]
            ticketaTicketID[allTicketAnswers] = ticketID
            ticketaText[allTicketAnswers] = text
            ticketaSUID[allTicketAnswers] = "0"
            ticketaDate[allTicketAnswers] = getData ( getTimestamp () )

            outputChatBox ( "Ticket Antwort erfolgreich abgesendet." , client, 200, 200, 0,true )
            local creatorName =  playerUIDName[ ticketUID[ticketID] ]
            if getPlayerFromName ( creatorName ) then
                outputChatBox ( "Dein Ticket (#"..ticketID..") hat eine neue Antwort bekommen." , getPlayerFromName ( creatorName ), 200, 200, 0,true )
            else
                offlinemsg ( "Dein Ticket (#"..ticketID..") hat eine neue Antwort bekommen." , "Server", creatorName )
            end
            -- Offline Nachricht
            if ticketSupporter[ticketID] ~= "none" then
                if not getPlayerFromName(ticketSupporter[ticketID]) then
                    offlinemsg ( "Neues Ticket-Antwort (#"..ticketID..") von "..getPlayerName(client).." erstellt.", "Server", ticketSupporter[ticketID] )
                end
            end
        

            -- Nachricht an Alle Admins ODER an den Zugeteilten
            for playeritem, index in pairs(adminsIngame) do 			
                if index >= 2 and ticketSupporter[ticketID] == playerUID[getPlayerName(playeritem) ]  then
                    outputChatBox ( "Neues Ticket-Antwort (#"..ticketID..") von "..getPlayerName(client).." erstellt." , playeritem, 200, 200, 0,true )
                    playSoundFrontEnd ( playeritem, 5 )
                elseif index >= 2 and ticketSupporter[ticketID] == "none"   then
                    outputChatBox ( "Neues Ticket-Antwort (#"..ticketID..") von "..getPlayerName(client).." erstellt." , playeritem, 200, 200, 0,true )
                    playSoundFrontEnd ( playeritem, 6 )
                end			
            end	


            dbExec ( handler, "INSERT INTO ?? ( ??,??,??,??,??) VALUES (?,?,?,?,?)", "ticket_answers", "ID", "UID", "ticket_ID", "text", "date", allTicketAnswers, playerUID[getPlayerName(client) ], ticketID, text, getTimestamp() )
        else
            triggerClientEvent ( client, "infobox_start", getRootElement(), "Nicht berechtigt.", 5000, 125, 0, 0 )
        end
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "Ticket ist geschlossen.", 5000, 125, 0, 0 )
    end
    end


-- // Events
addEvent ( "rateTicket", true )
addEventHandler ( "rateTicket", getRootElement(), rateTicket )
addEvent ( "newTicketAnswer", true )
addEventHandler ( "newTicketAnswer", getRootElement(), newTicketAnswer )
addEvent ( "closeTicket", true )
addEventHandler ( "closeTicket", getRootElement(), closeTicket )
addEvent ( "newTicket", true )
addEventHandler ( "newTicket", getRootElement(), newTicket )
addEvent ( "getTicketData", true )
addEventHandler ( "getTicketData", getRootElement(), getTicketData )
addEvent ( "getAnswerTicket_Text", true )
addEventHandler ( "getAnswerTicket_Text", getRootElement(), getAnswerTicket_Text )
addEvent ( "fillTickets", true )
addEventHandler ( "fillTickets", getRootElement(), fillTickets )
addEvent ( "fillTicketAnswers", true )
addEventHandler ( "fillTicketAnswers", getRootElement(), fillTicketAnswers )


--////////////////////
--    Adminansicht
--////////////////////



function openTicket(id)
    if ticketState[id] ~= 1 then
        ticketState[id] = 1
        ticketSupporter[id] = "none"
        ticketsUID[id] = 0
        outputChatBox ( "Ticket (#"..id..") erfolgreich geöffnet." , client, 200, 200, 0,true )
        waitingTickets = waitingTickets + 1
        dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "tickets", "state", 1,"sUID", 0, "ID", id )
    else
         triggerClientEvent ( client, "infobox_start", getRootElement(), "Ticket ist bereits geöffnet.", 5000, 125, 0, 0 )
    end
end

function passTicket(id, newOwner)
        local newOwnerUID = playerUID[newOwner]
        if ticketsUID[id] == playerUID[getPlayerName(client)] and ticketSupporter[id] ~= "none" or isAdminLevel ( client, 6 ) then 
            if tonumber(newOwnerUID) then
                local adminlvl = dbPoll ( dbQuery ( handler, "SELECT ?? FROM ?? WHERE ??=?", "Adminlevel", "userdata", "UID",newOwnerUID ), -1 )[1]["Adminlevel"]

                if getPlayerFromName(newOwner) and isAdminLevel ( player, 2 ) or adminlvl and adminlvl >= 2 then
                    if getPlayerFromName(newOwner) then
                        outputChatBox ( "Das Ticket (#"..id..") wurde von "..getPlayerName(client).." an dich weitergegeben.", getPlayerFromName(newOwner), 200, 200, 0,true )
                    else
                        offlinemsg ( "Das Ticket (#"..id..") wurde von "..getPlayerName(client).." an dich weitergegeben.", "Server",newOwner )
                    end
                    ticketState[id] = 2
                    ticketSupporter[id] = newOwner
                    ticketsUID[id] = newOwnerUID
                    outputChatBox ( "Ticket (#"..id..") erfolgreich weitergeleitet." , client, 200, 200, 0,true )
                    waitingTickets = waitingTickets + 1
                    dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "tickets", "state", 2, "sUID", newOwnerUID, "ID", id )
                else
                    triggerClientEvent ( client, "infobox_start", getRootElement(), "Spieler ist kein Ticketbeauftrafter.", 5000, 125, 0, 0 )
                end
            else
                triggerClientEvent ( client, "infobox_start", getRootElement(), "Spieler exestiert nicht.", 5000, 125, 0, 0 )
            end
        else
            if isAdminLevel ( client, 6 ) then
                triggerClientEvent ( client, "infobox_start", getRootElement(), "Ticket gehört dir nicht/\nIst nicht vergeben.", 5000, 125, 0, 0 )
            else
                triggerClientEvent ( client, "infobox_start", getRootElement(), "Ticket gehört dir nicht/\nIst nicht vergeben.\nDu bist nicht berechtigt.", 5000, 125, 0, 0 )
            end
        end
end

function checkForOpenTickets ()
    if waitingTickets > 0 then
        if waitingTickets == 1 then prefix = "ist ein Ticket" else prefix = "sind "..waitingTickets.." Tickets" end
        for playeritem, index in pairs(adminsIngame) do 			
            if index >= 2 then
                outputChatBox ( "[TICKETSYSTEM] Momentan "..prefix.." unbearbeitet." , playeritem, 200, 200, 0,true )

            end
        end
    end
end 
setTimer(checkForOpenTickets, 1000*60, 0)

function takeTicket(id)
    if ticketState[id] == 1 and ticketSupporter[id] == "none" then
        ticketState[id] = 2
        local newOwnerUID = playerUID[getPlayerName(client)]
        ticketSupporter[id] = getPlayerName(client)
        ticketsUID[id] = newOwnerUID
        outputChatBox ( "Ticket (#"..id..") erfolgreich angenommen." , client, 200, 200, 0,true )
        dbExec ( handler, "UPDATE ?? SET ??=?, ??=? WHERE ??=?", "tickets", "state", 2, "sUID", newOwnerUID, "ID", id )
    else
        triggerClientEvent ( client, "infobox_start", getRootElement(), "Ticket bereits vergeben.", 5000, 125, 0, 0 )
    end
end


addEvent ( "takeTicket", true )
addEventHandler ( "takeTicket", getRootElement(), takeTicket )
addEvent ( "passTicket", true )
addEventHandler ( "passTicket", getRootElement(), passTicket )
addEvent ( "openTicket", true )
addEventHandler ( "openTicket", getRootElement(), openTicket )