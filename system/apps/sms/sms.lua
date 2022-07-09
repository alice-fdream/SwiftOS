local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local themes = require("get_them")
local fs = require('filesystem')
local modem = require('component').modem
local event = require('event')

mainContainer = ...

sms_send = GUI.container(mainContainer.width/2-30, mainContainer.height/2-5, 60, 10)

local panel = GUI.panel (1, 1, sms_send.width-1, sms_send.height-1, backgr)
sms_send:addChild (panel)
sms_send:addChild (GUI.label (6, 2, panel.width, 1, text, "Служба исходящих данных " .. os.getenv('VER')))
sms_send:addChild(GUI.panel(2, sms_send.height, panel.width, 1, shadow_window))
sms_send:addChild(GUI.panel(sms_send.width, 2, 1, panel.height-1, shadow_window))
sms_send.touchX, sms_send.touchY = 0, 0

sms_send:addChild(GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    sms_send:remove()
    mainContainer:draw()
end

local portt = GUI.input(50, 4, 8, 3, input_back, input_text, input_text, input_back, input_text, "", "Порт")
sms_send:addChild(portt)

local smss = GUI.input(2, 4, 47, 3, input_back, input_text, input_text, input_back, input_text, "", "Сообщение")
sms_send:addChild(smss)

local ok = GUI.roundedButton (2, 7, 57, 3, button_def, button_text, button_active, button_text, 'Отправить')
sms_send:addChild(ok).onTouch = function()
  pp = io.open('/system/systemDATA/localhost/port')
  port = pp:read()
  local portik = tonumber(portt.text)
  modem.broadcast(portik, os.getenv('PLA'))
  modem.broadcast(portik, tonumber(port))
  modem.broadcast(portik, smss.text)
  sms_send:remove()
  mainContainer:draw()
  end


sms_send.eventHandler = function(main, win, evname, _, x, y)
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


mainContainer:addChild (sms_send)
mainContainer:draw()
