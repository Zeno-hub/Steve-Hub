-- GrowAGarden.lua (Rayfield GUI + Auto Buy Features)
-- Load Rayfield
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
end)
if not success or not Rayfield then
    warn("Gagal load Rayfield:", Rayfield)
    return
end

-- Delay sejenak supaya Rayfield benar-benar siap
task.delay(0.5, function()
    local window = Rayfield:CreateWindow({
        Name = "Steve Hub | Grow a Garden",
        LoadingTitle = "Steve Hub",
        LoadingSubtitle = "Zeno Edition",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "SteveHub",
            FileName = "GrowAGarden"
        },
        KeySystem = false,
    })

    local seedList = {
        "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Tomato Seed",
        "Cauliflower Seed", "Watermelon Seed", "Green Apple Seed", "Avocado Seed",
        "Banana Seed", "Pineapple Seed", "Kiwi seed", "Bell Pepper Seed",
        "Pricky Pear Seed", "Loquat Seed", "Feijoa Seed", "Sugar Apple"
    }
    local gearList = {
        "Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler",
        "Advanced Sprinkler", "Godly Sprinkler", "Tanning Mirror",
        "Master Sprinkler", "Cleaning Spray", "Favorite Tools",
        "Harvest Tool", "Friendship Pot"
    }

    local mainTab = window:CreateTab("🌱 Main", {Icon = "rbxassetid://6026568198"})
    local selectedSeeds, selectedGears = {}, {}

    mainTab:CreateDropdown({
        Name = "Pilih Seed buat Auto Buy",
        Options = seedList,
        MultiSelection = true,
        Callback = function(opts) selectedSeeds = opts end,
    })

    mainTab:CreateDropdown({
        Name = "Pilih Gear buat Auto Buy",
        Options = gearList,
        MultiSelection = true,
        Callback = function(opts) selectedGears = opts end,
    })

    mainTab:CreateToggle({
        Name = "Auto Buy Seed",
        CurrentValue = false,
        Callback = function(state)
            getgenv().autoBuySeed = state
            while getgenv().autoBuySeed do
                for _, seed in ipairs(selectedSeeds) do
                    local name = seed:gsub(" Seed", "")
                    game:GetService("ReplicatedStorage").GameEvents.BuySeedStock:FireServer(name)
                end
                task.wait(1)
            end
        end,
    })

    mainTab:CreateToggle({
        Name = "Auto Buy Gear",
        CurrentValue = false,
        Callback = function(state)
            getgenv().autoBuyGear = state
            while getgenv().autoBuyGear do
                for _, gear in ipairs(selectedGears) do
                    game:GetService("ReplicatedStorage").GameEvents.BuyGearStock:FireServer(gear)
                end
                task.wait(1)
            end
        end,
    })
end)
