local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')


local mainContainer = ...

settings = GUI.container(mainContainer.width/2-25, mainContainer.height/2-8, 50, 15)

local panel = GUI.panel (1, 1, settings.width-1, settings.height-1, backgr)
settings:addChild (panel)
settings:addChild (GUI.label (6, 2, panel.width, 1, text, "Настройки " .. os.getenv('NAME') .. ' ' .. os.getenv('VER')))
settings:addChild(GUI.panel(2, settings.height, panel.width, 1, shadow_window))
settings:addChild(GUI.panel(settings.width, 2, 1, panel.height-1, shadow_window))
settings.touchX, settings.touchY = 0, 0

settings:addChild(GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    settings:remove()
    mainContainer:draw()
end


settings:addChild(GUI.label (4, 6, panel.width, 1, text, "Управление темами"))
settings:addChild(GUI.framedButton(3, 5, 19, 3, colorDesktop, button_text, main_text, main_text, "")).onTouch = function()
  local result, reason = loadfile('/system/SwiftOS/settings/theme.lua')
    if result then
      result, reason = pcall(result, mainContainer)
        mainContainer:draw(true)
      if not result then
       error("Failed to perform pcall() : " .. reason)
   end
  else
   error("Failed to perform loadfile() : " .. reason)
   end
end

settings:addChild(GUI.label (4, 9, panel.width, 1, text, "Аккаунт и порты"))

settings:addChild(GUI.framedButton(3, 8, 17, 3, colorDesktop, button_text, main_text, main_text, "")).onTouch = function()
  local result, reason = loadfile('/system/SwiftOS/settings/account.lua')
    if result then
      result, reason = pcall(result, mainContainer)
        mainContainer:draw(true)
      if not result then
       error("Failed to perform pcall() : " .. reason)
   end
  else
   error("Failed to perform loadfile() : " .. reason)
   end
end

settings:addChild(GUI.label (4, 12, panel.width, 1, text, "Менеджер программ"))
settings:addChild(GUI.framedButton(3, 11, 19, 3, colorDesktop, button_text, main_text, main_text, "")).onTouch = function()
  local result, reason = loadfile('/system/SwiftOS/settings/program.lua')
    if result then
      result, reason = pcall(result, mainContainer)
        mainContainer:draw(true)
      if not result then
       error("Failed to perform pcall() : " .. reason)
   end
  else
   error("Failed to perform loadfile() : " .. reason)
   end
end


settings:addChild(GUI.label (24, 6, panel.width, 1, text, "Дисковая утилита"))
settings:addChild(GUI.framedButton(23, 5, 18, 3, colorDesktop, button_text, main_text, main_text, "")).onTouch = function()
  local result, reason = loadfile('/system/SwiftOS/settings/format_disk.lua')
    if result then
      result, reason = pcall(result, mainContainer)
        mainContainer:draw(true)
      if not result then
       error("Failed to perform pcall() : " .. reason)
   end
  else
   error("Failed to perform loadfile() : " .. reason)
   end
  end

settings.eventHandler = function(main, win, evname, _, x, y)
  if evname == "touch" then
    win.touchX, win.touchY = x, y
	 win:moveToFront()
    main:draw()
  elseif evname == "drag" then
    win.localX = ((x > win.touchX) and win.localX + 1) or ((x < win.touchX) and win.localX - 1) or win.localX
    win.localY = ((y > win.touchY) and win.localY + 1) or ((y < win.touchY) and win.localY - 1) or win.localY
    win.touchX, win.touchY = x, y
    main:draw()
  end
end


mainContainer:addChild (settings)
mainContainer:draw()
