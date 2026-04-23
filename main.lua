local utils = require ("utils")
local player = require ("player.player")
local playerActions = require ("player.actions")
local colossus = require ("colossus.colossus")

utils.enableUTF8()
utils.printHeader()

print(string.format("Olá %s, sua vida atual é %d/%d", player.name, player.health, player.maxHealth))

local boss = colossus

utils.printCreature(boss)

playerActions.build()

    while true do 
        print("O que você deseja fazer?")
        local validPlayerActions = playerActions.getValidACtions(player, colossus)
        for i, action in pairs(validPlayerActions) do
            print(string.format("%d, %s", i, action.description))
        end
        local chosenIndex = utils.ask()
        print("Escolha o index: ".. chosenIndex)
        if colossus.health <= 0 then
            break
        end
        
        if player.health <= 0 then
            break
        end
    end