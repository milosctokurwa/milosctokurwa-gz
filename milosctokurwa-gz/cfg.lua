config = {}

config.framework = "ESX" -- "ESX" or "QB" or "FiveM"

config.gz = {
    ["1"] = { -- name of greenzone
        coords = vector3(422.6534, -399.0890, 46.8880), -- coords (vector3/vec3) for marker/sphere
        r = 135, -- red color for marker/sphere
        g = 75, -- green color for marker/sphere
        b = 255, -- blue color for marker/sphere
        radius = 45.0, -- radius for marker/sphere
        blip = {
            title = "GZ", -- title for blip
            color = 2, -- color for blip https://docs.fivem.net/docs/game-references/blips/#blip-colors
            sprite = 487, -- sprite for blip https://docs.fivem.net/docs/game-references/blips/#blips
            scale = 1.0,-- scale for blip
        },
    },
    -- add more if u want
}