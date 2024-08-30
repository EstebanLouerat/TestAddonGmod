local function CreateChatUI()
    local chatFrame = vgui.Create("DFrame")
    chatFrame:SetSize(500, 300)
    chatFrame:SetPos(50, ScrH() - 600)
    chatFrame:SetTitle("")
    chatFrame:SetDraggable(false)
    chatFrame:ShowCloseButton(false)
    chatFrame:SetVisible(true)
    chatFrame:MakePopup()
    chatFrame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 200))
    end

    local chatHistory = vgui.Create("RichText", chatFrame)
    chatHistory:SetPos(10, 10)
    chatHistory:SetSize(480, 230)
    chatHistory:SetVerticalScrollbarEnabled(true)

    local chatInput = vgui.Create("DTextEntry", chatFrame)
    chatInput:SetPos(10, 250)
    chatInput:SetSize(350, 30)
    chatInput.OnEnter = function(self)
        local text = self:GetValue()
        chat.AddText(Color(255, 255, 255), text)
        chatHistory:InsertColorChange(255, 255, 255, 255)
        chatHistory:AppendText("\n" .. text)
        self:SetText("")
    end

    local occButton = vgui.Create("DButton", chatFrame)
    occButton:SetPos(370, 250)
    occButton:SetSize(60, 30)
    occButton:SetText("OOC")
    occButton.DoClick = function()
        -- Action pour le bouton OOC
    end

    local advertButton = vgui.Create("DButton", chatFrame)
    advertButton:SetPos(440, 250)
    advertButton:SetSize(60, 30)
    advertButton:SetText("ADVERT")
    advertButton.DoClick = function()
        -- Action pour le bouton ADVERT
    end
end

hook.Add("InitPostEntity", "CreateCustomUI", function()
    CreateChatUI()
end)