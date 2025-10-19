-- PART 1 SCRIPT START
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyEmotesHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Dragable Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0,600,0,400)
MainFrame.Position = UDim2.new(0.5,-300,0.5,-200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

-- Rainbow Outline
local Outline = Instance.new("UICorner")
Outline.CornerRadius = UDim.new(0,12)
Outline.Parent = MainFrame

local RainbowFrame = Instance.new("Frame")
RainbowFrame.Size = UDim2.new(1,4,1,4)
RainbowFrame.Position = UDim2.new(0,-2,0,-2)
RainbowFrame.BackgroundColor3 = Color3.fromHSV(0,1,1)
RainbowFrame.ZIndex = 0
RainbowFrame.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Text = "My Emotes"
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0,0,0,0)
Title.Size = UDim2.new(1,0,0,40)
Title.Parent = MainFrame

-- Minimize / Close Buttons
local MinButton = Instance.new("TextButton")
MinButton.Text = "-"
MinButton.Font = Enum.Font.FredokaOne
MinButton.TextSize = 20
MinButton.TextColor3 = Color3.new(1,1,1)
MinButton.Size = UDim2.new(0,30,0,30)
MinButton.Position = UDim2.new(1,-70,0,5)
MinButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
MinButton.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.FredokaOne
CloseButton.TextSize = 20
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.Size = UDim2.new(0,30,0,30)
CloseButton.Position = UDim2.new(1,-35,0,5)
CloseButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
CloseButton.Parent = MainFrame

-- Tabs Setup
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1,0,0,30)
TabFrame.Position = UDim2.new(0,0,0,40)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local R6TabBtn = Instance.new("TextButton")
R6TabBtn.Text = "R6"
R6TabBtn.Font = Enum.Font.FredokaOne
R6TabBtn.TextSize = 18
R6TabBtn.Size = UDim2.new(0,100,1,0)
R6TabBtn.Position = UDim2.new(0,0,0,0)
R6TabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
R6TabBtn.Parent = TabFrame

local R15TabBtn = Instance.new("TextButton")
R15TabBtn.Text = "R15"
R15TabBtn.Font = Enum.Font.FredokaOne
R15TabBtn.TextSize = 18
R15TabBtn.Size = UDim2.new(0,100,1,0)
R15TabBtn.Position = UDim2.new(0,110,0,0)
R15TabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
R15TabBtn.Parent = TabFrame

local OtherTabBtn = Instance.new("TextButton")
OtherTabBtn.Text = "Other"
OtherTabBtn.Font = Enum.Font.FredokaOne
OtherTabBtn.TextSize = 18
OtherTabBtn.Size = UDim2.new(0,100,1,0)
OtherTabBtn.Position = UDim2.new(0,220,0,0)
OtherTabBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
OtherTabBtn.Parent = TabFrame

-- Scroll Frame for Emotes
local EmoteFrame = Instance.new("ScrollingFrame")
EmoteFrame.Position = UDim2.new(0,0,0,70)
EmoteFrame.Size = UDim2.new(1,-10,1,-70)
EmoteFrame.CanvasSize = UDim2.new(0,0,0,0)
EmoteFrame.ScrollBarThickness = 10
EmoteFrame.BackgroundTransparency = 1
EmoteFrame.Parent = MainFrame

-- Sample R6 Emotes Table
local R6Emotes = {
    {Name="/e dance", AnimationId="1234567890"},
    {Name="/e wave", AnimationId="1234567891"},
    {Name="/e cheer", AnimationId="1234567892"},
    {Name="/e laugh", AnimationId="1234567893"},
}

-- Generate Buttons for R6
local function generateEmoteButtons(EmoteList)
    local yPos = 0
    for _, emote in ipairs(EmoteList) do
        local Btn = Instance.new("TextButton")
        Btn.Text = emote.Name
        Btn.Font = Enum.Font.FredokaOne
        Btn.TextSize = 16
        Btn.Size = UDim2.new(0,150,0,30)
        Btn.Position = UDim2.new(0,10,0,yPos)
        Btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Parent = EmoteFrame

        Btn.MouseButton1Click:Connect(function()
            pcall(function()
                LocalPlayer.Character.Humanoid:LoadAnimation(Instance.new("Animation",LocalPlayer.Character){AnimationId=emote.AnimationId}):Play()
            end)
        end)
        yPos = yPos + 35
    end
    EmoteFrame.CanvasSize = UDim2.new(0,0,0,yPos)
end

generateEmoteButtons(R6Emotes)

-- PART 1 SCRIPT END

-- PART 2 SCRIPT START

-- Hide/Show Frames for Tabs
local R6Frame = Instance.new("Frame")
R6Frame.Size = UDim2.new(1,0,1,-70)
R6Frame.Position = UDim2.new(0,0,0,70)
R6Frame.BackgroundTransparency = 1
R6Frame.Parent = MainFrame

local R15Frame = Instance.new("Frame")
R15Frame.Size = UDim2.new(1,0,1,-70)
R15Frame.Position = UDim2.new(0,0,0,70)
R15Frame.BackgroundTransparency = 1
R15Frame.Visible = false
R15Frame.Parent = MainFrame

local OtherFrame = Instance.new("Frame")
OtherFrame.Size = UDim2.new(1,0,1,-70)
OtherFrame.Position = UDim2.new(0,0,0,70)
OtherFrame.BackgroundTransparency = 1
OtherFrame.Visible = false
OtherFrame.Parent = MainFrame

R6TabBtn.MouseButton1Click:Connect(function()
    R6Frame.Visible = true
    R15Frame.Visible = false
    OtherFrame.Visible = false
end)

R15TabBtn.MouseButton1Click:Connect(function()
    R6Frame.Visible = false
    R15Frame.Visible = true
    OtherFrame.Visible = false
end)

OtherTabBtn.MouseButton1Click:Connect(function()
    R6Frame.Visible = false
    R15Frame.Visible = false
    OtherFrame.Visible = true
end)

-- Minimize Button
local Minimized = false
MinButton.MouseButton1Click:Connect(function()
    if not Minimized then
        MainFrame.Size = UDim2.new(0,150,0,30)
        EmoteFrame.Visible = false
        R6Frame.Visible = false
        R15Frame.Visible = false
        OtherFrame.Visible = false
        Minimized = true
    else
        MainFrame.Size = UDim2.new(0,600,0,400)
        EmoteFrame.Visible = true
        R6Frame.Visible = true
        Minimized = false
    end
end)

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Function to play R6 Emotes correctly
local function playEmote(animationId)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum then
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://"..animationId
        local track = hum:LoadAnimation(anim)
        track:Play()
    end
end

-- Generate Buttons for R6 Frame
local function generateR6Buttons(emotes)
    local yPos = 0
    for _, emote in ipairs(emotes) do
        local Btn = Instance.new("TextButton")
        Btn.Text = emote.Name
        Btn.Font = Enum.Font.FredokaOne
        Btn.TextSize = 16
        Btn.Size = UDim2.new(0,150,0,30)
        Btn.Position = UDim2.new(0,10,0,yPos)
        Btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        Btn.TextColor3 = Color3.fromRGB(255,255,255)
        Btn.Parent = R6Frame

        Btn.MouseButton1Click:Connect(function()
            pcall(function()
                playEmote(emote.AnimationId)
            end)
        end)
        yPos = yPos + 35
    end
end

generateR6Buttons(R6Emotes)

-- PART 2 SCRIPT END
