-- Easier access to services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

-- Random Player Spawn
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        -- Local tables so that it starts new for every player
        -- Creating a table out of the SpawnArea Folder
        local spawnAreas = Workspace.Arena.SpawnArea:GetChildren()
        
        -- Get random spawn 
        local randomSpawn = spawnAreas[math.random(1, #spawnAreas)]
        
        -- Moves player to spawn position
        local root = character:WaitForChild("HumanoidRootPart")
        local spawnPosition = randomSpawn.CFrame
        root.CFrame = spawnPosition + Vector3.new(0, 3, 0)
    end)    
end)        