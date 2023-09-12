local ticketType = {
    [1] = "Schnellanfrage",
    [2] = "Administrative Frage",
    [3] = "Projektleitung",
    [4] = "Bug"
}
local ticketState = {
    [1] = "offen",
    [2] = "in Bearbeitung",
    [3] = "Geschlossen",
    [4] = "Wartet auf Umleitung" -- ... zu einem höheren Rang
}
local ticketTypeRevert = {}

for i, type in ipairs(ticketType) do
    ticketTypeRevert[type] = i
end

local rating
local x, y = guiGetScreenSize()
local sx, sy = x/2560, y/1440

function openTicketWindow_window (adminView)
    if not adminView and not hasAdminView then
        adminView = false
    else
        adminView = true
    end
    hasAdminView = adminView
    setElementClicked ( true )
    showCursor(true)
    DGS:dgsSetInputEnabled( true )
    ticketWindow = DGS:dgsCreateWindow(946*sx, 480*sy, 669*sx, 490*sy, "Ticketsystem", false)
    DGS:dgsWindowSetSizable(ticketWindow,false)
    DGS:dgsWindowSetMovable(ticketWindow,false)
   -- minus 9
    tickets = DGS:dgsCreateGridList(10*sx, 16*sy, 649*sx, 373*sy, false, ticketWindow )
    if hasAdminView == true then
        tickets_id = DGS:dgsGridListAddColumn( tickets, "ID", 0.05)
        tickets_subject = DGS:dgsGridListAddColumn( tickets, "Titel", 0.2)
        tickets_supporter = DGS:dgsGridListAddColumn( tickets, "Supporter",0.15)
        tickets_creatore = DGS:dgsGridListAddColumn( tickets, "Ersteller",0.15)
        tickets_state = DGS:dgsGridListAddColumn( tickets, "Status" ,0.15)
        tickets_type = DGS:dgsGridListAddColumn( tickets, "Thema", 0.2)
        tickets_rating = DGS:dgsGridListAddColumn( tickets, "☆", 0.05)
        tickets_date = DGS:dgsGridListAddColumn( tickets, "Datum", 0.15)
    else
        tickets_subject = DGS:dgsGridListAddColumn( tickets, "Titel", 0.2)
        tickets_supporter = DGS:dgsGridListAddColumn( tickets, "Supporter",0.2)
        tickets_state = DGS:dgsGridListAddColumn( tickets, "Status" ,0.15)
        tickets_type = DGS:dgsGridListAddColumn( tickets, "Thema", 0.2)
        tickets_rating = DGS:dgsGridListAddColumn( tickets, "☆", 0.05)
        tickets_date = DGS:dgsGridListAddColumn( tickets, "Datum", 0.2)
    end
    DGS:dgsSetProperty( tickets,"rowHeight",25)
    local startRating = DGS:dgsCreateButton(14*sx, 404*sy, 116*sx, 46*sy, "Ticket bewerten", false, ticketWindow, nil, nil, nil, nil, nil, nil)  
    local closeTicket = DGS:dgsCreateButton(140*sx, 404*sy, 116*sx, 46*sy, "Ticket schliessen", false, ticketWindow, nil, nil, nil, nil, nil, nil)  
    local newTicket = DGS:dgsCreateButton(266*sx, 404*sy, 116*sx, 46*sy, "Ticket eröffnen", false, ticketWindow, nil, nil, nil, nil, nil, nil)  
    local refreshTickets = DGS:dgsCreateButton(392*sx, 404*sy, 116*sx, 46*sy, "Aktualisieren", false, ticketWindow, nil, nil, nil, nil, nil, nil)  

    local filterRating = DGS:dgsCreateCheckBox(515*sx, 408*sy, 134*sx, 15*sy, "Unbew. Tickets", false, false, ticketWindow)
    local filterClosed = DGS:dgsCreateCheckBox(515*sx, 433*sy, 134*sx, 15*sy, "Gesch. Tickets", false, false, ticketWindow)  
    -- // Adminsicht
    if hasAdminView == true then
        DGS:dgsSetEnabled(startRating, false)
        DGS:dgsSetSize(ticketWindow, 699*sx, 550*sy )
        DGS:dgsSetSize(tickets, 679*sx, 373*sy ) 
        filterAll = DGS:dgsCreateCheckBox(515*sx, 458*sy, 134*sx, 15*sy, "Alle Tickets", false, false, ticketWindow)  
        local openTicket = DGS:dgsCreateButton(14*sx, 464*sy, 116*sx, 46*sy, "Ticket wieder\nöffnen", false, ticketWindow, nil, nil, nil, nil, nil, nil)  
        local dispenseTicket = DGS:dgsCreateButton(266*sx, 464*sy, 116*sx, 46*sy, "Ticket weiterleiten", false, ticketWindow, nil, nil, nil, nil, nil, nil)  
        local takeTicket = DGS:dgsCreateButton(140*sx, 464*sy, 116*sx, 46*sy, "Ticket\nbeanspruchen", false, ticketWindow, nil, nil, nil, nil, nil, nil)  
        local newTicketSupporter =  DGS:dgsCreateEdit(392*sx, 464*sy, 116*sx, 46*sy, "", false, ticketWindow)
        DGS:dgsSetProperty(newTicketSupporter,"placeHolder","Neuer Beauftragter")
        searchIDEdit =  DGS:dgsCreateEdit(622*sx, 464*sy, 70*sx, 46*sy, "", false, ticketWindow)
        DGS:dgsSetProperty(searchIDEdit,"placeHolder","Ticket-ID")
        -- Events der Adminsicht
        addEventHandler( "onDgsMouseClick", takeTicket, 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == takeTicket then
                local Selected = DGS:dgsGridListGetSelectedItem(tickets)
                if Selected ~= -1 then 
                    local id = DGS:dgsGridListGetItemData(tickets,Selected,tickets_subject)
                    triggerServerEvent("takeTicket", getLocalPlayer(), id)
                    DGS:dgsGridListClear(tickets)
                    triggerServerEvent("fillTickets", getLocalPlayer(), DGS:dgsCheckBoxGetSelected(filterRating), DGS:dgsCheckBoxGetSelected(filterClosed))
                end
            end
        end)
        
        addEventHandler( "onDgsMouseClick", dispenseTicket, 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == dispenseTicket then
                local Selected = DGS:dgsGridListGetSelectedItem(tickets)
                local newTicketSuppTxt = DGS:dgsGetText(newTicketSupporter)
                if Selected ~= -1 then 
                    if string.len(newTicketSuppTxt) > 0 then
                        local id = DGS:dgsGridListGetItemData(tickets,Selected,tickets_subject)
                        triggerServerEvent("passTicket", getLocalPlayer(), id, newTicketSuppTxt)
                        DGS:dgsGridListClear(tickets)
                        triggerServerEvent("fillTickets", getLocalPlayer(), DGS:dgsCheckBoxGetSelected(filterRating), DGS:dgsCheckBoxGetSelected(filterClosed))
                    else
                        infobox_start_func ( "Zu kleiner Text.", 7500, 125, 0, 0 )
                    end
                end
            end
        end)
        addEventHandler( "onDgsMouseClick", openTicket, 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == openTicket then
                local Selected = DGS:dgsGridListGetSelectedItem(tickets)
                if Selected ~= -1 then 
                    local id = DGS:dgsGridListGetItemData(tickets,Selected,tickets_subject)
                    triggerServerEvent("openTicket", getLocalPlayer(), id)
                    DGS:dgsGridListClear(tickets)
                    triggerServerEvent("fillTickets", getLocalPlayer(), DGS:dgsCheckBoxGetSelected(filterRating), DGS:dgsCheckBoxGetSelected(filterClosed))
                end
            end
        end)
    end

    triggerServerEvent("fillTickets", getLocalPlayer(), DGS:dgsCheckBoxGetSelected(filterRating), DGS:dgsCheckBoxGetSelected(filterClosed))

    addEventHandler( "onDgsMouseClick", startRating, 
    function(button, state, x, y)
		if button == 'left' and state == 'up' and source == startRating then
            local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(tickets)
            if Selected ~= -1 then 
                local id = DGS:dgsGridListGetItemData(tickets,Selected,tickets_subject)
                local rating = tonumber( DGS:dgsGridListGetItemText(tickets,Selected,tickets_rating))
                local state = DGS:dgsGridListGetItemText(tickets,Selected,tickets_state)
                if state == "Geschlossen" then
                    if rating == 0 then
                        openRatingWindow(id)
                        DGS:dgsCloseWindow(ticketWindow)
                    else
                        infobox_start_func ( "Ticket bereits bewertet.", 7500, 125, 0, 0 )
                        
                    end
                else 
                    infobox_start_func ( "Nur geschlossene Tickets\n können bewertet werden.", 7500, 125, 0, 0 )
                end
            end
           
        end
        
    end)
    addEventHandler( "onDgsMouseDoubleClick", tickets, 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == tickets then
                local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(tickets)
                if Selected ~= -1 then 
                    local id = DGS:dgsGridListGetItemData(tickets,Selected,tickets_subject)
                    local state = DGS:dgsGridListGetItemText(tickets,Selected, tickets_state)
                   -- if state ~= "offen" then
                        openOneTicket(id)
                        DGS:dgsCloseWindow(ticketWindow)
                  --  else
                  --      infobox_start_func ( "Ticket ist noch offen.", 7500, 125, 0, 0 )
                  --  end
                end
		end
    end)
    
    addEventHandler( "onDgsMouseClick", closeTicket, 
    function(button, state, x, y)
		if button == 'left' and state == 'up' and source == closeTicket then
            local Selected = DGS:dgsGridListGetSelectedItem(tickets)
            if Selected ~= -1 then 
                local id = DGS:dgsGridListGetItemData(tickets,Selected,tickets_subject)
                triggerServerEvent("closeTicket", getLocalPlayer(), id)
                DGS:dgsGridListClear(tickets)
                triggerServerEvent("fillTickets", getLocalPlayer(), DGS:dgsCheckBoxGetSelected(filterRating), DGS:dgsCheckBoxGetSelected(filterClosed))
            end
		end
    end)

    addEventHandler( "onDgsMouseClick", newTicket, 
    function(button, state, x, y)
		if button == 'left' and state == 'up' and source == newTicket then
            openNewTicket()
            DGS:dgsCloseWindow(ticketWindow)
		end
    end)

    addEventHandler( "onDgsMouseClick", openTicket, 
    function(button, state, x, y)
		if button == 'left' and state == 'up'  and source == openTicket then
            local Selected = DGS:dgsGridListGetSelectedItem(tickets)
            if Selected ~= -1 then 
                local id = DGS:dgsGridListGetItemData(tickets,Selected,tickets_subject)
                openOneTicket(id)
                DGS:dgsCloseWindow(ticketWindow)
            end
		end
    end)
    
    addEventHandler( "onDgsMouseClick", refreshTickets, 
    function(button, state, x, y)
		if button == 'left' and state == 'up' and source == refreshTickets then
            DGS:dgsGridListClear(tickets)
            if not filterAll then
                filterAllBox = false
            else
                filterAllBox = DGS:dgsCheckBoxGetSelected(filterAll)
                DGS:dgsCheckBoxSetSelected(filterRating, false)
                DGS:dgsCheckBoxSetSelected(filterClosed, false)
            end
            
            if tonumber(DGS:dgsGetText(searchIDEdit)) and tonumber(DGS:dgsGetText(searchIDEdit)) > 0 then
                searchForID = tonumber(DGS:dgsGetText(searchIDEdit))
            else
                searchForID = false
            end
            triggerServerEvent("fillTickets", getLocalPlayer(), DGS:dgsCheckBoxGetSelected(filterRating), DGS:dgsCheckBoxGetSelected(filterClosed), filterAllBox, searchForID)
		end
    end)

    addEventHandler( "onDgsWindowClose", ticketWindow, 
    function()
        if not isElement(rateTicketWindow) and not isElement(openTicketWindow) and not isElement(ticketOverview_1) and not isElement(ticketOverview_1) then
            setElementClicked ( false )
            showCursor(false)
            DGS:dgsSetInputEnabled( false )
        end
    end)
    

