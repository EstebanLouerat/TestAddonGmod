-- Server-side code to handle chat messages and store them
util.AddNetworkString("eChatMessage")          -- Create network message for receiving messages from the client
util.AddNetworkString("eChatMessageBroadcast") -- Create network message for broadcasting messages to clients

-- Server-side function to store and broadcast messages
net.Receive("eChatMessage", function(len, ply)
    local text = net.ReadString()
    local msg = "[" .. os.date("%X") .. "] " .. ply:Nick() .. ": " .. text

    -- Save message to a log or database if needed
    -- Example: Save message to a file
    file.Append("chat_log.txt", msg .. "\n")

    -- Broadcast message to all players
    net.Start("eChatMessageBroadcast")
    net.WriteString(msg)
    net.Broadcast()
end)

-- Hook to prevent the default chatbox from being opened
hook.Add("PlayerBindPress", "eChat_HijackBind", function(ply, bind, pressed)
    if string.sub(bind, 1, 11) == "messagemode" then
        -- Custom chat type (e.g., team chat, normal chat)
        ply:ConCommand("say") -- or handle chat opening here
        return true
    end
end)
 