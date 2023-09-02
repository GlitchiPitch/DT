local CollectionService = game:GetService("CollectionService")


local PlayerManager  = {}

function PlayerManager.GetGui(player)
    local gui = player.PlayerGui.MainGui

    local targetHpScreen = gui.targetHpScreen.Label
    return {targetHpScreen = targetHpScreen }
end

function PlayerManager.PlayerData()
    -- money
    -- destroyedParts
    -- exp
end

function PlayerManager.SetMoney(player, value)
    local leaderstats = player.leaderstats
    local money = leaderstats.Money
    money += value
end

function PlayerManager.DestroyedPartsCount(player, id)
    -- table.insert(id)
end

return PlayerManager