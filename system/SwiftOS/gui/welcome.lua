local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local themes = require("get_them")
gpu = require('component').gpu
local fs = require('filesystem')
------------------------------------------------------------------------------------------
buffer.setGPUProxy(require("component").gpu)


css_ref()
local window1Container, window1Panel

 mainContainer = GUI.application()

mainContainer:addChild(GUI.panel(1, 1, mainContainer.width, mainContainer.height, colorDesktop))

window1Container = GUI.container(mainContainer.width/2-30, mainContainer.height/2-10, 60, 20)

local panel = GUI.panel (1, 1, window1Container.width-1, window1Container.height-1, backgr)
window1Container:addChild (panel)
window1Container:addChild(GUI.panel(2, window1Container.height, panel.width, 1, shadow_window))
window1Container:addChild(GUI.panel(window1Container.width, 2, 1, panel.height-1, shadow_window))
window1Container.touchX, window1Container.touchY = 0, 0
window1Container:addChild (GUI.image (21, 3, buffer.loadImage("/system/images/logo.pic")))
window1Container:addChild (GUI.label (22, 13, panel.width, 1, text, "SwiftOS Appalachi"))
local ends = GUI.roundedButton(4, 15, 53, 3, button_def, button_text, button_active, button_text, 'Завершить установку')
window1Container:addChild(ends).onTouch = function()

  panel:remove()

  local panel = GUI.panel (1, 1, window1Container.width-1, window1Container.height-1, backgr)
  window1Container:addChild (panel)
  window1Container:addChild(GUI.panel(2, window1Container.height, panel.width, 1, shadow_window))
  window1Container:addChild(GUI.panel(window1Container.width, 2, 1, panel.height-1, shadow_window))
  window1Container.touchX, window1Container.touchY = 0, 0

  local port = GUI.input(25, 5, 7, 1, input_back, input_text, input_text, input_back_foc, input_text, "", "Порт")
    window1Container:addChild(port)


local login = GUI.input(5, 7, 50, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Ваш логин")
  window1Container:addChild(login)


  local password = GUI.input(5, 11, 50, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Твой пароль")
    window1Container:addChild(password)



    local ends = GUI.roundedButton(4, 15, 53, 3, button_def, button_text, button_active, button_text, 'Сохранить')
    window1Container:addChild(ends).onTouch = function()

      local p1 = io.open('/system/SwiftOS/chat/port', 'w')
      p1:write(port.text)
      p1:close()

      local p2 = io.open('/system/auth/login', 'w')
      p2:write(login.text)
      p2:close()

      local p3 = io.open('/system/auth/password', 'w')
      p3:write(password.text)
      p3:close()


      computer.shutdown(true)



-- Конец созданию биометрии
    end
  mainContainer:draw()






-- Конец завершения установки
end


mainContainer:addChild (window1Container)
mainContainer:draw  (true)
mainContainer:start ()
