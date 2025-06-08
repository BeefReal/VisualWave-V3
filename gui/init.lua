local Theme = require("gui/components/theme")
local Tabs = require("gui/components/tabs")
local Buttons = require("gui/components/buttons")
local Keybinds = require("gui/components/keybinds")

local GuiService = {}

function GuiService:Create()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VisualWaveUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- Set up tab buttons, toggles, etc
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Theme.Frame
    mainFrame.Parent = screenGui

    local tabs = Tabs.Create(mainFrame, {"Combat", "Render", "World", "Misc"}, function(tab)
        print("Switched to tab:", tab)
    end)

    local toggle1 = Buttons.CreateToggle(mainFrame, "Fly", "F", false, function(state)
        print("Fly toggled:", state)
    end)
    toggle1.Position = UDim2.new(0, 10, 0, 100)
    toggle1.Parent = mainFrame
end

return GuiService
