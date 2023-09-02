local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ServerScriptService.Modules
local Commutate = require(ReplicatedStorage.Commutate)
local PlayerManager = require(Modules.PlayerManager)



local Map = workspace:WaitForChild('Map')
local Buildings = Map:WaitForChild('Buildings')


local Game = {}

Game.__index = Game

function Game.new(player)
    local self = setmetatable({}, Game)

    self.Player = player

    return self
end

function Game:Init()
    
end

function Game:Subs()
    Commutate.GetMoney.OnServerEvent:Connect(function(player, cost, id)
        PlayerManager.SetMoney(player, cost)
    end)
end

return Game