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





-- PART 3A START
-- My Emotes Hub — UI & core functionality (gradient-wave outline, tabs, minimize/maximize/close, Q restore,
-- universal emote playback with rig detection, animation speed slider + textbox sync, draggable UI)
-- This part builds the fixed UI and core functions. Emote lists (full) can be provided or loaded from raw links.

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- helper
local function safeParent(inst,p) pcall(function() inst.Parent = p end) end

-- create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MyEmotesHubGui"
screenGui.ResetOnSpawn = false
safeParent(screenGui, PlayerGui)

-- main frame
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0,520,0,420)
main.Position = UDim2.new(0.5,-260,0.45,-210)
main.BackgroundColor3 = Color3.fromRGB(28,28,28)
main.BorderSizePixel = 0
main.AnchorPoint = Vector2.new(0.5,0.5)
main.Parent = screenGui

-- rounded corners
local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0,14)

-- subtle inner panel for gradient outline layering
local outlineHolder = Instance.new("Frame")
outlineHolder.Name = "OutlineHolder"
outlineHolder.Size = UDim2.new(1,8,1,8)
outlineHolder.Position = UDim2.new(0,-4,0,-4)
outlineHolder.BackgroundTransparency = 1
outlineHolder.ZIndex = 0
outlineHolder.Parent = main

-- animated gradient overlay (gradient-wave effect)
local gradFrame = Instance.new("Frame")
gradFrame.Size = UDim2.new(1,0,1,0)
gradFrame.Position = UDim2.new(0,0,0,0)
gradFrame.BackgroundTransparency = 1
gradFrame.Parent = outlineHolder

local uiGrad = Instance.new("UIGradient", gradFrame)
uiGrad.Rotation = 0
uiGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255,127,0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255,255,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,0)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0,0,255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75,0,130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(148,0,211))
}

-- create an outer stroke using an ImageLabel that clips to edge (neon look)
local stroke = Instance.new("ImageLabel")
stroke.Name = "NeonStroke"
stroke.Size = UDim2.new(1,12,1,12)
stroke.Position = UDim2.new(0,-6,0,-6)
stroke.BackgroundTransparency = 1
stroke.Image = "rbxassetid://0" -- invisible base, we use UIGradient for color effect
stroke.Parent = outlineHolder
stroke.ZIndex = 0

-- add a UIGradient to stroke to make neon effect
local strokeGrad = Instance.new("UIGradient", stroke)
strokeGrad.Color = uiGrad.Color
strokeGrad.Rotation = 0
strokeGrad.Offset = Vector2.new(0,0)

-- create an inner border frame to sit visually above gradient (so main content is readable)
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1,-8,1,-8)
content.Position = UDim2.new(0,4,0,4)
content.BackgroundColor3 = Color3.fromRGB(20,20,20)
content.BorderSizePixel = 0
content.Parent = main
local contentCorner = Instance.new("UICorner", content)
contentCorner.CornerRadius = UDim.new(0,12)

-- Title bar (top)
local topBar = Instance.new("Frame", content)
topBar.Size = UDim2.new(1,0,0,36)
topBar.Position = UDim2.new(0,0,0,0)
topBar.BackgroundColor3 = Color3.fromRGB(32,32,32)
topBar.BorderSizePixel = 0

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(0.7,0,1,0)
title.Position = UDim2.new(0,12,0,0)
title.BackgroundTransparency = 1
title.Text = "My Emotes"
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.FredokaOne
title.TextSize = 20
title.TextColor3 = Color3.fromRGB(255,255,255)

-- minimize / close buttons
local btnMin = Instance.new("TextButton", topBar)
btnMin.Size = UDim2.new(0,34,0,26)
btnMin.Position = UDim2.new(0.76,0,0.1,0)
btnMin.Text = "−"
btnMin.Font = Enum.Font.FredokaOne
btnMin.TextSize = 20
btnMin.BackgroundColor3 = Color3.fromRGB(50,50,50)
btnMin.TextColor3 = Color3.fromRGB(255,255,255)
btnMin.AutoButtonColor = true
local btnClose = Instance.new("TextButton", topBar)
btnClose.Size = UDim2.new(0,34,0,26)
btnClose.Position = UDim2.new(0.86,0,0.1,0)
btnClose.Text = "✕"
btnClose.Font = Enum.Font.FredokaOne
btnClose.TextSize = 18
btnClose.BackgroundColor3 = Color3.fromRGB(50,50,50)
btnClose.TextColor3 = Color3.fromRGB(255,255,255)
btnClose.AutoButtonColor = true

