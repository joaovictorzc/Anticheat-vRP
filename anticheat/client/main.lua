local Tunnel = module("vrp", "lib/Tunnel")
Client = {}
Tunnel.bindInterface("anticheat", Client)


cache = {
  ped = PlayerPedId(),
  playerId = PlayerId(),
  vehicle = GetVehiclePedIsIn(PlayerPedId(), false),
}

exports('setHealth', function(health)
  if not Detections.GodMode then
    return
  end

  setHealth(health)
end)

CreateThread(function()
  while true do
    Wait(7000)
    cache.ped = PlayerPedId()
    cache.playerId = PlayerId()
    cache.vehicle = GetVehiclePedIsIn(cache.ped, false)
  end
end)