setDevelopmentMode(true)

function sound (x,y,z)
    playSound3D(":reallife_server/neues/comfortAccess/carlock.mp3", x,y,z)
end
addEvent( "sound", true )
addEventHandler( "sound", localPlayer, sound )