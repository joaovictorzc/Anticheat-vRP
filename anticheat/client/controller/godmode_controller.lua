if not Detections.GodMode then
  print("[anticheat] GodMode detection is disabled.")
  return
end

local expectedMaxHealth = GetEntityMaxHealth(cache.ped)
CreateThread(function()
  while true do
    Wait(5000)
    print("[GodMode] Looking for suspicious activity...")
    if not IsNuiFocused() and IsScreenFadedIn() then
      if GetPlayerInvincible(cache.playerId) or GetPlayerInvincible_2(cache.playerId) or (not GetEntityCanBeDamaged(cache.ped)) then
        print("[GodMode] GodMode detected: Player is invincible or cannot be damaged.")
        TriggerServerEvent("ac:record", "GodMode")
      end

      if GetEntityHealth(cache.ped) > expectedMaxHealth then
        print("[GodMode] GodMode detected: Entity health exceeds expected maximum health.")
        TriggerServerEvent("ac:record", "GodMode")
      end
    end
  end
end)

function setHealth(healthParam)
  if not Detections.GodMode then
    return
  end

  local health = parseInt(healthParam) or 0
  local maxHealth = GetEntityMaxHealth(cache.ped)
  if health < 0 or health > maxHealth then
    error("Valor da vida deve estar entre 0 e "..maxHealth)
  end

  expectedMaxHealth = health
end