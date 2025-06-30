--// Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

--// UI Window
local Window = Rayfield:CreateWindow({
   Name = "Steve Hub | Grow a Garden",
   LoadingTitle = "Grow a Garden",
   LoadingSubtitle = "by Zeno",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

--// Data Seed & Gear
local seeds = {
   "Carrot Seed", "Strawberry Seed", "Blueberry Seed", "Tomato Seed",
   "Cauliflower Seed", "Watermelon Seed", "Green Apple Seed", "Avocado Seed",
   "Banana Seed", "Pineapple Seed", "Kiwi seed", "Bell Pepper Seed",
   "Pricky Pear Seed", "Loquat Seed", "Feijoa Seed", "Sugar Apple"
}

local gears = {
   "Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler",
   "Advanced Sprinkler", "Godly Sprinkler", "Tanning Mirror",
   "Master Sprinkler", "Cleaning Spray", "Favorite Tools",
   "Harvest Tool", "Friendship Pot"
}

local selectedSeed = seeds[1]
local selectedGear = gears[1]

--// Dropdown Pilih Seed
Window:CreateDropdown({
   Name = "Pilih Seed",
   Options = seeds,
   CurrentOption = selectedSeed,
   Flag = "SeedOption",
   Callback = function(option)
      selectedSeed = option
   end,
})

--// Dropdown Pilih Gear
Window:CreateDropdown({
   Name = "Pilih Gear",
   Options = gears,
   CurrentOption = selectedGear,
   Flag = "GearOption",
   Callback = function(option)
      selectedGear = option
   end,
})

--// Auto Buy Seed
Window:CreateToggle({
   Name = "Auto Buy Seed",
   CurrentValue = false,
   Flag = "AutoBuySeed",
   Callback = function(state)
      getgenv().autoBuySeed = state
      task.spawn(function()
         while getgenv().autoBuySeed do
            game:GetService("ReplicatedStorage").Remotes.BuyItem:FireServer(selectedSeed)
            task.wait(1)
         end
      end)
   end,
})

--// Auto Buy Gear
Window:CreateToggle({
   Name = "Auto Buy Gear",
   CurrentValue = false,
   Flag = "AutoBuyGear",
   Callback = function(state)
      getgenv().autoBuyGear = state
      task.spawn(function()
         while getgenv().autoBuyGear do
            game:GetService("ReplicatedStorage").Remotes.BuyItem:FireServer(selectedGear)
            task.wait(1)
         end
      end)
   end,
})

--// Auto Plant
Window:CreateToggle({
   Name = "Auto Plant",
   CurrentValue = false,
   Flag = "AutoPlant",
   Callback = function(state)
      getgenv().autoPlant = state
      task.spawn(function()
         while getgenv().autoPlant do
            game:GetService("ReplicatedStorage").Remotes.Plant:FireServer()
            task.wait(1)
         end
      end)
   end,
})

--// Auto Water
Window:CreateToggle({
   Name = "Auto Water",
   CurrentValue = false,
   Flag = "AutoWater",
   Callback = function(state)
      getgenv().autoWater = state
      task.spawn(function()
         while getgenv().autoWater do
            game:GetService("ReplicatedStorage").Remotes.Water:FireServer()
            task.wait(1)
         end
      end)
   end,
})

--// Auto Harvest
Window:CreateToggle({
   Name = "Auto Harvest",
   CurrentValue = false,
   Flag = "AutoHarvest",
   Callback = function(state)
      getgenv().autoHarvest = state
      task.spawn(function()
         while getgenv().autoHarvest do
            game:GetService("ReplicatedStorage").Remotes.Harvest:FireServer()
            task.wait(1)
         end
      end)
   end,
})

--// Auto Sell
Window:CreateToggle({
   Name = "Auto Sell",
   CurrentValue = false,
   Flag = "AutoSell",
   Callback = function(state)
      getgenv().autoSell = state
      task.spawn(function()
         while getgenv().autoSell do
            game:GetService("ReplicatedStorage").Remotes.Sell:FireServer()
            task.wait(1)
         end
      end)
   end,
})
