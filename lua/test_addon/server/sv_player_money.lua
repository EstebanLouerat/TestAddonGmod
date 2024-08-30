-- sv_player_money.lua (côté serveur)
util.AddNetworkString("UpdatePlayerMoney")

hook.Add("PlayerInitialSpawn", "SetInitialPlayerMoney", function(ply)
    ply:SetNWInt("player_money", 10000) -- Par exemple, initialiser avec 10,000$
end)

-- Exemple de fonction pour donner de l'argent au joueur
function AddPlayerMoney(ply, amount)
    local currentMoney = ply:GetNWInt("player_money")
    ply:SetNWInt("player_money", currentMoney + amount)
end