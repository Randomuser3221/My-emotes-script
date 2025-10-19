-- Core UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EmoteUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Parent = ScreenGui

-- Tab Buttons
local TabButtons = Instance.new("Frame")
TabButtons.Name = "TabButtons"
TabButtons.Size = UDim2.new(1, 0, 0, 50)
TabButtons.Position = UDim2.new(0, 0, 0, 0)
TabButtons.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TabButtons.Parent = MainFrame

local R6TabBtn = Instance.new("TextButton")
R6TabBtn.Name = "R6TabBtn"
R6TabBtn.Size = UDim2.new(0, 100, 1, 0)
R6TabBtn.Position = UDim2.new(0, 0, 0, 0)
R6TabBtn.Text = "R6"
R6TabBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
R6TabBtn.Parent = TabButtons

local R15TabBtn = Instance.new("TextButton")
R15TabBtn.Name = "R15TabBtn"
R15TabBtn.Size = UDim2.new(0, 100, 1, 0)
R15TabBtn.Position = UDim2.new(0, 100, 0, 0)
R15TabBtn.Text = "R15"
R15TabBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
R15TabBtn.Parent = TabButtons

local OtherTabBtn = Instance.new("TextButton")
OtherTabBtn.Name = "OtherTabBtn"
OtherTabBtn.Size = UDim2.new(0, 100, 1, 0)
OtherTabBtn.Position = UDim2.new(0, 200, 0, 0)
OtherTabBtn.Text = "Other"
OtherTabBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
OtherTabBtn.Parent = TabButtons

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 1, -50)
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ContentFrame.Parent = MainFrame

-- Dragging Functionality
local dragging = false
local dragInput, mousePos, framePos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
        local delta = input.Position - mousePos
        MainFrame.Position = framePos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

-- Minimize and Close Buttons
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 50, 0, 50)
minimizeBtn.Position = UDim2.new(1, -50, 0, 0)
minimizeBtn.Text = "-"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
minimizeBtn.Parent = MainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 50, 0, 50)
closeBtn.Position = UDim2.new(1, -100, 0, 0)
closeBtn.Text = "X"
closeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
closeBtn.Parent = MainFrame

local miniBar = Instance.new("Frame")
miniBar.Name = "MiniBar"
miniBar.Size = UDim2.new(0, 100, 0, 50)
miniBar.Position = UDim2.new(0.5, -50, 0, 0)
miniBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
miniBar.Visible = false
miniBar.Parent = ScreenGui

minimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    miniBar.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    miniBar.Visible = false
end)

miniBar.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    miniBar.Visible = false
end)

-- Q Keybind to Toggle UI
local UIS = game:GetService("UserInputService")

UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Q then
        MainFrame.Visible = not MainFrame.Visible
        miniBar.Visible = not miniBar.Visible
    end
end)

local R6Emotes = {
    {Name = "Dance", AnimationId = 507767714}, 
    {Name = "Wave", AnimationId = 507766666}, 
    {Name = "Monster Mash", AnimationId = 123456789} -- AquaMatrix Gear
    -- Continue loading all AquaMatrix R6 emotes
}

local R15Emotes = {
    {Name = "Silly Dance", AnimationId = 654321987, UGC=false}, 
    {Name = "Jumping Jack", AnimationId = 987654321, UGC=false}
    -- Continue loading all FE Silly Emotes R15 emotes
}

local function generateEmoteButtons(emoteTable, parentFrame)
    local yPos = 0
    for _, emote in ipairs(emoteTable) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.Position = UDim2.new(0, 5, 0, yPos)
        btn.Text = emote.Name
        btn.Font = Enum.Font.FredokaOne
        btn.TextSize = 18
        btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
        btn.Parent = parentFrame

        btn.MouseButton1Click:Connect(function()
            -- Play the emote
            local plr = game.Players.LocalPlayer
            local character = plr.Character or plr.CharacterAdded:Wait()
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://"..emote.AnimationId
                local track = humanoid:LoadAnimation(anim)
                track:Play()
            end
        end)

        yPos = yPos + 45
    end
end

local R6Frame = Instance.new("ScrollingFrame")
R6Frame.Size = UDim2.new(1,0,1, -50)
R6Frame.Position = UDim2.new(0,0,0,50)
R6Frame.CanvasSize = UDim2.new(0,0,0,#R6Emotes*45)
R6Frame.Visible = true
R6Frame.Parent = ContentFrame

local R15Frame = Instance.new("ScrollingFrame")
R15Frame.Size = UDim2.new(1,0,1, -50)
R15Frame.Position = UDim2.new(0,0,0,50)
R15Frame.CanvasSize = UDim2.new(0,0,0,#R15Emotes*45)
R15Frame.Visible = false
R15Frame.Parent = ContentFrame

R6TabBtn.MouseButton1Click:Connect(function()
    R6Frame.Visible = true
    R15Frame.Visible = false
end)

R15TabBtn.MouseButton1Click:Connect(function()
    R6Frame.Visible = false
    R15Frame.Visible = true
end)

generateEmoteButtons(R6Emotes, R6Frame)
generateEmoteButtons(R15Emotes, R15Frame)
