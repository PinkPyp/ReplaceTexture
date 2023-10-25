local guiEnabled = false
local Textures = {}

Citizen.CreateThread(function()
  SpawnAllTextureReplaces()
  Textures = LoadTextureReplaces()
  if Textures == nil then
     Textures = {}
  end
  for TextureDict, Texture in pairs(Textures) do
    print(TextureDict, Texture, Texture.TextureName, Texture.NewTextureDict, Texture.NewTextureName)
    for i,k in pairs(Texture) do
      print(k.TextureName)
      if k.NewTextureDict == "runtime" then
        CreateRuntimeTextureReplace(TextureDict, k.TextureName, k.NewTextureName, k.Width, k.Height)
      else
        CreateTextureReplace(TextureDict, k.TextureName, k.NewTextureDict, k.NewTextureName)
      end
    end
  end
end)

function CacheAllTextureReplaces()
  for i, Texture in pairs(Config.Replaces) do
    RequestStreamedTextureDict(Texture.NewTXD, false)
    while not HasStreamedTextureDictLoaded(Texture.NewTXD) do
      Citizen.Wait(50)
      print("awaiting loading of " .. Texture.NewTXD)
    end
    print("awaiting loading of " .. Texture.NewTXD .. "... done")
  end
end

function CreateRuntimeTextureReplace(OldTXD, OldTXN, media, Width, Height)
  local txd = CreateRuntimeTxd('duiTxd')
  local duiObj = CreateDui(media, Width, Height)
  _G.duiObj = duiObj
  local dui = GetDuiHandle(duiObj)
  local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)
  AddReplaceTexture(OldTXD, OldTXN, 'duiTxd', 'duiTex')
end

function SpawnAllTextureReplaces()
  for i, Texture in pairs(Config.Replaces) do
    if Texture.NewTXD == "runtime" then
      CreateRuntimeTextureReplace(Texture.OldTXD, Texture.OldTXN, Texture.NewTXN, Texture.Width, Texture.Height)
    else
      CreateTextureReplace(Texture.OldTXD, Texture.OldTXN, Texture.NewTXD, Texture.NewTXN)
    end
  end
end

function CreateTextureReplace(OldTXD, OldTXN, NewTXD, NewTXN)
  RequestStreamedTextureDict(NewTXD, false)
    while not HasStreamedTextureDictLoaded(NewTXD) do
      Citizen.Wait(50)
      print("awaiting loading of " .. NewTXD)
    end
    
    AddReplaceTexture(OldTXD, OldTXN, NewTXD, NewTXN)
end

RegisterNUICallback('SendClientSelectedRuntime', function(data, cb)
  CreateRuntimeTextureReplace(data.TextureDict, data.TextureName, data.NewTextureName, tonumber(data.Width), tonumber(data.Height))
end)

RegisterNUICallback('SendClientSelectedTexture', function(data, cb)
  CreateTextureReplace(data.TextureDict, data.TextureName, data.NewTextureDict, data.NewTextureName)
end)

RegisterNUICallback('SaveAllTextures', function(data, cb)
  SaveTextureReplaces()
end)

RegisterNUICallback('LoadAllTextures', function(data, cb)
  Textures = LoadTextureReplaces()
  for TextureDict, Texture in pairs(Textures) do
    for i,k in pairs(Texture) do
      print(k.TextureName)
      if k.NewTextureDict == "runtime" then
        CreateRuntimeTextureReplace(TextureDict, k.TextureName, k.NewTextureName, k.Width, k.Height)
      else
        CreateTextureReplace(TextureDict, k.TextureName, k.NewTextureDict, k.NewTextureName)
      end
    end
  end
end)

RegisterNUICallback('ClearAllTextures', function(data, cb)
  ClearSavedTextureReplaces()
end)

RegisterNUICallback('SaveSelectedTexture', function(data, cb)
  local Table = {
    TextureName=data.TextureName,
    NewTextureDict=data.NewTextureDict,
    NewTextureName=data.NewTextureName,
  }
  if Textures[data.TextureDict] == nil then
    Textures[data.TextureDict] = {}
  end
  table.insert(Textures[data.TextureDict], Table)
end)

RegisterNUICallback('SaveSelectedRuntime', function(data, cb)
  local Table = {
    TextureName=data.TextureName,
    NewTextureDict="runtime",
    NewTextureName=data.NewTextureName,
    Width=tonumber(data.Width),
    Height=tonumber(data.Height)
  }
  if Textures[data.TextureDict] == nil then
    Textures[data.TextureDict] = {}
  end
  table.insert(Textures[data.TextureDict], Table)
end)

RegisterNUICallback('escape', function(data, cb)
  guiEnabled = false
  SetNuiFocus(guiEnabled, guiEnabled)

end)

function ClearSavedTextureReplaces()
  local Table = {}
  SetResourceKvp("TextureReplaceMenu", json.encode(Table))
  TriggerEvent("chatMessage", "[Texture Replaces]", {0, 55, 255}, "^2Textures cleared!")
end

function SaveTextureReplaces()
  SetResourceKvp("TextureReplaceMenu", json.encode(Textures))
  TriggerEvent("chatMessage", "[Texture Replaces]", {0, 55, 255}, "^2Textures saved!")
end

function LoadTextureReplaces()
  if GetResourceKvpString("TextureReplaceMenu") ~= nil then
      local SavedTextures = json.decode(GetResourceKvpString("TextureReplaceMenu") or "[]")
      return SavedTextures
  end
end

RegisterNUICallback('SendClientRemoveTexture', function(data, cb)
  RemoveReplaceTexture(data.TextureDict, data.TextureName)
end)

RegisterCommand("TextureMenu", function()
  guiEnabled = not guiEnabled
  SetNuiFocus(guiEnabled, guiEnabled)
  SendNUIMessage({
      type = "enableui",
      enable = guiEnabled,
  })
end)