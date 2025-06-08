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
    local chunk = modules[path]
    if not chunk then error("Module not found: " .. path) end
    return chunk()
end

-- Propagate global functions
for k, v in pairs(getfenv()) do env[k] = v end

-- Load modules into virtual memory
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

-- Run GUI init and create it
local guiService = env.require("gui/init")
guiService:Create()