-- tab buttons row
local tabsRow = Instance.new("Frame", content)
tabsRow.Size = UDim2.new(1,0,0,36)
tabsRow.Position = UDim2.new(0,0,0,36)
tabsRow.BackgroundTransparency = 1

local function makeTabBtn(text, posX)
    local b = Instance.new("TextButton", tabsRow)
    b.Size = UDim2.new(0,120,1,0)
    b.Position = UDim2.new(0,posX,0,0)
    b.Text = text
    b.Font = Enum.Font.FredokaOne
    b.TextSize = 16
    b.BackgroundColor3 = Color3.fromRGB(34,34,34)
    b.TextColor3 = Color3.fromRGB(240,240,240)
    local c = Instance.new("UICorner", b)
    c.CornerRadius = UDim.new(0,8)
    return b
end

local tabR6 = makeTabBtn("R6", 12)
local tabR15 = makeTabBtn("R15", 140)
local tabOther = makeTabBtn("Other", 268)

-- content area (scrolling frames)
local function makeScrollArea()
    local sc = Instance.new("ScrollingFrame", content)
    sc.Size = UDim2.new(1,-14,1,-120)
    sc.Position = UDim2.new(0,7,0,80)
    sc.CanvasSize = UDim2.new(0,0,0,0)
    sc.ScrollBarThickness = 8
    sc.BackgroundTransparency = 1
    local layout = Instance.new("UIListLayout", sc)
    layout.Padding = UDim.new(0,8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    return sc
end

local scrollR6 = makeScrollArea()
local scrollR15 = makeScrollArea()
local scrollOther = makeScrollArea()
scrollR15.Visible = false
scrollOther.Visible = false

-- print/status box
local statusBox = Instance.new("TextLabel", content)
statusBox.Size = UDim2.new(1,-20,0,36)
statusBox.Position = UDim2.new(0,10,1,-46)
statusBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
statusBox.TextColor3 = Color3.fromRGB(220,220,220)
statusBox.Font = Enum.Font.FredokaOne
statusBox.TextSize = 16
statusBox.Text = "Ready"
local statusCorner = Instance.new("UICorner", statusBox)
statusCorner.CornerRadius = UDim.new(0,8)

-- minimize / close logic
local isMin = false
local storedProps = {Size = main.Size, Position = main.Position}
btnMin.MouseButton1Click:Connect(function()
    if not isMin then
        storedProps.Size = main.Size
        storedProps.Position = main.Position
        main.Size = UDim2.new(0,260,0,36)
        main.Position = UDim2.new(0.5,-130,0.9,-18)
        content.Visible = false
        outlineHolder.Visible = true
        isMin = true
        btnMin.Text = "+"
    else
        main.Size = storedProps.Size
        main.Position = storedProps.Position
        content.Visible = true
        isMin = false
        btnMin.Text = "−"
    end
end)
btnClose.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
    statusBox.Text = "UI closed. Press Q to restore."
end)

-- Q key restore with notification
UserInputService.InputBegan:Connect(function(inp, gpe)
    if gpe then return end
    if inp.KeyCode == Enum.KeyCode.Q then
        if not screenGui.Enabled then screenGui.Enabled = true end
        -- small notification
        local note = Instance.new("TextLabel", screenGui)
        note.Size = UDim2.new(0,220,0,36)
        note.Position = UDim2.new(0.5,-110,0.9,0)
        note.BackgroundColor3 = Color3.fromRGB(30,30,30)
        note.TextColor3 = Color3.fromRGB(255,255,255)
        note.Font = Enum.Font.FredokaOne
        note.TextSize = 16
        note.Text = "🟢 UI Restored (Q)"
        note.AnchorPoint = Vector2.new(0.5,0.5)
        note.BorderSizePixel = 0
        local tw = TweenService:Create(note, TweenInfo.new(2, Enum.EasingStyle.Quad), {TextTransparency = 1, BackgroundTransparency = 1})
        tw:Play()
        delay(2, function() pcall(function() note:Destroy() end) end)
    end
end)

