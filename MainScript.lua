-- MainScript.lua for VisualWave
-- Dynamically loads all components and builds the GUI

local function import(path)
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/BeefReal/VisualWave-V3/main/" .. path))()
    end)
    if not success then
        warn("[VisualWave] Failed to load: " .. path .. "\nError: " .. tostring(result))
    end
    return result
end

-- Create folder structure in memory
local visualWave = Instance.new("Folder")
visualWave.Name = "VisualWave"
visualWave.Parent = game.CoreGui

local guiFolder = Instance.new("Folder")
guiFolder.Name = "gui"
guiFolder.Parent = visualWave

local guiComponents = Instance.new("Folder")
guiComponents.Name = "components"
guiComponents.Parent = guiFolder

local modulesFolder = Instance.new("Folder")
modulesFolder.Name = "modules"
modulesFolder.Parent = visualWave

local utilsFolder = Instance.new("Folder")
utilsFolder.Name = "utils"
utilsFolder.Parent = visualWave

local themesFolder = Instance.new("Folder")
themesFolder.Name = "themes"
themesFolder.Parent = visualWave

-- Load GUI components
guiComponents.tabs = import("gui/components/tabs.lua")
guiComponents.buttons = import("gui/components/buttons.lua")
guiComponents.keybinds = import("gui/components/keybinds.lua")
guiComponents.theme = import("gui/components/theme.lua")

-- Load GUI system
guiFolder.init = import("gui/init.lua")

-- Load Modules
modulesFolder["init"] = import("modules/init.lua")
modulesFolder["combat"] = import("modules/combat.lua")
modulesFolder["world"] = import("modules/world.lua")
modulesFolder["render"] = import("modules/render.lua")
modulesFolder["misc"] = import("modules/misc.lua")
modulesFolder["handler"] = import("modules/handler.lua")

-- Load Utils
utilsFolder["entity"] = import("utils/entity.lua")
utilsFolder["input"] = import("utils/input.lua")
utilsFolder["drawing"] = import("utils/drawing.lua")
utilsFolder["settings"] = import("utils/settings.lua")

-- Load Themes
themesFolder["default"] = import("themes/default.lua")
themesFolder["vaporwave"] = import("themes/vaporwave.lua")
themesFolder["dark"] = import("themes/dark.lua")

-- Start GUI
local GuiService = guiFolder.init
if GuiService and GuiService.Create then
    GuiService:Create()
else
    warn("[VisualWave] GuiService failed to initialize")
end
