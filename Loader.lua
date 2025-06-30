local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Steve Hub | Grow a Garden",
   LoadingTitle = "Loading UI...",
   LoadingSubtitle = "by Zeno",
   ConfigurationSaving = {
      Enabled = false,
   },
   Discord = {
      Enabled = false,
   },
   KeySystem = false,
})

local Tab = Window:CreateTab("Main", 4483362458)

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

-- Dropdown Seed
Tab:CreateDropdown({
   Name = "Pilih Seed",
   Options = seeds,
   CurrentOption = selectedSeed,
   Callback = function(Value)
      selectedSeed = Value
   end
})

-- Dropdown Gear
Tab:CreateDropdown({
   Name = "Pilih Gear",
   Options = gears,
   CurrentOption = selectedGear,
   Callback = function(Value)
      selectedGear = Value
   end
})

-- Auto Buy Seed
Tab:CreateToggle({
   Name = "Auto Buy Seed",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoBuySeed = Value
      while getgenv().autoBuySeed do
         game:GetService("ReplicatedStorage").Remotes.BuyItem:FireServer(selectedSeed)
         task.wait(1)
      end
   end
})

-- Auto Buy Gear
Tab:CreateToggle({
   Name = "Auto Buy Gear",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoBuyGear = Value
      while getgenv().autoBuyGear do
         game:GetService("ReplicatedStorage").Remotes.BuyItem:FireServer(selectedGear)
         task.wait(1)
      end
   end
})

-- Auto Plant
Tab:CreateToggle({
   Name = "Auto Plant",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoPlant = Value
      while getgenv().autoPlant do
         game:GetService("ReplicatedStorage").Remotes.Plant:FireServer()
         task.wait(1)
      end
   end
})

-- Auto Water
Tab:CreateToggle({
   Name = "Auto Water",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoWater = Value
      while getgenv().autoWater do
         game:GetService("ReplicatedStorage").Remotes.Water:FireServer()
         task.wait(1)
      end
   end
})

-- Auto Harvest
Tab:CreateToggle({
   Name = "Auto Harvest",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoHarvest = Value
      while getgenv().autoHarvest do
         game:GetService("ReplicatedStorage").Remotes.Harvest:FireServer()
         task.wait(1)
      end
   end
})

-- Auto Sell
Tab:CreateToggle({
   Name = "Auto Sell",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoSell = Value
      while getgenv().autoSell do
         game:GetService("ReplicatedStorage").Remotes.Sell:FireServer()
         task.wait(1)
      end
   end
})
