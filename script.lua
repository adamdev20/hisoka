
-- Library UI
local UILib = {}
function UILib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local Frame = Instance.new("Frame", ScreenGui)
    local Title = Instance.new("TextLabel", Frame)
    local CloseButton = Instance.new("TextButton", Frame)

    ScreenGui.Name = "UILibrary"
    Frame.Name = "MainFrame"
    Frame.Size = UDim2.new(0, 300, 0, 200)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BorderSizePixel = 0
    Frame.Active = true
    Frame.Draggable = true

    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextScaled = true
    Title.Font = Enum.Font.SourceSansBold

    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextScaled = true
    CloseButton.Font = Enum.Font.SourceSansBold

    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    return Frame
end

function UILib:CreateButton(parent, text, callback)
    local Button = Instance.new("TextButton", parent)
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Button.BorderSizePixel = 0
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextScaled = true
    Button.Font = Enum.Font.SourceSansBold
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- UI Initialization
local window = UILib:CreateWindow("ESP Player")

-- Variables
local espEnabled = false

-- Function to Create ESP
local function createESP(player)
    if player == game.Players.LocalPlayer then return end
    local BillboardGui = Instance.new("BillboardGui")
    local TextLabel = Instance.new("TextLabel")

    BillboardGui.Name = "ESP"
    BillboardGui.Adornee = player.Character:WaitForChild("HumanoidRootPart")
    BillboardGui.Size = UDim2.new(0, 200, 0, 50)
    BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
    BillboardGui.AlwaysOnTop = true

    TextLabel.Parent = BillboardGui
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = player.Name .. " | Distance: " .. math.floor((player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)
    TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    TextLabel.TextScaled = true
    TextLabel.Font = Enum.Font.SourceSansBold

    BillboardGui.Parent = player.Character:WaitForChild("HumanoidRootPart")
end

-- Function to Toggle ESP
local function toggleESP(state)
    espEnabled = state
    if espEnabled then
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                createESP(player)
            end
        end

        game.Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                createESP(player)
            end)
        end)
    else
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local esp = player.Character.HumanoidRootPart:FindFirstChild("ESP")
                if esp then esp:Destroy() end
            end
        end
    end
end

-- Button to Toggle ESP
UILib:CreateButton(window, "Toggle ESP", function()
    toggleESP(not espEnabled)
end)
