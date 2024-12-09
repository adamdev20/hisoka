-- Library UI
local UILib = {}
function UILib:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local Frame = Instance.new("Frame", ScreenGui)
    local Title = Instance.new("TextLabel", Frame)

    ScreenGui.Name = "UILibrary"
    Frame.Name = "MainFrame"
    Frame.Size = UDim2.new(0, 300, 0, 150)
    Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
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
local window = UILib:CreateWindow("Hop Server")
local HttpService = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local PlaceID = game.PlaceId
local ServerAPI = "https://games.roblox.com/v1/games/" .. PlaceID .. "/servers/Public?sortOrder=Asc&limit=100"

-- Function to Hop to Server with Few Players
local function hopToLowPlayerServer()
    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(ServerAPI))
    end)

    if success and result and result.data then
        for _, server in ipairs(result.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
                TPS:TeleportToPlaceInstance(PlaceID, server.id, game.Players.LocalPlayer)
                return
            end
        end
        print("Tidak ada server lain yang ditemukan.")
    else
        print("Gagal mendapatkan data server.")
    end
end

-- Button to Start Hop Server
UILib:CreateButton(window, "Hop Server", function()
    hopToLowPlayerServer()
end)
