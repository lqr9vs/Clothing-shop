function CreateShopPed(coords, model, heading)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    
    local ped = CreatePed(4, model, coords.x, coords.y, coords.z, heading, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    
    return ped
end

function OpenClothingMenu()
    ESX.UI.Menu.CloseAll()
    
    local elements = {
        {label = _U('change_clothes'), value = 'change'},
        {label = _U('save_clothes'), value = 'save'},
        {label = _U('delete_clothes'), value = 'delete'},
        {label = _U('buy_clothes'), value = 'buy'}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'main_menu', {
        title = _U('clothing_shop'),
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'change' then
            TriggerEvent('esx_skin:openChangeMenu')
        elseif data.current.value == 'save' then
            SaveOutfit()
        elseif data.current.value == 'delete' then
            DeleteOutfit()
        elseif data.current.value == 'buy' then
            OpenBuyMenu()
        end
    end, function(data, menu)
        menu.close()
    end)
end

function OpenBuyMenu()
    local elements = {}
    for item, price in pairs(Config.Prices) do
        table.insert(elements, {
            label = string.format("%s - $%d", _U(item), price),
            value = item,
            price = price
        })
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_menu', {
        title = _U('buy_clothes'),
        align = 'top-left',
        elements = elements
    }, function(data, menu)
        ESX.TriggerServerCallback('clothing-shop:buyItem', function(success)
            if success then
                ESX.ShowNotification(_U('purchased_item'))
            else
                ESX.ShowNotification(_U('not_enough_money'))
            end
        end, data.current.value, data.current.price)
    end, function(data, menu)
        menu.close()
    end)
end