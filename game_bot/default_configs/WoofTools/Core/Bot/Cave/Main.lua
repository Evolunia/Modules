local cavebotMacro = nil
local config = nil
local configName = modules.game_bot.contentsPanel.config:getCurrentOption().text

-- ui
local configWidget = UI.Config()
local ui = UI.createWidget("CaveBotPanel")

ui.list = ui.listPanel.list -- shortcut
CaveBot.actionList = ui.list

if CaveBot.Editor then
  CaveBot.Editor.setup()
end
if CaveBot.Config then
  CaveBot.Config.setup()
end
for extension, callbacks in pairs(CaveBot.Extensions) do
  if callbacks.setup then
    callbacks.setup()
  end
end

-- main loop, controlled by config
local actionRetries = 0
local prevActionResult = true
cavebotMacro = macro(20, function()
  if TargetBot and TargetBot.isActive() and not TargetBot.isCaveBotActionAllowed() then
    CaveBot.resetWalking()
    return -- target bot or looting is working, wait
  end

  if CaveBot.doWalking() then
    return -- executing walking
  end

  local actions = ui.list:getChildCount()
  if actions == 0 then return end
  local currentAction = ui.list:getFocusedChild()
  if not currentAction then
    currentAction = ui.list:getFirstChild()
  end
  local action = CaveBot.Actions[currentAction.action]
  local value = currentAction.value
  local retry = false
  if action then
    local status, result = pcall(function()
      CaveBot.resetWalking()
      return action.callback(value, actionRetries, prevActionResult)
    end)
    if status then
      if result == "retry" then
        actionRetries = actionRetries + 1
        retry = true
      elseif type(result) == 'boolean' then
        actionRetries = 0
        prevActionResult = result
      else
        error("Invalid return from cavebot action (" .. currentAction.action .. "), should be \"retry\", false or true, is: " .. tostring(result))
      end
    else
      error("Error while executing cavebot action (" .. currentAction.action .. "):\n" .. result)
    end
  else
    error("Invalid cavebot action: " .. currentAction.action)
  end

  if retry then
    return
  end

  if currentAction ~= ui.list:getFocusedChild() then
    -- focused child can change durring action, get it again and reset state
    currentAction = ui.list:getFocusedChild() or ui.list:getFirstChild()
    actionRetries = 0
    prevActionResult = true
  end
  local nextAction = ui.list:getChildIndex(currentAction) + 1
  if nextAction > actions then
    nextAction = 1
  end
  ui.list:focusChild(ui.list:getChildByIndex(nextAction))
end)

-- config, its callback is called immediately, data can be nil
local lastConfig = ""
onPlayerPositionChange(function(newPos, oldPos)
  if (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon One"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Two"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Three"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Four"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Five"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Six"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Seven"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Eight"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Nine"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Ten"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Eleven"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Magical Forest Dungeon Twelve"]) and toggleMagicalForest.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon One"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Two"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Three"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Four"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Five"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Six"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Seven"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Eight"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Nine"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Ten"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Eleven"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Desert Dungeon Twelve"]) and toggleDesert.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon One"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Two"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Three"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Four"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Five"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Six"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Seven"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Eight"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Nine"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Ten"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Eleven"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Undead Dungeon Twelve"]) and toggleUndead.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon One"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Two"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Three"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Four"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Five"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Six"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Seven"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Eight"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Nine"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Ten"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Eleven"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Toxic Dungeon Twelve"]) and toggleToxic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon One"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Two"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Three"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Four"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Five"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Six"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Seven"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Eight"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Nine"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Ten"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Eleven"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Winter Dungeon Twelve"]) and toggleWinter.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon One"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Two"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Three"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Four"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Five"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Six"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Seven"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Eight"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Nine"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Ten"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Eleven"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Demonic Dungeon Twelve"]) and toggleDemonic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon One"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Two"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Three"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Four"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Five"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Six"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Seven"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Eight"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Nine"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Ten"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Eleven"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Blood Dungeon Twelve"]) and toggleBlood.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon One"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Two"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Three"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Four"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Five"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Six"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Seven"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Eight"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Nine"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Ten"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Eleven"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Wasteland Dungeon Twelve"]) and toggleWasteland.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon One"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Two"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Three"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Four"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Five"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Six"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Seven"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Eight"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Nine"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Ten"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Eleven"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Aquatic Dungeon Twelve"]) and toggleAquatic.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon One"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Two"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Three"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Four"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Five"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Six"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Seven"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Eight"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Nine"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Ten"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Eleven"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Void Dungeon Twelve"]) and toggleVoid.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon One"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Two"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Three"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Four"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Five"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Six"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Seven"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Eight"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Nine"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Ten"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Eleven"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Ruins Dungeon Twelve"]) and toggleRuins.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon One"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Two"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Three"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Four"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Five"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Six"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Seven"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Eight"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Nine"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Ten"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Eleven"]) and toggleCrystalCaverns.isOn())
  or (Libraries.Tables.toString(newPos) == Libraries.Tables.toString(Libraries.Tiles.Landmarks["Crystal Caverns Dungeon Twelve"]) and toggleCrystalCaverns.isOn()) then
    config = Config.setup(storage.loadedWaypoints, configWidget, "cfg", function(name, enabled, data)
      if enabled and CaveBot.Recorder.isOn() then
        CaveBot.Recorder.disable()
        CaveBot.setOff()
        return
      end

      local currentActionIndex = ui.list:getChildIndex(ui.list:getFocusedChild())
      ui.list:destroyChildren()
      if not data then return cavebotMacro.setOff() end

      local cavebotConfig = nil
      for k,v in ipairs(data) do
        if type(v) == "table" and #v == 2 then
          if v[1] == "config" then
            local status, result = pcall(function()
              return json.decode(v[2])
            end)
            if not status then
              error("Error while parsing CaveBot extensions from config:\n" .. result)
            else
              cavebotConfig = result
            end
          elseif v[1] == "extensions" then
            local status, result = pcall(function()
              return json.decode(v[2])
            end)
            if not status then
              error("Error while parsing CaveBot extensions from config:\n" .. result)
            else
              for extension, callbacks in pairs(CaveBot.Extensions) do
                if callbacks.onConfigChange then
                  callbacks.onConfigChange(name, enabled, result[extension])
                end
              end
            end
          else
            CaveBot.addAction(v[1], v[2])
          end
        end
      end

      CaveBot.Config.onConfigChange(name, enabled, cavebotConfig)

      actionRetries = 0
      CaveBot.resetWalking()
      prevActionResult = true
      cavebotMacro.setOn(enabled)
      cavebotMacro.delay = nil
      if lastConfig == name then
        -- restore focused child on the action list
        ui.list:focusChild(ui.list:getChildByIndex(currentActionIndex))
      end
      lastConfig = name
    end)
  end
