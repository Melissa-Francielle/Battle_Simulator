local utils = {}


-- Função para habilitar o suporte a UTF-8 no console do Windows
function utils.enableUTF8()
    os.execute("chcp 65001")
end

-- Função para imprimir o cabeçalho do jogo
function utils.printHeader()

print([[
=============================================================================|
                             Bem vindo ao                                    |
                        SIMULADOR DE BATALHAS                                |
            -----------------------------------------------                  |
                        |\                     /)                            |
                      /\_\\__               (_//                             |
                    |   `>\-`      _._       //`)                            |
                     \ /` \\   _.-`:::`-._  //                               |
                       `    \|`    :::    `|/                                |
                             |     :::     |                                 |
                             |.....:::.....|                                 |
                             |:::::::::::::|                                 |
                             |     :::     |                                 |
                             \     :::     /                                 |
                              \    :::    /                                  |
                               `-. ::: .-'                                   |
                                //`:::`\\                                    |
                               //   '   \\                                   |
                              |/         \\                                  |
                                                                             |
=============================================================================|
                Você enpunha sua espada e se prepara para lutar.
                            Está na hora de batalhar!
            ++ ----------------------------------------------- ++
]])

end

--- comment
--- @param attribute number
--- @return string 
--- 
function utils.getProgressBar(attribute)
    local fullChar = "▰"
    local emptyChar = "▱"

    local result = ""
    for i = 1, 10, 1 do
        if i <= attribute then
            result = result .. fullChar
        else
            result = result .. emptyChar
        end
    end
    return result
end

--- comment 
--- @param creature table 
--- 
function utils.printCreature(creature)
    local healthRate = math.floor(creature.health / creature.maxHealth + 10)
    
    print("Informações carregadas com sucesso!")
    print("___________________________________________________________________")
    print("|____________________________".."INFO".."_________________________________|")
    print("|".. "\t\t\t\t\t\t\t\t  |")
    print("|" .. " Nome: " .. creature.name .. "         " .. "  \t\t\t\t\t  |")
    print("|".. "\t\t\t\t\t\t\t\t  |")
    print("|".. "\t\t\t Descrição: " .. "\t\t\t\t  |")
    print("|".. "\t\t\t\t\t\t\t\t  |")
    print("|".. creature.description .. "  \t\t\t\t\t\t\t\t  |")
    print("|" .. "_________________________________________________________________|")
    print("|".. "\t\t\t\t\t\t\t\t  |")
    print("|".. "---------------------------Atributos ----------------------------|")
    print("|".. "HP:  " .. utils.getProgressBar(healthRate) .. "\t\t\t\t\t\t  |")
    print("|".. "Ataque:  " .. utils.getProgressBar(creature.attack) .. "\t\t\t\t\t\t  |")
    print("|".. "Defesa:  " .. utils.getProgressBar(creature.defense) .. "\t\t\t\t\t\t  |")
    print("|".. "Velocidade:  " .. utils.getProgressBar(creature.speed) .. "\t\t\t\t\t  |")
    print("|".. "\t\t\t\t\t\t\t\t  |")
    print("|" .. "_________________________________________________________________|")
end


--- @return any
function utils.ask()
    io.write("> ")
    local answer = io.read("*n")
    return answer
    
end
return utils 