local Theme = require("gui/components/theme.lua")
local Tabs = require("gui/components/tabs.lua")
local Buttons = require("gui/components/buttons.lua")
-- optional: local Keybinds = require("gui/components/keybinds") -- if used

local GuiService = {}

function GuiService:Create()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VisualWaveUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("CoreGui") -- or PlayerGui if you prefer

    -- Main background frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Theme.Frame
    mainFrame.Parent = screenGui

    -- Tabs
    local tabs = Tabs.Create(mainFrame, {"Combat", "Render", "World", "Misc"}, function(tab)
        print("Switched to tab:", tab)
    end)

    -- Fly Toggle
    local toggle1 = Buttons.CreateToggle(mainFrame, "Fly", "F", false, function(state)
        print("Fly toggled:", state)
    end)
    toggle1.Position = UDim2.new(0, 10, 0, 100)
    toggle1.Parent = mainFrame
end

return GuiService
