function printRed(text)
    print("^1" .. text)
end
printRed("Cybr Rob NPCs")




local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("addmoney:addMoney")
AddEventHandler("addmoney:addMoney", function(amount)
    local src = source

    local player = QBCore.Functions.GetPlayer(src)
     if player then
        player.Functions.AddMoney("cash", amount)
        end
end)
