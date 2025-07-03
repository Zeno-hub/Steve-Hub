--[[ 
    Grow a Garden GUI by Zeno & Ciefy
    UI: Rayfield (customized)
    Features: Auto Buy Seed/Gear, Auto Plant, Water, Harvest, Sell, + Utility
]]

-- // Load Rayfield UI
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- // Variables
local runService = game:GetService("RunService")
local replicated = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local player = players.LocalPlayer

local selectedSeeds = {}
local selectedGears = {}

local autoBuySeed, autoBuyGear = false, false
local autoPlant, autoWater, autoHarvest, autoSell = false, false, false, false

-- // GUI Setup
local Window = Rayfield:CreateWindow({
	Name = "Grow a Garden - Steve Hub",
	LoadingTitle = "Steve Hub",
	LoadingSubtitle = "by Zeno",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "SteveHub",
		FileName = "GrowAGarden"
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

-- // Dropdowns
Tab:CreateDropdown({
	Name = "Select Seeds to Auto Buy",
	Options = seeds,
	MultiSelection = true,
	CurrentOption = {},
	Flag = "SeedSelect",
	Callback = function(Options)
		selectedSeeds = Options
	end,
})

Tab:CreateDropdown({
	Name = "Select Gears to Auto Buy",
	Options = gears,
	MultiSelection = true,
	CurrentOption = {},
	Flag = "GearSelect",
	Callback = function(Options)
		selectedGears = Options
	end,
})

-- // Auto Features
Tab:CreateToggle({
	Name = "Auto Buy Seed",
	CurrentValue = false,
	Callback = function(Value)
		autoBuySeed = Value
	end,
})

Tab:CreateToggle({
	Name = "Auto Buy Gear",
	CurrentValue = false,
	Callback = function(Value)
		autoBuyGear = Value
	end,
})

Tab:CreateToggle({
	Name = "Auto Plant",
	CurrentValue = false,
	Callback = function(Value)
		autoPlant = Value
	end,
})

Tab:CreateToggle({
	Name = "Auto Water",
	CurrentValue = false,
	Callback = function(Value)
		autoWater = Value
	end,
})

Tab:CreateToggle({
	Name = "Auto Harvest",
	CurrentValue = false,
	Callback = function(Value)
		autoHarvest = Value
	end,
})

Tab:CreateToggle({
	Name = "Auto Sell",
	CurrentValue = false,
	Callback = function(Value)
		autoSell = Value
	end,
})

-- // Utility Tab
local UtilTab = Window:CreateTab("Utility", 4483362458)

UtilTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {16, 100},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 16,
	Callback = function(Value)
		player.Character.Humanoid.WalkSpeed = Value
	end,
})

UtilTab:CreateButton({
	Name = "Enable Infinite Jump",
	Callback = function()
		game:GetService("UserInputService").JumpRequest:Connect(function()
			player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
		end)
	end,
})

UtilTab:CreateButton({
	Name = "Enable Fly",
	Callback = function()
		loadstring(game:HttpGet("https://pastebin.com/raw/MVi3jY7b"))()
	end,
})

UtilTab:CreateButton({
	Name = "Enable NoClip",
	Callback = function()
		runService.Stepped:Connect(function()
			if player.Character then
				for _, v in pairs(player.Character:GetDescendants()) do
					if v:IsA("BasePart") and v.CanCollide == true then
						v.CanCollide = false
					end
				end
			end
		end)
	end,
})

-- // Auto Loops
task.spawn(function()
	while task.wait(1) do
		if autoBuySeed then
			for _, seed in ipairs(selectedSeeds) do
				replicated.GameEvents:WaitForChild("BuySeedStock"):FireServer(seed:gsub(" Seed", ""))
			end
		end

		if autoBuyGear then
			for _, gear in ipairs(selectedGears) do
				replicated.GameEvents:WaitForChild("BuyGearStock"):FireServer(gear)
			end
		end

		if autoSell then
			replicated.GameEvents:WaitForChild("Sell_Item"):FireServer()
		end
	end
end)

-- // Auto Plant, Water, Harvest
task.spawn(function()
	while task.wait(0.5) do
		local plots = workspace:WaitForChild("Plots"):GetChildren()
		for _, plot in ipairs(plots) do
			if plot:IsA("Model") and plot:FindFirstChild("Soil") then
				local pos = plot.Soil.Position

				if autoPlant and #selectedSeeds > 0 then
					replicated.GameEvents:WaitForChild("Plant_RE"):FireServer(pos, selectedSeeds[1]:gsub(" Seed", ""))
				end

				if autoWater then
					replicated.GameEvents:WaitForChild("Water_RE"):FireServer(pos)
				end

				if autoHarvest and plot:FindFirstChild("Crop") then
					local crop = plot.Crop
					replicated.GameEvents:WaitForChild("ByteNetReliable"):FireServer(
						require(replicated:WaitForChild("ByteNetLib")).buffer.fromstring("collect"),
						{ crop }
					)
				end
			end
		end
	end
end)
