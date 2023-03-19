
local vehicle = nil
local pilot = false
local acceptedvehicle = false

local acceptedvehs = {
    "modelx",
    "models",
    "model3"
}

RegisterCommand("w_autopilot", function()
    acceptedvehicle = false
    ClearPedTasks(GetPlayerPed(-1))
    pilot = true
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        for k,v in pairs(acceptedvehs) do
            if(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)) == v) then
                acceptedvehicle = true
            end
        end
        if acceptedvehicle then
            if pilot then
                if IsWaypointActive() then
                    local coord = GetBlipCoords(GetFirstBlipInfoId(8))
                    TaskVehicleDriveToCoord(GetPlayerPed(-1),vehicle,coord.x, coord.y, 0.0,100.0,1.0,GetHashKey(vehicle),786603,1.0,1)
                    while pilot do
                        Wait(1)
                        local PlayerPos = GetEntityCoords(PlayerPedId())
                        if GetDistanceBetweenCoords(PlayerPos, coord.x,coord.y, false) <= 15 then
                            exports['mythic_notify']:DoLongHudText('inform', "Your car has arrived. Autopilot has been turned off!", { ['background-color'] = '#00A300', ['color'] = '#ffffff' })
                            ClearPedTasks(GetPlayerPed(-1))
                            pilot = false
                        end
                    end
                else
                    exports['mythic_notify']:DoLongHudText('inform', "No Waypoint Selected!", { ['background-color'] = '#ff0000', ['color'] = '#ffffff' })
                end
            end
        else
            exports['mythic_notify']:DoLongHudText('inform', "Your vehicle dosen't support Autopilot!", { ['background-color'] = '#ff0000', ['color'] = '#ffffff' })
        end
    end
end)