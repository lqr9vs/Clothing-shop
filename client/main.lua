local shopPeds = {}

-- Create shop locations
Citizen.CreateThread(function()
    for _, shop in ipairs(Config.Shops) do
        if shop.blip.enable then
            local blip = AddBlipForCoord(shop.coords)
            SetBlipSprite(blip, shop.blip.sprite)
            SetBlipColour(blip, shop.blip.color)
            SetBlipScale(blip, shop.blip.scale)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(shop.name)
            EndTextCommandSetBlipName(blip)
        end

        if shop.ped.enable then
            local ped = CreateShopPed(shop.coords, shop.ped.model, shop.ped.heading)
            table.insert(shopPeds, ped)
        end
    end
end)

-- Shop interaction
Citizen.CreateThread(function()
    while true do
        local wait = 1000
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        for _, shop in ipairs(Config.Shops) do
            local distance = #(playerCoords - shop.coords)
            
            if distance < 20.0 then
                wait = 0
                
                if shop.marker.enable and distance < 15.0 then
                    DrawMarker(shop.marker.type, shop.coords.x, shop.coords.y, shop.coords.z - 0.98, 
                        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
                        shop.marker.scale.x, shop.marker.scale.y, shop.marker.scale.z, 
                        shop.marker.color.r, shop.marker.color.g, shop.marker.color.b, shop.marker.color.a, 
                        false, true, 2, false, nil, nil, false)
                end
                
                if distance < 1.5 then
                    ESX.ShowHelpNotification(_U('press_to_open'))
                    if IsControlJustReleased(0, 38) then
                        OpenClothingMenu()
                    end
                end
            end
        end
        
        Citizen.Wait(wait)
    end
end)

-- Cleanup peds on resource stop
AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        for _, ped in ipairs(shopPeds) do
            DeletePed(ped)
        end
    end
end)