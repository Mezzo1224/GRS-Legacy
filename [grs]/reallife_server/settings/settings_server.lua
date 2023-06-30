



-- Aktiviert den Inhalt von [maps] 
-- Die Karten können auch in die Server Config eingefügt werden, Code:
--[[
	<resource src="bahnhof" startup="1" protected="0" />
<resource src="Club-SF" startup="1" protected="0" />
<resource src="garagedeko" startup="1" protected="0" />
<resource src="Gelber-Punkt-by-wantedd" startup="1" protected="0" />
<resource src="Hauser" startup="1" protected="0" />
<resource src="kartbahn" startup="1" protected="0" />
<resource src="kollecthaus" startup="1" protected="0" />
<resource src="lossantosmap" startup="1" protected="0" />
<resource src="ls-hosp-dec" startup="1" protected="0" />
<resource src="ltr" startup="1" protected="0" />
<resource src="map_flores2" startup="1" protected="0" />
<resource src="Noobspawn" startup="1" protected="0" />
<resource src="PoliceDepartment" startup="1" protected="0" />
<resource src="SF_Garage" startup="1" protected="0" />
<resource src="wangcars" startup="1" protected="0" />
--]]

mapsExtension = false
mapsFromExtension = {
	[1] = "bahnhof",
	[2] = "Club-SF",
	[3] = "garagedeko",
	[4] = "Gelber-Punkt-by-wantedd",
	[5] = "Hauser",
	[6] = "kartbahn",
	[7] = "kollecthaus",
	[8] = "lossantosmap",
	[9] = "ls-hosp-dec",
	[10] = "ltr",
	[11] = "map_flores2",
	[12] = "Noobspawn",
	[13] = "PoliceDepartment",
	[14] = "SF_Garage",
	[15] = "wangcars"}



testmode = false
winterzeit = 1
maxplayers = 100
wctime = 20
speznr = { [110]=true, [112]=true, [300]=true, [400]=true } -- 110=Polize, 112=Sanitäter, 300=Mechaniker, 400=Taxi
tramSpeed = 0.35
aktionpuffer = 3*60*1000
healafterdmgtime = 3*60*1000

-- Cars
destcardim = 1
noobbikerespawn = 5
FCarIdleRespawn = 10
FCarDestroyRespawn = 0.1
noobrollerrespawntime = 5
noobrolleridlerespawntime = 600

-- Preise
nitroprice = 50
tuningpartprice = 75

paynsprayprice = 25
wantedprice = 200
wantedkillmoney = 100
wantedarrestmoney = 300
jailtimeperwanted = 5
hospitalcosts = 30
autosteuerprice = 30
autosteuererh = 1.5
drugprice = 30
smsprice = 1
callprice = 2
adcosts = 9
adbasiscosts = 50
pm_price = 250
waffenscheinprice = 8000
weaponsTruckCost = 5000


zinssatz = 0.15

-- Essen
salatprice = 15
smallpizzaprice = 15
normalpizzaprice = 40
bigpizzaprice = 50
salatheal = 25
smallpizzaheal = 15
normalpizzaheal = 35
bigpizzaheal = 50

-- SFPD

copcars = { [598]=true, [596]=true, [597]=true }
copbikes = { [523]=true }
copjeeps = { [599]=true }
cophelis = { [497]=true }
copvehs = { [598]=true, [596]=true, [597]=true, [523]=true, [599]=true, [497]=true }

validResources = { ["realdriveby"]=true, ["parachute"]=true, ["vio"]=true }
stopBadScripts = false

timeTillWeaponTruckDisappears = 20 * 60 * 1000
timeTillDrogentruckDisappears = 20 * 60 * 1000

--[[function resourceStart ( resource )

	if not validResources [ getResourceName ( resource ) ] then
		if stopBadScripts then
			cancelEvent()
		end
	end
end
addEventHandler ( "onResourcePreStart", getRootElement(), resourceStart )]]