-- Load Kavo UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Buat Window dengan tema dasar dulu (nanti kita ubah warna manual)
local Window = Library.CreateLib("Zeno Speed Hub", "DarkTheme")

-- Ganti warna UI jadi ungu setelah dibuat
task.wait(1)
for i,v in pairs(game.CoreGui:GetDescendants()) do
    if v:IsA("TextLabel") or v:IsA("TextButton") then
        v.TextColor3 = Color3.fromRGB(200, 150, 255) -- teks ungu muda
    end
    if v:IsA("Frame") or v:IsA("ScrollingFrame") then
        v.BackgroundColor3 = Color3.fromRGB(60, 0, 100) -- latar ungu gelap
    end
end

-- Contoh tab
local MainTab = Window:NewTab("Main")
local Section = MainTab:NewSection("Auto Stuff")

Section:NewToggle("Auto Farm", "Aktifin Auto Farm", function(v)
    _G.AutoFarm = v
    while _G.AutoFarm do
        print("Auto farming aktif...")
        task.wait(1)
    end
end)
