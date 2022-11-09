pedSkin = {}
-- // MODEL, txdFile, dffFile
pedSkin[1] = { 285,"swat.txd", "swat.dff"  } 


-- // Pedskins laden
for i, value in pairs(pedSkin) do
    local model, txdFile, dffFile = pedSkin[i][1],  pedSkin[i][2],  pedSkin[i][3]
    local txd = engineLoadTXD ( "pedSkins/"..txdFile )
    engineImportTXD ( txd, model )
    local dff = engineLoadDFF (  "pedSkins/"..dffFile, model )
    engineReplaceModel ( dff, model )

end