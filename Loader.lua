-- Archeron Hub UI (Warna Ungu + Tombol Logo Close)
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Buat ScreenGui
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ArcheronHub"

-- Frame utama
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 450, 0, 300)
main.Position = UDim2.new(0.5, -225, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(75, 0, 130)
main.BorderSizePixel = 0
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Active = true
main.Draggable = true

-- Judul
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, -50, 0, 40)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Archeron Hub 💜"
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 200, 255)
title.TextXAlignment = Enum.TextXAlignment.Left

-- Garis atas
local line = Instance.new("Frame", main)
line.Size = UDim2.new(1, 0, 0, 2)
line.Position = UDim2.new(0, 0, 0, 40)
line.BackgroundColor3 = Color3.fromRGB(200, 100, 255)

-- Tombol Close (pake logo Archeron dari link/gambar sebelumnya)
local close = Instance.new("ImageButton", main)
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -35, 0, 5)
close.BackgroundTransparency = 1
close.Image = "rbxassetid://16323983276" -- Ganti ini dengan ID logo Archeron yang pernah lu kasih

close.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Tombol Auto Farm
local btn = Instance.new("TextButton", main)
btn.Size = UDim2.new(0, 400, 0, 40)
btn.Position = UDim2.new(0.5, -200, 0, 60)
btn.BackgroundColor3 = Color3.fromRGB(120, 0, 180)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Font = Enum.Font.GothamBold
btn.Text = "Auto Farm [OFF]"
btn.TextSize = 20

local autofarm = false
btn.MouseButton1Click:Connect(function()
    autofarm = not autofarm
    btn.Text = "Auto Farm [" .. (autofarm and "ON" or "OFF") .. "]"
    if autofarm then
        spawn(function()
            while autofarm do
                print("Auto farming aktif...")
                task.wait(1)
            end
        end)
    end
end)

-- Credit label
local credit = Instance.new("TextLabel", main)
credit.Size = UDim2.new(1, 0, 0, 30)
credit.Position = UDim2.new(0, 0, 1, -30)
credit.BackgroundTransparency = 1
credit.Text = "Created by Zeno 🌀"
credit.Font = Enum.Font.Gotham
credit.TextSize = 14
credit.TextColor3 = Color3.fromRGB(200, 200, 255)

-- ESC toggle UI
game:GetService("UserInputService").InputBegan:Connect(function(input, gp)
    if input.KeyCode == Enum.KeyCode.RightControl then
        gui.Enabled = not gui.Enabled
    end
end)