-- gradient wave animation: continuously rotate gradient and slightly offset stroke to create moving wave
local rot = 0
RunService.RenderStepped:Connect(function(dt)
    rot = (rot + dt * 18) % 360
    uiGrad.Rotation = rot
    strokeGrad.Rotation = -rot
end)

-- draggable (touch + mouse robust)
do
    local dragging = false
    local dragInput, dragStart, startPos
    local uis = UserInputService

    local function update(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    uis.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            update(input)
        end
    end)
end

-- ANIMATION PLAYBACK (universal rig detection)
local function playAnimationById(animId, speed)
    speed = tonumber(speed) or 1
    local char = LocalPlayer.Character
    if not char then statusBox.Text = "No character found"; return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then statusBox.Text = "No Humanoid found"; return end
    -- ensure valid id like "123456789" or "rbxassetid://123"
    local id = tostring(animId):match("%d+")
    if not id then statusBox.Text = "Invalid animation id"; return end
    local anim = Instance.new("Animation")
    anim.Name = "MyEmoteAnim"
    anim.AnimationId = "rbxassetid://"..id
    local ok, track = pcall(function() return hum:LoadAnimation(anim) end)
    if not ok or not track then
        statusBox.Text = "Failed to load animation "..tostring(id)
        return
    end
    track:Play()
    -- adjust speed safely
    pcall(function() track:AdjustSpeed(speed) end)
    statusBox.Text = "Playing: "..tostring(animId)
end

-- SLIDER + TEXTBOX (animation speed)
local otherControls = Instance.new("Frame", scrollOther)
otherControls.Size = UDim2.new(1, -20, 0, 60)
otherControls.Position = UDim2.new(0, 10, 0, 6)
otherControls.BackgroundTransparency = 1

local speedLabel = Instance.new("TextLabel", otherControls)
speedLabel.Text = "Anim Speed"
speedLabel.Size = UDim2.new(0,120,1,0)
speedLabel.Position = UDim2.new(0,0,0,0)
speedLabel.BackgroundTransparency = 1
speedLabel.Font = Enum.Font.FredokaOne
speedLabel.TextSize = 14
speedLabel.TextColor3 = Color3.fromRGB(220,220,220)

local speedBox = Instance.new("TextBox", otherControls)
speedBox.Size = UDim2.new(0,80,0,28)
speedBox.Position = UDim2.new(0,130,0,8)
speedBox.Text = "1"
speedBox.ClearTextOnFocus = false
speedBox.Font = Enum.Font.FredokaOne
speedBox.TextSize = 14
speedBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
speedBox.TextColor3 = Color3.fromRGB(240,240,240)
local speedSliderBg = Instance.new("Frame", otherControls)
speedSliderBg.Size = UDim2.new(0,240,0,12)
speedSliderBg.Position = UDim2.new(0,220,0,22)
speedSliderBg.BackgroundColor3 = Color3.fromRGB(60,60,60)
local sliderCorner = Instance.new("UICorner", speedSliderBg)
sliderCorner.CornerRadius = UDim.new(0,6)

local sliderHandle = Instance.new("Frame", speedSliderBg)
sliderHandle.Size = UDim2.new(0,14,1,0)
sliderHandle.Position = UDim2.new(0,0,0,0)
sliderHandle.BackgroundColor3 = Color3.fromRGB(200,200,200)
local handleCorner = Instance.new("UICorner", sliderHandle)
handleCorner.CornerRadius = UDim.new(0,6)

-- helper to set slider and textbox
local function setSpeedFromValue(value)
    value = math.clamp(value, 0.1, 10)
    speedBox.Text = tostring(math.floor(value*100)/100)
    local width = speedSliderBg.AbsoluteSize.X - sliderHandle.AbsoluteSize.X
    sliderHandle.Position = UDim2.new(0, math.floor((value - 0.1) / (10 - 0.1) * width), 0, 0)
end

-- initial
local initialSpeed = tonumber(speedBox.Text) or 1
-- wait for absolute size
spawn(function()
    wait(0.1)
    setSpeedFromValue(initialSpeed)
end)

