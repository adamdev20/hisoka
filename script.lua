local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/adamdev20/lib/refs/heads/main/main.lua", true))()

local window = UILib:CreateWindow("Speed Hack UI")

local isSpeedEnabled = false
local normalSpeed = 16
local fastSpeed = 100

local function updateWalkSpeed()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if humanoid then
        if isSpeedEnabled then
            humanoid.WalkSpeed = fastSpeed
        else
            humanoid.WalkSpeed = normalSpeed
        end
    end
end

UILib:CreateToggle(window, "Lari Cepat", false, function(state)
    isSpeedEnabled = state
    updateWalkSpeed()
end)

updateWalkSpeed()
