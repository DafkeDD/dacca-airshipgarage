local QBCore = exports['qb-core']:GetCoreObject()
local PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)


RegisterNetEvent('dacca:garage')
AddEventHandler('dacca:garage', function(pd)
    local vehicle = pd.vehicle
    local coords = { ['x'] = 448.54, ['y'] = -981.2, ['z'] = 43.69, ['h'] = 87.88 }
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        -- SetVehicleNumberPlateText(veh, "ZULU"..tostring(math.random(1000, 9999)))
        SetVehicleNumberPlateText(vehicle, plate)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        SetEntityHeading(veh, coords.h)
        TaskWarpPedIntoVehicle(GetPlayerPed(-1), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        SetVehicleModColor_1(veh, 1, 1)
    end, coords, true)
end)

RegisterNetEvent('dacca:storecar')
AddEventHandler('dacca:storecar', function()

    QBCore.Functions.Notify('Vehicle Stored!')
    local car = GetVehiclePedIsIn(PlayerPedId(),true)
    DeleteVehicle(car)
    DeleteEntity(car)
end)


RegisterNetEvent('police:client:menu', function(vehName)
            local myMenu = {
                {
                    id = 1,
                    header = 'police garage',
                    txt = ''
                },
                {
                    id = 2,
                    header = "< take",
                    txt = "police air ship",
                    params = {
                        event = "dacca:garage", --- event name
                        args = {
                            vehicle = 'airship2', --- the car name 
                            
                        }
                    }
                },
                {
                    id = 4,
                    header = '< store',
                    txt = '',
                    params = {
                        event = 'dacca:storecar',
                    }
                },
            }
            exports['qb-menu']:openMenu(myMenu)
end)
