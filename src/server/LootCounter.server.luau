-- Easier access to services
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

-- Loot Collection Event
local lootCollected = ServerScriptService.Server:WaitForChild("LootCollected")

-- Add leaderboard stats/counter for every player
Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local loot = Instance.new("IntValue")
    loot.Name = "Loot"
    loot.Value = 0
    loot.Parent = leaderstats
end)

-- Receives signal that says lootCollected event has been triggered
lootCollected.Event:Connect(function(player)
    local loot = player.leaderstats:FindFirstChild("Loot")
    loot.Value += 1
end)