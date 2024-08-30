local function CreatePlayerInfoUI()
    local infoFrame = vgui.Create("DPanel")

    -- Importer les icônes
    local profileIconMat = Material("profile_card.png", "noclamp smooth")
    local walletIconMat = Material("wallet.png", "noclamp smooth")
    local healthIconMat = Material("health.png", "noclamp smooth")
    local shieldIconMat = Material("shield.png", "noclamp smooth")
    local hungerIconMat = Material("hunger.png", "noclamp smooth")

    surface.CreateFont("CustomJobFont", {
        font = "Trebuchet MS", -- Police de base
        size = 18,             -- Taille plus petite
        weight = 500,          -- Épaisseur de la police
        italic = true          -- Rendre la police en italique
    })

    infoFrame:SetSize(300, 250)  -- Ajuster la taille pour accommoder les icônes et le texte
    infoFrame:SetPos(100, ScrH() - 300)
    infoFrame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 150))

        -- Profile
        surface.SetMaterial(profileIconMat)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(10, 10, 40, 40)
        
        draw.SimpleText(LocalPlayer():Nick(), "Trebuchet24", 60, 10, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(LocalPlayer():getDarkRPVar("job"), "CustomJobFont", 60, 30, Color(200, 200, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)


        -- Wallet and Job
        surface.SetMaterial(walletIconMat)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(10, 65, 40, 40)

        draw.SimpleText(LocalPlayer():getDarkRPVar("money") .. "$", "Trebuchet24", 60, 70, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.RoundedBox(8, 127, 68, 50, 30, Color(0, 255, 0, 100))
        draw.SimpleText("+$" .. LocalPlayer():getDarkRPVar("salary"), "Trebuchet24", 130, 70, Color(0, 255, 0), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)


        -- Health, Shield and Energy
        surface.SetMaterial(healthIconMat)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(10, 140, 30, 30)

        draw.SimpleText(LocalPlayer():Health(), "Trebuchet24", 35, 145, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

        surface.SetMaterial(shieldIconMat)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(75, 140, 30, 30)

        draw.SimpleText(LocalPlayer():Armor(), "Trebuchet24", 100, 145, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

         surface.SetMaterial(hungerIconMat)
         surface.SetDrawColor(255, 255, 255, 255)
         surface.DrawTexturedRect(140, 140, 30, 30)
 
         draw.SimpleText(LocalPlayer():getDarkRPVar("Energy"), "Trebuchet24", 175, 145, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    end
end


local function DisplayIdentityImage()
    local margin = 20
    local screenWidth = ScrW()
    local screenHeight = ScrH()

    -- Charger l'image
    local imagePath = "identity text.png"
    local imageMat = Material(imagePath, "noclamp smooth")

    -- Calculer la taille de l'image
    local imageWidth = imageMat:Width()
    local imageHeight = imageMat:Height()

    -- Calculer la position de l'image
    local xPos = (screenWidth - imageWidth) / 2
    local yPos = margin

    -- Créer un panneau pour afficher l'image
    local imagePanel = vgui.Create("DPanel")
    imagePanel:SetSize(imageWidth, imageHeight)
    imagePanel:SetPos(xPos, yPos)
    imagePanel:SetPaintBackground(false)

    imagePanel.Paint = function(self, w, h)
        surface.SetMaterial(imageMat)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.DrawTexturedRect(0, 0, w, h)
    end
end

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

hook.Add("HUDShouldDraw", "HideDefaultHUD", function(name)
    -- Liste des éléments du HUD à cacher
    local elementsToHide = {
        ["CHudHealth"] = true,
        ["CHudBattery"] = true,
        ["CHudAmmo"] = true,
        ["CHudSecondaryAmmo"] = true,
        ["CHudCrosshair"] = true,
        ["CHudWeaponSelection"] = true,
        ["CHudChat"] = true,
        ["CHudDamageIndicator"] = true
    }

    -- Si l'élément fait partie de la liste, on ne le dessine pas
    if elementsToHide[name] then
        return false
    end
end)

hook.Add("InitPostEntity", "CreateCustomUI", function()
    CreatePlayerInfoUI()
    DisplayIdentityImage()
end)
