Config = {
    Locale = 'fr', -- Default language
    Shops = {
        {
            coords = vector3(72.3, -1399.1, 28.4), -- Example location
            name = "Magasin de Vêtements",
            blip = {
                enable = true,
                sprite = 73,
                color = 47,
                scale = 0.8
            },
            marker = {
                enable = true,
                type = 27,
                scale = vector3(1.0, 1.0, 1.0),
                color = {r = 255, g = 255, b = 255, a = 100}
            },
            ped = {
                enable = true,
                model = 's_f_m_shop_high',
                heading = 270.0
            }
        }
        -- Add more shops here
    },
    Prices = {
        mask = 500,
        arms = 1000,
        pants = 1500,
        bag = 2000,
        shoes = 1500,
        tshirt = 1000,
        torso = 2000,
        decals = 500,
        kevlar = 3000,
        bproof = 4000
    }
}