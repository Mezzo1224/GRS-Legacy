feuerjobicon = createPickup ( -2026.5947265625, 67.112854, 28.69159, 3, 1239, 100, 0 )

function feuerjobiconHit ( player )
	triggerClientEvent ( player, "plusfeuer", player, vioGetElementData ( player, "feuer" ) )
	triggerClientEvent ( player, "showfirejobwindow", player )
end
addEventHandler ( "onPickupHit", feuerjobicon, feuerjobiconHit )
local deinefeuer = 0
--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MT-RPG' - Resoruce for MTA: San Andreas PROJECT X          ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################



local cFunc = {}
local cSetting = {}


-- FUNCTIONS --


cSetting["fire_positions"] = {
	-- LOS SANTOS --
	{2216.814453125, -2666.984375, 17.882808685303},
	{1938.1939697266, -1911.4255371094, 15.256797790527},
	{1920.7014160156, -1998.5482177734, 13.554395675659},
	{2053.2082519531, -2125.0893554688, 13.6328125},
	{1062.3879394531, -1696.2911376953, 14.3671875},
	{1139.3118896484, -1762.1187744141, 13.595740318298},
	{864.54400634766, -977.99969482422, 37.1875},
	{1048.5948486328, -1055.8071289063, 31.696151733398},
	{1183.0281982422, -1107.9006347656, 25.823791503906},
	{1286.814453125, -1299.2752685547, 13.54340171814},
	{2053.0693359375, -1278.5280761719, 23.988443374634},
	{2111.42578125, -1279.2106933594, 25.8359375},
	{2758.578125, -1537.2458496094, 25.992923736572},
	{1684.5944824219, -1343.4270019531, 17.436433792114},
	{151.5545501709, -114.42558288574, 1.5742318630219},
	{251.88500976563, -19.081115722656, 1.8283348083496},
	{1330.0148925781, 372.78872680664, 19.5546875},
	{1271.3168945313, 293.25469970703, 19.5546875},
	{2333.0871582031, 61.683921813965, 26.70578956604},
	{2488.4155273438, 11.762690544128, 28.44164276123},
	-- SAN FIERRO --
	{-2070.6853027344, -326.13397216797, 35.468143463135},
	{-2619.4484863281, -97.773696899414, 4.3359375},
	{-2792.8400878906, 84.905075073242, 7.6311511993408},
	{-2242.1860351563, -53.818119049072, 35.3203125},
	{-2426.1262207031, 338.07723999023, 36.9921875},
	{-2765.353515625, 372.02346801758, 6.339786529541},
	{-2055.0295410156, 452.67108154297, 35.171875},
	{-2402.4143066406, 829.27954101563, 36.871536254883},
	{-1779.6612548828, 1024.2116699219, 25.01099395752},
	{-2570.5573730469, 1151.2624511719, 55.7265625},
	{-2482.5463867188, 2407.5305175781, 17.109375},
	{-2583.7004394531, 2307.8571777344, 7.0028858184814},
	{-2362.888671875, 2440.5954589844, 8.6679458618164},
	{-1455.5932617188, 2640.9182128906, 55.8359375},
	{-1739.0520019531, 1302.4506835938, 7.1875},
	{-1493.0943603516, 980.01702880859, 7.1875},
	{-2033.2076416016, 902.23590087891, 50.169353485107},
	{-1703.9974365234, 785.76763916016, 25.711502075195},
	{-2176.1762695313, 720.36285400391, 61.979537963867},
	{-1015.0573120117, -701.04669189453, 32.0078125},
	{-2120.9321289063, -2354.2875976563, 30.773017883301},
	{-2059.5747070313, -2505.0908203125, 30.801424026489},
}

cFunc["apply_random_fire"] = function()
	local rand = math.random(1, #cSetting["fire_positions"])
	local x, y, z = cSetting["fire_positions"][rand][1], cSetting["fire_positions"][rand][2], cSetting["fire_positions"][rand][3]
	
	outputFactionMessage("sffd", "To all nearby fire departments: Fire in "..getZoneName(x, y, z, false)..", "..getZoneName(x, y, z, true).." spotted!", 255, 0, 0)
	outputFactionMessage("lsfd", "To all nearby fire departments: Fire in "..getZoneName(x, y, z, false)..", "..getZoneName(x, y, z, true).." spotted!", 255, 0, 0)
	
	triggerClientEvent(getRootElement(), "onMTFireCreate", getRootElement(), cSetting["fire_positions"][rand])
	setTimer(triggerClientEvent, 10*60*1000, 1, getRootElement(), "onMTFireDelete", getRootElement(), cSetting["fire_positions"][rand])
end

-- EVENT HANDLERS --

setTimer(cFunc["apply_random_fire"], 5*60*1000, -1)
addCommandHandler("randfire", cFunc["apply_random_fire"])

]]

--[[
	##########################################################################
	##                                                                      ##
	## Project: 'MT-RPG' - Resoruce for MTA: San Andreas PROJECT X          ##
	##                      Developer: Noneatme                             ##
	##           License: See LICENSE in the top level directory            ##
	##                                                                      ##
	##########################################################################
]]


local cFunc = {}
local cSetting = {}

cSetting["fire_loescher"] = {}

addEvent("doENRFireAddLoescher", true)
addEvent("addstart", true)

cSetting["fire_id"] = 1

-- FUNCTIONS --

