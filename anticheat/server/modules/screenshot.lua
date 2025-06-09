CreateThread(function()
  if GetResourceState("screenshot-basic") ~= "started" then
    print("[ANTICHEAT] Screenshot resource not started, disabling screenshot functionality.")
    return
  end
end)

function GetPlayerScreenshot(source)
  if GetResourceState("screenshot-basic") ~= "started" then
    return nil
  end
  local screenshot = Client.requestScreenshot(source, ServerConfig.Webhooks.screenshot)
  print(screenshot)
  if not screenshot or screenshot == "" then
    print("[ANTICHEAT] Failed to take screenshot for source: " .. source)
    return nil
  end
  return screenshot
end