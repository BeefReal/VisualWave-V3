local HttpGet = function(url)
    return loadstring(game:HttpGet(url, true))()
end

-- Load modules manually
local Theme = HttpGet("https://raw.githubusercontent.com/BeefReal/VisualWave-V3/main/gui/components/theme.lua")
local Buttons = HttpGet("https://raw.githubusercontent.com/BeefReal/VisualWave-V3/main/gui/components/buttons.lua")
local Tabs = HttpGet("https://raw.githubusercontent.com/BeefReal/VisualWave-V3/main/gui/components/tabs.lua")

-- Create GUI manually here (since init.lua expects `require`)
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

-- Use Tabs
Tabs.Create(frame, { "Exploits", "Render", "World", "Misc" }, function(tab)
    print("Switched to tab:", tab)
end)