cSetting["fire_positions_1"] = {
{-1783.5999755859, 572.70001220703, 34.799999237061},
{-1781.6999511719, 569.20001220703, 34.799999237061},
{-1785.4000244141, 575.70001220703, 34.799999237061},
{-1775.5, 560.79998779297, 34.799999237061},
{-1771.1999511719, 558, 34.799999237061},
{-1775.5, 554.90002441406, 34.799999237061},
{-1785, 533.79998779297, 34.799999237061},
{-1788.5999755859, 536, 34.799999237061},
{-1789.3000488281, 529.59997558594, 34.799999237061},
{-1794.9000244141, 534.40002441406, 34.799999237061},
{-1803.5, 531.70001220703, 34.799999237061},
{-1806.9000244141, 531.90002441406, 34.799999237061},
{-1810.1999511719, 531.79998779297, 34.799999237061},
}

cSetting["fire_positions_2"] = {
{-2493.1999511719, 309.89999389648, 34.799999237061},
{-2496.3999023438, 310.10000610352, 34.799999237061},
{-2495.6999511719, 303.5, 34.799999237061},
{-2492.8000488281, 305.5, 34.799999237061},
{-2500.8999023438, 314.79998779297, 34.799999237061},
{-2507.1000976563, 313.20001220703, 34.799999237061},
{-2504.1999511719, 309.10000610352, 34.799999237061},
{-2501.6999511719, 302.60000610352, 34.799999237061},
{-2506.8999023438, 304.70001220703, 34.799999237061},
{-2509.8999023438, 309, 34.799999237061},
{-2498.6999511719, 297, 34.799999237061},
{-2494.3999023438, 300, 34.799999237061},
{-2502.8000488281, 296.79998779297, 34.799999237061},
{-2505.5, 300.70001220703, 34.799999237061},
{-2496.3000488281, 292.5, 34.799999237061},
{-2496.2998046875, 292.5, 34.799999237061},
{-2500.6999511719, 291.60000610352, 34.799999237061},
{-2506.5, 293.10000610352, 34.799999237061},
{-2509.6999511719, 296.79998779297, 34.799999237061},
{-2511.5, 301.89999389648, 34.799999237061},
{-2513.8999023438, 290.89999389648, 34.799999237061},
{-2510.5, 290, 34.799999237061},
{-2505.3999023438, 288.70001220703, 34.799999237061},
{-2499.8000488281, 287.20001220703, 34.799999237061},
{-2495, 285.89999389648, 34.799999237061},
{-2488.5, 285.20001220703, 34.799999237061, 0, 0, 1.99},
{-2482.3999023438, 284.70001220703, 34.799999237061, 0, 0, 3.99},
{-2487.1999511719, 279, 34.799999237061, 0, 0, 3.9},
{-2491.1000976563, 280, 34.799999237061, 0, 0, 357.9},
{-2495.5, 281.10000610352, 34.799999237061, 0, 0, 353.99},
{-2499.6999511719, 282.70001220703, 34.799999237061, 0, 0, 353.99},
{-2503.8000488281, 284.79998779297, 34.799999237061, 0, 0, 353.99},
{-2509.6999511719, 285, 34.799999237061, 0, 0, 353.99},
{-2512.1000976563, 282.79998779297, 34.799999237061, 0, 0, 353.99},
{-2507.3000488281, 281.5, 34.799999237061, 0, 0, 353.99},
{-2502.8999023438, 280.39999389648, 34.799999237061, 0, 0, 353.99},
}

cSetting["fire_positions_3"] = {
{-1982.0999755859, 645.09997558594, 46.200000762939},
{-1979.0999755859, 643.20001220703, 46.200000762939},
{-1985.3000488281, 641.90002441406, 46.200000762939},
{-1984.3000488281, 649.79998779297, 46.200000762939},
{-1980.3000488281, 649.29998779297, 46.200000762939},
{-1980.2998046875, 649.2998046875, 46.200000762939},
{-1973.5999755859, 652.20001220703, 46.200000762939},
{-1973.5, 647.5, 46.200000762939},
{-1971.4000244141, 643.5, 46.200000762939},
{-1968.0999755859, 641.20001220703, 46.200000762939},
{-1967.4000244141, 648.70001220703, 46.200000762939},
{-1966.5, 654.20001220703, 46.200000762939},
{-1970.8000488281, 657.20001220703, 46.200000762939},
{-1977, 654.90002441406, 46.200000762939},
{-1971.9000244141, 662, 46.200000762939},
{-1976.4000244141, 665.20001220703, 46.200000762939},
{-1980.1999511719, 659.90002441406, 46.200000762939},
{-1983.5, 662.20001220703, 46.200000762939},
{-1985.5999755859, 657.5, 46.200000762939},
{-1980.5999755859, 666.20001220703, 46.200000762939},
{-1983.1999511719, 668.09997558594, 46.200000762939},
{-1983.19921875, 668.099609375, 46.200000762939},
{-1976.3000488281, 669.5, 46.200000762939},
{-1972.5, 668.40002441406, 46.200000762939},
{-1967.1999511719, 666.90002441406, 46.200000762939},
{-1968.5999755859, 661.79998779297, 46.200000762939},
{-1964.9000244141, 671.09997558594, 46.200000762939},
{-1968.6999511719, 672.20001220703, 46.200000762939},
{-1973.5, 673.59997558594, 46.200000762939},
{-1976.8000488281, 676.59997558594, 46.200000762939},
{-1981.0999755859, 675.20001220703, 46.200000762939},
{-1983.3000488281, 678.40002441406, 46.200000762939},
{-1985.1999511719, 671.70001220703, 46.200000762939},
{-1980.1999511719, 680.20001220703, 46.200000762939},
}

