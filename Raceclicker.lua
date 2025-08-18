-- Archeron Hub - Simple UI Fix
local player = game:GetService("Players").LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "ArcheronHub"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 120)
frame.Position = UDim2.new(0, 20, 0, 80) -- kiri atas
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Parent = gui
frame.Active = true
frame.Draggable = true

-- Title
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, -40, 0, 30)
title.Position = UDim2.new(0, 10, 0, 5)
title.BackgroundTransparency = 1
title.Text = "Archeron Hub"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button (Logo Archeron)
local btnClose = Instance.new("ImageButton")
btnClose.Parent = frame
btnClose.Size = UDim2.new(0, 30, 0, 30)
btnClose.Position = UDim2.new(1, -35, 0, 5)
btnClose.BackgroundTransparency = 1
btnClose.Image = "rbxassetid://104034274572307" -- Logo ID lo
btnClose.MouseButton1Click:Connect(function()
    gui.Enabled = false -- bisa juga: gui:Destroy()
end)

-- Auto Open Button
local btnAuto = Instance.new("TextButton")
btnAuto.Parent = frame
btnAuto.Size = UDim2.new(1, -20, 0, 40)
btnAuto.Position = UDim2.new(0, 10, 0, 45)
btnAuto.BackgroundColor3 = Color3.fromRGB(30,30,30)
btnAuto.TextColor3 = Color3.fromRGB(255,255,255)
btnAuto.Font = Enum.Font.SourceSansBold
btnAuto.TextSize = 16
btnAuto.Text = "Auto Open Silver Crate: OFF"
btnAuto.BorderSizePixel = 0

local auto = false
btnAuto.MouseButton1Click:Connect(function()
    auto = not auto
    btnAuto.Text = "Auto Open Silver Crate: " .. (auto and "ON" or "OFF")
    if auto then
        spawn(function()
            while auto do
                local args = {"Silver"}
                pcall(function()
                    game:GetService("ReplicatedStorage")
                        :WaitForChild("Packages")
                        :WaitForChild("Knit")
                        :WaitForChild("Services")
                        :WaitForChild("CratesService")
                        :WaitForChild("RF")
                        :WaitForChild("OpenCrate")
                        :InvokeServer(unpack(args))
                end)
                task.wait(1)
            end
        end)
    end
end)
