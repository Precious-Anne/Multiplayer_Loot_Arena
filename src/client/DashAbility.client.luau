-- Easier access to services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- Locates the specific player using the ability
local player = Players.LocalPlayer

-- Dash Function
local function dash()
    -- Gets character and avoids returning nil to avoid error
    character = player.Character
    if not character then
        return
    end

    -- Gets root and avoids nil to avoid error
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then 
        return
    end

    -- Moves player forward through AssemblyLinearVelocity
    root.AssemblyLinearVelocity = root.CFrame.LookVector * 100 + Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)

end

-- Indicates that pressing Q will trigger the dash function
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if input.KeyCode == Enum.KeyCode.Q then
        dash()
    end   
end)



-- Avoids triggering input logic when player is interacting with Roblox GUI
if gameProcessedEvent then
    return
end
