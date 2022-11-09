local mySQLFile = xmlLoadFile(":reallife_server/mysql/mysql.xml")
-- // Beim nicht laden wird die Datei erstellt
if not mySQLFile then
    mySQLFile = xmlCreateFile(":reallife_server/mysql/mysql.xml","mysql")
    xmlNodeSetValue (xmlCreateChild ( mySQLFile, "initialized"), "false" )
    print("SQL File initialisiert.")

    --// Host
    xmlNodeSetValue (xmlCreateChild ( mySQLFile, "host"), "" )

    
    xmlSaveFile(mySQLFile)
    xmlUnloadFile(mySQLFile)
end