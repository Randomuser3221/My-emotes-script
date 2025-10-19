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
-- PART 2

local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local UI = script.Parent:WaitForChild("MainFrame")

-- Smooth rainbow outline
local Outline = UI:WaitForChild("Outline")
local Hue = 0
game:GetService("RunService").RenderStepped:Connect(function(dt)
    Hue = (Hue + dt*0.2) % 1
    local color = Color3.fromHSV(Hue, 1, 1)
    Outline.BackgroundColor3 = color
end)

-- Drag functionality
local dragging = false
local dragInput, mousePos, framePos
UI.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = UI.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
UI.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        UI.Position = framePos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

-- Minimize & Close
local minimizeBtn = UI:WaitForChild("MinimizeBtn")
local closeBtn = UI:WaitForChild("CloseBtn")
local miniBar = script:WaitForChild("MiniBar")

minimizeBtn.MouseButton1Click:Connect(function()
    UI.Visible = false
    miniBar.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    UI.Visible = false
    miniBar.Visible = false
end)

miniBar.OpenBtn.MouseButton1Click:Connect(function()
    UI.Visible = true
    miniBar.Visible = false
end)

-- Q keybind notification
UIS.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.Q then
        UI.Visible = true
        miniBar.Visible = false
        -- Notification
        local notif = Instance.new("TextLabel")
        notif.Size = UDim2.new(0,200,0,40)
        notif.Position = UDim2.new(0.5,-100,0.1,0)
        notif.BackgroundTransparency = 0.5
        notif.Text = "UI Shown via Q"
        notif.Parent = UI.Parent
        game.Debris:AddItem(notif,2)
    end
end)