-- make slider draggable
do
    local dragging = false
    local function update(pos)
        local abs = speedSliderBg.AbsolutePosition.X
        local width = speedSliderBg.AbsoluteSize.X - sliderHandle.AbsoluteSize.X
        local x = math.clamp(pos.X - abs, 0, width)
        local value = 0.1 + (x / (width)) * (10 - 0.1)
        setSpeedFromValue(value)
    end
    sliderHandle.InputBegan:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            ip.Changed:Connect(function()
                if ip.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(ip)
        if dragging and (ip.UserInputType == Enum.UserInputType.MouseMovement or ip.UserInputType == Enum.UserInputType.Touch) then
            update(ip.Position)
        end
    end)
    speedSliderBg.InputBegan:Connect(function(ip)
        if ip.UserInputType == Enum.UserInputType.MouseButton1 or ip.UserInputType == Enum.UserInputType.Touch then
            update(ip.Position)
        end
    end)
    speedBox.FocusLost:Connect(function()
        local num = tonumber(speedBox.Text)
        if num then setSpeedFromValue(num) else speedBox.Text = "1" end
    end)
end

-- TAB SWITCHING LOGIC (show/hide scroll areas)
tabR6.MouseButton1Click:Connect(function()
    scrollR6.Visible = true
    scrollR15.Visible = false
    scrollOther.Visible = false
end)
tabR15.MouseButton1Click:Connect(function()
    scrollR6.Visible = false
    scrollR15.Visible = true
    scrollOther.Visible = false
end)
tabOther.MouseButton1Click:Connect(function()
    scrollR6.Visible = false
    scrollR15.Visible = false
    scrollOther.Visible = true
end)

-- EMOTE BUTTON CREATION (re-usable)
local function createEmoteEntry(parent, displayName, animId)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,-16,0,34)
    btn.BackgroundColor3 = Color3.fromRGB(46,46,46)
    btn.TextColor3 = Color3.fromRGB(240,240,240)
    btn.Font = Enum.Font.FredokaOne
    btn.TextSize = 16
    btn.AutoButtonColor = true
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,8)
    btn.Text = displayName
    btn.Parent = parent

    local play = Instance.new("TextButton", btn)
    play.Size = UDim2.new(0,48,1,0)
    play.Position = UDim2.new(1,-52,0,0)
    play.Text = "Play"
    play.Font = Enum.Font.FredokaOne
    play.BackgroundColor3 = Color3.fromRGB(70,130,70)
    play.TextColor3 = Color3.fromRGB(255,255,255)
    local pc = Instance.new("UICorner", play)
    pc.CornerRadius = UDim.new(0,8)

    play.MouseButton1Click:Connect(function()
        local speed = tonumber(speedBox.Text) or 1
        playAnimationById(animId, speed)
    end)

    -- optionally, clicking the row also plays
    btn.MouseButton1Click:Connect(function()
        local speed = tonumber(speedBox.Text) or 1
        playAnimationById(animId, speed)
    end)
    return btn
end

-- Example: populate with a small set first; later parts will append full lists
local sampleR6 = {
    {"/e dance","507776043"},
    {"/e wave","507770239"},
    {"/e cheer","507773423"},
    {"/e laugh","507773736"}
}
for _,v in ipairs(sampleR6) do
    createEmoteEntry(scrollR6, v[1], v[2])
end

local sampleR15 = {
    {"R15 Wave","507771019"},
    {"R15 Dance","507777826"}
}
for _,v in ipairs(sampleR15) do
    createEmoteEntry(scrollR15, v[1], v[2])
end

-- OTHER tab: monster mash placeholder (will equip or play depending on item)
createEmoteEntry(scrollOther, "Monster Mash (Equip/Play)", "507776789")

-- adjust canvas sizes after populating
local function fixCanvas(sf)
    local layout = sf:FindFirstChildOfClass("UIListLayout")
    if layout then
        sf.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 12)
    end
end
fixCanvas(scrollR6)
fixCanvas(scrollR15)
fixCanvas(scrollOther)

