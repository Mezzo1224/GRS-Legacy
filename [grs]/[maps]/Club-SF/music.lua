--[[local streamURL = "http://streamer.psyradio.org:8030/listen.pls"
function onResourceStart()
	
sound = playSound3D(streamURL, -2659.7136230469, 1410.1876220703, 91017034912109, true)

end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onResourceStart)]]--

DiscoSF = playSound3D("http://streamer.psyradio.org:8030/listen.pls", -1497.7510986328, 805.13781738281, 10.859927177429, true)
setSoundMaxDistance(DiscoSF, 13)
setSoundMinDistance(DiscoSF, 1)
setSoundVolume(DiscoSF , 100)


DiscoSF1 = playSound3D("http://streamer.psyradio.org:8030/listen.pls", -1510.3123779297, 804.69390869141, 7.18531, true)
setSoundMaxDistance(DiscoSF1, 13)
setSoundMinDistance(DiscoSF1, 0)
setSoundVolume(DiscoSF1 , 50)
setSoundEffectEnabled(DiscoSF1,"i3dl2reverb",true)