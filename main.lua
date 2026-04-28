local utils = require ("utils")
local player = require ("player.player")
local playerActions = require ("player.actions")
local colossus = require ("colossus.colossus")
local colossusActions = require ("colossus.actions")

utils.enableUTF8()
utils.printHeader()

print(string.format("Olá %s, sua vida atual é %d/%d", player.name, player.health, player.maxHealth))

local boss = colossus
local bossActions = colossusActions

utils.printCreature(boss)

playerActions.build()
bossActions.build()

    while true do 
        print()
        print(string.format("Qual será sua ação %s?", player.name))
        local validPlayerActions = playerActions.getValidACtions(player, colossus)
        for i, action in pairs(validPlayerActions) do
            print(string.format("%d, %s", i, action.description))
        end
        local chosenIndex = utils.ask()
        local chosenAction = validPlayerActions[chosenIndex]
        local isActionValid = chosenAction ~= nil

        if isActionValid then
            chosenAction.execute(player, boss)
        else
            print(string.format("Sua escolha é invalida, %s perdeu o turno", player.name))
        end

        if boss.health <= 0 then
            break
        end
        
        print()
        local validBossActions = bossActions.getValidACtions(player, boss)
        local bossActions = validBossActions[math.random(#validBossActions)]
        bossActions.execute(player, boss)

        if player.health <= 0 then
            break
        end

    end
