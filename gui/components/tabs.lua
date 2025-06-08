-- gui/components/tabs.lua

local Theme = require("gui/components/theme")

local Tabs = {}

function Tabs.Create(parent, tabNames, onTabChanged)
    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, -20, 0, 36)
    tabBar.Position = UDim2.new(0, 10, 0, 45)
    tabBar.BackgroundTransparency = 1
    tabBar.Parent = parent

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Horizontal
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 6)
    layout.Parent = tabBar

    local tabButtons = {}
    local currentTab = nil

    for i, tabName in ipairs(tabNames) do
        local btn = Instance.new("TextButton")
        btn.Text = tabName
        btn.Size = UDim2.new(0, 110, 1, 0)
        btn.BackgroundColor3 = Theme.Frame or Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = Theme.TextSecondary or Color3.fromRGB(180, 180, 180)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.AutoButtonColor = true
        btn.Parent = tabBar

        local uicorner = Instance.new("UICorner")
        uicorner.CornerRadius = UDim.new(0, 8)
        uicorner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            if currentTab == btn then return end
            currentTab = btn
            for _, b in pairs(tabButtons) do
                b.BackgroundColor3 = Theme.Frame or Color3.fromRGB(40, 40, 40)
                b.TextColor3 = Theme.TextSecondary or Color3.fromRGB(180, 180, 180)
            end
            btn.BackgroundColor3 = Theme.Accent or Color3.fromRGB(100, 100, 255)
            btn.TextColor3 = Theme.TextPrimary or Color3.fromRGB(255, 255, 255)
            onTabChanged(tabName)
        end)

        tabButtons[tabName] = btn

        if i == 1 then
            currentTab = btn
            btn.BackgroundColor3 = Theme.Accent or Color3.fromRGB(100, 100, 255)
            btn.TextColor3 = Theme.TextPrimary or Color3.fromRGB(255, 255, 255)
        end
    end

    return tabBar
end

return Tabs