end
function openNewTicket ()
    openTicketWindow = DGS:dgsCreateWindow(1084*sx, 473*sy, 393*sx, 494*sy, "Ticket eröffnen", false)
    setElementClicked ( true )
    showCursor(true)
    DGS:dgsSetInputEnabled( true )
    DGS:dgsWindowSetSizable(openTicketWindow,false)
    DGS:dgsWindowSetMovable(openTicketWindow,false)
    DGS:dgsCreateLabel(9*sx, 11*sy, 78*sx, 15*sy, "Thema", false, openTicketWindow )
    selectedType = DGS:dgsCreateComboBox(9*sx, 27*sy, 226*sx, 20*sy, "", false, openTicketWindow )
    DGS:dgsCreateLabel(10*sx, 76*sy, 87*sx, 15*sy, "Titel", false, openTicketWindow )
    selectedTitle = DGS:dgsCreateEdit(11*sx, 99*sy, 233*sx, 31*sy, "", false, openTicketWindow)
    DGS:dgsCreateLabel(11*sx, 145*sy, 87*sx, 15*sy, "Text", false, openTicketWindow )
    selectedText = DGS:dgsCreateMemo(11*sx, 171*sy, 368*sx, 236*sy, "", false, openTicketWindow)
    submitTicketBtn = DGS:dgsCreateButton(60*sx, 416*sy, 131*sx, 49*sy, "Abschicken", false, openTicketWindow)
   -- DGS:dgsCreateLabel(194, 441, 175, 28, "Priorität: Sehr hoch", false, openTicketWindow )

    -- Typen hinzufügen
    for i, type in ipairs(ticketType) do
        DGS:dgsComboBoxAddItem(selectedType, type)
    end
    
    addEventHandler( "onDgsMouseClick", submitTicketBtn, 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == submitTicketBtn then
            local item = DGS:dgsComboBoxGetSelectedItem(selectedType)
	        if item ~= -1 then
                local ttext, tsub, ttype = DGS:dgsGetText(selectedText), DGS:dgsGetText(selectedTitle), DGS:dgsComboBoxGetItemText(selectedType, item)
                if string.len(tsub) > 0 then
                    if string.len(ttext) > 0 then
                        local ttype = ticketTypeRevert[tostring(ttype)]
                        -- TICKET ABSCHICKEN
                        triggerServerEvent("newTicket", getLocalPlayer(), getPlayerName( getLocalPlayer() ), tsub, ttext, ttype )
                        DGS:dgsCloseWindow(openTicketWindow)
                    else 
                        newInfobox ("Zu kleiner Text.", 3, 255, 255,255, 255, 3)
                    end
                else 
                    newInfobox ("Zu kleiner Titel.", 3, 255,255,255, 255, 3)
                end
            else 
                newInfobox ("Wähle ein Thema aus.", 3, 255,255,255, 255, 3)
            end
            
		end
    end)

    addEventHandler( "onDgsWindowClose", openTicketWindow, 
    function()
        openTicketWindow_window()
    end)

