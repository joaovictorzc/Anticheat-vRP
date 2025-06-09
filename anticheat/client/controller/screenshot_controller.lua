function Client.requestScreenshot(url)
  if GetResourceState("screenshot-basic") ~= "started" then
    return nil
  end
  local p = promise:new()

  exports["screenshot-basic"]:requestScreenshotUpload(url, 'files[]', function(data)
    print(data)
    local resp = json.decode(data)
    print(json.encode(resp, { indent = true }))
    if resp and resp.attachments and resp.attachments[1] then
      print("[ANTICHEAT] Screenshot uploaded successfully for URL: " .. url)
      p:resolve(resp.attachments[1].url)
    else
      print("[ANTICHEAT] Screenshot upload failed for URL: " .. url)
      p:resolve(nil)
    end
  end)
  return Citizen.Await(p)
end