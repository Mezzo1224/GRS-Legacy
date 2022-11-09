local gate = createObject(980,-2770.3999023438,1276,8.1999998092651,0,0,5.99853515625)
local gate_status = "zu"

function open_gate_func (player)
	local spielername = getPlayerName(player)
    if spielername == "Bonus" then
        if getDistanceBetweenPoints3D (-2770.3999023438,1276,8.1999998092651, getElementPosition ( player ) ) < 17 then
	        if gate_status == "zu" then
		        moveObject(gate, 1500, -2770.3999023438,1276,2.4000000953674)
				gate_status = "offen"
			elseif gate_status == "offen" then
			    moveObject(gate, 1500, -2770.3999023438,1276,8.1999998092651)
				gate_status = "zu"
			end
		end
	end
end
addCommandHandler("mv", open_gate_func)