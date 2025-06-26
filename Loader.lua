
-- Archeron Hub (SpeedHub Style UI) by Zeno

-- CONFIG
local logoID = "rbxassetid://17629427114" -- Archeron logo
local themeColor = Color3.fromRGB(100, 0, 150)
local accentColor = Color3.fromRGB(200, 150, 255)

-- UI SETUP
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ArcheronHub"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.ResetOnSpawn = false

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 350)
main.Position = UDim2.new(0.5, -300, 0.5, -175)
main.BackgroundColor3 = themeColor
main.BorderSizePixel = 0
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.ClipsDescendants = true
main.Active = true
main.Draggable = true

-- Sidebar
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 140, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(60, 0, 100)

-- Title
local title = Instance.new("TextLabel", sidebar)
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "Archeron Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = accentColor
title.BackgroundTransparency = 1

-- Tab Buttons
local tabs = {"Main", "Shop", "Teleport", "Misc", "Credits", "Player", "Automatically"}
local pages = {}

local function switchTo(tabName)
    for name, page in pairs(pages) do
        page.Visible = (name == tabName)
    end
end

for i, name in ipairs(tabs) do
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, -20, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, 50 + (i-1)*35)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(90, 0, 140)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.MouseButton1Click:Connect(function()
        switchTo(name)
    end)
end

-- Page Container
for _, name in ipairs(tabs) do
    local page = Instance.new("Frame", main)
    page.Name = name
    page.Size = UDim2.new(1, -140, 1, 0)
    page.Position = UDim2.new(0, 140, 0, 0)
    page.BackgroundColor3 = Color3.fromRGB(50, 0, 70)
    page.Visible = false
    pages[name] = page

    -- Example Label
    local lbl = Instance.new("TextLabel", page)
    lbl.Size = UDim2.new(1, 0, 0, 40)
    lbl.Position = UDim2.new(0, 0, 0, 10)
    lbl.Text = name .. " Page"
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 22
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.BackgroundTransparency = 1
end

switchTo("Main")

-- Close Button
local closeBtn = Instance.new("ImageButton", main)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -35, 0, 7)
closeBtn.BackgroundTransparency = 1
closeBtn.Image = logoID
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- PLAYER TAB: Infinite Jump
local infJump = false
local btnJump = Instance.new("TextButton", pages["Player"])
btnJump.Size = UDim2.new(0, 200, 0, 35)
btnJump.Position = UDim2.new(0, 20, 0, 60)
btnJump.BackgroundColor3 = Color3.fromRGB(140, 0, 200)
btnJump.TextColor3 = Color3.fromRGB(255, 255, 255)
btnJump.Font = Enum.Font.GothamBold
btnJump.TextSize = 16
btnJump.Text = "Infinite Jump [OFF]"

btnJump.MouseButton1Click:Connect(function()
    infJump = not infJump
    btnJump.Text = "Infinite Jump [" .. (infJump and "ON" or "OFF") .. "]"
end)

UIS.JumpRequest:Connect(function()
    if infJump then
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- PLAYER TAB: SpeedHack
local speedOn = false
local btnSpeed = Instance.new("TextButton", pages["Player"])
btnSpeed.Size = UDim2.new(0, 200, 0, 35)
btnSpeed.Position = UDim2.new(0, 20, 0, 105)
btnSpeed.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
btnSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
btnSpeed.Font = Enum.Font.GothamBold
btnSpeed.TextSize = 16
btnSpeed.Text = "SpeedHack [OFF]"

btnSpeed.MouseButton1Click:Connect(function()
    speedOn = not speedOn
    btnSpeed.Text = "SpeedHack [" .. (speedOn and "ON" or "OFF") .. "]"
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedOn and 100 or 16
    end
end)

-- AUTOMATICALLY TAB: AutoFarm dummy toggle
local autoFarm = false
local btnFarm = Instance.new("TextButton", pages["Automatically"])
btnFarm.Size = UDim2.new(0, 200, 0, 35)
btnFarm.Position = UDim2.new(0, 20, 0, 60)
btnFarm.BackgroundColor3 = Color3.fromRGB(140, 0, 180)
btnFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
btnFarm.Font = Enum.Font.GothamBold
btnFarm.TextSize = 16
btnFarm.Text = "Auto Farm [OFF]"

btnFarm.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    btnFarm.Text = "Auto Farm [" .. (autoFarm and "ON" or "OFF") .. "]"
    if autoFarm then
        spawn(function()
            while autoFarm do
                print("Auto farming...")
                task.wait(1)
            end
        end)
    end
end)

-- Animation
main.Size = UDim2.new(0, 0, 0, 0)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 600, 0, 350),
    Position = UDim2.new(0.5, -300, 0.5, -175)
}):Play()
