local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = ReplicatedStorage:WaitForChild('Remotes')


return {
    GetMoney = Remotes.Event1
}