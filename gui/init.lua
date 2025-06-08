-- gui/init.lua

-- installs gui sys
-- loads components

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

    Tabs:Create(frame)

    return screenGui
end

return GuiService
