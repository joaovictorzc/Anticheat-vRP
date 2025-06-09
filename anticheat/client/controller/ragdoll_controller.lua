if not Detections.AntiRagdoll then
  print("[anticheat] AntiRagdoll detection is disabled.")
  return
end

CreateThread(function()
  while true do
    Wait(800)
    if IsPedRagdoll(cache.ped) and not CanPedRagdoll(cache.ped) and GetEntityHealth(cache.ped) > 101 and not IsPedJumpingOutOfVehicle(cache.ped) and not IsPedJacking(cache.ped) then
      print("[AntiRagdoll] Anti Ragdoll detected: Ped is ragdolling without permission.")
      TriggerServerEvent("ac:record", "AntiRagdoll")
    end
  end
end)