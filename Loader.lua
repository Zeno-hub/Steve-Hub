-- Grow a Garden Auto Script by Zeno
-- GUI with auto farming + utilities

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Grow a Garden | SteveHub",
    LoadingTitle = "SteveHub Loaded",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Seed & Gear List
local SeedList = {
    "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Tomato Seed",
    "Cauliflower Seed", "Watermelon Seed", "Green Apple Seed", "Avocado Seed",
    "Banana Seed", "Pineapple Seed", "Kiwi seed", "Bell Pepper Seed",
    "Pricky Pear Seed", "Loquat Seed", "Feijoa Seed", "Sugar Apple"
}

local GearList = {
    "Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler",
    "Advanced Sprinkler", "Godly Sprinkler", "Tanning Mirror", "Master Sprinkler",
    "Cleaning Spray", "Favorite Tools", "Harvest Tool", "Friendship Pot"
}

-- Variables
local selectedSeeds = {}
local selectedGears = {}
local autoBuySeed = false
local autoBuyGear = false

-- Buy Functions
local function buySeed(seed)
    local args = {seed}
    game:GetService("ReplicatedStorage").GameEvents.BuySeedStock:FireServer(unpack(args))
end

local function buyGear(gear)
    local args = {gear}
    game:GetService("ReplicatedStorage").GameEvents.BuyGear:FireServer(unpack(args))
end

-- Auto Loop
task.spawn(function()
    while task.wait(2) do
        if autoBuySeed then
            for _, seed in pairs(selectedSeeds) do
                buySeed(seed)
            end
        end
        if autoBuyGear then
            for _, gear in pairs(selectedGears) do
                buyGear(gear)
            end
        end
    end
   end
