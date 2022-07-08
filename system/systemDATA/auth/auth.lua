buffer = require("NyaDraw")
GUI = require("GUI")
local computer = require("computer")
themes = require("get_them")
gpu = require('component').gpu
term = require('term')
------------------------------------------------------------------------------------------
buffer.setGPUProxy(require("component").gpu)


file = io.open('/system/systemDATA/auth/login', 'r')
user1 = file:read()
file:close()
file = io.open('/system/systemDATA/auth/password', 'r')
password1 = file:read()
file:close()

function check()
if login.text == user1 then
if pass.text == password1 then
  gpu.setBackground(0x000000)
  term.clear()
  mainContainer:stop ()
  os.execute('/system/SwiftOS/gui/gui.lua')
else
end
else
end

end


css_ref()
local window1Container, window1Panel

 mainContainer = GUI.application()

mainContainer:addChild(GUI.panel(1, 1, mainContainer.width, mainContainer.height, colorDesktop))

window1Container = GUI.container(mainContainer.width/2-18, mainContainer.height/2-8, 36, 16)

local panel = GUI.panel (1, 1, window1Container.width-1, window1Container.height-1, backgr)
window1Container:addChild (panel)
window1Container:addChild (GUI.label (6, 2, panel.width, 1, text, "Авторизация SwiftOS " .. os.getenv('VER')))
window1Container:addChild(GUI.panel(2, window1Container.height, panel.width, 1, shadow_window))
window1Container:addChild(GUI.panel(window1Container.width, 2, 1, panel.height-1, shadow_window))
window1Container.touchX, window1Container.touchY = 0, 0

window1Container:addChild(GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
    computer.shutdown(true)
end
	login = GUI.input(3, 4, 30, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Логин")
  window1Container:addChild(login)

  pass = GUI.input(3, 8, 30, 3, input_back, input_text, input_text, input_back_foc, input_text, "", "Пароль", false, "*")
  window1Container:addChild(pass)

  local auth = GUI.roundedButton(19, 12, 12, 3, button_def, button_text, button_active, button_text, 'Вход')
  window1Container:addChild(auth).onTouch = function()
check()
  end

local biometry = GUI.roundedButton(32, 12, 3, 3, button_def, button_text, button_active, button_text, '∑')
window1Container:addChild(biometry).eventHandler = function(main, win, evname, uss, x, y, hh, hhh)
  if evname == "touch" then
    if hhh == user1 then
    computer.beep(800, 0.2)
    computer.beep(1000, 0.3)
	 os.execute('/system/SwiftOS/gui/gui.lua')
	 else
    computer.beep(1000, 0.2)
    computer.beep(800, 0.3)		
end
end
end

window1Container.eventHandler = function(main, win, evname, _, x, y)
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



mainContainer:addChild (window1Container)
mainContainer:draw  (true)
mainContainer:start ()
