local maxStamina = 100
local staminaRegenRate = 10
local staminaDrainRate = 20
local playerStamina = maxStamina
local isRunning = false

local function HandlePlayerStamina()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    if ply:KeyDown(IN_SPEED) and playerStamina > 0 then
        playerStamina = math.max(playerStamina - staminaDrainRate * FrameTime(), 0)
        isRunning = true
    else
        playerStamina = math.min(playerStamina + staminaRegenRate * FrameTime(), maxStamina)
        isRunning = false
    end

    if playerStamina <= 0 and ply:KeyDown(IN_SPEED) then
        ply:SetRunSpeed(ply:GetWalkSpeed())
    elseif playerStamina > 0 and not ply:KeyDown(IN_SPEED) then
        ply:SetRunSpeed(ply:GetWalkSpeed() * 2)
    end
end

local function DrawStaminaBar()
    local runningMat = Material("run.png", "noclamp smooth")
    
    local staminaBarWidth = 300
    local staminaBarHeight = 20
    local frameX = (ScrW() / 2) - (staminaBarWidth / 2)
    local frameY = ScrH() - 100
    
    surface.SetMaterial(runningMat)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(ScrW() / 2 - (runningMat:Width() / 2), frameY - 60, 40, 40)
    draw.RoundedBox(8, frameX, frameY, staminaBarWidth, staminaBarHeight, Color(0, 0, 0, 150))
    draw.RoundedBox(8, frameX, frameY, (playerStamina / maxStamina) * staminaBarWidth, staminaBarHeight, Color(0, 255, 0, 200))
end

hook.Add("Think", "UpdatePlayerStamina", HandlePlayerStamina)

hook.Add("HUDPaint", "DrawStaminaHUD", function()
    local ply = LocalPlayer()

    if IsValid(ply) and ply:Alive() then
        DrawStaminaBar()
    end
end)