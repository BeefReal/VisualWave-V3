-- gui/components/theme.lua

local Themes = {}

local ThemeFolder = script.Parent.Parent.Parent:FindFirstChild("themes")
-- FUTURE: May need to adjust path

-- loading
for _, themeModule in ipairs(ThemeFolder:GetChildren()) do
    if themeModule:IsA("ModuleScript") then
        local name = themeModule.Name:lower()
        Themes[name] = require(themeModule)
    end
end

local currentTheme = Themes["default"] or {}

-- apply
function Themes.applyTheme(guiElements, themeName)
    local theme = Themes[themeName:lower()]
    if not theme then
        warn("Theme not found:", themeName)
        return
    end
    currentTheme = theme

    -- colors
    if guiElements.MainFrame then
        guiElements.MainFrame.BackgroundColor3 = theme.BackgroundColor
    end
    if guiElements.TitleLabel then
        guiElements.TitleLabel.TextColor3 = theme.TextColor
    end
    if guiElements.TabButtons then
        for _, button in pairs(guiElements.TabButtons) do
            button.BackgroundColor3 = theme.ButtonColor
            button.TextColor3 = theme.TextColor
        end
    end
    if guiElements.ScrollFrames then
        for _, scrollFrame in pairs(guiElements.ScrollFrames) do
            scrollFrame.ScrollBarImageColor3 = theme.ScrollbarColor
        end
    end
    -- element
end

return Themes
