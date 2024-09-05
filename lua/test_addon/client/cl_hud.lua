local function CreatePlayerInfoUI()
    local profileIconMat = Material("profile_card.png", "noclamp smooth")
    local walletIconMat = Material("wallet.png", "noclamp smooth")
    local healthIconMat = Material("health.png", "noclamp smooth")
    local shieldIconMat = Material("shield.png", "noclamp smooth")
    local hungerIconMat = Material("hunger.png", "noclamp smooth")

    surface.CreateFont("CustomJobFont", {
        font = "Trebuchet MS",
        size = 18,
        weight = 900,
        italic = true
    })

    surface.CreateFont("Bold", {
        font = "Trebuchet MS",
        size = 30,
        weight = 800,
        italic = false 
    })

    local frameX = 100
    local frameY = ScrH() - 250

    draw.RoundedBox(8, frameX, frameY + 130, 300, 50, Color(0, 0, 0, 150))

    surface.SetMaterial(profileIconMat)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(frameX + 10, frameY + 10, 40, 40)

    draw.SimpleText(LocalPlayer():Nick(), "Trebuchet24", frameX + 60, frameY + 10, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(LocalPlayer():getDarkRPVar("job"), "CustomJobFont", frameX + 60, frameY + 30, Color(240, 240, 240), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    surface.SetMaterial(walletIconMat)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(frameX + 10, frameY + 65, 40, 40)

    draw.SimpleText(LocalPlayer():getDarkRPVar("money") .. "$", "Trebuchet24", frameX + 60, frameY + 70, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.RoundedBox(8, frameX + 127, frameY + 68, 50, 30, Color(0, 255, 0, 100))
    draw.SimpleText("+$" .. LocalPlayer():getDarkRPVar("salary"), "Trebuchet24", frameX + 130, frameY + 70, Color(0, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    surface.SetMaterial(healthIconMat)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(frameX + 10, frameY + 140, 30, 30)

    draw.SimpleText(LocalPlayer():Health(), "Bold", frameX + 45, frameY + 140, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    surface.SetMaterial(shieldIconMat)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(frameX + 110, frameY + 140, 30, 30)

    draw.SimpleText(LocalPlayer():Armor(), "Bold", frameX + 145, frameY + 140, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    surface.SetMaterial(hungerIconMat)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(frameX + 210, frameY + 140, 30, 30)

    draw.SimpleText(LocalPlayer():getDarkRPVar("Energy"), "Bold", frameX + 250, frameY + 140, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end

local function DisplayIdentityImage()
    local margin = 20
    local screenWidth = ScrW()
    local screenHeight = ScrH()

    local imagePath = "identity text.png"
    local imageMat = Material(imagePath, "noclamp smooth")

    local imageWidth = imageMat:Width()
    local imageHeight = imageMat:Height()

    local xPos = (screenWidth - imageWidth) / 2
    local yPos = margin

    surface.SetMaterial(imageMat)
    surface.SetDrawColor(255, 255, 255, 255)
    surface.DrawTexturedRect(xPos, yPos, imageWidth, imageHeight)
end

hook.Add("HUDShouldDraw", "HideDefaultHUD", function(name)
    local hideHUDElements = {
        ["CHudHealth"] = true,
        ["CHudBattery"] = true,
        ["CHudAmmo"] = true,
        ["CHudSecondaryAmmo"] = true,
        ["CHudCrosshair"] = true,
        ["CHudWeaponSelection"] = true,
        ["CHudChat"] = true,
        ["CHudDamageIndicator"] = true
    }

    if hideHUDElements[name] then
        return false
    end
end)

hook.Add("HUDShouldDraw", "HideSpecificDarkRPHud", function(name)
    local hideElements = {
        ["DarkRP_HUD"] = true,
        ["DarkRP_EntityDisplay"] = true,
        ["DarkRP_LocalPlayerHUD"] = true,
        ["DarkRP_Hungermod"] = true,
        ["DarkRP_Agenda"] = true
    }

    if hideElements[name] then
        return false
    end
end)

hook.Add("HUDPaint", "DrawCustomHUD", function()
    local ply = LocalPlayer()

    if IsValid(ply) and ply:Alive() then
        DisplayIdentityImage()
        CreatePlayerInfoUI()
    end
end)
