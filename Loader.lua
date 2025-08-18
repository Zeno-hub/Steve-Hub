-- // Auto Next World - Race Clicker (Bypass Check)
-- By Zeno Hub 😹

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Config
local AutoNextWorld = false
local checkTime = 5
local worlds = {"Underwater", "Coral", "Atlantis", "WildWest", "Mine", "Toy", "Prison"}

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KnitServices = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
local WorldService = KnitServices:WaitForChild("WorldService")
local Travel = WorldService:WaitForChild("RF"):WaitForChild("Travel")

-- Teleport Function (Test world unlock by trying)
local function TryTeleport(worldName)
    local success, result = pcall(function()
        return Travel:InvokeServer("Home", false, worldName)
    end)
    if success and result ~= nil then
        Rayfield:Notify({
            Title = "Auto Next World",
            Content = "Teleport ke: " .. worldName,
            Duration = 3,
            Image = 4483362458
        })
        return true
    end
    return false
end

-- Loop
task.spawn(function()
    while task.wait(checkTime) do
        if AutoNextWorld then
            for i = #worlds, 1, -1 do
                if TryTeleport(worlds[i]) then
                    break
                end
            end
        end
    end
end)

-- GUI Window
local Window = Rayfield:CreateWindow({
    Name = "Zeno Hub | Race Clicker",
    LoadingTitle = "Zeno Hub",
    LoadingSubtitle = "by Ciefy 😹",
    KeySystem = false
})

local MainTab = Window:CreateTab("Main", 4483362458)

MainTab:CreateToggle({
    Name = "Auto Next World",
    CurrentValue = false,
    Flag = "AutoNextWorld",
    Callback = function(Value)
        AutoNextWorld = Value
    end,
})
