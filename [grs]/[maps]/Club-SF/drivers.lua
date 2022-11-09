function drivers ( )
   ped1 = createPed ( 59, -1489.5366210938, 806.46960449219, 10.859927177429 )
   setPedRotation ( ped1, 0 )
setPedAnimation ( ped1, "dancing", "dnce_m_a", -1, true, false, false )
setTimer ( setPedAnimation, 1500, 0, ped1, "dancing", "dnce_m_a", -1, true, false, false )
end
addEventHandler ( "onResourceStart", resourceRoot, drivers )