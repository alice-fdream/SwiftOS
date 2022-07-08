local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')


local mainContainer = ...

prgs = GUI.container(1, 1, 160, 50)

local panel = GUI.panel (1, 1, prgs.width, prgs.height, backgr)
prgs:addChild (panel)
prgs:addChild (GUI.label (6, 2, panel.width, 1, text, "Менеджер программ " .. os.getenv('NAME') .. ' ' .. os.getenv('VER')))
prgs.touchX, prgs.touchY = 0, 0

prgs:addChild(GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    prgs:remove()
    mainContainer:draw()
end



local yu = 6
local xy = 4
local file = ''
for file in fs.list('/system/apps/') do
  if xy == 4 and yu == 51 then
  xy = 31
  yu = 6
  end

  if xy == 31 and yu == 51 then
  xy = 62
  yu = 6
  end

  if xy == 62 and yu == 51 then
  xy = 93
  yu = 6
  end

  if xy == 93 and yu == 51 then
  xy = 122
  yu = 6
  end

local c = 0
  local slash = 0
  local object = ''
  local c = string.len(file)
  local slash = c - 1
  local object = file:sub(1, slash)
  prgs:addChild(GUI.label (xy, yu, panel.width, 1, text, object))
  prgs:addChild(GUI.roundedButton (xy + 13, yu-1, 3, 3, button_def, button_text, button_active, button_text, '√')).onTouch = function()

    local result, reason = loadfile('/system/apps/' .. object .. '/' .. object .. '.lua')
      if result then
        result, reason = pcall(result, mainContainer)
        prgs:remove()
        css_ref()
          mainContainer:draw(true)
        if not result then
         error("Failed to perform pcall() : " .. reason)
     end
    else
     error("Failed to perform loadfile() : " .. reason)
     end
  end
  prgs:addChild(GUI.roundedButton (xy + 17, yu-1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function()
    os.execute('rm -r /system/apps/' .. object .. '/')
            prgs:remove()
        css_ref()
          mainContainer:draw(true)
  end
yu = yu + 3
end




mainContainer:addChild (prgs)
mainContainer:draw()
