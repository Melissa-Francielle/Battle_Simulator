local actions = {}

actions.list = {}

function actions.build()
    actions.list = {}

    local swordAttack = {
        description = " Atacar com a espada",
        requirement = nil,
        execute = function (playerData, creatureData)
            local sucessChance = creatureData.speed == 0 and 1 or playerData.speed / creatureData.speed
            local sucess = math.random() <= sucessChance
            local rawDamage = playerData.attack - math.random() * creatureData.defense

            local damage = math.max(1, math.ceil(rawDamage))
            
            if sucess then
                print(string.format("A criatura recebeu danos (%d)", damage))
                creatureData.health = creatureData.health - damage
            else
                print("O ataque não causou danos na criatura")
            end
        end     
    }

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