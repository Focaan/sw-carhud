local inVehicle = false
local hudon = false

Citizen.CreateThread(function()
    while true do
        local wait = 350
        Citizen.Wait(wait)

        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local isInVehicle = IsPedInAnyVehicle(playerPed, false)
        local isPauseMenuActive = IsPauseMenuActive() 
        local isBigMapActive = IsBigmapActive()

        if isInVehicle and not isPauseMenuActive and not isBigMapActive then
            if not inVehicle then
                inVehicle = true
                hudon = true
                if hudStatus ~= "on" then
                    SendNUIMessage({ type = "carHudUpdate", show = true, mapLoc = getMapLoc() })
                end
            end

            local speed = GetEntitySpeed(vehicle) * 2.23694 
            local fuel = GetVehicleFuelLevel(vehicle)

            SendNUIMessage({
                type = "carHudUpdate",
                fuel = fuel,
                speed = math.floor(speed),
                mapLoc = getMapLoc()
            })
        else
            if inVehicle then
                inVehicle = false
                hudon = false
                SendNUIMessage({ type = "leaveCar" })
            end
            wait = 1500
        end
    end
end)
