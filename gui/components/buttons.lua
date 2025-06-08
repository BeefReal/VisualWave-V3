-- gui/components/buttons.lua

local Theme = require("gui/components/theme")
local UserInputService = game:GetService("UserInputService")

local Buttons = {}

function Buttons.CreateToggle(parent, name, defaultKey, initialState, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 42)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Text = "▶ " .. name
    toggleBtn.Size = UDim2.new(0.65, -6, 1, 0)
    toggleBtn.BackgroundColor3 = initialState and (Theme.ButtonActive or Color3.fromRGB(85, 170, 255)) or (Theme.ButtonInactive or Color3.fromRGB(50, 50, 50))
    toggleBtn.TextColor3 = Theme.TextPrimary or Color3.fromRGB(255, 255, 255)
    toggleBtn.Font = Enum.Font.GothamSemibold
    toggleBtn.TextSize = 14
    toggleBtn.BorderSizePixel = 0
    toggleBtn.AutoButtonColor = true
    toggleBtn.Parent = container
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 6)

    local keybindBtn = Instance.new("TextButton")
    keybindBtn.Text = "Key: " .. defaultKey:upper()
    keybindBtn.Size = UDim2.new(0.35, 0, 1, 0)
    keybindBtn.Position = UDim2.new(0.65, 6, 0, 0)
    keybindBtn.BackgroundColor3 = Theme.Frame or Color3.fromRGB(30, 30, 30)
    keybindBtn.TextColor3 = Theme.TextSecondary or Color3.fromRGB(180, 180, 180)
    keybindBtn.Font = Enum.Font.Gotham
    keybindBtn.TextSize = 13
    keybindBtn.BorderSizePixel = 0
    keybindBtn.Parent = container
    Instance.new("UICorner", keybindBtn).CornerRadius = UDim.new(0, 6)

    local boundKey = defaultKey:lower()
    local waitingForBind = false
    local state = initialState

    local function updateVisual()
        toggleBtn.BackgroundColor3 = state and (Theme.ButtonActive or Color3.fromRGB(85, 170, 255)) or (Theme.ButtonInactive or Color3.fromRGB(50, 50, 50))
    end

    local function toggle()
        state = not state
        updateVisual()
        callback(state)
    end

    updateVisual()

    toggleBtn.MouseButton1Click:Connect(toggle)

    keybindBtn.MouseButton1Click:Connect(function()
        waitingForBind = true
        keybindBtn.Text = "Press key..."
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if waitingForBind and input.UserInputType == Enum.UserInputType.Keyboard then
            boundKey = input.KeyCode.Name:lower()
            keybindBtn.Text = "Key: " .. boundKey:upper()
            waitingForBind = false
        elseif input.KeyCode.Name:lower() == boundKey then
            toggle()
        end
    end)

    return container
end

return Buttons