end

-- // Bewerten
function openRatingWindow (id)
    rateTicketWindow = DGS:dgsCreateWindow(1052*sx, 603*sy, 456*sx, 435*sy, "Ticket bewerten", false)
    setElementClicked ( true )
    showCursor(true)
    currRating = 0
    local stars = {}
    stars[1] = DGS:dgsCreateImage(51*sx, 30*sy, 64*sx, 64*sy, ":reallife_server/images/ticketsystem/rate_off.png", false,rateTicketWindow)
    stars[2] =  DGS:dgsCreateImage(125*sx, 30*sy, 64*sx, 64*sy, ":reallife_server/images/ticketsystem/rate_off.png", false, rateTicketWindow)
    stars[3] =  DGS:dgsCreateImage(199*sx, 30*sy, 64*sx, 64*sy, ":reallife_server/images/ticketsystem/rate_off.png", false, rateTicketWindow)
    stars[4] =  DGS:dgsCreateImage(273*sx, 30*sy, 64*sx, 64*sy, ":reallife_server/images/ticketsystem/rate_off.png", false, rateTicketWindow)
    stars[5] =  DGS:dgsCreateImage(347*sx, 30*sy, 64*sx, 64*sy, ":reallife_server/images/ticketsystem/rate_off.png", false, rateTicketWindow)
    DGS:dgsCreateLabel(56*sx, 107*sy, 355*sx, 40*sy, "Beachte bitte, dass die Bewertung für\ndas jeweilige Teammitglied wichtig ist.", false,rateTicketWindow)
    sentRatingBtn = DGS:dgsCreateButton(174*sx, 171*sx, 105*sx, 37*sx, "Absenden", false, rateTicketWindow)    

    addEventHandler( "onDgsMouseClick", sentRatingBtn, 
    function(button, state, x, y)
		if button == 'left' and state == 'up' and source == sentRatingBtn then
           if currRating > 0 then
              triggerServerEvent("rateTicket", getLocalPlayer(), id,currRating )
              DGS:dgsCloseWindow(rateTicketWindow)
           end
		end
    end)

    addEventHandler( "onDgsMouseEnter", root, function(aX, aY)
        if DGS:dgsGetType(source) == "dgs-dximage" then
            if source == stars[1] then
                DGS:dgsImageSetImage(stars[1],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[2],":reallife_server/images/ticketsystem/rate_off.png" )
                DGS:dgsImageSetImage(stars[3],":reallife_server/images/ticketsystem/rate_off.png" )
                DGS:dgsImageSetImage(stars[4],":reallife_server/images/ticketsystem/rate_off.png" )
                DGS:dgsImageSetImage(stars[5],":reallife_server/images/ticketsystem/rate_off.png" )
                currRating = 1
            elseif source == stars[2] then
                DGS:dgsImageSetImage(stars[1],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[2],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[3],":reallife_server/images/ticketsystem/rate_off.png" )
                DGS:dgsImageSetImage(stars[4],":reallife_server/images/ticketsystem/rate_off.png" )
                DGS:dgsImageSetImage(stars[5],":reallife_server/images/ticketsystem/rate_off.png" )
                currRating = 2
            elseif source == stars[3] then
                DGS:dgsImageSetImage(stars[1],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[2],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[3],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[4],":reallife_server/images/ticketsystem/rate_off.png" )
                DGS:dgsImageSetImage(stars[5],":reallife_server/images/ticketsystem/rate_off.png" )
                currRating = 3
            elseif source == stars[4] then
                DGS:dgsImageSetImage(stars[1],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[2],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[3],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[4],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[5],":reallife_server/images/ticketsystem/rate_off.png" )
                currRating = 4
            elseif source == stars[5] then
                DGS:dgsImageSetImage(stars[1],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[2],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[3],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[4],":reallife_server/images/ticketsystem/rate_on.png" )
                DGS:dgsImageSetImage(stars[5],":reallife_server/images/ticketsystem/rate_on.png" )
                currRating = 5
            end
        end

  
    end)

    addEventHandler( "onDgsWindowClose", rateTicketWindow, 
    function()
        openTicketWindow_window()
    end)

