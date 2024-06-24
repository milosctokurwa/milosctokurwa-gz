
-- FRAMEWORK

if config.framework == "ESX" then
    MTK = exports['es_extended']:getSharedObject()
elseif config.framework == "QB" then
    QBCore = exports['qb-core']:GetCoreObject()
else
    print("Unknown framework")
end

-- LOCALS

local checkGZ = false
local insideGZ = {}
local blipsGZ = {}

-- FUNCTIONS

notify = function(msg)
    if config.framework == "ESX" then
        MTK.ShowNotification(msg)
    elseif config.framework == "QB" then
        QBCore.Functions.Notify(msg, 'success', 5000)
    elseif config.framework == "FiveM" then
        AddTextEntry('notify', msg)
        BeginTextCommandDisplayHelp('notify',msg)
        EndTextCommandDisplayHelp(0, false, true, -1)
    else
        print("Framework not supported for notifications")
    end
end

EnteredGZ = function()
    checkGZ = true
    notify("You are in a safe zone")
    SetLocalPlayerAsGhost(true)
end

QuitGZ = function()
    checkGZ = false
    notify("You are leaving the safe zone")
    SetLocalPlayerAsGhost(false)
end

CheckGZ = function()
    return checkGZ
end

exports("checkGZ", CheckGZ)

-- MAIN LOOP

CreateThread(function()
    for k, v in pairs(config.gz) do
        local blip = AddBlipForCoord(v.coords)
        SetBlipSprite(blip, v.blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, v.blip.scale)
        SetBlipColour(blip, v.blip.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.blip.title)
        EndTextCommandSetBlipName(blip)
        blipsGZ[k] = blip
    end
    
    while true do
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        local msec = 0
        local distance2 = 100
        for k, v in pairs(config.gz) do
            local distance = #(pedCoords - v.coords)
            if distance < distance2 then
                distance2 = distance
            end

            if distance <= v.radius + 50 then
                DrawSphere(v.coords, v.radius, v.r, v.g, v.b, 0.5)
            end

            if distance <= v.radius then
                if not insideGZ[k] then
                    insideGZ[k] = true
                    EnteredGZ()
                end
            else
                if insideGZ[k] then
                    insideGZ[k] = false
                    QuitGZ()
                end
            end

            if distance2 > v.radius + 50 then
                msec = 500
            else
                msec = 0
            end
        end

        Wait(msec)
    end
end)
