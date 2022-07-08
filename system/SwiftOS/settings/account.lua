local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local fs = require('filesystem')


local mainContainer = ...

account = GUI.container(1, 1, 160, 50)

local panel = GUI.panel (1, 1, account.width, account.height, backgr)
account:addChild (panel)
account:addChild (GUI.label (6, 2, panel.width, 1, text, "Управление аккаунтом " .. os.getenv('NAME') .. ' ' .. os.getenv('VER')))
account.touchX, account.touchY = 0, 0

account:addChild(GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    account:remove()
    mainContainer:draw()
end

local portt = GUI.input(62, 20, 30, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Порт")
account:addChild(portt)

local login = GUI.input(62, 24, 30, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Логин")
account:addChild(login)

local pass = GUI.input(62, 28, 30, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Пароль")
account:addChild(pass)

account:addChild(GUI.roundedButton (62, 32, 30, 3, button_def, button_text, button_active, button_text, 'Изменить')).onTouch = function()

if portt.text == '' or login.text == '' or pass.text == '' then
account:addChild(GUI.label(64, 19, panel.width, 1, text, "Данные не заполнены"))
else

  local p1 = io.open('/system/systemDATA/localhost/port', 'w')
  p1:write(portt.text)
  p1:close()

  local p2 = io.open('/system/systemDATA/auth/login', 'w')
  p2:write(login.text)
  p2:close()

  local p3 = io.open('/system/systemDATA/auth/password', 'w')
  p3:write(pass.text)
  p3:close()
  computer.shutdown(true)
    end


end





mainContainer:addChild (account)
mainContainer:draw()
