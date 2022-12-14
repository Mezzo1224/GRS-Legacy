packages = {
	createPickup ( -1277.4365234375, 58.07186126709, 70.60230255127, 3, 1276, 0 ),
	createPickup ( -1983.5153808594, 137.75064086914, 30.619560241699, 3, 1276, 0 ),
	createPickup ( -1989.5472412109, 1117.8156738281, 73.581398010254, 3, 1276, 0 ),
	createPickup ( -1375.9006347656, 1491.2154541016, 10.756679534912, 3, 1276, 0 ),
	createPickup ( -1825.2287597656, 541.15783691406, 150.36605834961, 3, 1276, 0 ),
	createPickup ( -2155.9328613281, -404.79080200195, 38.312358856201, 3, 1276, 0 ),
	createPickup ( -2050.794921875, -443.80313110352, 74.822380065918, 3, 1276, 0 ),
	createPickup ( -2052.0910644531, 305.60397338867, 41.545742034912, 3, 1276, 0 ),
	createPickup ( -2514.53125, 796.62170410156, 41.655117034912, 3, 1276, 0 ),
	createPickup ( -2474.8071289063, 1552.5639648438, 32.787929534912, 3, 1276, 0 ),
	createPickup ( -2807.3764648438, 1162.4674072266, 25.803554534912, 3, 1276, 0 ),
	createPickup ( -2708.1826171875, 377.91351318359, 11.533007621765, 3, 1276, 0 ),
	createPickup ( -2571.0798339844, 327.51455688477, 10.116054534912, 3, 1276, 0 ),
	createPickup ( -1860.9008789063, -29.447776794434, 21.641443252563, 3, 1276, 0 ),
	createPickup ( -1517.8822021484, 108.67943572998, 16.881679534912, 3, 1276, 0 ),
	createPickup ( -1304.6301269531, 483.47424316406, 1.6119002103806, 3, 1276, 0 ),
	createPickup ( -1637.126953125, 488.01953125, 29.498867034912, 3, 1276, 0 ),
	createPickup ( -2665.7138671875, 1595.0284423828, 216.82745361328, 3, 1276, 0 ),
	createPickup ( -2682.5966796875, 1274.7376708984, 60.771320343018, 3, 1276, 0 ),
	createPickup ( -1942.1853027344, 883.455078125, 71.173881530762, 3, 1276, 0 ),
	createPickup ( -1826.4676513672, 366.33242797852, 16.717617034912, 3, 1276, 0 ),
	createPickup ( -1943.0307617188, 487.23587036133, 31.522304534912, 3, 1276, 0 ),
	createPickup ( -2240.646484375, 600.18481445313, 52.241054534912, 3, 1276, 0 ),
	createPickup ( -2491.3928222656, 128.91076660156, 25.420742034912, 3, 1276, 0 ),
	createPickup ( -1951.4162597656, 279.83767700195, 35.022304534912, 3, 1276, 0 ) }


function pickupPackage ( player )
	local package = source
	local number = vioGetElementData ( source, "pickupID" )
	if number then
		if tonumber ( vioGetElementData ( player, "package"..number ) ) == 0 then
			local pname = getPlayerName ( player )
			vioSetElementData ( player, "package"..number, 1 )
			vioSetElementData ( player, "foundpackages", vioGetElementData ( player, "foundpackages" ) + 1 )
			outputChatBox ( "Du hast "..vioGetElementData ( player, "foundpackages" ).." von 25 versteckten P??ckchen gefunden und erhaelst 10 Punkte sowie 100 $!", player, 0, 125, 0 )
			triggerClientEvent ( player, "playPackageSound", getRootElement() )	
			vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + 100 )
			vioSetElementData ( player, "bonuspoints", vioGetElementData ( player, "bonuspoints" ) + 10 )
			dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "packages", "Paket"..number, 1, "UID",  playerUID[pname] )
			triggerClientEvent ( player, "hidePackages", getRootElement(), package )
		end
	end
	PackageAchievCheck ( player )
end
for i = 1, #packages do
	addEventHandler ( "onPickupHit", packages[i], pickupPackage )
	vioSetElementData ( packages[i], "pickupID", i )
end


function PackageAchievCheck ( player )

	if vioGetElementData ( player, "collectr_achiev" ) and vioGetElementData ( player, "foundpackages" ) then
		if vioGetElementData ( player, "collectr_achiev" ) ~= "done" and tonumber(vioGetElementData ( player, "foundpackages" )) >= 25 then						-- Achiev: Collector
			vioSetElementData ( player, "collectr_achiev", "done" )																								-- Achiev: Collector
			triggerClientEvent ( player, "showAchievmentBox", player, "  Der\n Sammler", 50, 10000 )															-- Achiev: Collector
			vioSetElementData ( player, "bonuspoints", tonumber(vioGetElementData ( player, "bonuspoints" )) + 50 )												-- Achiev: Collector
			dbExec ( handler, "UPDATE ?? SET ??=? WHERE ??=?", "achievments", "DerSammler", "done", "UID",  playerUID[getPlayerName(player)] ) 					-- Achiev: Collector
		end																																						-- Achiev: Collector
	end
end