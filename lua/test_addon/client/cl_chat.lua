local function CreateChatUI()
    myChat = {}

    myChat.dFrame = vgui.Create("DFrame")
    myChat.dFrame:SetSize(500, 300)
    myChat.dFrame:SetPos(50, ScrH() - 600)
    myChat.dFrame:SetTitle("")
    myChat.dFrame:SetDraggable(false)
    myChat.dFrame:ShowCloseButton(false)
    myChat.dFrame:SetVisible(true)
    myChat.dFrame:MakePopup()
    myChat.dFrame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 200))
    end

    myChat.dRichText = vgui.Create("RichText", myChat.dFrame)
    myChat.dRichText:SetPos(10, 10)
    myChat.dRichText:SetSize(480, 230)
    myChat.dRichText:SetVerticalScrollbarEnabled(true)

    myChat.dTextEntry = vgui.Create("DTextEntry", myChat.dFrame)
    myChat.dTextEntry:SetPos(10, 250)
    myChat.dTextEntry:SetSize(350, 30)
    myChat.dTextEntry.OnEnter = function(self)
        local text = self:GetValue()
        chat.AddText(Color(255, 255, 255), text)
        myChat.dRichText:InsertColorChange(255, 255, 255, 255)
        myChat.dRichText:AppendText("\n" .. text)
        self:SetText("")
    end

    myChat.occButton = vgui.Create("DButton", myChat.dFrame)
    myChat.occButton:SetPos(370, 250)
    myChat.occButton:SetSize(60, 30)
    myChat.occButton:SetText("OOC")
    myChat.occButton.DoClick = function()
        -- Action pour le bouton OOC
    end

    myChat.advertButton = vgui.Create("DButton", myChat.dFrame)
    myChat.advertButton:SetPos(440, 250)
    myChat.advertButton:SetSize(60, 30)
    myChat.advertButton:SetText("ADVERT")
    myChat.advertButton.DoClick = function()
        -- Action pour le bouton ADVERT
    end
end

hook.Add( "PlayerBindPress", "overrideChatbind", function( ply, bind, pressed )
    local bTeam = false
    if bind == "messagemode" then
        print( "global chat" )
    elseif bind == "messagemode2" then
        print( "team chat" )
        bTeam = true
    else
        return
    end

    myChat.openChatbox( bTeam )

    return true -- Doesn't allow any functions to be called for this bind
end )

hook.Add( "ChatText", "serverNotifications", function( index, name, text, type )
    if type == "joinleave" or type == "none" then
        myChat.dRichText:AppendText( text .. "\n" )
    end
end )

hook.Add( "HUDShouldDraw", "noMoreDefault", function( name )
	if name == "CHudChat" then
		return false
	end
end )

local oldAddText = chat.AddText
function chat.AddText( ... )
	local args = {...} -- Create a table of varargs

	for _, obj in ipairs( args ) do
		if type( obj ) == "table" then -- We were passed a color object
			myChat.dRichText:InsertColorChange( obj.r, obj.g, obj.b, 255 )
		elseif type( obj ) == "string"  then -- This is just a string
			myChat.dRichText:AppendText( obj )
		elseif obj:IsPlayer() then
			local col = GAMEMODE:GetTeamColor( obj ) -- Get the player's team color
			myChat.dRichText:InsertColorChange( col.r, col.g, col.b, 255 ) -- Make their name that color
			myChat.dRichText:AppendText( obj:Nick() )
		end
	end

	-- Gotta end our line for this message
	myChat.dRichText:AppendText( "\n" )

	-- Call the original function
	oldAddText( ... )
end

hook.Add("InitPostEntity", "CreateCustomUI", function()
    CreateChatUI()
end)