-- helper to load emote IDs from a raw GitHub script (will look for rbxassetid://123456)
local function extractIdsFromRaw(raw)
    local ids = {}
    for id in raw:gmatch("rbxassetid://(%d+)") do
        table.insert(ids, id)
    end
    -- also try plain numeric animation ids
    for id in raw:gmatch("(%d%d%d%d%d%d%d%d%d%d+)") do
        table.insert(ids, id)
    end
    return ids
end

-- function to fetch and populate emotes from remote raw scripts (AquaMatrix / SILLY origin)
local function fetchAndPopulate(rawUrl, parent, prefix)
    spawn(function()
        local success, raw = pcall(function() return HttpService:GetAsync(rawUrl, true) end)
        if not success or not raw then
            statusBox.Text = "Failed to fetch emotes from remote."
            return
        end
        local ids = extractIdsFromRaw(raw)
        if #ids == 0 then
            statusBox.Text = "No animation ids found in remote."
            return
        end
        for i,id in ipairs(ids) do
            createEmoteEntry(parent, (prefix or "Emote ")..tostring(i), id)
        end
        fixCanvas(parent)
        statusBox.Text = "Loaded "..tostring(#ids).." emotes from remote."
    end)
end

-- Example usage (replace with actual raw URLs in later parts)
-- fetchAndPopulate("https://raw.githubusercontent.com/.../AquaMatrix.lua", scrollR6, "Aqua R6 ")
-- fetchAndPopulate("https://raw.githubusercontent.com/.../SillyOrigin.lua", scrollR15, "Silly R15 ")

statusBox.Text = "UI ready. Use tabs to switch. Use slider/text to set speed."
-- PART 3A END


-- PART 3B START
-- My Emotes Hub — UI fixes & full core functionality (soft-wave rainbow outline, drag, tabs,
-- universal emote playback (R6/R15 auto-detect), slider+textbox speed sync, custom emote loader)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- safe create helper
local function New(class, props)
    local o = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            pcall(function() o[k] = v end)
        end
    end
    return o
end

-- remove old if present
pcall(function()
    local old = PlayerGui:FindFirstChild("MyEmotesHubGui")
    if old then old:Destroy() end
end)

-- SCREEN GUI
local screenGui = New("ScreenGui", {Name="MyEmotesHubGui", ResetOnSpawn=false, Parent=PlayerGui})

-- MAIN FRAME
local main = New("Frame", {
    Name = "Main",
    Size = UDim2.new(0,540,0,460),
    Position = UDim2.new(0.5,-270,0.45,-230),
    AnchorPoint = Vector2.new(0.5,0.5),
    BackgroundColor3 = Color3.fromRGB(24,24,24),
    BorderSizePixel = 0,
    Parent = screenGui
})
New("UICorner", {Parent = main, CornerRadius = UDim.new(0,14)})

-- OUTLINE HOLDER (for soft-wave gradient)
local outlineHolder = New("Frame", {Parent = main, Size = UDim2.new(1,8,1,8), Position = UDim2.new(0,-4,0,-4), BackgroundTransparency = 1, ZIndex = 0})
local outlineFrame = New("Frame", {Parent = outlineHolder, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1})
local stroke = New("Frame", {Parent = outlineHolder, Size = UDim2.new(1,6,1,6), Position = UDim2.new(0,-3,0,-3), BackgroundTransparency = 1})
New("UICorner", {Parent = stroke, CornerRadius = UDim.new(0,16)})

-- UIGradient used for soft-wave; we'll animate Rotation to create moving wave effect
local strokeGrad = New("UIGradient", {Parent = stroke})
strokeGrad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,0)),
    ColorSequenceKeypoint.new(0.16, Color3.fromRGB(255,127,0)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255,255,0)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,255,0)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0,0,255)),
    ColorSequenceKeypoint.new(0.83, Color3.fromRGB(75,0,130)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(148,0,211))
}
strokeGrad.Rotation = 0
strokeGrad.Offset = Vector2.new(0,0)

-- CONTENT (inner readable area)
local content = New("Frame", {Parent = main, Size = UDim2.new(1,-8,1,-8), Position = UDim2.new(0,4,0,4), BackgroundColor3 = Color3.fromRGB(18,18,18)})
New("UICorner", {Parent = content, CornerRadius = UDim.new(0,12)})

-- TOP BAR
local topBar = New("Frame", {Parent = content, Size = UDim2.new(1,0,0,40), BackgroundColor3 = Color3.fromRGB(28,28,28)})
New("UICorner", {Parent = topBar, CornerRadius = UDim.new(0,10)})
local title = New("TextLabel", {Parent = topBar, Text = "My Emotes", Font = Enum.Font.FredokaOne, TextSize = 20, TextColor3 = Color3.fromRGB(245,245,245), BackgroundTransparency = 1, Position = UDim2.new(0,12,0,0), Size = UDim2.new(0.6,0,1,0), TextXAlignment = Enum.TextXAlignment.Left})