cSetting["fire_positions_4"] = {
{-2669, -288.20001220703, 6.9000000953674},
{-2666.6999511719, -283, 6.9000000953674},
{-2670.8999023438, -282.20001220703, 6.9000000953674},
{-2668.5, -277.60000610352, 6.9000000953674},
{-2672.1999511719, -276.89999389648, 6.9000000953674},
{-2674.3000488281, -281.10000610352, 6.9000000953674},
{-2678, -280.39999389648, 6.9000000953674},
{-2675.8999023438, -276, 6.9000000953674},
{-2672.8000488281, -272, 6.9000000953674},
{-2677.1999511719, -271.10000610352, 6.9000000953674},
{-2680.8999023438, -275.5, 6.9000000953674},
{-2684.6999511719, -282.10000610352, 6.9000000953674},
{-2687.8000488281, -280, 6.9000000953674},
{-2691.1000976563, -287.5, 6.9000000953674},
{-2694, -286.89999389648, 6.9000000953674},
{-2696.8000488281, -293.20001220703, 6.9000000953674},
{-2700.5, -294, 6.9000000953674},
{-2703.1000976563, -299.60000610352, 6.9000000953674},
{-2706.5, -298.89999389648, 6.9000000953674},
{-2708.3999023438, -304.89999389648, 6.9000000953674},
{-2714.3000488281, -307.60000610352, 6.9000000953674},
{-2683.6000976563, -273.29998779297, 6.9000000953674},
{-2680, -270.70001220703, 6.9000000953674},
{-2680, -270.69921875, 6.9000000953674},
}

cSetting["fire_positions_5"] = {
{-2679.8000488281, 1379.6999511719, 6.6999998092651},
{-2678.1999511719, 1382.5999755859, 6.6999998092651},
{-2682, 1375.5999755859, 6.6999998092651},
{-2687.5, 1378.5999755859, 6.6999998092651},
{-2690, 1374, 6.6999998092651},
{-2678.6999511719, 1373.3000488281, 6.6999998092651},
{-2674.1000976563, 1375, 6.6999998092651},
{-2671.6999511719, 1379.4000244141, 6.6999998092651},
{-2671.5, 1384.4000244141, 6.6999998092651},
{-2671.5, 1384.3994140625, 6.6999998092651},
{-2669, 1374.0999755859, 6.6999998092651},
{-2666.6999511719, 1378.4000244141, 6.6999998092651},
{-2666.1000976563, 1382.5, 6.6999998092651},
{-2664.6000976563, 1387.1999511719, 6.6999998092651},
{-2661.1999511719, 1383.3000488281, 6.6999998092651},
{-2660.8000488281, 1379.3000488281, 6.6999998092651},
{-2661.1999511719, 1375.5, 6.6999998092651},
{-2656.5, 1376, 6.6999998092651},
{-2656.8999023438, 1380.1999511719, 6.6999998092651},
{-2657.3999023438, 1384.6999511719, 6.6999998092651},
{-2657.8000488281, 1388.6999511719, 6.6999998092651},
{-2654.1000976563, 1389.0999755859, 6.6999998092651},
{-2653.6000976563, 1384.0999755859, 6.6999998092651},
{-2653.1999511719, 1380.4000244141, 6.6999998092651},
{-2652.8000488281, 1376.1999511719, 6.6999998092651},
{-2652.7998046875, 1376.19921875, 6.6999998092651},

}

cSetting["fire_positions_6"] = {
{-85.800003051758, -1608, 2.2999999523163},
{-80, -1604.5, 2.2999999523163},
{-75.900001525879, -1601.3000488281, 2.2999999523163},
{-81.400001525879, -1599.5999755859, 2.2999999523163},
{-86.300003051758, -1602, 2.2999999523163},
{-81.300003051758, -1594.4000244141, 2.2999999523163},
{-85.099998474121, -1591.4000244141, 2.2999999523163},
{-85.099609375, -1591.3994140625, 2.2999999523163},
{-80.800003051758, -1587.5, 2.2999999523163},
{-82.800003051758, -1582.1999511719, 2.2999999523163},
{-87.099998474121, -1584.3000488281, 2.2999999523163},
{-93.099998474121, -1583.3000488281, 2.2999999523163},
{-98.599998474121, -1585, 2.2999999523163},
{-97, -1579.6999511719, 2.2999999523163},
{-87.099998474121, -1579.9000244141, 2.2999999523163},
{-97, -1575.5, 2.2999999523163},
{-97, -1575.5, 2.2999999523163},
{-88.800003051758, -1572.0999755859, 2.2999999523163},
{-83.699996948242, -1573.5, 2.2999999523163},
{-96.699996948242, -1571.6999511719, 2.2999999523163},
{-106.59999847412, -1577.5, 2.2999999523163},
{-103, -1571, 2.2999999523163},
{-100, -1568.6999511719, 2.2999999523163},
{-108.30000305176, -1573.4000244141, 2.2999999523163},
{-104.5, -1565.4000244141, 2.2999999523163},
{-99.900001525879, -1564.5999755859, 2.2999999523163},
{-80.900001525879, -1577.4000244141, 2.2999999523163},
{-78.300003051758, -1573.6999511719, 2.2999999523163},
{-81.699996948242, -1570.0999755859, 2.2999999523163},
{-85.800003051758, -1569, 2.2999999523163},
{-85.300003051758, -1574.5999755859, 2.2999999523163},

}

