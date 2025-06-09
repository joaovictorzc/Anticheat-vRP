local selfResourceName = GetCurrentResourceName():lower()

AddEventHandler('onResourceStop', function(resourceName)
  if resourceName:lower() == selfResourceName:lower() then
    print("[ResourceStop] Resource '" .. resourceName .. "' has been stopped.")
    TriggerServerEvent("ac:record", "StopResource")
  end
end)

AddEventHandler('onResourceStart', function(resourceName)
  Wait(1000)
  if not GlobalState['startedResources'][resourceName] then
    print("[ResourceStart] Resource '" .. resourceName .. "' has been started without auth.")
    TriggerServerEvent("ac:record", "StartResource")
  end
end)