



function SubmitRegisterBtn(button)
	
	if button == "left" and source == regButton then
		local pname = getPlayerName ( lp )
		local passwort = DGS:dgsGetText( pw )
		local pwlaenge = #passwort
		local email = DGS:dgsGetText( email )
		local bonuscode =  DGS:dgsGetText( bonus )
		local werbender = DGS:dgsGetText( werber )
					
					
		
		if  DGS:dgsGetText( pwAgain ) ~= passwort then
			outputChatBox ( "Die beiden Passwoerter stimmen nicht ueberein!", 125, 0, 0 )
		elseif pwlaenge < 6 or passwort == "******" or passwort == pname or passwort == "123456" then
			outputChatBox ("Fehler: Ungueltiges Passwort", 255, 0 ,0 )
		else
			local birth_correct = 0
			bday = tonumber( DGS:dgsGetText( registerDay ))
			bmon = tonumber( DGS:dgsGetText( registerMonth ))
			byear = tonumber( DGS:dgsGetText( registerYear ))
			if math.floor(bday) == bday and math.floor(bmon) == bmon and byear == math.floor (byear) then
				if bday < 32 and  bday > 0 and byear < 2009 and byear > 1900 and bmon < 13 and bmon > 0 then
					if bday < 29 then
						birth_correct = 1
					elseif (bday == 29 or bday == 30) and bmon ~= 2 then
						birth_correct = 1
					elseif bday == 31 and ( bmon == 1 or bmon == 3 or bmon == 5 or bmon == 7 or bmon == 8 or bmon == 10 or bmon == 12 ) then
						birth_correct = 1
					elseif bday == 29 and bmony == 2 and math.floor((byear/4)) == byear/4 then
						birth_correct = 1
					end
				else
					birth_correct = 0
				end
			else
				birth_correct = 0
			end
			if birth_correct == 1 then
				if DGS:dgsRadioButtonGetSelected(weib) == true then
					geschlecht = 0
				elseif DGS:dgsRadioButtonGetSelected(oberbanga) == true then
					geschlecht = 1
				end
				player = lp
				stopSound (joinmusik)
				triggerServerEvent ( "register", lp, player, hash ( "sha512", passwort ), bday, bmon, byear, geschlecht,bonuscode,email,werbender)
				DGS:dgsCloseWindow(register)
				findSettings ()
				killTimer(pwTimer)
				showChat(false)
			else
				outputChatBox ("Fehler: Ungueltiges Geburtsdatum!", 255, 0 , 0 )
			end
		end
	end
end
 





 
function showRegisterGui_func ()
		showCursor(true)
		register = DGS:dgsCreateWindow(0.35, 0.37, 0.27, 0.25,"Registrieren",true, nil,nil,nil,nil,nil,nil,nil, true)
		DGS:dgsWindowSetSizable(register,false)
		DGS:dgsWindowSetMovable(register,false)
		tabmenu = DGS:dgsCreateTabPanel(0.02, 0.02, 0.96, 0.88,true, register)
		acc = DGS:dgsCreateTab("Account erstellen",tabmenu)
		opt = DGS:dgsCreateTab("Optionales",tabmenu)
		reg = DGS:dgsCreateTab("Registrieren",tabmenu)
		DGS:dgsCreateLabel(0.03, 0.02, 0.12, 0.13, "Name",true,acc)
		DGS:dgsCreateLabel(0.03, 0.17, 0.29, 0.13, getPlayerName(getLocalPlayer()),true,acc)
		DGS:dgsCreateLabel(0.03, 0.35, 0.15, 0.13, "Passwort",true,acc)
		pw = DGS:dgsCreateEdit( 0.03, 0.53, 0.29, 0.13, "", true, acc )
		DGS:dgsSetProperty(pw,"masked",true) 
		DGS:dgsCreateLabel(0.38, 0.02, 0.37, 0.13, "Geburtstag (tt/mm/jjjj)",true,acc)
		registerDay = DGS:dgsCreateEdit( 0.38, 0.17, 0.09, 0.13, "", true, acc )
		registerMonth = DGS:dgsCreateEdit( 0.51, 0.17, 0.09, 0.13, "", true, acc )
		registerYear = DGS:dgsCreateEdit( 0.65, 0.17, 0.11, 0.13, "", true, acc )
		DGS:dgsCreateLabel(0.38, 0.35, 0.37, 0.13, "Geschlecht",true,acc)
		weib = DGS:dgsCreateRadioButton(0.38, 0.52, 0.23, 0.14, "Weiblich",true, acc)
		oberbanga  = DGS:dgsCreateRadioButton(0.65, 0.52, 0.23, 0.14, "Männlich",true, acc)
		DGS:dgsRadioButtonSetSelected(weib, true)
		DGS:dgsEditSetMaxLength(registerDay,2)
		DGS:dgsEditSetMaxLength(registerMonth,2)
		DGS:dgsEditSetMaxLength(registerYear,4)
		pwSafety = DGS:dgsCreateProgressBar(0.03, 0.77, 0.29, 0.18, true, acc)
		-- Optionales
		DGS:dgsCreateLabel(0.02, 0.05, 0.17, 0.13, "Bonuscode",true,opt)
		DGS:dgsCreateLabel(0.02, 0.33, 0.50, 0.52, "Ein Bonuscode kannst du im Forum\nfinden oder von anderen Usern\nerhalten. Ein Bonuscode gibt\ndir beim erstellen deines Accounts \nextra Geld.",true,opt)
		bonus = DGS:dgsCreateEdit(0.02, 0.18, 0.28, 0.13, "", true, opt )
		
		DGS:dgsCreateLabel(0.62, 0.05, 0.17, 0.13, "E-Mail", true,opt)
		email = DGS:dgsCreateEdit( 0.62, 0.18, 0.28, 0.13, "", true, opt )
		
		DGS:dgsCreateLabel(0.62, 0.33, 0.17, 0.13, "Werber",true,opt)
		werber = DGS:dgsCreateEdit(0.62, 0.49, 0.28, 0.13, "", true, opt )
		
		DGS:dgsCreateLabel(0.02, 0.05, 0.65, 0.34, "Überprüfe deine Daten und gebe dein Passwort\nnochmal ein.",true,reg)
		DGS:dgsCreateLabel(0.02, 0.43, 0.35, 0.14, "Passwort Wiederholung",true,reg)
		pwAgain = DGS:dgsCreateEdit(0.02, 0.62, 0.35, 0.13, "", true, reg )
		regButton = DGS:dgsCreateButton(0.07, 0.79, 0.5, 0.17, "Registrierung abschließen", true, reg, nil, nil, nil, nil, nil, nil, tocolor(1,223,1), tocolor(4,170,4), tocolor(4,170,4) )
		setTimer(checkPWSafety,250,1 )
		DGS:dgsSetProperty(pwAgain,"masked",true) 
		addEventHandler ( "onDgsMouseClick", regButton, SubmitRegisterBtn, true )
		





