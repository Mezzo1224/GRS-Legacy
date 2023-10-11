
optionsUI = {}

function showPlayerOptionsUI ()
    local gameIcon, keybindsIcon, accountIcon  = dxCreateTexture(":grs_tests/playerOptions/game.png"), dxCreateTexture(":grs_tests/playerOptions/keyboard.png"), dxCreateTexture(":grs_tests/playerOptions/account.png")

    DGS:dgsSetInputEnabled ( true )
    DGS:dgsSetInputMode( "no_binds_when_editing" )

    optionsUI["window"] = DGS:dgsCreateWindow(0.37, 0.11, 0.25, 0.29, "Login", true)
    DGS:dgsCenterElement(optionsUI["window"], false, true) 
    DGS:dgsWindowSetSizable(optionsUI["window"], false)
    DGS:dgsWindowSetMovable(optionsUI["window"], false)
    DGS:dgsSetProperty(optionsUI["window"],"ignoreTitle", true)
    DGS:dgsWindowSetCloseButtonEnabled(optionsUI["window"], false)
    DGS:dgsSetProperty(optionsUI["window"],"ignoreTitle", true)

    optionsUI["tabpanel"] = DGS:dgsCreateTabPanel(0.02, 0.07, 0.97, 0.90, true, optionsUI["window"])
    DGS:dgsSetProperty(optionsUI["tabpanel"],"tabAlignment","center")
    DGS: dgsSetProperty(optionsUI["tabpanel"],"tabHeight",{0.35,true})

    optionsUI["tabpanel_game"] = DGS:dgsCreateTab("Spiel", optionsUI["tabpanel"])
    DGS:dgsSetProperty( optionsUI["tabpanel_game"],"tabImage",{gameIcon,gameIcon,gameIcon})
    DGS:dgsSetProperty(optionsUI["tabpanel_game"],"width",157)
end
--showPlayerOptionsUI ()