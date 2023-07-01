inGreenzone = false
inNoDMZone = inGreenzone
hud = "on" -- /debug

function renderGreenzoneInfo ()
    if hud == "off" then
        paddingY = -280
    else
        paddingY = 0
    end
    if inGreenzone then
        dxDrawRectangle(2131, 283 + paddingY, 419, 61, tocolor(123, 0, 0, 228), false)
        dxDrawText("Du befindest dich in einer Greenzone.\nDeathmatch ist absolut untersagt.", 2224, 293 + paddingY, 2494, 328, tocolor(255, 255, 255, 255), 1.20, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawImage(2141, 283 + paddingY, 73, 59, ":grs_tests/greenzone/prohibited.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
    end
end
addEventHandler("onClientRender", root, renderGreenzoneInfo)