-- VisualWave MainScript (Loadstring-compatible)
-- Dynamically loads all modules and creates a virtual require system

if not isfile or not loadstring or not game or not game:HttpGet then
    warn("Unsupported executor or environment")
    return
end

local baseUrl = "https://raw.githubusercontent.com/BeefReal/VisualWave-V3/main/"
local files = {
    ["gui/init"] = "gui/init.lua",
    ["gui/components/tabs"] = "gui/components/tabs.lua",
    ["gui/components/buttons"] = "gui/components/buttons.lua",
    ["gui/components/theme"] = "gui/components/theme.lua",
    ["gui/components/keybinds"] = "gui/components/keybinds.lua",
    ["modules/init"] = "modules/init.lua",
    ["modules/combat"] = "modules/combat.lua",
    ["modules/render"] = "modules/render.lua",
    ["modules/world"] = "modules/world.lua",
    ["modules/misc"] = "modules/misc.lua",
    ["utils/entity"] = "utils/entity.lua",
    ["utils/input"] = "utils/input.lua",
    ["utils/drawing"] = "utils/drawing.lua",
    ["utils/settings"] = "utils/settings.lua",
    ["themes/default"] = "themes/default.lua",
    ["themes/vaporwave"] = "themes/vaporwave.lua",
    ["themes/dark"] = "themes/dark.lua",
}

local modules = {}
local env = {}

-- Fake require system
env.require = function(path)
    local moduleFunc = modules[path]
    if not moduleFunc then error("Module not found: " .. path) end
    -- Cache the result after first run
    if type(moduleFunc) == "function" then
        local result = moduleFunc()
        modules[path] = result
        return result
    else
        return moduleFunc
    end
end

-- Copy all global functions and variables into our environment
for k, v in pairs(getfenv() or _G) do
    env[k] = v
end

-- Load all modules into virtual memory environment
for id, urlPath in pairs(files) do
    local success, result = pcall(function()
        local source = game:HttpGet(baseUrl .. urlPath)
        local func = loadstring(source, "@" .. id)
        setfenv(func, env)
        modules[id] = func
    end)
    if not success then
        warn("Failed to load module:", id, result)
    end
end

-- Initialize the GUI
local guiService = env.require("gui/init")
local screenGui = guiService:Create()

-- Parent the GUI to CoreGui if not already parented (safety check)
if screenGui and not screenGui.Parent then
    screenGui.Parent = game:GetService("CoreGui")
end