cSetting["fire_positions_7"] = {
{-1115.6999511719, -1287.4000244141, 128.89999389648},
{-1115.6999511719, -1282.5, 128.89999389648},
{-1117.4000244141, -1274.9000244141, 128.89999389648},
{-1109.5, -1277, 128.89999389648},
{-1104, -1286.8000488281, 128.89999389648},
{-1105.3000488281, -1280.9000244141, 128.89999389648},
{-1097.8000488281, -1283.5999755859, 128.89999389648},
{-1093.8000488281, -1287.8000488281, 128.89999389648},
{-1091.3000488281, -1281.9000244141, 128.89999389648},
{-1096.4000244141, -1278.6999511719, 128.89999389648},
{-1100.6999511719, -1274, 128.89999389648},
{-1111.5, -1271.5, 128.89999389648},
{-1115.4000244141, -1265.4000244141, 128.89999389648},
{-1105.9000244141, -1266.6999511719, 128.89999389648},
{-1097, -1268.8000488281, 128.89999389648},
{-1092.8000488281, -1274, 128.89999389648},
{-1092.7998046875, -1274, 128.89999389648},
{-1084.6999511719, -1285.3000488281, 128.89999389648},
{-1086.4000244141, -1278.8000488281, 128.89999389648},
{-1088.3000488281, -1271.3000488281, 128.89999389648, 0, 0, 5.9},
{-1092.3000488281, -1263.8000488281, 128.89999389648, 0, 0, 5.99},
{-1099.6999511719, -1262.0999755859, 128.89999389648, 0, 0, 5.99},
{-1108.0999755859, -1260.6999511719, 128.89999389648, 0, 0, 5.99},
{-1115.1999511719, -1258.0999755859, 128.89999389648, 0, 0, 5.99},
{-1100, -1257, 128.89999389648, 0, 0, 5.99},
{-1090.0999755859, -1256.5, 128.89999389648, 0, 0, 5.99},
{-1086.1999511719, -1260.4000244141, 128.89999389648, 0, 0, 5.99},
{-1083.5999755859, -1266.4000244141, 128.89999389648, 0, 0, 5.99},
{-1081.9000244141, -1272.9000244141, 128.89999389648, 0, 0, 5.99},
{-1080.1999511719, -1279.4000244141, 128.89999389648, 0, 0, 5.99},
{-1078.5999755859, -1285.5, 128.89999389648, 0, 0, 5.99},
{-1073.6999511719, -1287.5999755859, 128.89999389648, 0, 0, 5.99},
{-1075.1999511719, -1281.8000488281, 128.89999389648, 0, 0, 5.99},
{-1073.9000244141, -1276, 128.89999389648, 0, 0, 5.99},
{-1075.5, -1269.6999511719, 128.89999389648, 0, 0, 5.99},
{-1078.9000244141, -1262.5999755859, 128.89999389648, 0, 0, 5.99},
{-1080.1999511719, -1257.8000488281, 128.89999389648, 0, 0, 5.99},
{-1073.4000244141, -1257.3000488281, 128.89999389648, 0, 0, 5.99},
{-1072.5, -1260.9000244141, 128.89999389648, 0, 0, 3.99},
{-1071.1999511719, -1265.6999511719, 128.89999389648, 0, 0, 3.9935},
{-1069.6999511719, -1271.5, 128.89999389648, 0, 0, 3.9935},
{-1071.1999511719, -1278.8000488281, 128.89999389648, 0, 0, 3.9935},
{-1069.8000488281, -1284.0999755859, 128.89999389648, 0, 0, 3.9935},
{-1067.4000244141, -1286.5999755859, 128.89999389648, 0, 0, 3.9935},
{-1068.0999755859, -1276.6999511719, 128.89999389648, 0, 0, 3.9935},
{-1066.9000244141, -1266.3000488281, 128.89999389648, 0, 0, 3.9935},
{-1068.1999511719, -1261.1999511719, 128.89999389648, 0, 0, 3.9935},
{-1068.1999511719, -1256.3000488281, 128.89999389648, 0, 0, 3.9935},
{-1068.19921875, -1256.2998046875, 128.89999389648, 0, 0, 3.9935},

}

cSetting["fire_positions_8"] = {
{-2318.1999511719, 262.10000610352, 35},
{-2319.1000976563, 267.10000610352, 35},
{-2315.6999511719, 272.5, 35},
{-2325.1999511719, 271.20001220703, 35},
{-2332.3000488281, 266.89999389648, 35},
{-2330.6999511719, 262.39999389648, 35},
{-2325.8000488281, 258.79998779297, 35},
{-2330.1999511719, 254.39999389648, 35},
{-2330.3000488281, 249.39999389648, 35},
{-2322.8000488281, 249.19999694824, 35},
{-2319.8999023438, 255.10000610352, 35},
{-2312.6000976563, 254.89999389648, 35},
{-2310.6999511719, 259.60000610352, 35},
{-2309.3000488281, 264.29998779297, 35},
{-2309.1999511719, 268.29998779297, 35},
{-2309.19921875, 268.2998046875, 35},
}

cSetting["fire_positions_9"] = {
{-2612.5, -240.10000610352, 18.700000762939},
{-2606.6000976563, -239.60000610352, 18.700000762939},
{-2609.8000488281, -232.39999389648, 18.700000762939},
{-2615.3000488281, -233.69999694824, 18.700000762939},
{-2620.3000488281, -236.19999694824, 18.700000762939},
{-2617.5, -240.80000305176, 18.700000762939},
{-2617.6000976563, -247.19999694824, 18.700000762939},
{-2613.5, -249.69999694824, 18.700000762939},
{-2610.3999023438, -244.60000610352, 18.700000762939},
{-2606.8000488281, -246.80000305176, 18.700000762939},
{-2601.1000976563, -237.39999389648, 18.700000762939},
{-2596.6000976563, -240.10000610352, 18.700000762939},
{-2601.5, -245.30000305176, 18.700000762939},
{-2610.1000976563, -251.19999694824, 18.700000762939},
{-2616.8000488281, -251.19999694824, 18.700000762939},
{-2616.7998046875, -251.19921875, 18.700000762939},
}

