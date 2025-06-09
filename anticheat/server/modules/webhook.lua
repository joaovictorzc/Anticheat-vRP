function SendWebhook(data)
  if ServerConfig.Webhooks[data.mode] then
    local embed = { 
      color = 16711680,
      description = data.description
    }
    if data.screenshot then
      embed.image = {
        url = data.screenshot
      }
    end
    local responseStatus, responseBody, responseHeaders, errorData = PerformHttpRequestAwait(
    ServerConfig.Webhooks[data.mode],
    "POST",
    json.encode({
      username = "Anticheat",
      embeds = { embed },
    }),
    {
      ["Content-Type"] = "application/json"
    })

    if responseStatus ~= 204 then
      print("[ANTICHEAT] Failed to send webhook - Status: " .. responseStatus)
      if errorData then
        print("[ANTICHEAT] Error data: " .. errorData)
      end
      return false
    end
  end
  return true
end