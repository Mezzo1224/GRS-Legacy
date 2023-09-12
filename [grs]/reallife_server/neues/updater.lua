
function updateCheck ()
	if ServerConfig["updater"].versionsChecker == "meta" then
		fetchRemote ( ServerConfig["updater"].githubRawMeta, getVersionMeta, "", false )
	elseif ServerConfig["updater"].versionsChecker == "repository" then
		fetchRemote ( ServerConfig["updater"].githubRespoLink, getVersionRespo, "", false )
	else
		print("Updater deaktiviert.")
	end
end

updateReminder = 0
function getVersionRespo ( responseData, errorCode)
	local fileName = ":grs_cache/updater/repository.txt"
	if errorCode == 0 then
		local fileData = fromJSON(responseData)
		local lastUpdate =  fileData.pushed_at
		print("Letztes Update", fileData.pushed_at, "SHA256", sha256 ( lastUpdate ) )
		if fileExists ( fileName ) then
			-- // Ab hier beginnt der eigendliche Check
			local respoFile = fileOpen(fileName)  
			local count = fileGetSize(respoFile)
			local lastUpdateFromFile =  fileRead(respoFile, count)
			fileClose(respoFile)  
			print("Github",  sha256 ( lastUpdate ), "Lokal", lastUpdateFromFile )
			if  sha256 ( lastUpdate ) ~= lastUpdateFromFile then
                updateReminder = ( updateReminder + 1)
				print("!!! UPDATE VERFÜGBAR - ERINNERUNG "..updateReminder.." / 10 !!!")
				print("Es wurde etwas in der GitHub Repository abgeändert. Letztes Update: "..lastUpdate)
				print("https://github.com/Mezzo1224/GRS-Legacy")
				print("Hinweis: Diese Meldung kann mit dem löschen Folgender Datei beendet werden: ", fileName)
				if updateReminder >= 10 then
					fileDelete(fileName)
				end

			end
		else
			local newFile = fileCreate(fileName)
			if (newFile) then
				fileWrite(newFile, sha256 ( lastUpdate ) )
				fileClose(newFile)  
				print("Updater wurde vorbereitet. Erneuter Check.")
				updateCheck ()
			end
		end
	else
		print(errorCode)
	end
end

function getVersionMeta ( responseData, errorCode )
	if errorCode == 0 then
		local fileData = responseData
		if fileExists ( ":grs_cache/updater/meta_cache.xml" ) then
			fileDelete ( ":grs_cache/updater/meta_cache.xml" )
		end
		local newFile = fileCreate(":grs_cache/updater/meta_cache.xml")
		if (newFile) then
			fileWrite(newFile, fileData)
			fileClose(newFile)  
		end

		-- // Jetzt Versionen checken
		local cacheMeta = xmlLoadFile ( ":grs_cache/updater/meta_cache.xml" )
		if cacheMeta then
			local cacheMeta_info = xmlFindChild( cacheMeta, "info", 0 )
			local gitHubVersion = xmlNodeGetAttribute(cacheMeta_info, "version")
			xmlUnloadFile(cacheMeta)
			local version = getResourceInfo ( getThisResource(), "version" )
			if version ~= gitHubVersion then
				print("!!! UPDATE VERFÜGBAR !!!")
				print("Es ist ein Update verfügbar! (Momentane Version "..version..", Verfügbare Version: "..gitHubVersion..")")
				print("https://github.com/Mezzo1224/GRS-Legacy")
			end
		end
	else
		print(errorCode)
	end
end

    setTimer ( function()
        if versionsChecker  then
            updateCheck ()
            updateCheckTimer =  setTimer ( updateCheck, 3600*1000, 0 )
        else
            print("Updater deaktiviert.")
        end
    end, 5000, 1 )
