-- // Auto Next World GUI - Race Clicker
-- By Zeno Hub 😹

-- // Load Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- // Config
local AutoNextWorld = false
local checkTime = 5
local worlds = {"Underwater", "Coral", "Atlantis", "WildWest", "Mine", "Toy", "Prison"}

-- // Service
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local KnitServices = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")
local WorldService = KnitServices:WaitForChild("WorldService")
local Travel = WorldService:WaitForChild("RF"):WaitForChild("Travel")

-- // Teleport Function
local function Teleport(worldName)
    local args = {
        "Event",
        false,
        worldName
    }
    Travel:InvokeServer(unpack(args))
    warn("Auto Teleport ke World: " .. worldName)
end

-- // Loop
task.spawn(function()
    while task.wait(checkTime) do
        if AutoNextWorld then
            pcall(function()
                local plr = game.Players.LocalPlayer
                local unlocked = plr:FindFirstChild("WorldsUnlocked") -- ganti kalau beda nama folder

                if unlocked then
                    for i = #worlds, 1, -1 do
                        local worldName = worlds[i]
                        local worldVal = unlocked:FindFirstChild(worldName)
                        if worldVal and worldVal.Value == true then
                            Teleport(worldName)
                            break
                        end
                    end
                end
            end)
        end
    end
end)

-- // GUI Window
local Window = Rayfield:CreateWindow({
    Name = "Zeno Hub | Race Clicker",
    LoadingTitle = "Zeno Hub",
    LoadingSubtitle = "by Ciefy 😹",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "ZenoHub",
       FileName = "RaceClicker"
    },
    Discord = {
       Enabled = false,
       Invite = "", 
       RememberJoins = true 
    },
    KeySystem = false
})

-- // Tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- // Toggle Auto Next World
MainTab:CreateToggle({
    Name = "Auto Next World",
    CurrentValue = false,
    Flag = "AutoNextWorld",
    Callback = function(Value)
        AutoNextWorld = Value
    end,
})