end
addEvent ( "ShowRegisterGui", true)
addEventHandler ( "ShowRegisterGui", getRootElement(), showRegisterGui_func )



	
function checkPWSafety ()

--	if guiGetVisible ( GUIEditor.window[1] ) then
		local pw = tostring ( DGS:dgsGetText( pw ) )
		safety = # pw
		if safety >= 10 then
			safety = 50
		elseif safety >= 7 then
			safety = 30
		else
			safety = 10
		end
		if tonumber ( pw ) then	
			safety = safety
		else
			safety = safety + 25
		end
		if pw ~= "123456" then
			safety = safety + 25
		end
		if # pw < 6 then
			safety = 0
		end
		DGS:dgsProgressBarSetProgress(pwSafety, safety)
		
		pwTimer = setTimer ( checkPWSafety, 250, 1 )
--	end
end

function GUI_DisableRegisterGui()

-- 	cancelCameraIntro ()
	destroyElement ( GUIEditor.window[1] )
	showCursor ( false )
	
end
addEvent ( "DisableRegisterGui", true )
addEventHandler ( "DisableRegisterGui", getRootElement(), GUI_DisableRegisterGui)

function showBeginGui_func ()

	gWindow["welcomeInfo"] = guiCreateWindow(507,285,445,266,"Fast geschafft!",false)
	guiSetAlpha(gWindow["welcomeInfo"],1)
	gLabel["anfangsText"] = guiCreateLabel(0.0225,0.0789,0.9303,0.3083,"Das Tutorial ist nun beendet!\nNun waere es angebracht, sich im Hilfemenue ( Kurztaste: F1 ) erst einmal\nueber die Serverregeln und anfaenglichen Schritte zu informieren.\n\nViel Spass auf "..SharedConfig["main"].serverName.."!",true,gWindow["welcomeInfo"])
	guiSetAlpha(gLabel["anfangsText"],1)
	guiLabelSetColor(gLabel["anfangsText"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["anfangsText"],"top")
	guiLabelSetHorizontalAlign(gLabel["anfangsText"],"left",false)
	guiSetFont(gLabel["anfangsText"],"default-bold-small")
	gButton["HelmenueOpen"] = guiCreateButton(0.0225,0.406,0.2292,0.1466,"Hilfemenue aufrufen",true,gWindow["welcomeInfo"])
	guiSetAlpha(gButton["HelmenueOpen"],1)
	gButton["closeAnfangsWindow"] = guiCreateButton(0.2674,0.406,0.2292,0.1466,"Fenster\nschliessen",true,gWindow["welcomeInfo"])
	guiSetAlpha(gButton["closeAnfangsWindow"],1)
	gLabel["anfangsPS"] = guiCreateLabel(0.0225,0.609,0.9618,0.1391,"P.S.: Vergiss nicht, auch in unserem Forum vorbei zu schauen - dort erwarten\ndich zahlreiche Events und Informationen!",true,gWindow["welcomeInfo"])
	guiSetAlpha(gLabel["anfangsPS"],1)
	guiLabelSetColor(gLabel["anfangsPS"],255,255,255)
	guiLabelSetVerticalAlign(gLabel["anfangsPS"],"top")
	guiLabelSetHorizontalAlign(gLabel["anfangsPS"],"left",false)
	guiSetFont(gLabel["anfangsPS"],"default-bold-small")
	gLabel["anfangsAdresse"] = guiCreateLabel(0.1011,0.7707,1,0.1729,forumURL,true,gWindow["welcomeInfo"])
	guiSetAlpha(gLabel["anfangsAdresse"],1)
	guiLabelSetColor(gLabel["anfangsAdresse"],200,200,000)
	guiLabelSetVerticalAlign(gLabel["anfangsAdresse"],"top")
	guiLabelSetHorizontalAlign(gLabel["anfangsAdresse"],"left",false)
	guiSetFont(gLabel["anfangsAdresse"],"sa-header")
	addEventHandler("onClientGUIClick", gButton["HelmenueOpen"], SubmitOpenHelpMenueBtn, false)
	addEventHandler("onClientGUIClick", gButton["closeAnfangsWindow"], SubmitCloseThisWindowBtn, false)
end
addEvent ( "showBeginGui", true )
addEventHandler ( "showBeginGui", getRootElement(), showBeginGui_func )

function SubmitCloseThisWindowBtn ()

	guiSetVisible ( gWindow["welcomeInfo"], false )
	showCursor(false)
	triggerServerEvent ( "cancel_gui_server", lp )
end
function SubmitOpenHelpMenueBtn ()

	guiSetVisible ( gWindow["welcomeInfo"], false )
	_CreateHelpmenueGui()
end

-- // Betafenster

function showBetaWindow ()
	showCursor(true)
	setElementClicked(true)
	showChat(false)
	local x, y = guiGetScreenSize()
	local sx, sy = x/2560, y/1440
	betawindow = DGS:dgsCreateWindow(1026*sx, 615*sy, 508*sx, 211*sy, "Betakey", false)
	DGS:dgsWindowSetCloseButtonEnabled(betawindow, false)
	DGS:dgsWindowSetSizable(betawindow,false)
    DGS:dgsWindowSetMovable(betawindow,false)
	DGS:dgsCreateLabel(103*sx, 9*sy, 303*sx, 46*sy, "Um auf den Server zu spielen, gebe deinen Betakey ein.\n\nMelde dich bei Discord für einen Key: Mezzo#0187", false, betawindow )
	local k1 = DGS:dgsCreateEdit(68*sx, 82*sy, 104*sx, 40*sy, "", false, betawindow)
	local k2 = DGS:dgsCreateEdit(202*sx, 82*sy, 104*sx, 40*sy, "", false, betawindow)
	local k3 = DGS:dgsCreateEdit(338*sx, 82*sy, 104*sx, 40*sy, "", false, betawindow)
	DGS:dgsSetProperty(k1,"maxLength",5)
	DGS:dgsSetProperty(k2,"maxLength",5)
	DGS:dgsSetProperty(k3,"maxLength",5)
	DGS:dgsCreateLabel(185*sx, 92*sy, 17*sx, 31*sy, "-", false, betawindow )
	DGS:dgsCreateLabel(316*sx, 92*sy, 17*sx, 31*sy, "-", false, betawindow )

	sendBetaKeyBtn = DGS:dgsCreateButton(188*sx, 140*sy, 128*sx, 40*sy, "Bestätigen", false, betawindow)  
	
	addEventHandler( "onDgsMouseClick", sendBetaKeyBtn, 
	function(button, state, x, y)
		if button == 'left' and state == 'up' and source == sendBetaKeyBtn then
				local k1t, k2t, k3t = DGS:dgsGetText(k1),DGS:dgsGetText(k2) ,DGS:dgsGetText(k3)
				local betakey = k1t.."-"..k2t.."-"..k3t
				if string.len(k1t) == 5 and string.len(k2t) == 5 and string.len(k3t) == 5  then
					triggerServerEvent("submitBetaKey", getLocalPlayer(), betakey)
				else
					infobox_start_func ( "Key ungültig.", 7500, 125, 0, 0 )
				end
			end
	end)


end
addEvent ( "showBetaWindow", true)
addEventHandler ( "showBetaWindow", getRootElement(), showBetaWindow )
