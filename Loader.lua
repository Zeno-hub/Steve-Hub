-- Steve-Hub GUI v3 by Zeno
-- Auto Buy Seeds & Gear + UI Archeron icon

local CoreGui = game:GetService("CoreGui")
local screenGui = Instance.new("ScreenGui", CoreGui)
screenGui.Name = "SteveHubUI"
screenGui.ResetOnSpawn = false

-- Main GUI Frame
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 250, 0, 200)
frame.Position = UDim2.new(0.5, -125, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)

-- Title Bar
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.Text = "🌱 Steve-Hub by Zeno"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local close = Instance.new("TextButton", frame)
close.Size = UDim2.new(0, 25, 0, 25)
close.Position = UDim2.new(1, -30, 0, 5)
close.Text = "❌"
close.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
close.TextColor3 = Color3.new(1,1,1)

-- Minimize Button
local mini = Instance.new("TextButton", frame)
mini.Size = UDim2.new(0, 25, 0, 25)
mini.Position = UDim2.new(1, -60, 0, 5)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
mini.TextColor3 = Color3.new(1,1,1)

-- Drag Function
local dragging, dragInput, dragStart, startPos
title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)
title.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
								   startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
title.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- Toggle Generator
local function createToggle(text, posY, callback)
	local btn = Instance.new("TextButton", frame)
	btn.Size = UDim2.new(0.8, 0, 0, 35)
	btn.Position = UDim2.new(0.1, 0, 0, posY)
	btn.Text = text .. ": OFF"
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18

	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = text .. ": " .. (state and "ON" or "OFF")
		callback(state)
	end)
end

-- Auto Buy Seeds
createToggle("Auto Buy Seed", 50, function(enabled)
	_G.autoSeed = enabled
	if enabled then
		spawn(function()
			while _G.autoSeed do
				for _, seed in ipairs({
					"Carrot Seed", "Strawberry Seed", "Tomato Seed", "Cauliflower Seed",
					"Watermelon Seed", "Green Apple Seed", "Avocado Seed", "Banana Seed",
					"Pineapple Seed", "Kiwi Seed", "Bell Pepper Seed", "Pricky Pear Seed",
					"Loquat Seed", "Feijoa Seed", "Sugar Apple"
				}) do
					local ev = game.ReplicatedStorage:FindFirstChild("Events"):FindFirstChild("Buy " .. seed)
					if ev then ev:FireServer() end
				end
				task.wait(5)
			end
		end)
	end
end)

-- Auto Buy Gear
createToggle("Auto Buy Gear", 95, function(enabled)
	_G.autoGear = enabled
	if enabled then
		spawn(function()
			while _G.autoGear do
				for _, gear in ipairs({
					"Watering Can", "Trowel", "Recall Wrench", "Basic Sprinkler",
					"Advanced Sprinkler", "Godly Sprinkler", "Tanning Mirror",
					"Master Sprinkler", "Cleaning Spray", "Favorite Tools",
					"Friendship Pot", "Harvest Tool"
				}) do
					local ev = game.ReplicatedStorage:FindFirstChild("Events"):FindFirstChild("Buy " .. gear)
					if ev then ev:FireServer() end
				end
				task.wait(6)
			end
		end)
	end
end)

-- Icon Archeron
local icon = Instance.new("ImageButton", CoreGui)
icon.Name = "SteveHubIcon"
icon.Image = "https://i.imgur.com/gwiQqpB.png"
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(1, -60, 0, 60)
icon.BackgroundTransparency = 1

local iconCorner = Instance.new("UICorner", icon)
iconCorner.CornerRadius = UDim.new(0, 10)

icon.Visible = false
icon.MouseButton1Click:Connect(function()
	frame.Visible = true
	icon.Visible = false
end)

-- Close Panel
close.MouseButton1Click:Connect(function()
	frame.Visible = false
	icon.Visible = true
end)

-- Minimize Panel
local minimized = false
mini.MouseButton1Click:Connect(function()
	if not minimized then
		for _, c in pairs(frame:GetChildren()) do
			if c:IsA("TextButton") and c ~= close and c ~= mini then
				c.Visible = false
			end
		end
		frame.Size = UDim2.new(0, 250, 0, 40)
	else
		for _, c in pairs(frame:GetChildren()) do
			if c:IsA("TextButton") and c ~= close and c ~= mini then
				c.Visible = true
			end
		end
		frame.Size = UDim2.new(0, 250, 0, 200)
	end
	minimized = not minimized
end)