local btnMin = New("TextButton", {Parent = topBar, Text = "−", Font = Enum.Font.FredokaOne, TextSize = 20, Size = UDim2.new(0,34,0,28), Position = UDim2.new(0.74,0,0.08,0), BackgroundColor3 = Color3.fromRGB(42,42,42), TextColor3 = Color3.fromRGB(240,240,240)})
New("UICorner", {Parent = btnMin, CornerRadius = UDim.new(0,8)})
local btnClose = New("TextButton", {Parent = topBar, Text = "✕", Font = Enum.Font.FredokaOne, TextSize = 18, Size = UDim2.new(0,34,0,28), Position = UDim2.new(0.85,0,0.08,0), BackgroundColor3 = Color3.fromRGB(42,42,42), TextColor3 = Color3.fromRGB(240,240,240)})
New("UICorner", {Parent = btnClose, CornerRadius = UDim.new(0,8)})

-- TABS ROW
local tabsRow = New("Frame", {Parent = content, Size = UDim2.new(1,0,0,40), Position = UDim2.new(0,0,0,40), BackgroundTransparency = 1})
local function MakeTab(text, x)
    local b = New("TextButton", {Parent = tabsRow, Text = text, Font = Enum.Font.FredokaOne, TextSize = 16, Size = UDim2.new(0,140,1,0), Position = UDim2.new(0,x,0,0), BackgroundColor3 = Color3.fromRGB(34,34,34), TextColor3 = Color3.fromRGB(240,240,240)})
    New("UICorner", {Parent = b, CornerRadius = UDim.new(0,8)})
    return b
end
local tabR6 = MakeTab("R6", 12)
local tabR15 = MakeTab("R15", 162)
local tabOther = MakeTab("Other", 312)

