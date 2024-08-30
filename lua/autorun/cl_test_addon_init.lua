local function loadCl(file)
    if SERVER then
        AddCSLuaFile(file)

    elseif CLIENT then
        include(file)

    end
end

local function loadSv(file)
    if SERVER then
        include(file)
    end
end

local function loadSh(file)
    if SERVER then
        AddCSLuaFile(file)
    end
    include(file)
end

local addonPath = "test_addon/"


-- loadSh(addonPath .."shared/sh_config.lua")

loadCl(addonPath .."client/cl_hud.lua")
loadCl(addonPath .."client/cl_chat.lua")

loadSv(addonPath .."server/sv_player_money.lua")

print("[Test] HUD System Loaded")