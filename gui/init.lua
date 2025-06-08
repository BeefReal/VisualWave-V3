-- gui/init.lua

local Tabs = require(script.components.tabs)
local Buttons = require(script.components.buttons)
local Theme = require(script.components.theme)
local Keybinds = require(script.components.keybinds)

local GuiService = {}

function GuiService:Create()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VisualWaveUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 800, 0, 500)
    frame.Position = UDim2.new(0.5, -400, 0.5, -250)
    frame.BackgroundColor3 = Theme.BackgroundColor
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = Theme.BorderColor
    stroke.Thickness = 1.2
    stroke.Parent = frame

    -- Define your tab names
    local tabNames = {"Exploit", "Settings", "Render", "World", "Misc"}

    -- Create container for tab content frames
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -20, 1, -100)
    contentContainer.Position = UDim2.new(0, 10, 0, 90)
    contentContainer.BackgroundTransparency = 1
    contentContainer.Parent = frame

    -- Create one content frame per tab (empty for now)
    local tabContents = {}
    for _, tabName in ipairs(tabNames) do
        local tabFrame = Instance.new("Frame")
        tabFrame.Size = UDim2.new(1, 0, 1, 0)
        tabFrame.BackgroundTransparency = 1
        tabFrame.Visible = false
        tabFrame.Parent = contentContainer
        tabContents[tabName] = tabFrame
    end

    -- Show first tab content initially
    tabContents[tabNames[1]].Visible = true

    -- Callback when tab changes
    local function onTabChanged(selectedTab)
        for tabName, tabFrame in pairs(tabContents) do
            tabFrame.Visible = (tabName == selectedTab)
        end
    end

    -- Create tabs bar with names and callback
    Tabs:Create(frame, tabNames, onTabChanged)

    return screenGui
end

return GuiService
