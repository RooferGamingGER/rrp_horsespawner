
local recentlySpawned = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if recentlySpawned > 0 then
            recentlySpawned = recentlySpawned - 1
        end
    end
end)

function SpawnHorse()
    local localPed = PlayerPedId()
    local randomHorseModel = math.random(1, #Config.Horses)
    local model = GetHashKey(Config.Horses[randomHorseModel])
    local forward = Citizen.InvokeNative(0x2412D9C05BB09B97, localPed)
    local pos = GetEntityCoords(localPed)
    local myHorse = Citizen.InvokeNative(0xD49F9B0955C367DE, model, pos.x, pos.y - 4, pos.z - 0.5, 180.0, true, true, true, true)
    Citizen.InvokeNative(0x283978A15512B2FE, myHorse, true)
    SetPedAsGroupMember(myHorse, 0) --Citizen.InvokeNative(0x9F3480FE65DB31B5, myHorse, 0)
    SetModelAsNoLongerNeeded(model) -- Citizen.InvokeNative(0x4AD96EF928BD4F9A, model)
    Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, myHorse)
end

RegisterCommand("horse", function(source, args, rawCommand)
    if recentlySpawned <= 0 then
        recentlySpawned = 30
        SpawnHorse()
    else
        TriggerEvent("chat:systemMessage", "Please wait 30 seconds before spawning another horse.")
    end
end, false)