cSetting["fire_positions_10"] = {
{-1744.8000488281, 164.30000305176, 3.2000000476837},
{-1741.9000244141, 167.39999389648, 3.2000000476837},
{-1742, 176.19999694824, 3.2000000476837},
{-1742.0999755859, 186.5, 3.2000000476837},
{-1739.0999755859, 173.5, 3.2000000476837},
{-1736.0999755859, 173.89999389648, 3.2000000476837},
{-1737.1999511719, 182.10000610352, 3.2000000476837},
{-1736, 188.60000610352, 3.2000000476837},
{-1732.5, 187, 3.2000000476837},
{-1732.4000244141, 178.39999389648, 3.2000000476837},
{-1731.8000488281, 172.19999694824, 3.2000000476837},
{-1734.4000244141, 169.10000610352, 3.2000000476837},
{-1737.4000244141, 166.69999694824, 3.2000000476837},
{-1732.1999511719, 167.39999389648, 3.2000000476837},
{-1739.5, 163.69999694824, 3.2000000476837},
{-1746.9000244141, 160.19999694824, 3.2000000476837},
{-1741.6999511719, 159.39999389648, 3.2000000476837},
{-1736.9000244141, 161.5, 3.2000000476837},
{-1734.5999755859, 163.30000305176, 3.2000000476837},
{-1735.5999755859, 159.39999389648, 3.2000000476837},
{-1738.5999755859, 157.19999694824, 3.2000000476837},
}

cSetting["fire_positions_11"] = {
{-1282.8000488281, 47.299999237061, 13.800000190735},
{-1277.8000488281, 45.599998474121, 13.800000190735},
{-1281, 42, 13.800000190735},
{-1281.1999511719, 50.5, 13.800000190735},
{-1285.6999511719, 52.200000762939, 13.800000190735},
{-1287.5999755859, 48.900001525879, 13.800000190735},
{-1287.5, 44.200000762939, 13.800000190735},
{-1271.8000488281, 47.799999237061, 13.800000190735},
{-1281.6999511719, 55.599998474121, 13.800000190735},
{-1286, 57, 13.800000190735},
{-1279.5, 58.599998474121, 13.800000190735},
{-1279.5999755859, 61.299999237061, 13.800000190735},
{-1273.5999755859, 61.400001525879, 13.800000190735},
{-1271.9000244141, 64.199996948242, 13.800000190735},
{-1275.1999511719, 67.599998474121, 13.800000190735},
{-1283.0999755859, 62.400001525879, 13.800000190735},
{-1288.8000488281, 57.799999237061, 13.800000190735},
{-1290.9000244141, 52.799999237061, 13.800000190735},
{-1293, 47.5, 13.800000190735},
{-1290.4000244141, 43.099998474121, 13.800000190735},
{-1284.8000488281, 39.5, 13.800000190735},
{-1284.7998046875, 39.5, 13.800000190735},
}

cSetting["fire_positions_12"] = {
{-1014.5, -695.5, 31.700000762939},
{-1017.200012207, -696.79998779297, 31.700000762939},
{-1014, -698.20001220703, 31.700000762939},
{-1012.299987793, -696.70001220703, 31.700000762939},
{-1014.0999755859, -691.29998779297, 31.700000762939},
{-1017.299987793, -691.09997558594, 31.700000762939},
{-1020.299987793, -694.40002441406, 31.700000762939},
{-1021, -690.90002441406, 31.700000762939},
{-1017.5, -687, 31.700000762939},
{-1020.9000244141, -688, 31.700000762939},
{-1024.8000488281, -686.40002441406, 31.700000762939},
{-1027.8000488281, -690.29998779297, 31.700000762939},
{-1029.1999511719, -685.90002441406, 31.700000762939},
{-1029.19921875, -685.8994140625, 31.700000762939},
{-1032.1999511719, -686.5, 31.700000762939},
{-1033.3000488281, -692.40002441406, 31.700000762939},
{-1035.4000244141, -690.09997558594, 31.700000762939},
{-1036.5, -685.79998779297, 31.700000762939},
{-1040.3000488281, -689.09997558594, 31.700000762939},
{-1041.1999511719, -693, 31.700000762939},
{-1041.19921875, -693, 31.700000762939},
{-1042.9000244141, -695.90002441406, 31.700000762939},
{-1045.1999511719, -689.40002441406, 31.700000762939},
{-1043.8000488281, -702.09997558594, 31.700000762939},
{-1042.1999511719, -709.40002441406, 31.700000762939},
{-1042.19921875, -709.3994140625, 31.700000762939},
}

cSetting["fire_positions_13"] = {
{-2065.8000488281, -906.09997558594, 31.799999237061},
{-2064.3000488281, -901.90002441406, 31.799999237061},
{-2067.8999023438, -899.5, 31.799999237061},
{-2067.6999511719, -896.09997558594, 31.799999237061},
{-2073, -896.20001220703, 31.799999237061},
{-2078.5, -893.20001220703, 31.799999237061},
{-2073, -893.5, 31.799999237061},
{-2073, -893.5, 31.799999237061},
{-2075.3000488281, -889.90002441406, 31.799999237061},
{-2081.1999511719, -892.20001220703, 31.799999237061},
{-2085.1999511719, -889.20001220703, 31.799999237061},
{-2079.6999511719, -887.09997558594, 31.799999237061},
{-2084.1999511719, -883.40002441406, 31.799999237061},
{-2090.1000976563, -886.59997558594, 31.799999237061},
{-2074, -883, 31.799999237061},
{-2077.5, -880.79998779297, 31.799999237061},
{-2078.3999023438, -877.5, 31.799999237061},
{-2070.3000488281, -877.29998779297, 31.799999237061},
{-2073.6999511719, -873.90002441406, 31.799999237061},
{-2065.8999023438, -876.5, 31.799999237061},
{-2068.5, -880, 31.799999237061},
{-2067.6999511719, -871.79998779297, 31.799999237061},
{-2063.1000976563, -873.5, 31.799999237061},
{-2064, -870.40002441406, 31.799999237061},
{-2065.6999511719, -867.20001220703, 31.799999237061},
{-2062.1999511719, -867.29998779297, 31.799999237061},
{-2061.8000488281, -863.09997558594, 31.799999237061},
{-2061.7998046875, -863.099609375, 31.799999237061},
}