end

-- // Antworten & Ticketinformationen ansehen
function openOneTicket(id, subject)
    local ticketID = id
    

    ticketOverview_1 = DGS:dgsCreateWindow(1261*sx, 477*sy, 436*sx, 487*sy, "Ticket", false)
    setElementClicked ( true )
    showCursor(true)
    DGS:dgsSetInputEnabled( true )
    DGS:dgsWindowSetSizable(ticketOverview_1,false)
    DGS:dgsWindowSetMovable(ticketOverview_1,false)
    answers = DGS:dgsCreateGridList(10*sx, 16*sy, 416*sx, 161*sy, false,  ticketOverview_1 )
    answers_from = DGS:dgsGridListAddColumn( answers, "Von", 0.5)
    answers_date = DGS:dgsGridListAddColumn( answers, "Datum", 0.5)


    answers_text = DGS:dgsCreateMemo(11*sx, 194*sy, 415*sx, 195*sy,"",false, ticketOverview_1)
    answerTicketBtn = DGS:dgsCreateButton(11*sx, 395*sy, 145*sx, 55*sy, "Antworten", false, ticketOverview_1, nil, nil, nil, nil, nil, nil)  


    addEventHandler( "onDgsMouseDoubleClick", answers, 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == answers then
                local Selected, selectedCol = DGS:dgsGridListGetSelectedItem(answers)
                if Selected ~= -1 then 
                    local id = DGS:dgsGridListGetItemData(answers,Selected,answers_from)
                    triggerServerEvent("getAnswerTicket_Text", getLocalPlayer(), id)
                end
		end
    end)


    addEventHandler( "onDgsMouseClick", answerTicketBtn, 
    function(button, state, x, y)
        if button == 'left' and state == 'up' and source == answerTicketBtn then
                local atext =  DGS:dgsGetText(answers_text)
                local state = DGS:dgsGetText(suppBy)
                if not string.find(state, "none") then
                    if string.len(atext) > 0 then
                        triggerServerEvent("newTicketAnswer", getLocalPlayer(), ticketID, atext)
                        DGS:dgsGridListClear(answers)
                        triggerServerEvent("fillTicketAnswers", getLocalPlayer(), id)
                    else 
                        infobox_start_func ( "Zu kleiner Text.", 7500, 125, 0, 0 )
                    end
                else 
                    infobox_start_func ( "Das Ticket muss erst beansprucht werden.", 7500, 125, 0, 0 )
                end
		end
    end)




    ticketOverview_2 = DGS:dgsCreateWindow(897*sx, 476*sy, 354*sx, 488*sy, "Ticket Übersicht", false)
    DGS:dgsWindowSetCloseButtonEnabled(ticketOverview_2, false)
    DGS:dgsWindowSetSizable(ticketOverview_2,false)
    DGS:dgsWindowSetMovable(ticketOverview_2,false)
    creatore = DGS:dgsCreateLabel(18*sx, 21*sy, 326*sx, 22*sy,"Erstellt von:", false, ticketOverview_2 )
    createDate = DGS:dgsCreateLabel(18*sx, 52*sy, 326*sx, 22*sy, "Erstellt am:", false, ticketOverview_2 )
    suppBy = DGS:dgsCreateLabel(18*sx, 85*sy, 326*sx, 22*sy, "Supporter:", false, ticketOverview_2 )
    stateType = DGS:dgsCreateLabel(18*sx, 119*sy, 326*sx, 22*sy, "Status / Thema: ", false, ticketOverview_2 )
    lastAnswer = DGS:dgsCreateLabel(18*sx, 151*sy, 326*sx, 22*sy, "Letzte Antwort:", false, ticketOverview_2 )

    createSubject = DGS:dgsCreateMemo(18*sx, 183*sy, 325*sx, 36*sy,"THEMA", false, ticketOverview_2 )
    createText =  DGS:dgsCreateMemo(18*sx, 226*sy, 325*sx, 225*sy,"TEXT", false, ticketOverview_2 )
    DGS:dgsMemoSetReadOnly(createSubject, true)
    DGS:dgsMemoSetReadOnly(createText, true)
    triggerServerEvent("fillTicketAnswers", getLocalPlayer(), id)
    triggerServerEvent("getTicketData", getLocalPlayer(), id)

    addEventHandler( "onDgsWindowClose", ticketOverview_1, 
    function()
        DGS:dgsCloseWindow(ticketOverview_2)
        if adminInteractions then
            DGS:dgsCloseWindow(adminInteractions)
        end
        DGS:dgsSetInputEnabled( false )
        openTicketWindow_window()
    end)
    if hasAdminView == true then
        adminInteractions = DGS:dgsCreateWindow(901*sx, 358*sy, 790*sx, 88*sy, "Admininteraktionen", false)
        DGS:dgsWindowSetCloseButtonEnabled(adminInteractions, false)
        DGS:dgsWindowSetSizable(adminInteractions,false)
        DGS:dgsWindowSetMovable(adminInteractions,false)
        teleport = DGS:dgsCreateButton(12*sx, 11*sy, 125*sx, 47*sy, "Teleportieren", false,adminInteractions)
        quickAnswerList = DGS:dgsCreateComboBox(147*sx, 11*sy, 167*sx, 25*sy, "", false,adminInteractions)
        fillQuickAnswer = DGS:dgsCreateButton(324*sx, 11*sy, 125*sx, 46*sy, "Schnellantwort\neinfügen", false,adminInteractions)
      --  toggleSuppmode = DGS:dgsCreateButton(480*sx, 11*sy, 125*sx, 46*sy, "Supportmodus", false,adminInteractions)
        DGS:dgsComboBoxAddItem(quickAnswerList, "Fraktionsbeitritt")

        quickAnswerListText = {
            ["Fraktionsbeitritt"] = "Hallo\num einer Fraktions beizutreten musst du /fc [NAME] benutzen.\nDu brauchst für manche Fraktionen ein Mindestlevel.\nUm eine Fraktion zu verlassen gebe /leavefac ein.\nWenn du eine Fraktion verlässt,\nbekommst du automisch eine Fraktionssperre."
        }

        addEventHandler( "onDgsMouseClick", teleport, 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == teleport then

                triggerServerEvent("goto", getLocalPlayer(),getLocalPlayer(), "", globalTicketCreatore)
            end
        end)
    

        addEventHandler( "onDgsMouseClick", fillQuickAnswer, 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == fillQuickAnswer then
                local item = DGS:dgsComboBoxGetSelectedItem(quickAnswerList)
                if item ~= -1 then
                    local tquick =  DGS:dgsComboBoxGetItemText(quickAnswerList, item)
                    DGS:dgsSetText(answers_text, quickAnswerListText[tquick])
                else 
                    infobox_start_func ( "Wähle eine Antwort aus.", 7500, 125, 0, 0 )
                end
            end
        end)
    end
