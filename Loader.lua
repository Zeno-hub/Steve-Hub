-- Steve-Hub by Zeno | Auto Buy + Auto Collect System with Rayfield UI

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- UI Window
local Window = Rayfield:CreateWindow({
    Name = "Steve-Hub | Grow a Garden",
    LoadingTitle = "Steve-Hub by Zeno",
    LoadingSubtitle = "loading tools...",
    ConfigurationSaving = {
        Enabled = false
    },
    Discord = {
        Enabled = false
    },
    KeySystem = false
})

-- Configuration
_G.autoSeed = false
_G.autoGear = false
_G.autoCollect = false

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CmdrClient = ReplicatedStorage:WaitForChild("CmdrClient")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

-- Seed & Gear List
local seedList = {
    "Carrot Seed", "Strawberry Seed", "Tomato Seed", "Cauliflower Seed",
    "Watermelon Seed", "Green Apple Seed", "Avocado Seed", "Banana Seed",
    "Pineapple Seed", "Kiwi Seed", "Bell Pepper Seed", "Pricky Pear Seed",
    "Loquat Seed", "Feijoa Seed", "Sugar Apple"
}

local gearList = {
    "Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler",
    "Advanced Sprinkler", "Godly Sprinkler", "Tanning Mirror", "Master Sprinkler",
    "Cleaning Spray", "Favorite Tools", "Friendship Pot", "Harvest Tool"
}

-- Auto Buy Seed
local function autoSeedLoop()
    spawn(function()
        while _G.autoSeed do
            local seedStock = CmdrClient:WaitForChild("globalseedstock")
            for _, seed in ipairs(seedList) do
                local item = seedStock:FindFirstChild(seed)
                if item and item:FindFirstChild("Stock") and item.Stock.Value > 0 then
                    GameEvents:WaitForChild("BuySeedStock"):FireServer(seed)
                    wait(0.25)
                end
            end
            wait(5)
        end
    end)
end

-- Auto Buy Gear
local function autoGearLoop()
    spawn(function()
        while _G.autoGear do
            local gearStock = CmdrClient:WaitForChild("globalgearstock")
            for _, gear in ipairs(gearList) do
                local item = gearStock:FindFirstChild(gear)
                if item and item:FindFirstChild("Stock") and item.Stock.Value > 0 then
                    GameEvents:WaitForChild("BuyGearStock"):FireServer(gear)
                    wait(0.25)
                end
            end
            wait(5)
        end
    end)
end

-- Auto Collect (Harvest)
local function autoCollectLoop()
    spawn(function()
        while _G.autoCollect do
            for _, plot in pairs(workspace:GetDescendants()) do
                if plot:IsA("Model") and plot:FindFirstChild("ReadyToHarvest") and plot.ReadyToHarvest.Value == true then
                    local harvestEvent = GameEvents:FindFirstChild("HarvestCrop")
                    if harvestEvent then
                        harvestEvent:FireServer(plot)
                        wait(0.1)
                    end
                end
            end
            wait(3)
        end
    end)
end

-- UI Tabs and Toggles
local MainTab = Window:CreateTab("Automation", 4483362458)

MainTab:CreateToggle({
    Name = "Auto Buy Seed",
    CurrentValue = false,
    Flag = "AutoSeed",
    Callback = function(Value)
        _G.autoSeed = Value
        if Value then autoSeedLoop() end
    end
})

MainTab:CreateToggle({
    Name = "Auto Buy Gear",
    CurrentValue = false,
    Flag = "AutoGear",
    Callback = function(Value)
        _G.autoGear = Value
        if Value then autoGearLoop() end
    end
})

MainTab:CreateToggle({
    Name = "Auto Collect (Harvest)",
    CurrentValue = false,
    Flag = "AutoCollect",
    Callback = function(Value)
        _G.autoCollect = Value
        if Value then autoCollectLoop() end
    end
})

Rayfield:Notify({
    Title = "Steve-Hub Loaded",
    Content = "Auto tools ready!",
    Duration = 4,
    Image = 4483362458,
    Actions = {
        Ignore = {
            Name = "Ok",
            Callback = function() end
        }
    }
})
