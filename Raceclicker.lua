-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Name = "AcheronCrateHub"

-- Frame utama
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.2
MainFrame.Parent = ScreenGui
MainFrame.Active = true   -- biar bisa digeser
MainFrame.Draggable = true
MainFrame.Name = "MainFrame"

-- Pinggiran ungu
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(130, 0, 200)
UIStroke.Parent = MainFrame

-- Judul
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Acheron Hub - Crates"
Title.TextColor3 = Color3.fromRGB(200, 200, 200)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol close (logo Acheron)
local CloseButton = Instance.new("ImageButton")
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.BackgroundTransparency = 1
CloseButton.Image = "rbxassetid://104034274572307" -- ganti dengan rblx id logo

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Tombol Auto Open Crate
local AutoButton = Instance.new("TextButton")
AutoButton.Parent = MainFrame
AutoButton.Size = UDim2.new(0, 200, 0, 40)
AutoButton.Position = UDim2.new(0.5, -100, 0.5, -20)
AutoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AutoButton.Text = "Auto Open Silver Crate: OFF"
AutoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoButton.TextSize = 14
AutoButton.Font = Enum.Font.GothamBold

local CornerBtn = Instance.new("UICorner")
CornerBtn.CornerRadius = UDim.new(0, 10)
CornerBtn.Parent = AutoButton

local StrokeBtn = Instance.new("UIStroke")
StrokeBtn.Thickness = 2
StrokeBtn.Color = Color3.fromRGB(130, 0, 200)
StrokeBtn.Parent = AutoButton

-- Fungsi Auto Crate
local auto = false
AutoButton.MouseButton1Click:Connect(function()
    auto = not auto
    if auto then
        AutoButton.Text = "Auto Open Silver Crate: ON"
    else
        AutoButton.Text = "Auto Open Silver Crate: OFF"
    end
end)

-- Loop buka crate
task.spawn(function()
    while task.wait(1) do
        if auto then
            local args = {"Silver"}
            pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CratesService"):WaitForChild("RF"):WaitForChild("OpenCrate"):InvokeServer(unpack(args))
            end)
        end
    end
end)
