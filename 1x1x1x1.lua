local function addTextureAndFireToParts()
    local textureId = "rbxassetid://16592126876"
    for _, obj in ipairs(game.Workspace:GetDescendants()) do
        if obj:IsA("Part") then
            for _, face in ipairs({"Top","Bottom","Left","Right","Front","Back"}) do
                local texture = Instance.new("Texture")
                texture.Texture = textureId
                texture.Face = Enum.NormalId[face]
                texture.Parent = obj
            end
            local fire = Instance.new("Fire")
            fire.Size = 5
            fire.Heat = 10
            fire.Color = Color3.new(1, 0.4, 0)
            fire.Parent = obj
        end
    end
end

local function showPersistentText()
    local player = game.Players.LocalPlayer
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false

    local TextLabel = Instance.new("TextLabel")
    TextLabel.Size = UDim2.new(1, 0, 0, 100)
    TextLabel.Position = UDim2.new(0, 0, 0, 50)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = "1x1x1x1 is coming"
    TextLabel.TextColor3 = Color3.new(1, 0, 0)
    TextLabel.TextSize = 60
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextScaled = true
    TextLabel.Parent = ScreenGui
end

local function playJumpstyleMusic()
    local musicId = "rbxassetid://184387083"
    local sound = Instance.new("Sound")
    sound.SoundId = musicId
    sound.Looped = true
    sound.Volume = 1
    sound.Parent = game.SoundService
    sound:Play()
end

addTextureAndFireToParts()
showPersistentText()
playJumpstyleMusic()
