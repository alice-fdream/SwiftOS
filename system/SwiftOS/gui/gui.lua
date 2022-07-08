local buffer = require("NyaDraw")
local GUI = require("GUI")
local computer = require("computer")
local themes = require("get_them")
local fs = require('filesystem')
local modem = require('component').modem
local event = require('event')
local unicode = require('unicode')



pp = io.open('/system/systemDATA/localhost/port')
port = pp:read()
if port == '' or port == nil then

else
modem.open(tonumber(port))
end

------------------------------------------------------------------------------------------
buffer.setGPUProxy(require("component").gpu)

file = io.open('/system/systemDATA/auth/login')
os.setenv("PLA", file:read())
file:close()
css_ref()
local window1Container, window1Panel

 mainContainer = GUI.application()


 -- daemon sms
 function sms_show(q1,w2,e3,r4,t5, user)

   daemon = GUI.container(mainContainer.width/2-30, mainContainer.height/2-9, 60, 8)

   local panel = GUI.panel (1, 1, daemon.width-1, daemon.height-1, backgr)
   daemon:addChild (panel)
   daemon:addChild (GUI.label (6, 2, panel.width, 1, text, "Служба входящих данных " .. os.getenv('VER')))
   daemon:addChild(GUI.panel(2, daemon.height, panel.width, 1, shadow_window))
   daemon:addChild(GUI.panel(daemon.width, 2, 1, panel.height-1, shadow_window))
   daemon.touchX, daemon.touchY = 0, 0

   daemon:addChild(GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
       daemon:remove()
       mainContainer:draw()
   end
   event.cancel(rdSMS)
   q11, w21, e31, r41, t51, port = event.pull('modem_message')
   q111, w211, e311, r411, t511, sms = event.pull('modem_message')
   rdSMS = event.listen('modem_message', sms_show)
   daemon.eventHandler = function(main, win, evname, _, x, y)
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

   daemon:addChild (GUI.label (4, 4, panel.width, 1, text, "Получено сообщение от " .. user))
   daemon:addChild (GUI.label (4, 5, panel.width, 1, text, "Порт отправителя: " .. port))
   daemon:addChild (GUI.label (4, 6, panel.width, 1, text, "Сообщение: " .. sms))

   mainContainer:addChild (daemon)
   mainContainer:draw()
 end

 rdSMS = event.listen('modem_message', sms_show)



mainContainer:addChild(GUI.panel(1, 1, mainContainer.width, mainContainer.height, colorDesktop))

local menu = mainContainer:addChild(GUI.menu(1, 1, mainContainer.width, backgr, text, 0x076918, 0xFFFFFF, nil))

local counn = unicode.len(os.getenv('PLA'))
local yyu = 160 - counn
 mainContainer:addChild (GUI.label (yyu, 1, mainContainer.width, 1, text, os.getenv('PLA')))

local osx = menu:addContextMenu(os.getenv('NAME'), main_text)
osx:addItem('О Системе').onTouch =  function ()
local infosystem = GUI.container    (mainContainer.width/2-30, mainContainer.height/2-8, 60, 15)

infosystem.touchX, infosystem.touchY = 0, 0

infosystem.eventHandler = function(main, win, evname, _, x, y)
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

local x0pan = infosystem:addChild (GUI.panel (1, 1, infosystem.width-1, infosystem.height-1, backgr))
infosystem:addChild(GUI.panel(2, infosystem.height, x0pan.width, 1, shadow_window))
infosystem:addChild(GUI.panel(infosystem.width, 2, 1, x0pan.height-1, shadow_window))

infosystem:addChild (GUI.label (6, 2, x0pan.width, x0pan.height, text, "О Системе"))
infosystem:addChild (GUI.image (4, 4, buffer.loadImage("/system/systemDATA/images/logo.pic")))
infosystem:addChild (GUI.label (28, 5, x0pan.width, x0pan.height, text, os.getenv('NAME')))
infosystem:addChild (GUI.label (28, 6, x0pan.width, x0pan.height, text, 'Версия: ' .. os.getenv('VER')))
 infosystem:addChild (GUI.label (28, 7, x0pan.width, x0pan.height, text, 'Пользователь: ' .. os.getenv("PLA")))
 infosystem:addChild (GUI.label (28, 8, x0pan.width, x0pan.height, text, 'RAM: ' .. (computer.totalMemory() / 1024) / 1024 .. ' МБ'))
 infosystem:addChild (GUI.roundedButton (2, 1, 3, 3, close_button, button_text, button_active, button_text, 'X')).onTouch = function ()
		infosystem:remove()
		mainContainer:draw()
	end

	mainContainer:addChild (infosystem)
	mainContainer:draw()
end
osx:addSeparator()
osx:addItem ("Выйти").onTouch     = function () mainContainer:stop() os.execute('/system/systemDATA/auth/auth.lua') end
osx:addItem ("Выключить").onTouch     = function () computer.shutdown ()     end
osx:addItem ("Перезагрузить").onTouch = function ()
computer.shutdown (true)
 end




mainContainer:addChild (GUI.roundedButton (-2, 14, 12, 25, backgr, button_text, backgr, button_text, ' '))



mainContainer:addChild (GUI.image (2, 16, buffer.loadImage("/system/apps/via/icon.pic")))


mainContainer:addChild(GUI.framedButton(1, 15, 8, 5, colorDesktop, button_text, main_text, main_text, "")).onTouch = function ()
  local result, reason = loadfile('/system/apps/via/via.lua')
    if result then
      result, reason = pcall(result, mainContainer)
        mainContainer:draw(true)
      if not result then
       if type(reason) == "table" and reason.reason == "terminated" then return end
       error("Failed to perform pcall() : " .. reason)
      end
  else
   error("Failed to perform loadfile() : " .. reason)
   end
 end



 mainContainer:addChild (GUI.image (2, 21, buffer.loadImage("/system/systemDATA/images/setting.pic")))


 mainContainer:addChild(GUI.framedButton(1, 20, 8, 5, colorDesktop, button_text, main_text, main_text, "")).onTouch = function ()
   local result, reason = loadfile('/system/SwiftOS/settings/main.lua')
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



 mainContainer:addChild (GUI.image (2, 26, buffer.loadImage("/system/systemDATA/images/printer.pic")))


 mainContainer:addChild(GUI.framedButton(1, 25, 8, 5, colorDesktop, button_text, main_text, main_text, "")).onTouch = function ()
   local result, reason = loadfile('/system/SwiftOS/printer/main.lua')
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
  
  
  
   mainContainer:addChild (GUI.image (2, 33, buffer.loadImage("/system/systemDATA/images/all.pic")))


 mainContainer:addChild(GUI.framedButton(1, 32, 8, 5, colorDesktop, button_text, main_text, main_text, "")).onTouch = function ()
   local result, reason = loadfile('/system/SwiftOS/applist/apps.lua')
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




mainContainer:draw  (true)
mainContainer:start ()


