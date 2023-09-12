local x, y = guiGetScreenSize()
local sx, sy = x/2560, y/1440


function checkNewUpdate ()
    if fileExists(":grs_cache/update/update.txt") then
        local updateFile = fileOpen(":grs_cache/update/update.txt")
        local updateFileVer = fileRead(updateFile,  fileGetSize(updateFile))
        if updateFileVer ~= curVersion then
            showNewUpdate()
            -- // Alte Datei löschen
            fileClose(updateFile)
            fileDelete(":grs_cache/update/update.txt")
            -- // Neue erstellen
            local updateFile = fileCreate(":grs_cache/update/update.txt")
            fileWrite(updateFile,curVersion)
            fileClose(updateFile)
        else
            fileClose(updateFile)
        end
    else
        local updateFile = fileCreate(":grs_cache/update/update.txt")
        fileWrite(updateFile,curVersion)
        fileClose(updateFile)
        
        showNewUpdate()
    end
end

function showNewUpdate ()    
        triggerServerEvent("fetchUpdateDetails", getLocalPlayer())
        updateWindow = DGS:dgsCreateWindow(1034*sx, 0*sy, 492*sx, 443*sy,"Neues Update - "..curVersion,false)
        updateText = DGS:dgsCreateMemo(13*sx, 35*sy, 469*sx, 373*sy,"", false, updateWindow )
        DGS:dgsMoveTo(updateWindow,1034*sx, 499*sy,false,"OutQuad",2000)
        DGS:dgsWindowSetSizable(updateWindow,false)
        DGS:dgsWindowSetMovable(updateWindow,false)
        showCursor(true)
        setElementClicked ( true )
        guiSetInputEnabled ( false )
        DGS:dgsMemoSetReadOnly(updateText, true)
        addEventHandler( "onDgsWindowClose", updateWindow, 
            function()
                setElementClicked ( false )
                showCursor(false)
                guiSetInputEnabled ( true )
            end)

end
addEvent ( "showNewUpdate", true )
addEventHandler ( "showNewUpdate", getRootElement(), showNewUpdate )

function updateUpdateText (text)
    DGS:dgsSetText(updateText, text )
end
addEvent ( "updateUpdateText", true )
addEventHandler ( "updateUpdateText", getRootElement(), updateUpdateText )


function deleteUpdateFile ()
    if fileExists(":grs_cache/update/update.txt") then
        fileDelete(":grs_cache/update/update.txt")
        checkNewUpdate ()
        infobox_start_func ( "Updatedatei gelöscht.", 7500, 237, 150, 19 )
    else
        infobox_start_func ( "Es gibt keine Update-Datei.", 7500, 125, 0, 0 )
    end
end
addCommandHandler("deleteuf", deleteUpdateFile)


function makeNewUpdate_window()

    newUpdateWindow =  DGS:dgsCreateWindow(1053*sx, 505*sy, 519*sx, 482*sy,"Neues Update erstellen",false)
    updateVer = DGS:dgsCreateEdit(17*sx, 18*sy, 128*sx, 36*sy, curVersion, false, newUpdateWindow )
    updateText = DGS:dgsCreateMemo(12*sx, 70*sy, 497*sx, 325*sy, "", false, newUpdateWindow )
    

    getFile = DGS:dgsCreateButton(162*sx, 17*sy, 122*sx, 37*sy, "Datei abrufen", false, newUpdateWindow)
    newUpdateBtn =  DGS:dgsCreateButton(191*sx, 405*sy, 136*sx, 49*sy, "Updaten / Erstellen", false, newUpdateWindow)
 
    showCursor(true)
    setElementClicked ( true )
    guiSetInputEnabled ( false )

    addEventHandler( "onDgsWindowClose", newUpdateWindow, 
    function()
        setElementClicked ( false )
        showCursor(false)
        guiSetInputEnabled ( true )
    end)

        addEventHandler( "onDgsMouseClick", getFile, 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == getFile then
                local versionText = DGS:dgsGetText(updateVer)
                if string.len(versionText) > 0 then
                    triggerServerEvent("getUpdateFile", getLocalPlayer(), versionText)
                else
                    infobox_start_func ( "Keine Version eingegeben.", 7500, 125, 0, 0 )
                end
            end
        end)

        addEventHandler( "onDgsMouseClick", newUpdateBtn, 
        function(button, state, x, y)
            if button == 'left' and state == 'up' and source == newUpdateBtn then
                local versionText = DGS:dgsGetText(updateVer)
                local text = DGS:dgsGetText(updateText)
                if string.len(versionText) > 0 then
                    if string.len(text) > 0 then
                        triggerServerEvent("makeNewUpdate", getLocalPlayer(), versionText, text)
                        DGS:dgsCloseWindow(newUpdateWindow)
                else
                    infobox_start_func ( "Text zu klein.", 7500, 125, 0, 0 )
                end
            else
                infobox_start_func ( "Keine Version eingegeben.", 7500, 125, 0, 0 )
            end
        end
    end)

    local versionText = DGS:dgsGetText(updateVer)
    triggerServerEvent("getUpdateFile", getLocalPlayer(), versionText)
    DGS:dgsFocus(updateText)
end
addEvent ( "makeNewUpdate_window", true )
addEventHandler ( "makeNewUpdate_window", getRootElement(), makeNewUpdate_window )


function updateNewUpdateText (text)
    DGS:dgsSetText(updateText, text )
end
addEvent ( "updateNewUpdateText", true )
addEventHandler ( "updateNewUpdateText", getRootElement(), updateNewUpdateText )