local level = 2

AddEventHandler('onClientMapStart', function()
	level = 2
	NetworkSetTalkerProximity(5.0)
end)

function ShowNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString("L'intensité de votre voix a été réglée sur " .. text .. ".")
	DrawNotification(true, false)
end

local pressed = false
local once = true
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if once then
			once = false
			NetworkSetVoiceActive(1)
		end

		while IsControlPressed(1, 288) and pressed do
			Wait(10)
		end
		if IsControlPressed(1, 288) and not pressed then
			pressed = true
			level = level + 1
			if level > 3 then
				level = 1
			end
			if level == 1 then
				NetworkSetTalkerProximity(3.0)
				ShowNotif("~b~très basse~w~")
			elseif level == 2 then
				NetworkSetTalkerProximity(5.0)
				ShowNotif("~g~normale~w~")
			elseif level == 3 then
				NetworkSetTalkerProximity(12.0)
				ShowNotif("~o~très élevée~w~")
			end
			Wait(200)
		elseif not IsControlPressed(1, 288) and pressed then
			pressed = false
		end
	end
end)

-- by Garfieldouille#0001