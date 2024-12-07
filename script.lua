local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/adamdev20/lib/refs/heads/main/main.lua"))()

local window = UILib:CreateWindow("ESP Player")

local function createESP(player)
    local espLabel = Instance.new("TextLabel")
    espLabel.Parent = game.CoreGui
    espLabel.Text = player.Name
    espLabel.BackgroundTransparency = 1
    espLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    espLabel.Font = Enum.Font.SourceSans
    espLabel.TextSize = 16
    espLabel.TextStrokeTransparency = 0.5

    player.CharacterAdded:Connect(function(character)
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local screenPos = game:GetService("Workspace").CurrentCamera:WorldToScreenPoint(humanoidRootPart.Position)
        espLabel.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y - 50)

        game:GetService("RunService").Heartbeat:Connect(function()
            if character and humanoidRootPart then
                local screenPos = game:GetService("Workspace").CurrentCamera:WorldToScreenPoint(humanoidRootPart.Position)
                espLabel.Position = UDim2.new(0, screenPos.X, 0, screenPos.Y - 50)
                espLabel.Text = player.Name .. " - " .. math.floor((character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "m"
            end
        end)
    end)
end

for _, player in pairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        createESP(player)
    end
end

game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        createESP(player)
    end
end)
