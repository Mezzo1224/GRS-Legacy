-- // Utility
local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil

local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end

local start
local animTime
local tempPos = {{},{}}
local tempPos2 = {{},{}}

local function camRender()
	local now = getTickCount()
	if (sm.moov == 1) then
		local x1, y1, z1 = interpolateBetween(tempPos[1][1], tempPos[1][2], tempPos[1][3], tempPos2[1][1], tempPos2[1][2], tempPos2[1][3], (now-start)/animTime, "InOutQuad")
		local x2,y2,z2 = interpolateBetween(tempPos[2][1], tempPos[2][2], tempPos[2][3], tempPos2[2][1], tempPos2[2][2], tempPos2[2][3], (now-start)/animTime, "InOutQuad")
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	else
		removeEventHandler("onClientRender",root,camRender)
	end
end

function cancelCameraRender ()
    if (sm.moov == 1) then
        removeEventHandler("onClientRender",root,camRender)
    end
end

function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if(sm.moov == 1) then
		killTimer(timer1)
		removeEventHandler("onClientRender",root,camRender)
	end
	sm.moov = 1
	timer1 = setTimer(removeCamHandler,time,1)
	start = getTickCount()
	animTime = time
	tempPos[1] = {x1,y1,z1}
	tempPos[2] = {x1t,y1t,z1t}
	tempPos2[1] = {x2,y2,z2}
	tempPos2[2] = {x2t,y2t,z2t}
	addEventHandler("onClientRender",root,camRender)
	return true
end

-- // Kamera
local cameraFlight = {
    [1] = { -- // San Fierro
        [1] = {
            startCoords = {-2398.396484375, -568.46929931641, 143.08219909668, -2398.1877441406, -567.52514648438, 142.82723999023},
            endCoords = {-2012.3082275391, -200.66299438477, 72.391700744629, -2012.2220458984, -199.66893005371, 72.325340270996},
            movementTime = 10000,
        },
        [2] = {
            startCoords = {-2012.3082275391, -200.66299438477, 72.391700744629, -2012.2220458984, -199.66893005371, 72.325340270996},
            endCoords = {-1974.2202148438, 221.47540283203, 50.25659942627, -1974.6843261719, 220.61291503906, 50.054866790771},
            movementTime = 10000,
        },
        [3] = {
            startCoords = {-1974.2202148438, 221.47540283203, 50.25659942627, -1974.6843261719, 220.61291503906, 50.054866790771},
            endCoords = {-2212.5297851562, 302.35739135742, 64.75479888916, -2213.4770507812, 302.67437744141, 64.71028137207},
            movementTime = 10000,
        },
    }, 
    [2] = { -- // Los Santos
        [1] = {
            startCoords = {2165.5710449219, -2552.1447753906, 50.175998687744, 2164.5776367188, -2552.0385742188, 50.13148117065},
            endCoords = {2105.833984375, -1892.2459716797, 67.290000915527, 2105.7326660156, -1891.2629394531, 67.136703491211},
            movementTime = 10000,
        },
        [2] = {
            startCoords = nil,
            endCoords = { 2271.9338378906, -1535.8367919922, 75.008399963379, 2272.2687988281, -1534.9810791016, 74.613952636719},
            movementTime = 10000,
        },
        [3] = {
            startCoords = nil,
            endCoords = {2420.3369140625, -1653.1159667969, 50.896598815918, 2421.1982421875, -1653.2877197266, 50.418544769287},
            movementTime = 10000,
        },
    },
    [3] = { -- // Las Venturas
        [1] = {
            startCoords = {2499.2395019531, 1405.0258789062, 56.267601013184, 2498.4240722656, 1404.4581298828, 56.380104064941},
            endCoords = { 2096.2338867188, 1285.7841796875, 82.399299621582, 2096.2329101562, 1285.6970214844, 81.403106689453},
            movementTime = 10000,
        },
        [2] = {
            startCoords = nil,
            endCoords = { 2052.3989257812, 1512.3072509766, 43.272701263428, 2051.8210449219, 1513.0373535156, 42.907943725586},
            movementTime = 10000,
        },
        [3] = {
            startCoords = nil,
            endCoords = { 2133.3200683594, 1746.1309814453, 35.625598907471, 2133.4575195312, 1747.1076660156, 35.460792541504},
            movementTime = 10000,
        }
    }
}


local currentTimer = nil
local currentIndex = 1 
local function startCameraFlight()
    local randomCameraflight = math.random(1,3)
    if currentIndex <= #cameraFlight[randomCameraflight] then
        local currentEntry = cameraFlight[randomCameraflight][currentIndex]
       -- Start-Koordinaten
       local startX, startY, startZ, startX2, startY2, startZ2
       if currentIndex == 1 then
           startX, startY, startZ = currentEntry.startCoords[1], currentEntry.startCoords[2], currentEntry.startCoords[3]
           setCameraMatrix(startX, startY, startZ, startX2, startY2, startZ2)
           startX2, startY2, startZ2 = currentEntry.startCoords[4], currentEntry.startCoords[5], currentEntry.startCoords[6]
       else
           -- Verwenden Sie die "endCoords" des vorherigen Eintrags als "startCoords"
           local previousEntry = cameraFlight[randomCameraflight][currentIndex - 1]
           startX, startY, startZ = previousEntry.endCoords[1], previousEntry.endCoords[2], previousEntry.endCoords[3]
           startX2, startY2, startZ2 = previousEntry.endCoords[4], previousEntry.endCoords[5], previousEntry.endCoords[6]
       end

       -- End-Koordinaten
       local endX, endY, endZ, endX2, endY2, endZ2 = currentEntry.endCoords[1], currentEntry.endCoords[2], currentEntry.endCoords[3], currentEntry.endCoords[4], currentEntry.endCoords[5], currentEntry.endCoords[6]
        
        smoothMoveCamera ( startX, startY, startZ, startX2, startY2, startZ2, endX, endY, endZ, endX2, endY2, endZ2, currentEntry.movementTime )
        
        -- Erstellen Sie einen Timer basierend auf movementTime und rufen Sie startCameraFlight für den nächsten Eintrag auf
        currentTimer = setTimer(startCameraFlight, currentEntry.movementTime, 1)
        
        currentIndex = currentIndex + 1 -- Zum nächsten Eintrag in der Tabelle gehen
    else
        -- Alle Kamerabewegungen sind abgeschlossen --> Wechsel zur Nächsten Einstellung
        fadeCamera(false)
        setTimer ( function()
            fadeCamera(true)
            currentIndex = 1
            startCameraFlight()
        end, 3000, 1 )
    end
end

-- Funktion, um die Kamerabewegung abzubrechen
function cancelCameraFlight()
    if currentTimer and isTimer(currentTimer) then
        killTimer(currentTimer)
        cancelCameraRender ()
        setCameraTarget(getLocalPlayer())
    end
end




function intCam()
    startCameraFlight()
    setPlayerHudComponentVisible("ammo", false)
    setPlayerHudComponentVisible("health", false)
    setPlayerHudComponentVisible("clock", false)
    setPlayerHudComponentVisible("money", false)
    setPlayerHudComponentVisible("wanted", false)
    setPlayerHudComponentVisible("weapon", false)
    setPlayerHudComponentVisible("radar", false)
    showChat(false)
end