-- Scroll areas
local function MakeScroll(parent)
    local sc = New("ScrollingFrame", {Parent = parent, Size = UDim2.new(1,-24,1,-150), Position = UDim2.new(0,12,0,96), BackgroundTransparency = 1, ScrollBarThickness = 8})
    local layout = New("UIListLayout", {Parent = sc})
    layout.Padding = UDim.new(0,8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    return sc
end
local scrollR6 = MakeScroll(content)
local scrollR15 = MakeScroll(content)
local scrollOther = MakeScroll(content)
scrollR15.Visible = false
scrollOther.Visible = false

-- STATUS BOX
local statusBox = New("TextLabel", {Parent = content, Size = UDim2.new(1,-24,0,36), Position = UDim2.new(0,12,1,-46), BackgroundColor3 = Color3.fromRGB(34,34,34), TextColor3 = Color3.fromRGB(230,230,230), Font = Enum.Font.FredokaOne, TextSize = 15, Text = "Ready"})
New("UICorner", {Parent = statusBox, CornerRadius = UDim.new(0,8)})

-- MINIMIZE/CLOSE/RESTORE logic
local isMin = false
local prevProps = {Size = main.Size, Position = main.Position}
btnMin.MouseButton1Click:Connect(function()
    if not isMin then
        prevProps.Size = main.Size
        prevProps.Position = main.Position
        main.Size = UDim2.new(0,260,0,40)
        main.Position = UDim2.new(0.5, -130, 0.9, -20)
        content.Visible = false
        isMin = true
        btnMin.Text = "+"
    else
        main.Size = prevProps.Size
        main.Position = prevProps.Position
        content.Visible = true
        isMin = false
        btnMin.Text = "−"
    end
end)

btnClose.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
    statusBox.Text = "UI closed. Press Q to restore."
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        screenGui.Enabled = true
        -- tiny notification
        local note = New("TextLabel", {Parent = screenGui, Size = UDim2.new(0,220,0,36), Position = UDim2.new(0.5,-110,0.9,0), BackgroundColor3 = Color3.fromRGB(30,30,30), TextColor3 = Color3.fromRGB(255,255,255), Font = Enum.Font.FredokaOne, TextSize = 16, Text = "🟢 UI Restored (Q)", AnchorPoint = Vector2.new(0.5,0.5)})
        New("UICorner", {Parent = note, CornerRadius = UDim.new(0,8)})
        TweenService:Create(note, TweenInfo.new(2, Enum.EasingStyle.Quad), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
        delay(2, function() pcall(function() note:Destroy() end) end)
    end
end)

-- SOFT-WAVE ANIMATION: slowly rotate gradient to create moving wave across outline
RunService.RenderStepped:Connect(function(dt)
    strokeGrad.Rotation = (strokeGrad.Rotation + dt * 14) % 360
    -- subtle offset wave
    local t = tick() * 0.22
    strokeGrad.Offset = Vector2.new( math.sin(t)*0.2, math.cos(t)*0.2 )
end)

-- DRAGGING (topBar)
do
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- UNIVERSAL EMOTE PLAYBACK
local function playAnimationById(animId, speed)
    speed = tonumber(speed) or 1
    if not animId then statusBox.Text = "Invalid animation id"; return end
    local char = LocalPlayer.Character
    if not char then statusBox.Text = "No character"; return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then statusBox.Text = "No humanoid"; return end
    local id = tostring(animId):match("(%d+)")
    if not id then statusBox.Text = "Invalid id"; return end
    local anim = New("Animation", {})
    anim.AnimationId = "rbxassetid://"..id
    local ok, track = pcall(function() return hum:LoadAnimation(anim) end)
    if not ok or not track then
        statusBox.Text = "Failed to load "..tostring(id)
        return
    end
    track:Play()
    pcall(function() track:AdjustSpeed(speed) end)
    statusBox.Text = "Playing "..tostring(animId)
end

-- SLIDER + TEXTBOX SYNC (in Other tab)
local controls = New("Frame", {Parent = scrollOther, Size = UDim2.new(1,-24,0,80), Position = UDim2.new(0,12,0,6), BackgroundTransparency = 1})
local lbl = New("TextLabel", {Parent = controls, Text = "Animation Speed", Font = Enum.Font.FredokaOne, TextSize = 14, TextColor3 = Color3.fromRGB(230,230,230), BackgroundTransparency = 1, Size = UDim2.new(0,140,1,0)})
local speedBox = New("TextBox", {Parent = controls, Text = "1", ClearTextOnFocus = false, Font = Enum.Font.FredokaOne, TextSize = 14, BackgroundColor3 = Color3.fromRGB(44,44,44), TextColor3 = Color3.fromRGB(240,240,240), Size = UDim2.new(0,84,0,28), Position = UDim2.new(0,150,0,12)})
New("UICorner", {Parent = speedBox, CornerRadius = UDim.new(0,6)})

local trackBg = New("Frame", {Parent = controls, Size = UDim2.new(0,260,0,12), Position = UDim2.new(0,250,0,32), BackgroundColor3 = Color3.fromRGB(60,60,60)})
New("UICorner", {Parent = trackBg, CornerRadius = UDim.new(0,6)})
local handle = New("Frame", {Parent = trackBg, Size = UDim2.new(0,12,1,0), Position = UDim2.new(0,0,0,0), BackgroundColor3 = Color3.fromRGB(200,200,200)})
New("UICorner", {Parent = handle, CornerRadius = UDim.new(0,6)})

local function setSpeed(v)
    v = math.clamp(tonumber(v) or 1, 0.1, 10)
    speedBox.Text = tostring(math.floor(v*100)/100)
    local width = trackBg.AbsoluteSize.X - handle.AbsoluteSize.X
    handle.Position = UDim2.new(0, math.floor((v - 0.1) / (10 - 0.1) * width), 0, 0)
end

-- wait for absolute size then init
spawn(function() wait(0.1) setSpeed(tonumber(speedBox.Text) or 1) end)

-- handle dragging
do
    local dragging = false
    local function update(pos)
        local abs = trackBg.AbsolutePosition.X
        local width = trackBg.AbsoluteSize.X - handle.AbsoluteSize.X
        local x = math.clamp(pos.X - abs, 0, width)
        local val = 0.1 + (x / width) * (10 - 0.1)
        setSpeed(val)
    end
    handle.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dragging=true i.Changed:Connect(function() if i.UserInputState==Enum.UserInputState.End then dragging=false end end) end end)
    UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then update(i.Position) end end)
    trackBg.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then update(i.Position) end end)
    speedBox.FocusLost:Connect(function() setSpeed(tonumber(speedBox.Text) or 1) end)
