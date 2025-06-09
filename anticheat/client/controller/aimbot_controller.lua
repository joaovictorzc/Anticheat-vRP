if not Detections.Aimbot then
  print("[anticheat] Aimbot detection is disabled.")
  return
end

local aimLockThreshold = 1000
local maxAimDistance = 100.0
local aimingStartTime = nil
local aimingTarget = nil
local aimingTimer = nil

CreateThread(function()
  while true do
    Citizen.Wait(100)
    if not DoesEntityExist(cache.ped) or IsEntityDead(cache.ped) then
      aimingStartTime = nil
      aimingTarget = nil
      aimingTimer = nil
      goto continue
    end

    if IsPlayerFreeAiming(PlayerId()) then
      local success, targetEntity = GetEntityPlayerIsFreeAimingAt(PlayerId())
      if success and targetEntity and DoesEntityExist(targetEntity) and targetEntity ~= cache.ped then
        print("[Aimbot] Free aiming at entity: " .. tostring(targetEntity))
        if IsEntityAPed(targetEntity) and not IsPedDeadOrDying(targetEntity, true) then
          print("[Aimbot] Target is a valid ped. Handle: " .. tostring(targetEntity))
          local shooterCoords = GetPedBoneCoords(cache.ped, 31086, 0.0, 0.0, 0.0)
          local targetCoords  = GetEntityCoords(targetEntity)
          local dist = #(shooterCoords - targetCoords)
          print(("[Aimbot] Distance to target: %.2f meters."):format(dist))
          if dist <= maxAimDistance then
            print("[Aimbot] Target is within max aim distance.")
            if aimingTarget ~= targetEntity then
              aimingTarget = targetEntity
              aimingStartTime = GetGameTimer()
              aimingTimer = 0
            else
              aimingTimer = GetGameTimer() - aimingStartTime
            end

            print(("[Aimbot] Aiming at target: %s for %d ms."):format(tostring(aimingTarget), aimingTimer))
            if aimingTimer >= aimLockThreshold then
              print(("[Aimbot] Aimbot detected: Player %s is aiming at %s for %d ms."):format(GetPlayerName(PlayerId()), aimingTarget, aimingTimer))
              TriggerServerEvent("ac:record", "Aimbot", {
                targetHandle = aimingTarget,
                duration = aimingTimer
              })
              aimingStartTime = GetGameTimer() + aimLockThreshold * 0.5 
            end

            goto continue
          end
        end
      end
    end

    aimingStartTime = nil
    aimingTarget = nil
    aimingTimer = nil

    ::continue::
  end
end)