cSetting["fire_positions_14"] = {
{-2070.6999511719, -393.20001220703, 35.200000762939},
{-2066.5, -396.89999389648, 35.200000762939},
{-2073.3999023438, -394.70001220703, 35.200000762939},
{-2074.6000976563, -392.20001220703, 35.200000762939},
{-2077.3000488281, -394.5, 35.200000762939},
{-2077.2998046875, -394.5, 35.200000762939},
{-2081.8999023438, -393.10000610352, 35.200000762939},
{-2083.1999511719, -395.20001220703, 35.200000762939},
{-2087.3999023438, -392.5, 35.200000762939},
{-2089.1999511719, -395.39999389648, 35.200000762939},
{-2093, -395.20001220703, 35.200000762939},
{-2093.1999511719, -393, 35.200000762939},
{-2093.19921875, -393, 35.200000762939},
{-2097.5, -392.39999389648, 35.200000762939},
{-2097.3999023438, -395.60000610352, 35.200000762939},
{-2100.5, -393.89999389648, 35.200000762939},
{-2101.3999023438, -390.70001220703, 35.200000762939},
{-2103.8000488281, -393.29998779297, 35.200000762939},
{-2103.6999511719, -395.29998779297, 35.200000762939},
}

cSetting["fire_positions_15"] = {
{-2070.6999511719, -393.20001220703, 35.200000762939},
{-2066.5, -396.89999389648, 35.200000762939},
{-2073.3999023438, -394.70001220703, 35.200000762939},
{-2074.6000976563, -392.20001220703, 35.200000762939},
{-2077.3000488281, -394.5, 35.200000762939},
{-2077.2998046875, -394.5, 35.200000762939},
{-2081.8999023438, -393.10000610352, 35.200000762939},
{-2083.1999511719, -395.20001220703, 35.200000762939},
{-2087.3999023438, -392.5, 35.200000762939},
{-2089.1999511719, -395.39999389648, 35.200000762939},
{-2093, -395.20001220703, 35.200000762939},
{-2093.1999511719, -393, 35.200000762939},
{-2093.19921875, -393, 35.200000762939},
{-2097.5, -392.39999389648, 35.200000762939},
{-2097.3999023438, -395.60000610352, 35.200000762939},
{-2100.5, -393.89999389648, 35.200000762939},
{-2101.3999023438, -390.70001220703, 35.200000762939},
{-2103.8000488281, -393.29998779297, 35.200000762939},
{-2103.6999511719, -395.29998779297, 35.200000762939},
{-2464.1999511719, -605.40002441406, 132.19999694824},
{-2462.6999511719, -609.20001220703, 132.19999694824},
{-2459.1000976563, -606.90002441406, 132.19999694824},
{-2461.1000976563, -601.40002441406, 132.19999694824},
{-2458.8000488281, -599.90002441406, 132.19999694824},
{-2454.3000488281, -604.70001220703, 132.19999694824},
{-2454.1000976563, -600.40002441406, 132.19999694824},
{-2455.8999023438, -607.79998779297, 132.19999694824},
{-2470.6000976563, -606.5, 132.19999694824},
{-2465.8000488281, -611.70001220703, 132.19999694824},
{-2457.6999511719, -611, 132.19999694824},
{-2457.69921875, -611, 132.19999694824},
}
thisdeltedfires = 0
cFunc["loesche_feuer"] = function(id)
	-- outputChatBox("a")
	-- outputChatBox(id)
	triggerClientEvent("onENRFireDelete", getRootElement(), id)
	if(cSetting["fire_positions_"..fireposition][id]) then
	-- outputChatBox("b")
		local x, y, z = cSetting["fire_positions_"..fireposition][id][1], cSetting["fire_positions_"..fireposition][id][2], cSetting["fire_positions_"..fireposition][id][3]
		thisdeltedfires = thisdeltedfires + 1
		killTimer(_G["killf_"..id])
		-- outputChatBox(thisdeltedfires.." - "..#cSetting["fire_positions_"..fireposition], getPlayerFromName("[SCR]Nils"), 200, 0, 0)
		-- outputChatBox(thisdeltedfires.." - "..#cSetting["fire_positions_"..fireposition], getPlayerFromName("[SCR]Tacky"), 200, 0, 0)
			if thisdeltedfires >= #cSetting["fire_positions_"..fireposition] then
				sendMSGForJob( "Das Feuer in "..getZoneName(x, y, z, false)..", "..getZoneName(x, y, z, true).." wurde gelöscht!", "feuerwehrmann", 0, 255, 0)
				sendMSGForFaction( "INFO: Das Feuer in "..getZoneName(x, y, z, false)..", "..getZoneName(x, y, z, true).." wurde gelöscht!", 5, 200, 200, 0)
				setTimer(cFunc["addRandomFire"], 5*1000*60, 1)
				thisdeltedfires = 0
				triggerClientEvent("allfiresdelted", getRootElement())
				rand = 0
			end
		if(cSetting["fire_loescher"][id]) then
		-- outputChatBox("c")
			for index, player in pairs(cSetting["fire_loescher"][id]) do
			-- outputChatBox("d")
				if(isElement(player)) then
				-- outputChatBox("e")	
					cSetting["fire_loescher"][id] = {}
					toggleAllControls ( player, true )
					setControlState ( player, "fire", false )
					setCameraTarget ( player, player )
						deinefeuer = vioGetElementData ( player, "feuer" )
						if deinefeuer < 50 then
							deingehalt = 10
						elseif deinefeuer < 250 then
							deingehalt = 15
						elseif deinefeuer < 700 then
							deingehalt = 20
						elseif deinefeuer < 1500 then
							deingehalt = 25
						elseif deinefeuer < 2500 then
							deingehalt = 30
						elseif deinefeuer < 5000 then
							deingehalt = 35
						elseif deinefeuer < 10000 then
							deingehalt = 45
						elseif deinefeuer < 17500 then
							deingehalt = 55
						elseif deinefeuer < 30000 then
							deingehalt = 70
						elseif deinefeuer < 50000 then
							deingehalt = 85
						else
							deingehalt = 100
						end
					outputChatBox("Feuer gelöscht, du erhälst "..deingehalt.."$!", player, 255, 255, 0)
					vioSetElementData ( player, "feuer", vioGetElementData ( player, "feuer" )+1 )
					triggerClientEvent ( player, "plusfeuer", player, vioGetElementData ( player, "feuer" ) )
					vioSetElementData ( player, "money", vioGetElementData ( player, "money" ) + tonumber(deingehalt) )
					addPlayerXP(player,tonumber(deingehalt)/4))
						if deinefeuer == 50 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Feuerwehrmann befördert.", player, 25, 200, 0 )
						elseif deinefeuer == 250 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Oberfeuerwehrmann befördert.", player, 25, 200, 0 )
						elseif deinefeuer == 700 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Hauptfeuerwehrmann befördert.", player, 25, 200, 0 )
						elseif deinefeuer == 1500 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Löschmeister befördert.", player, 25, 200, 0 )
						elseif deinefeuer == 2500 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Oberlöschmeister befördert.", player, 25, 200, 0 )
						elseif deinefeuer == 5000 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Hauptlöschmeister befördert.", player, 25, 200, 0 )
						elseif deinefeuer == 10000 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Brandmeister befördert.", player, 25, 200, 0 )
						elseif deinefeuer == 17500 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Oberbrandmeister befördert.", player, 25, 200, 0 )
						elseif deinefeuer == 30000 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Hauptbrandmeister befördert.", player, 25, 200, 0 )
						elseif deinefeuer == 50000 then
							outputChatBox("Herzlichen Glückwunsch! Du wurdest so eben zum Brandexperte befördert.", player, 25, 200, 0 )
						end
				end
			end
		end	
		cSetting["fire_loescher"][id] = {}
		cSetting["fire_loescher"][id] = false
	end
end

cFunc["add_player_loescher"] = function(id)
	-- outputChatBox("aaaaaaaaaaa")
	if not(cSetting["fire_loescher"][id]) then
		cSetting["fire_loescher"][id] = {}
		cSetting["fire_loescher"][id]["timer"] = setTimer(cFunc["loesche_feuer"], 5000, 1, id)
		toggleAllControls ( source, false )
		setControlState ( source, "fire", true )
		setCameraTarget ( source, nil )
		-- outputChatBox("bbbbbbbbbb")
		cSetting["fire_loescher"][id][source] = source
	end
end
-- function pos (player)
-- x, y, z = getElementPosition(player)
-- outputChatBox(x..", "..y..", "..z)
-- end
-- addCommandHandler("pos", pos)
rand = 0
cFunc["addRandomFire"] = function()
	fireposition = math.random(1, 15)
	for j = 1, #cSetting["fire_positions_"..fireposition] do
		-- outputChatBox(j.." - "..#cSetting["fire_positions_"..fireposition], source, 0, 200, 0)
		rand = rand + 1
		-- outputChatBox(rand)
		local x, y, z = cSetting["fire_positions_"..fireposition][j][1], cSetting["fire_positions_"..fireposition][j][2], cSetting["fire_positions_"..fireposition][j][3]
		triggerClientEvent("onENRFireCreate", getRootElement(), j, x, y, z)
		cSetting["fire_id"] = cSetting["fire_id"]+1
		_G["killf_"..j] = setTimer(cFunc["loesche_feuer"], 60000*10, 1, j)
		if j == 1 then
			sendMSGForJob( "An alle verfügbaren Einheiten: Feuer in "..getZoneName(x, y, z, false)..", "..getZoneName(x, y, z, true).." gemeldet!", "feuerwehrmann", 255, 0, 0)
			sendMSGForFaction( "INFO: Feuer in "..getZoneName(x, y, z, false)..", "..getZoneName(x, y, z, true).." gemeldet!", 5, 200, 200, 0)
		end
	end
end

-- EVENT HANDLERS --

addEventHandler("doENRFireAddLoescher", getRootElement(), cFunc["add_player_loescher"])

cFunc["addstart"] = function()
	triggerClientEvent("addstart", getRootElement(), cSetting["fire_id"], x, y, z)
end
addEventHandler("addstart", getRootElement(), cFunc["addstart"])

--[[
addCommandHandler("firehere", function(thePlayer)
	local x, y, z = getElementPosition(thePlayer)
	triggerClientEvent("onMTFireCreate", getRootElement(), cSetting["fire_id"], x, y, z)
	
	cSetting["fire_id"] = cSetting["fire_id"]+1
	
	setTimer(cFunc["loesche_feuer"], 10*1000*60, 1, cSetting["fire_id"]-1)
end)]]

setTimer(cFunc["addRandomFire"], 5*1000*60, 1)
-- addCommandHandler("addrandomfire", cFunc["addRandomFire"])

function FireVehicleEnter ( thePlayer, seat, jacked )
    if ( getElementModel ( source ) == 407 or 544 ) then
		toggleControl(thePlayer, "vehicle_fire", false)
		toggleControl(thePlayer, "vehicle_secondary_fire", false)
		-- toggleControl(thePlayer, "fire", false)
		-- outputChatBox("1")
        if ( getElementData ( source, "owner" ) ~= getPlayerName(thePlayer) and seat == 0 ) then
			opticExitVehicle ( thePlayer )
			outputChatBox("Du darfst dieses Fahrzeug nicht fahren.", thePlayer, 200, 0, 0)
		end
        if ( getElementData ( source, "owner" ) == getPlayerName(thePlayer) ) then
			if isTimer(_G["firetimer_"..getPlayerName(thePlayer)]) then killTimer(_G["firetimer_"..getPlayerName(thePlayer)]) end		
		end
    end
end

function FireVehicleExit ( thePlayer, seat, jacked )
    if ( getElementModel ( source ) == 407 or 544 ) then
		toggleControl(thePlayer, "vehicle_fire", true)
		toggleControl(thePlayer, "vehicle_secondary_fire", true)
		-- toggleControl(thePlayer, "fire", true)
		-- outputChatBox("0")
        if ( getElementData ( source, "owner" ) == getPlayerName(thePlayer) ) then
			_G["firetimer_"..getPlayerName(thePlayer)] = setTimer(function ()
				destroyElement(_G["fireveh_"..getPlayerName(thePlayer)])
				outputChatBox("Dein Feuerwehrfahrzeug wurde entfernt.", thePlayer, 200, 0, 0)
			end, 600000, 1 )
		end
    end
end

function FireVehicleDestroy ( )
	if isElement(_G["fireveh_"..getPlayerName(source)]) then destroyElement(_G["fireveh_"..getPlayerName(source)]) end
	if isTimer(_G["firetimer_"..getPlayerName(source)]) then killTimer(_G["firetimer_"..getPlayerName(source)]) end
end

function FireVehicleDestroy2 ( player )
	destroyElement(_G["fireveh_"..getPlayerName(player)])
	if isTimer(_G["firetimer_"..getPlayerName(player)]) then killTimer(_G["firetimer_"..getPlayerName(player)]) end
	triggerClientEvent ( player, "infobox_start", getRootElement(), "\n\nDu hast dein\nFahrzeug respawnt!", 5000, 0, 255, 0 )
end
addEvent("FireVehicleDestroy", true)
addEventHandler("FireVehicleDestroy", getRootElement(), FireVehicleDestroy2)

function FireVehicleLock ( player )
	local veh = _G["fireveh_"..getPlayerName(player)]
	if isVehicleLocked ( veh ) then
		setVehicleLocked ( veh, false )
		outputChatBox ( "Fahrzeug Aufgeschlossen!", player, 0, 0, 255 )
	elseif not isVehicleLocked ( veh ) then
		setVehicleLocked ( veh, true )
		outputChatBox ( "Fahrzeug Abgeschlossen!", player, 0, 0, 255 )
	end
end
addEvent("FireVehicleLock", true)
addEventHandler("FireVehicleLock", getRootElement(), FireVehicleLock)

function giveFireVeh_func ( player, vehid )
	if isElement(_G["fireveh_"..getPlayerName(player)]) then
		destroyElement(_G["fireveh_"..getPlayerName(player)])
	end
	-- local x, y, z = getElementPosition ( player )
	-- -2021.6999511719, 92.900001525879, 28.39999961853, 0, 0, 270
	-- -2022.1999511719, 75.400001525879, 28.39999961853, 0, 0, 270
	if math.random (99,100) == 99 then
		_G["fireveh_"..getPlayerName(player)] = createVehicle ( vehid, -2021.6999511719, 92.900001525879, 28.39999961853, 0, 0, 270 )
	else
		_G["fireveh_"..getPlayerName(player)] = createVehicle ( vehid, -2022.1999511719, 75.400001525879, 28.39999961853, 0, 0, 270 )
	end
	-- vioSetElementData ( _G["fireveh_"..getPlayerName(player)], "owner", getPlayerName(player) )
	outputChatBox ( "Dieses Fahrzeug gehört vorübergehend dir!", player, 0, 50, 200 )
	toggleControl(player, "vehicle_fire", false)
	toggleControl(player, "vehicle_secondary_fire", false)
	warpPedIntoVehicle(player, _G["fireveh_"..getPlayerName(player)])
	setElementData ( _G["fireveh_"..getPlayerName(player)], "owner", getPlayerName(player) )
	addEventHandler ( "onVehicleEnter", _G["fireveh_"..getPlayerName(player)], FireVehicleEnter )
	addEventHandler ( "onVehicleExit", _G["fireveh_"..getPlayerName(player)], FireVehicleExit )
	addEventHandler ( "onPlayerQuit", player, FireVehicleDestroy )
	if isTimer(_G["firetimer_"..getPlayerName(player)]) then killTimer(_G["firetimer_"..getPlayerName(player)]) end		
end
addEvent("giveFireVeh", true)
addEventHandler("giveFireVeh", getRootElement(), giveFireVeh_func)


function setfirefighter ( player, skinid )
	if vioGetElementData ( player, "job" ) ~= "feuerwehrmann" then
		vioSetElementData ( player, "job", "feuerwehrmann" )
		triggerClientEvent ( player, "infobox_start", getRootElement(), "Du bist nun\nFeuerwehrmann!", 7500, 0, 125, 0 )
		outputChatBox ( "Mit /quitjob kannst du den Job wieder kündigen!", player, 0, 200, 0 )
		outputChatBox ( "Mit 'Q' oder 'E' kannst du zu deinem Feuerlöscher wechseln.", player, 0, 200, 0 )
	end
	takeWeapon (player, 42)
	giveWeapon ( player, 42, 10500 )
	setfirefighterskin(player, skinid)
	vioSetElementData ( player, "fskin", skinid )
end
addEvent("setfirefighter", true)
addEventHandler("setfirefighter", getRootElement(), setfirefighter)


function setfirefighterskin ( player, skinid )
	setPedSkin(player, skinid)
end
addEvent("setfirefighterskin", true)
addEventHandler("setfirefighterskin", getRootElement(), setfirefighterskin)
