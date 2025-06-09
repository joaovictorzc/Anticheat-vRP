if not Detections.Stamina then
  print("[anticheat] Stamina detection is disabled.")
  return
end

CreateThread(function()
  while true do
    Wait(5000)
    if not IsPedInAnyVehicle(cache.ped, true) and not IsPedRagdoll(cache.ped) and not IsPedFalling(cache.ped) and not IsPedJumpingOutOfVehicle(cache.ped) and not IsPedInParachuteFreeFall(cache.ped) and GetEntitySpeed(cache.ped) > 6.9 then
      local staminaLevel = GetPlayerSprintStaminaRemaining(cache.playerId)
      if tonumber(staminaLevel) == 0.0 then
        print("[Anticheat] Stamina detected: Player sprinting without stamina.")
        TriggerServerEvent("ac:record", "Stamina")
      end
    end
  end
end)