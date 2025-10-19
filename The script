-- My Emotes Enhanced
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local Mouse = Player:GetMouse()

-- UI Setup
local Font = Enum.Font.GothamBlack
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyEmotesUI"
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 520, 0, 420)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0,15)

-- Tabs: R6, R15, Settings
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1,0,0,50)
TabFrame.BackgroundTransparency = 1
TabFrame.Parent = MainFrame

local function createTab(name, x)
    local btn = Instance.new("TextButton")
    btn.Text = name
    btn.Font = Font
    btn.TextSize = 20
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Size = UDim2.new(0,100,1,0)
    btn.Position = UDim2.new(0,x,0,0)
    btn.Parent = TabFrame
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0,12)
    return btn
end

local r6Tab = createTab("R6",10)
local r15Tab = createTab("R15",120)
local settingsTab = createTab("Settings",230)

-- Scrolling Frames
local function createScroll()
    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1,-20,1,-60)
    scroll.Position = UDim2.new(0,10,0,50)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.ScrollBarThickness = 6
    scroll.Parent = MainFrame
    return scroll
end

local r6Scroll = createScroll()
local r15Scroll = createScroll()
r15Scroll.Visible = false
local settingsScroll = createScroll()
settingsScroll.Visible = false

-- Print box
local printBox = Instance.new("TextLabel")
printBox.Size = UDim2.new(1,-20,0,30)
printBox.Position = UDim2.new(0,10,1,-40)
printBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
printBox.TextColor3 = Color3.fromRGB(255,255,255)
printBox.Font = Font
printBox.TextSize = 16
printBox.Text = "Status: Ready"
printBox.Parent = MainFrame
local corner2 = Instance.new("UICorner", printBox)
corner2.CornerRadius = UDim.new(0,8)

-- Animation Speed
local animSpeed = 1
local speedLabel = Instance.new("TextLabel")
speedLabel.Text = "Anim Speed:"
speedLabel.Font = Font
speedLabel.TextSize = 16
speedLabel.Position = UDim2.new(0,10,0,10)
speedLabel.Parent = settingsScroll

local speedBox = Instance.new("TextBox")
speedBox.Text = "1"
speedBox.Font = Font
speedBox.TextSize = 16
speedBox.Position = UDim2.new(0,120,0,10)
speedBox.Size = UDim2.new(0,80,0,30)
speedBox.Parent = settingsScroll

speedBox.FocusLost:Connect(function()
    local num = tonumber(speedBox.Text)
    if num and num>0 then animSpeed = num printBox.Text="Anim Speed set to "..num else printBox.Text="Invalid Speed" end
end)

-- Load Emotes from GitHub
local function getAnimations(url)
    local success, data = pcall(function() return HttpService:GetAsync(url) end)
    if success then
        local ids = {}
        for id in data:gmatch("rbxassetid://(%d+)") do
            table.insert(ids, tonumber(id))
        end
        return ids
    else
        printBox.Text="Failed to load emotes"
        return {}
    end
end

-- Example URLs (replace with your R6/R15 GitHub raw links)
local r6IDs = getAnimations("https://rawscripts.net/raw/Universal-Script-AquaMatrix-24778")
local r15IDs = getAnimations("https://rawscripts.net/raw/Universal-Script-FE-SILLY-EMOTES-ORIGIN-51285")

-- Function to create buttons
local function addEmoteButtons(scrollFrame, ids)
    local y=10
    for i,id in pairs(ids) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-20,0,40)
        btn.Position = UDim2.new(0,10,0,y)
        btn.Text = "Emote "..i
        btn.Font = Font
        btn.TextSize = 18
        btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Parent = scrollFrame
        local corner = Instance.new("UICorner",btn)
        corner.CornerRadius = UDim.new(0,8)

        btn.MouseButton1Click:Connect(function()
            local humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://"..id
                local track = humanoid:LoadAnimation(anim)
                track:AdjustSpeed(animSpeed)
                track:Play()
                printBox.Text = "Animation Played ✅"
            else
                printBox.Text = "No Humanoid ❌"
            end
        end)
        y=y+50
    end
    scrollFrame.CanvasSize = UDim2.new(0,0,0,y)
end

addEmoteButtons(r6Scroll, r6IDs)
addEmoteButtons(r15Scroll, r15IDs)

-- Tab Switching
r6Tab.MouseButton1Click:Connect(function()
    r6Scroll.Visible=true
    r15Scroll.Visible=false
    settingsScroll.Visible=false
end)
r15Tab.MouseButton1Click:Connect(function()
    r6Scroll.Visible=false
    r15Scroll.Visible=true
    settingsScroll.Visible=false
end)
settingsTab.MouseButton1Click:Connect(function()
    r6Scroll.Visible=false
    r15Scroll.Visible=false
    settingsScroll.Visible=true
end)

-- Search Bar
local searchBox = Instance.new("TextBox")
searchBox.PlaceholderText="Search Emotes..."
searchBox.Size=UDim2.new(0,200,0,30)
searchBox.Position=UDim2.new(0,300,0,10)
searchBox.Font=Font
searchBox.TextSize=16
searchBox.Parent=MainFrame

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = searchBox.Text:lower()
    for _, btn in pairs(r6Scroll:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.Visible=btn.Text:lower():find(query)~=nil
        end
    end
    for _, btn in pairs(r15Scroll:GetChildren()) do
        if btn:IsA("TextButton") then
            btn.Visible=btn.Text:lower():find(query)~=nil
        end
    end
end)