end)

config = Config.setup(storage.loadedWaypoints, configWidget, "cfg", function(name, enabled, data)
  if enabled and CaveBot.Recorder.isOn() then
    CaveBot.Recorder.disable()
    CaveBot.setOff()
    return
  end

  local currentActionIndex = ui.list:getChildIndex(ui.list:getFocusedChild())
  ui.list:destroyChildren()
  if not data then return cavebotMacro.setOff() end

  local cavebotConfig = nil
  for k,v in ipairs(data) do
    if type(v) == "table" and #v == 2 then
      if v[1] == "config" then
        local status, result = pcall(function()
          return json.decode(v[2])
        end)
        if not status then
          error("Error while parsing CaveBot extensions from config:\n" .. result)
        else
          cavebotConfig = result
        end
      elseif v[1] == "extensions" then
        local status, result = pcall(function()
          return json.decode(v[2])
        end)
        if not status then
          error("Error while parsing CaveBot extensions from config:\n" .. result)
        else
          for extension, callbacks in pairs(CaveBot.Extensions) do
            if callbacks.onConfigChange then
              callbacks.onConfigChange(name, enabled, result[extension])
            end
          end
        end
      else
        CaveBot.addAction(v[1], v[2])
      end
    end
  end

  CaveBot.Config.onConfigChange(name, enabled, cavebotConfig)

  actionRetries = 0
  CaveBot.resetWalking()
  prevActionResult = true
  cavebotMacro.setOn(enabled)
  cavebotMacro.delay = nil
  if lastConfig == name then
    -- restore focused child on the action list
    ui.list:focusChild(ui.list:getChildByIndex(currentActionIndex))
  end
  lastConfig = name
end)

-- ui callbacks
ui.showEditor.onClick = function()
  if not CaveBot.Editor then return end
  if ui.showEditor:isOn() then
    CaveBot.Editor.hide()
    ui.showEditor:setOn(false)
  else
    CaveBot.Editor.show()
    ui.showEditor:setOn(true)
  end
end

ui.showConfig.onClick = function()
  if not CaveBot.Config then return end
  if ui.showConfig:isOn() then
    CaveBot.Config.hide()
    ui.showConfig:setOn(false)
  else
    CaveBot.Config.show()
    ui.showConfig:setOn(true)
  end
end

-- public function, you can use them in your scripts
CaveBot.isOn = function()
  return config.isOn()
end

CaveBot.isOff = function()
  return config.isOff()
end

CaveBot.setOn = function(val)
  if val == false then
    return CaveBot.setOff(true)
  end
  config.setOn()
end

CaveBot.setOff = function(val)
  if val == false then
    return CaveBot.setOn(true)
  end
  config.setOff()
end

CaveBot.delay = function(value)
  cavebotMacro.delay = math.max(cavebotMacro.delay or 0, now + value)
end

CaveBot.gotoLabel = function(label)
  label = label:lower()
  for index, child in ipairs(ui.list:getChildren()) do
    if child.action == "label" and child.value:lower() == label then
      ui.list:focusChild(child)
      return true
    end
  end
  return false
end

CaveBot.save = function()
  local data = {}

  for index, child in ipairs(ui.list:getChildren()) do
    table.insert(data, {child.action, child.value})
  end

  if CaveBot.Config then
    table.insert(data, {"config", json.encode(CaveBot.Config.save())})
  end

  local extension_data = {}
  for extension, callbacks in pairs(CaveBot.Extensions) do
    if callbacks.onSave then
      local ext_data = callbacks.onSave()
      if type(ext_data) == "table" then
        extension_data[extension] = ext_data
      end
    end
  end
  table.insert(data, {"extensions", json.encode(extension_data, 2)})
  config.save(data)
end


local extFiles = g_resources.listDirectoryFiles("/game_bot/" .. configName .. "/Extensions/Cave", false, false)
for i, file in ipairs(extFiles) do
  local ext = file:split(".")
  if ext[#ext]:lower() == "lua"  then
    dofile('/Extensions/Cave/'..file)
  end
end
