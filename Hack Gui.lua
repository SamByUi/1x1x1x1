local player = game.Players.LocalPlayer
local playerGui = player:FindFirstChildOfClass("PlayerGui")
if playerGui:FindFirstChild("Hack Gui") then
    playerGui:FindFirstChild("Hack Gui"):Destroy()
end
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Hack Gui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui
local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 340, 0, 380)
frame.Position = UDim2.new(0.1,0,0.2,0)
frame.BackgroundColor3 = Color3.new(0,0,0)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = false
frame.Parent = screenGui
local uistroke = Instance.new("UIStroke")
uistroke.Parent = frame
uistroke.Thickness = 5

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,38)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "Hack Gui"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0,32,0,32)
closeBtn.Position = UDim2.new(1, -40, 0, 3)
closeBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)
closeBtn.Text = "X"
closeBtn.TextScaled = true
closeBtn.TextColor3 = Color3.fromRGB(255,0,0)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = frame
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
local dragToggle, dragInput, dragStart, startPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true
        dragStart = input.Position
        startPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragToggle = false
            end
        end)
    end
end)
frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragToggle then
        local delta = input.Position - dragStart
        frame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

local function createButton(name, yorder)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0.84,0,0,56)
    btn.Position = UDim2.new(0.08,0,0,56+62*(yorder-1))
    btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.BorderSizePixel = 0
    btn.Parent = frame
    local bstroke = Instance.new("UIStroke")
    bstroke.Parent = btn
    bstroke.Thickness = 3
    return btn, bstroke
end
local function rainbow(t)
    return Color3.fromHSV((tick()/2+t)%1,1,1)
end
local btns = {}
local names = {"change colour","Unanchor","music","fire","spin"}
local strokes = {}
for i,name in ipairs(names) do
    local btn,stroke = createButton(name, i)
    btns[name] = btn
    strokes[name] = stroke
end
game:GetService("RunService").RenderStepped:Connect(function()
    uistroke.Color = rainbow(0)
    for i,name in ipairs(names) do
        strokes[name].Color = rainbow(i/8)
        btns[name].TextColor3 = rainbow(i/8+0.2)
    end
end)

local changing = false
btns["change colour"].MouseButton1Click:Connect(function()
    changing = not changing
    if changing then
        btns["change colour"].Text = "colouring..."
    else
        btns["change colour"].Text = "change colour"
    end
end)
spawn(function()
    while true do
        if changing then
            local c = 0
            for _,part in ipairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Color = Color3.fromHSV(((tick()/2)+(c/15))%1,1,1)
                    c = c + 1
                end
            end
        end
        wait(0.08)
    end
end)
btns["Unanchor"].MouseButton1Click:Connect(function()
    for _,part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = false
        end
    end
end)
local musicID = 9120478200
local music
btns["music"].MouseButton1Click:Connect(function()
    if music then music:Destroy() end
    music = Instance.new("Sound", workspace)
    music.SoundId = "rbxassetid://"..tostring(musicID)
    music.Volume = 2
    music.Looped = true
    music.Playing = true
end)
btns["fire"].MouseButton1Click:Connect(function()
    for _,part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            if not part:FindFirstChild("RainbowFire") then
                local fire = Instance.new("Fire", part)
                fire.Name = "RainbowFire"
                fire.Size = 10
                fire.Heat = 0
                fire.Color = Color3.new(math.random(), math.random(), math.random())
                fire.SecondaryColor = Color3.new(math.random(), math.random(), math.random())
            end
        end
    end
end)
local spinning = false
btns["spin"].MouseButton1Click:Connect(function()
    spinning = not spinning
    btns["spin"].Text = spinning and "spinning..." or "spin"
end)
game:GetService("RunService").RenderStepped:Connect(function(dt)
    if spinning then
        for _,part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CFrame = part.CFrame * CFrame.Angles(0, math.rad(30)*dt, 0)
            end
        end
    end
end)
