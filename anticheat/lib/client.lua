local setEntityHealth = SetEntityHealth
function SetEntityHealth(entity, health)
  local requestedResource = GetInvokingResource()
  if GetResourceState(requestedResource) ~= "started" then
    return setEntityHealth(entity, health)
  end
end