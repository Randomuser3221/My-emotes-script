-- My Emotes Script (Part 1: UI Setup & Tabs)

-- Destroy previous UI if exists
if game.CoreGui:FindFirstChild("MyEmotesUI") then
    game.CoreGui.MyEmotesUI:Destroy()
end

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Main UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyEmotesUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 500)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Rainbow outline
local Outline = Instance.new("UIStroke")
Outline.Parent = MainFrame
Outline.Thickness = 3
Outline.Color = Color3.fromRGB(255, 0, 0)
Outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Animate rainbow outline
local colors = {Color3.fromRGB(255,0,0),Color3.fromRGB(255,127,0),Color3.fromRGB(255,255,0),Color3.fromRGB(0,255,0),Color3.fromRGB(0,0,255),Color3.fromRGB(75,0,130),Color3.fromRGB(148,0,211)}
local colorIndex = 1
RunService.RenderStepped:Connect(function()
    Outline.Color = colors[colorIndex]
    colorIndex = colorIndex + 1
    if colorIndex > #colors then
        colorIndex = 1
    end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundTransparency = 1
Title.Text = "My Emotes"
Title.Font = Enum.Font.FredokaOne
Title.TextSize = 24
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextStrokeTransparency = 0
Title.TextScaled = true

-- Tabs
local TabFrame = Instance.new("Frame")
TabFrame.Parent = MainFrame
TabFrame.Size = UDim2.new(1,0,0,40)
TabFrame.Position = UDim2.new(0,0,0,40)
TabFrame.BackgroundTransparency = 1

local function createTabButton(name, pos)
    local button = Instance.new("TextButton")
    button.Parent = TabFrame
    button.Size = UDim2.new(0, 130, 1, 0)
    button.Position = UDim2.new(0, pos, 0, 0)
    button.Text = name
    button.Font = Enum.Font.FredokaOne
    button.TextSize = 18
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.BackgroundColor3 = Color3.fromRGB(40,40,40)
    button.BorderSizePixel = 0
    return button
end

local R6TabBtn = createTabButton("R6", 10)
local R15TabBtn = createTabButton("R15", 150)
local OtherTabBtn = createTabButton("Other", 290)

-- Container for emotes
local ContentFrame = Instance.new("ScrollingFrame")
ContentFrame.Parent = MainFrame
ContentFrame.Size = UDim2.new(1, -20, 1, -80)
ContentFrame.Position = UDim2.new(0, 10, 0, 80)
ContentFrame.CanvasSize = UDim2.new(0,0,2,0)
ContentFrame.ScrollBarThickness = 10
ContentFrame.BackgroundTransparency = 1

-- UIListLayout
local ListLayout = Instance.new("UIListLayout")
ListLayout.Parent = ContentFrame
ListLayout.Padding = UDim.new(0,5)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Function to switch tabs
local function switchTab(tabName)
    for _,v in pairs(ContentFrame:GetChildren()) do
        if v:IsA("TextButton") then
            v.Visible = false
        end
    end
    for _,v in pairs(ContentFrame:GetChildren()) do
        if v.Name:match(tabName) then
            v.Visible = true
        end
    end
end

R6TabBtn.MouseButton1Click:Connect(function() switchTab("R6") end)
R15TabBtn.MouseButton1Click:Connect(function() switchTab("R15") end)
OtherTabBtn.MouseButton1Click:Connect(function() switchTab("Other") end)