end

-- EMOTE ROW CREATOR (adds Play button and sets up click)
local function createEmoteEntry(parent, name, animId)
    local row = New("Frame", {Parent = parent, Size = UDim2.new(1,-12,0,40), BackgroundTransparency = 1})
    local btn = New("TextButton", {Parent = row, Size = UDim2.new(1, -80, 1, 0), Position = UDim2.new(0,0,0,0), Text = name, Font = Enum.Font.FredokaOne, TextSize = 15, BackgroundColor3 = Color3.fromRGB(40,40,40), TextColor3 = Color3.fromRGB(240,240,240), AutoButtonColor = true})
    New("UICorner", {Parent = btn, CornerRadius = UDim.new(0,8)})
    local playBtn = New("TextButton", {Parent = row, Size = UDim2.new(0,72,1,0), Position = UDim2.new(1,-72,0,0), Text = "Play", Font = Enum.Font.FredokaOne, TextSize = 14, BackgroundColor3 = Color3.fromRGB(72,148,72), TextColor3 = Color3.fromRGB(255,255,255)})
    New("UICorner", {Parent = playBtn, CornerRadius = UDim.new(0,8)})
    local function doPlay()
        local speed = tonumber(speedBox.Text) or 1
        spawn(function() pcall(function() playAnimationById(animId, speed) end) end)
    end
    playBtn.MouseButton1Click:Connect(doPlay)
    btn.MouseButton1Click:Connect(doPlay)
    return row
end

-- SAMPLE EMOTES (small sets; later parts will add full lists)
local sampleR6 = {
    {"/e dance", "507776043"},
    {"/e wave", "507770239"},
    {"/e cheer", "507773423"},
    {"/e laugh", "507773736"}
}
local sampleR15 = {
    {"R15 Dance 1", "507777826"},
    {"R15 Wave", "507771019"}
}
for _,e in ipairs(sampleR6) do createEmoteEntry(scrollR6, e[1], e[2]) end
for _,e in ipairs(sampleR15) do createEmoteEntry(scrollR15, e[1], e[2]) end
createEmoteEntry(scrollOther, "Monster Mash (placeholder)", "507776789")

-- fix canvas sizes
local function fixCanvas(sf)
    local layout = sf:FindFirstChildOfClass("UIListLayout")
    if layout then
        sf.CanvasSize = UDim2.new(0,0,0, layout.AbsoluteContentSize.Y + 12)
    end
end
fixCanvas(scrollR6); fixCanvas(scrollR15); fixCanvas(scrollOther)

-- CUSTOM EMOTE LOADER (manual ID)
local customRow = New("Frame", {Parent = scrollOther, Size = UDim2.new(1,-12,0,46), BackgroundTransparency = 1})
local customBox = New("TextBox", {Parent = customRow, Size = UDim2.new(0.64,0,0,32), Position = UDim2.new(0,0,0,8), Text = "", PlaceholderText = "Paste animation id or rbxassetid://...", Font = Enum.Font.FredokaOne, ClearTextOnFocus = false, BackgroundColor3 = Color3.fromRGB(44,44,44), TextColor3 = Color3.fromRGB(240,240,240)})
New("UICorner", {Parent = customBox, CornerRadius = UDim.new(0,6)})
local customPlay = New("TextButton", {Parent = customRow, Size = UDim2.new(0,100,0,32), Position = UDim2.new(1,-100,0,8), Text = "🔧 Play Custom", Font = Enum.Font.FredokaOne, BackgroundColor3 = Color3.fromRGB(70,130,180), TextColor3 = Color3.fromRGB(255,255,255)})
New("UICorner", {Parent = customPlay, CornerRadius = UDim.new(0,6)})
customPlay.MouseButton1Click:Connect(function()
    local txt = customBox.Text
    local id = tostring(txt):match("(%d+)")
    if not id then statusBox.Text = "Invalid custom ID" return end
    local speed = tonumber(speedBox.Text) or 1
    playAnimationById(id, speed)
end)

statusBox.Text = "UI fixed. Soft-wave outline active. Use tabs to browse emotes."
-- PART 3B END
