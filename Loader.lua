-- Auto Next World Teleport Script (Urutan Updated)

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Steve Hub | Auto World",
   LoadingTitle = "Steve Hub Loader",
   LoadingSubtitle = "by Zeno",
   ConfigurationSaving = {
      Enabled = false
   },
   Discord = {
      Enabled = false
   }
})

-- urutan world bener
local Worlds = {
    "Coral",
    "Underwater",
    "Atlantis",
    "WildWest",
    "Mine",
    "Toy",
    "Prison"
}

local Tab = Window:CreateTab("Teleport", 4483362458)
local Section = Tab:CreateSection("Auto Next World")

local AutoNext = false

Tab:CreateToggle({
   Name = "Auto Next World",
   CurrentValue = false,
   Flag = "AutoNext",
   Callback = function(Value)
       AutoNext = Value
       while AutoNext do
           task.wait(2)

           local currentWorld = game:GetService("Players").LocalPlayer.PlayerGui.HUD.World.Text
           local nextWorld

           for i,world in ipairs(Worlds) do
               if world == currentWorld and Worlds[i+1] then
                   nextWorld = Worlds[i+1]
                   break
               end
           end

           if nextWorld then
               local args = { nextWorld, false }
               game:GetService("ReplicatedStorage")
                   :WaitForChild("Packages")
                   :WaitForChild("Knit")
                   :WaitForChild("Services")
                   :WaitForChild("WorldService")
                   :WaitForChild("RF")
                   :WaitForChild("Travel")
                   :InvokeServer(unpack(args))
           end
       end
   end,
})
