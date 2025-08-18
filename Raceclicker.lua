-- Archeron Hub UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("ImageButton")
local AutoButton = Instance.new("TextButton")

-- Parent
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "ArcheronHub"

-- Main Frame
MainFrame.Size = UDim2.new(0, 250, 0, 120)
MainFrame.Position = UDim2.new(0, 20, 0, 80) -- kiri atas
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.BorderSizePixel = 0
MainFrame.BackgroundTransparency = 0.2
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true -- bisa digeser

-- Title
Title.Parent = MainFrame
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.BackgroundTransparency = 1
Title.Text = "Archeron Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button (Logo Archeron)
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Image = "rbxassetid://104034274572307" -- ID decal Archeron
CloseButton.BackgroundTransparency = 1
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Auto Open Button
AutoButton.Parent = MainFrame
AutoButton.Size = UDim2.new(1, -20, 0, 40)
AutoButton.Position = UDim2.new(0, 10, 0, 45)
AutoButton.BackgroundColor3 = Color3.fromRGB(30,30,30)
AutoButton.TextColor3 = Color3.fromRGB(255,255,255)
AutoButton.Font = Enum.Font.SourceSansBold
AutoButton.TextSize = 16
AutoButton.Text = "Auto Open Silver Crate: OFF"
AutoButton.BorderSizePixel = 0

-- Toggle auto open
local auto = false
AutoButton.MouseButton1Click:Connect(function()
    auto = not auto
    if auto then
        AutoButton.Text = "Auto Open Silver Crate: ON"
        spawn(function()
            while auto do
                local args = {"Silver"}
                game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("CratesService"):WaitForChild("RF"):WaitForChild("OpenCrate"):InvokeServer(unpack(args))
                task.wait(1)
            end
        end)
    else
        AutoButton.Text = "Auto Open Silver Crate: OFF"
    end
end)
