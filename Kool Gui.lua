local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MoolerYipe_GUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderColor3 = Color3.new(1, 0, 0)
frame.BorderSizePixel = 4
frame.Draggable = true
frame.Active = true
frame.Visible = true
frame.Parent = screenGui

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundColor3 = Color3.new(0.2, 0, 0)
titleLabel.Text = "By MoolerYipe"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.TextScaled = true
titleLabel.Parent = frame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 40, 0, 40)
closeButton.Position = UDim2.new(1, -40, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.BackgroundColor3 = Color3.new(0.8, 0, 0)
closeButton.Parent = frame

local minimizeButton = Instance.new("TextButton")
minimizeButton.Size = UDim2.new(0, 40, 0, 40)
minimizeButton.Position = UDim2.new(1, -80, 0, 0)
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
minimizeButton.Parent = frame

local minimizedButton = Instance.new("TextButton")
minimizedButton.Size = UDim2.new(0, 100, 0, 40)
minimizedButton.Position = UDim2.new(0.05, 0, 0.05, 0)
minimizedButton.Text = "打开 GUI"
minimizedButton.TextColor3 = Color3.new(1, 1, 1)
minimizedButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
minimizedButton.Parent = screenGui
minimizedButton.Visible = false

minimizeButton.MouseButton1Click:Connect(function()
    frame.Visible = false
    minimizedButton.Visible = true
end)

minimizedButton.MouseButton1Click:Connect(function()
    frame.Visible = true
    minimizedButton.Visible = false
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local function createButton(text, posY, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 50)
    button.Position = UDim2.new(0, 10, 0, posY)
    button.Text = text
    button.TextColor3 = Color3.new(0, 0, 0)
    button.BackgroundColor3 = Color3.new(1, 1, 1)
    button.Parent = frame
    button.MouseButton1Click:Connect(callback)
end

createButton("全图 Disco", 60, function()
    local colors = {Color3.new(1, 0, 0), Color3.new(0, 1, 0), Color3.new(0, 0, 1), Color3.new(1, 1, 0), Color3.new(1, 0, 1)}
    while wait(0.1) do
        for _, part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Color = colors[math.random(1, #colors)]
            end
        end
    end
end)

createButton("全图 崩坏", 120, function()
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = false
        end
    end
end)

createButton("全图 火焰", 180, function()
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local fire = Instance.new("Fire")
            fire.Size = math.random(1, 15)
            fire.Parent = part
        end
    end
end)

createButton("全员 黑化", 240, function()
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player.Character then
            local character = player.Character
            
            for _, accessory in ipairs(character:GetDescendants()) do
                if accessory:IsA("Accessory") or accessory:IsA("Clothing") or accessory:IsA("ShirtGraphic") then
                    accessory:Destroy()
                end
            end
            
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.new(0, 0, 0)
                end
            end
        end
    end
end)

createButton("闪烁 红屏效果", 300, function()
    local flashing = true
    local screen = Instance.new("Frame")
    screen.Size = UDim2.new(1, 0, 1, 0)
    screen.BackgroundColor3 = Color3.new(1, 0, 0)
    screen.Parent = screenGui
    while flashing do
        screen.Visible = not screen.Visible
        wait(0.1)
    end
end)

createButton("启动假终端", 360, function()
    local terminal = Instance.new("Frame")
    terminal.Size = UDim2.new(0.8, 0, 0.6, 0)
    terminal.Position = UDim2.new(0.1, 0, 0.2, 0)
    terminal.BackgroundColor3 = Color3.new(0, 0, 0)
    terminal.Parent = screenGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(0, 1, 0)
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Top
    textLabel.Font = Enum.Font.Code
    textLabel.TextSize = 14
    textLabel.TextWrapped = true
    textLabel.Text = "Initializing...\nConnecting to server...\nSuccess.\nDownloading data..."
    textLabel.Parent = terminal

    for _ = 1, 50 do
        textLabel.Text = textLabel.Text .. "\n" .. "Data #" .. math.random(1, 9999) .. " retrieved."
        wait(0.1)
    end

    wait(5)
    terminal:Destroy()
end)