local utils = require("utils")
local actions = {}

actions.list = {}

function actions.build()
    actions.list = {}    

    local bodyAttack = {
        description = " Atacar com a corpo",
        requirement = nil,
        execute = function (playerData, creatureData)
            local sucessChance = playerData.speed == 0 and 1 or creatureData.speed / playerData.speed
            local sucess = math.random() <= sucessChance
            local rawDamage = creatureData.attack - math.random() * playerData.defense
            local damage = math.max(1, math.ceil(rawDamage))
            
            if sucess then
                playerData.health = playerData.health - damage
                print(string.format("%s atacou o %s e ele recebeu danos (%d)", creatureData.name, playerData.name, damage))
                local healthRate = math.floor(playerData.health / playerData.maxHealth * 10)
                
                print(string.format("%s: %s", playerData.name, utils.getProgressBar(healthRate)))
            else
                print(string.format("%s tentou atacar, mas o ataque não causou danos ao jogador", creatureData.name))
            end
        end     
    }

    local sonarAttack = {
        description = "Atacar com um grito poderoso",
        requirement = nil,
        execute = function (playerData, creatureData)
            local rawDamage = creatureData.attack - math.random() * playerData.defense
            local damage = math.max(1, math.ceil(rawDamage * 0.3))

            playerData.health = playerData.health - damage

            print(string.format("%s usou um sonar em  %s e deu %d pontos de dano", creatureData.name, playerData.name, damage))
            local healthRate = math.floor((playerData.health / playerData.maxHealth) * 10)
            print(string.format("%s: %s", playerData.name, utils.getProgressBar(healthRate)))
            
        end
    }

    local idleAction = {
        description = "Aguardando",
        requirement = nil,
        execute = function (playerData, creatureData)

            print(string.format("%s não fará nada neste turno", creatureData.name))            
        end
    }
    
    actions.list[#actions.list + 1] = bodyAttack
    actions.list[#actions.list + 1] = sonarAttack
    actions.list[#actions.list + 1] = idleAction

--[[
    local regenPotion = {
        description = "Tomar um poção de regerenação",
        requirement = function (playerData, creatureData)
            return playerData.potions >= 1
        end,
        execute = function (playerData, creatureData)
            playerData.potions = playerData.potions - 1

            local regenPotions = 5
            playerData.health = math.max(playerData.maxHealth, playerData.health + regenPotions)        
            print(string.format("A poção regenerou alguns pontos de vida!"))
        end
    }

    actions.list[#actions.list + 1] = swordAttack
]]
end

--- comment
--- @param playerData table
---@param creatureData table
--- @return table
function actions.getValidACtions(playerData, creatureData)
    local validActions = {}
    for _, acition in pairs(actions.list) do
        local requirement = actions.requirement
        local isValid = requirement == nil or requirement()
        if isValid then
            validActions[#validActions + 1] = acition
        end
    end 
    return validActions
end

return actions 
