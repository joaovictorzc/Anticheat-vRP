if not Detections.SuperJump then
  print("[anticheat] SuperJump detection is disabled.")
  return
end

CreateThread(function()
  while true do
    Wait(2000)
    if IsPedJumping(cache.ped) and not IsPedRagdoll(cache.ped) then
      local velocity = GetEntityVelocity(cache.ped)
      print("[SuperJump] Jump detected: Ped is jumping with velocity check.", json.encode(velocity))
      if velocity.z > 1.0 then
        print("[Anticheat] SuperJump detected: Velocity is above threshold.")
        TriggerServerEvent("ac:record", "SuperJump")
      end
    end

    if IsPedFalling(cache.ped) and not IsPedRagdoll(cache.ped) then
      local velocity = GetEntityVelocity(cache.ped)
      print("[Anticheat] Jump detected: Ped is falling with velocity check.", json.encode(velocity))
      if velocity.z < -1.0 then
        print("[SuperJump] SuperJump detected: Falling velocity is below threshold.")
        TriggerServerEvent("ac:record", "SuperJump")
      end
    end

    if IsPedClimbing(cache.ped) then
      local velocity = GetEntityVelocity(cache.ped)
      print("[Anticheat] Jump detected: Ped is climbing.", json.encode(velocity))
      if velocity.z > 3.2 then
        print("[SuperJump] SuperJump detected: Climbing velocity is above threshold.")
        TriggerServerEvent("ac:record", "SuperJump")
      end
    end
  end
end)