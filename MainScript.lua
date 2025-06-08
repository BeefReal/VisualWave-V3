local repo = "https://raw.githubusercontent.com/BeefReal/VisualWave-V3/main/"

local function import(file)
    return loadstring(game:HttpGet(repo .. file))()
end

-- Load modules
local Theme = import("gui/components/theme.lua")
local Tabs = import("gui/components/tabs.lua")
local Buttons = import("gui/components/buttons.lua")
local Keybinds = import("gui/components/keybinds.lua")

-- Setup GUI
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

    Tabs.Create(frame, {"Exploits", "Render", "World", "Misc"}, function(tab) end)

    return screenGui
end

GuiService:Create()
