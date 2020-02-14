local vocalLevel = 2

AddEventHandler('onClientMapStart', function()
	vocalLevel = 2
	NetworkSetTalkerProximity(5.001)
end)

function ShowNotif(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString("L'intensité de votre voix a été réglée sur " .. text .. ".")
	DrawNotification(true, false)
end



local keyPressed = false
local once = true
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if once then
			once = false
			NetworkSetVoiceActive(1)
		end

		while IsControlPressed(1, 288) and keyPressed do
			Wait(10)
		end
		if IsControlPressed(1, 288) and not keyPressed then
			keyPressed = true
			vocalLevel = vocalLevel + 1
			if vocalLevel > 3 then
				vocalLevel = 1
			end
			if vocalLevel == 1 then
				NetworkSetTalkerProximity(3.001)
				ShowNotif("~b~très basse~w~")
			elseif vocalLevel == 2 then
				NetworkSetTalkerProximity(5.001)
				ShowNotif("~g~normale~w~")
			elseif vocalLevel == 3 then
				NetworkSetTalkerProximity(12.091)
				ShowNotif("~o~très élevée~w~")
			end
			Wait(200)
		elseif not IsControlPressed(1, 288) and keyPressed then
			keyPressed = false
		end
	end
end)