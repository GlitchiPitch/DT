local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService('CollectionService')

local Commutate = require(ReplicatedStorage.Commutate)

local PlayerManager = require(ServerScriptService.Modules.PlayerManager)

local tag = 'Destroyable'
local propToolsAttribute = {'Damage', 'Material'}
local BILLBOARD_DISTANCE = 100

local materials = Enum.Material

local materialsHp = {
    Wood = 10, -- materials.Wood.Name
}

local propTools = { 
    tool1 = {5, materials.Wood.Name},

}


local Map = workspace:WaitForChild('Map')
local Tools = ReplicatedStorage.Tools

local ClientManager = {}

ClientManager.__index = ClientManager

function ClientManager.setup(player)
    SetupMap()
    SetupTools()
end

function SetupTools()
    for i, tool in pairs(Tools:GetChildren()) do
        tool.Equipped:Connect(function(mouse)

            -- mouse.Move:Connect(function()
            --     -- self:ShowTargetHp(mouse.Target)
            -- end)

            mouse.Button1Down:Connect(function()
                Target(mouse.Target, tool)
            end)
        end)
    end
end

function SetupToolProperty(tool)
    for i = 1,#propToolsAttribute do
        tool:SetAttribute(propToolsAttribute[i], propTools[tool.Name][i])
    end
end

function CheckDestoryedParts()
    
end

function SetupMap()
    SetupBuild()
end

function CalculateHealth(item)
    local hp = table.unpack() * materialsHp[item.Material.Name] -- check inadd clay game + 
    return hp
end

function SetupBuild()
    for i, item in pairs(Map.Buildings:GetDescendants()) do
        if item:IsA('Part') then -- or item:IsA('UnionOperation') 
            item:SetAttribute('Health',  CalculateHealth(item))
            item:SetAttribute('Cost', CalculateHealth(item))
            createSurface(item)
        end
    end
end

function createSurface(item)
    local billboard = Instance.new('BillboardGui')
    billboard.Name = 'HealthGui'
    billboard.Parent = item
    billboard.Size = UDim2.fromScale(4,4)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = BILLBOARD_DISTANCE

    local text = Instance.new('TextLabel')
    text.Name = 'HealthLabel'
    text.Size = UDim2.fromScale(1,1)
    text.TextScaled = true
    text.BackgroundTransparency = 1
    text.Text = item:GetAttribute('Health')
    text.Parent = billboard

end

function Target(mouseTarget, tool)
    local hasTag = CollectionService:HasTag(tag)
    local toolCouldDestroyThisMaterial = mouseTarget.Material == tool:GetAttribute('Material')

    if hasTag and toolCouldDestroyThisMaterial then

        mouseTarget:SetAttribute('Health', mouseTarget:GetAttribute('Health') - tool:GetAttribute('Damage'))
        mouseTarget.HealthGui.HealthLabel.Text = mouseTarget:GetAttribute('Health')
        if mouseTarget:GetAttribute('Health') <= 0 then
            -- local player = game.Players:GetPlayerFromCharacter(tool.Parent)
            Commutate.GetMoney:FireServer(mouseTarget:GetAttribute('Cost'), mouseTarget:GetAttribute('Id'))
            mouseTarget:Destroy()
        end
    end
end

-- function ClientManager:ShowTargetHp(mouseTarget)
--     if CollectionService:HasTag(tag) then

--     end
-- end

return ClientManager