-- Easier access to services
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

-- Loot Collection Event
local lootCollected = ServerScriptService.Server:WaitForChild("LootCollected")

-- Makes LootSpawns Folder into a table 
local lootArea = Workspace.Arena:WaitForChild("LootSpawns")
local lootSpawn = lootArea:GetChildren()

-- Function to randomly spawn a loot
local function spawnLoot()
    -- Accessing the loot from ServerStorage
    local loot = ServerStorage.Loots.Loot:Clone()
    loot.Parent = Workspace

    -- Gets random area and random X/Z values
    local getRandomArea = lootSpawn[math.random(1, #lootSpawn)]

    local randomX = math.random(
        getRandomArea.Position.X - getRandomArea.Size.X / 2,
        getRandomArea.Position.X + getRandomArea.Size.X / 2
    )
    
    local randomZ = math.random(
        getRandomArea.Position.Z - getRandomArea.Size.Z / 2,
        getRandomArea.Position.Z + getRandomArea.Size.Z / 2
    )

    -- Gets final position value and gives it to the loot
    local lootPosition = Vector3.new(
        randomX,
        getRandomArea.Position.Y + 3,
        randomZ
    )

    loot.CFrame = CFrame.new(lootPosition)

    -- Destroys loot when player touches it and collects it
    local collected = false 

    loot.Touched:Connect(function(part)
        -- Checks if the loot has already been collected before
        if collected then
            return
        end
        
        -- Checks if the part that touched the loot was a humanoid part
        local character = part.Parent
        local humanoid = character:FindFirstChild("Humanoid")

        if humanoid then 
            -- Checks and gets player if humanoid part is from a player
            local player = Players:GetPlayerFromCharacter(character)

            loot:Destroy()

            collected = true

            -- Signals LootCounter server script that lootCollected event has been triggered
            lootCollected:Fire(player)

            -- Respawns loot after 10 seconds
            task.wait(10)
            spawnLoot()
        end
    end)
end    

-- Repeatedly spawns a loot if the number of loot is under 50
for i = 1, 30 do
    spawnLoot()
end