end

function updateTicketData (id, from, date, supporter, state, type, lastAnswer2, subject, text)
    globalTicketCreatore = from
    DGS:dgsSetText(creatore, "Erstellt von: "..from)
    DGS:dgsSetText(createDate, "Erstellt am: "..date)
    DGS:dgsSetText(suppBy, "Supporter: "..supporter)
    DGS:dgsSetText(stateType, "Status / Thema: "..ticketState[state].." / "..ticketType[type])
    DGS:dgsSetText(lastAnswer, lastAnswer2)
    DGS:dgsSetText(createSubject, subject)
    DGS:dgsSetText(createText, text)
end

function setTicketAnwer_Text (text)
    DGS:dgsSetText(answers_text, text)

end

function addTicketAnswer (id, from, date)
    local row = DGS:dgsGridListAddRow ( answers )
    if from == getPlayerName(getLocalPlayer()) then
        DGS:dgsGridListSetItemText ( answers, row, answers_from, "Dir" , false, false )
    else
         DGS:dgsGridListSetItemText ( answers, row, answers_from, from , false, false )
    end
    DGS:dgsGridListSetItemText ( answers, row, answers_date, date , false, false )
    
    DGS:dgsGridListSetItemData ( answers, row,answers_from, id )

end

function addTicket (id,subject, supporter, state, type, rating, date, creatore)
    local row = DGS:dgsGridListAddRow ( tickets )
    if tostring(supporter) == "none" then
        supporter = "Nicht zugeteilt"
    else
        supporter = supporter
    end
    if string.len(subject) >= 7 then
        subject = string.sub(subject,1, 19).."..."
    end
    DGS:dgsGridListSetItemText ( tickets, row, tickets_subject, subject , false, false )
    DGS:dgsGridListSetItemText ( tickets, row, tickets_supporter, supporter , false, false )
    DGS:dgsGridListSetItemText ( tickets, row, tickets_state, ticketState[state] , false, false )
    DGS:dgsGridListSetItemText ( tickets, row, tickets_type, ticketType[type] , false, false )
    DGS:dgsGridListSetItemText ( tickets, row, tickets_rating, rating , false, false )
    DGS:dgsGridListSetItemText ( tickets, row, tickets_date, date , false, false )
    DGS:dgsGridListSetItemData ( tickets, row,tickets_subject, id )
    if tickets_id then
        DGS:dgsGridListSetItemText ( tickets, row, tickets_id, id , false, false )
    end
    if tickets_creatore then
        DGS:dgsGridListSetItemText ( tickets, row, tickets_creatore, creatore , false, false )
    end
end







-- // Events
addEvent ( "updateTicketData", true )
addEventHandler ( "updateTicketData", getRootElement(), updateTicketData )
addEvent ( "setTicketAnwer_Text", true )
addEventHandler ( "setTicketAnwer_Text", getRootElement(), setTicketAnwer_Text )
addEvent ( "addTicketAnswer", true )
addEventHandler ( "addTicketAnswer", getRootElement(), addTicketAnswer )
addEvent ( "addTicket", true )
addEventHandler ( "addTicket", getRootElement(), addTicket )
addEvent ( "openTicketWindow", true )
addEventHandler ( "openTicketWindow", getRootElement(), openTicketWindow_window )
