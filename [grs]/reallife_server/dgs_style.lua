-- // Es gibt bei DGS ein Style System, ich benutze jedoch in dieser Client Datei OnDgsCreate um bei jeder Erstellung
-- // eines Elements bestimmte Einstellungen vorzunehmen


local windowColor = tocolor(19, 96, 173, 240)
local colummColor = tocolor(14, 103, 158, 255)



function createDgsElement ()
    local type = DGS:dgsGetType(source)
    if type == "dgs-dxwindow" then
        DGS:dgsSetProperty(source,"titleColor", windowColor )
        DGS:dgsFocus(source)
    elseif type == "dgs-dxlabel" then
        -- DGS:dgsSetProperty(source,"wordbreak", true)
    elseif type == "dgs-dxgridlist" then
        DGS:dgsSetProperty(source,"columnColor",colummColor)
    end
end
addEventHandler("onDgsCreate",getRootElement(),createDgsElement)


