if not Detections.NoClip then
  print("[anticheat] NoClip detection is disabled.")
  return
end

local lastPedCoords = GetEntityCoords(cache.ped)
CreateThread(function()
  while true do
    Wait(4000)
    print("[NoClip] Looking for suspicious activity...")
    if cache.vehicle ~= 0 then
      local coords = GetEntityCoords(cache.ped)
      if #(coords - lastPedCoords) > 20.0 and GetEntityHeightAboveGround(PlayerPedId()) > 4.0 and not IsPedFalling(PlayerPedId()) then
        print("[NoClip] NoClip detected: Ped moved more than 20 units without falling.")
        TriggerServerEvent("ac:record", "NoClip")
      end

      lastPedCoords = coords
    end

    if not IsEntityVisible(cache.ped) then
      print("[NoClip] NoClip detected: Ped is not visible.")
      TriggerServerEvent("ac:record", "NoClip")
    end
  end
end)