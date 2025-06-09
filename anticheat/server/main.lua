
local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")
local vRP = Proxy.getInterface("vRP")
Client = Tunnel.getInterface("anticheat")

local playerCooldown = {}

RegisterNetEvent("ac:record", function(detection, detectionData)
  local source = source
  local user_id = vRP.getUserId(source)
  local detectionMode = Detections[detection]

  if playerCooldown[source] then
    if os.time() < playerCooldown[source] then
      return
    end
  end
  playerCooldown[source] = os.time() + 3

  print("[ANTICHEAT] Detecção recebida: " .. detection .. " | Source: " .. source)
  if not detectionMode then
    print("[ANTICHEAT] Detection not registered: " .. detection)
    return
  end 

  local playerCoords = GetEntityCoords(GetPlayerPed(source))
  local playerIdentifiers = GetPlayerIdentifiers(source)
  local playerScreenshot = GetPlayerScreenshot(source)
  

  if detectionMode == "ban" then
    if not user_id then
      print("[ANTICHEAT] User ID not found for banning.")
      return
    end
    vRP.setBanned(user_id)
    vRP.kick(user_id, "Você foi banido por trapaça.")
  end

  local embedFields = {
    "**Detecção:** "..detection,
    "**Coords:** "..playerCoords.x..", "..playerCoords.y..", "..playerCoords.z,
    "**ID: **"..(user_id or "N/A"),
    "**Source: **"..source,
    "**Identificadores: **"..json.encode(playerIdentifiers),
  }
  if detectionData then
    table.insert(embedFields, "**Detalhes da detecção: **"..json.encode(detectionData))
  end

  table.insert(embedFields, "**Screenshot: **"..(playerScreenshot or "Não"))
  table.insert(embedFields, "**Data: **"..os.date("%d/%m/%Y às %H:%M:%S"))

  print("[ANTICHEAT] Detecção de trapaça registrada: "..detection.." | ID: "..(user_id or "N/A").." | Source: "..source.. " | Screenshot: "..(playerScreenshot and "Sim" or "Não"))

  SendWebhook({
    mode = detectionMode,
    description = table.concat(embedFields, "\n"),
    screenshot = playerScreenshot
  })
end)

AddEventHandler('playerDropped', function()
  local source = source
  if playerCooldown[source] then
    playerCooldown[source] = nil
  end
end)