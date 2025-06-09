GlobalState['startedResources'] = {}

CreateThread(function()
  local resourceList = {}
  for i = 0, GetNumResources(), 1 do
    local resourceName = GetResourceByFindIndex(i)
    if resourceName and GetResourceState(resourceName) == "started" then
      resourceList[resourceName] = true
    end
  end
  GlobalState['startedResources'] = resourceList
end)

AddEventHandler('onResourceStart', function(resourceName)
  if not GlobalState['startedResources'][resourceName] then
    local resourceList = GlobalState['startedResources']
    resourceList[resourceName] = true
    GlobalState['startedResources'] = resourceList
  end
end)

AddEventHandler('onResourceStop', function(resourceName)
  if GlobalState['startedResources'][resourceName] then
    local resourceList = GlobalState['startedResources']
    resourceList[resourceName] = nil
    GlobalState['startedResources'] = resourceList
  end
end)