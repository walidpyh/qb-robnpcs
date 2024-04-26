local aimingAtNPC = false
    local QBCore = exports['qb-core']:GetCoreObject()
    local canrob = true

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            
            local playerPed = PlayerPedId()
            local currentWeapon = GetSelectedPedWeapon(playerPed)
            
            if canrob == true and IsPedAPlayer(playerPed) and IsPedArmed(playerPed, 7) and currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
                local hit, entity = GetEntityPlayerIsFreeAimingAt(PlayerId())
                
                if hit and canrob == true and IsPedHuman(entity) and not IsPedAPlayer(entity) then
                    aimingAtNPC = true
                    local npcPed = entity
                    
                    SetBlockingOfNonTemporaryEvents(npcPed, true)
                    SetPedFleeAttributes(npcPed, 0, false)
                    SetPedCombatAttributes(npcPed, 17, true)
                    SetPedCombatAttributes(npcPed, 46, true)
                    
                    TaskHandsUp(npcPed, -1, playerPed, -1, true)
                    Citizen.Wait(5000)
                    TaskPlayAnim(npcPed, "mp_common", "givetake1_a", 8.0, -8.0, -1, 1, 0, false, false, false)
                    ClearPedTasks(npcPed)
                    local amount = math.random(Config.minamount, Config.maxamount)
                    if amount <= 0 then
                        QBCore.Functions.Notify(Config.nomoneymsg)
                        return
                    end

                    TriggerServerEvent("addmoney:addMoney", amount)
                    QBCore.Functions.Notify("You got from them $" .. amount)
                    canrob = false
                    Citizen.Wait(Config.cooldown)
                    canrob = true
                else
                    aimingAtNPC = false
                end
            else
                aimingAtNPC = false
            end
        end
end)