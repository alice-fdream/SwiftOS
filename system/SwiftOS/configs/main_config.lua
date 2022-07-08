local shell = require("shell")
local tty = require("tty")
local fs = require("filesystem")
local gpu = require('component').gpu
local term = require('term')


if tty.isAvailable() then
  if io.stdout.tty then
    io.write("\27[40m\27[37m")
    tty.clear()
  end
end

shell.setAlias("dir", "ls")
shell.setAlias("move", "mv")
shell.setAlias("rename", "mv")
shell.setAlias("copy", "cp")
shell.setAlias("del", "rm")
shell.setAlias("md", "mkdir")
shell.setAlias("cls", "clear")
shell.setAlias("rs", "redstone")
shell.setAlias("view", "edit -r")
shell.setAlias("help", "man")
shell.setAlias("cp", "cp -i")
shell.setAlias("l", "ls -lhp")
shell.setAlias("..", "cd ..")
shell.setAlias("df", "df -h")
shell.setAlias("grep", "grep --color")
shell.setAlias("more", "less --noback")
shell.setAlias("reset", "resolution `cat /dev/components/by-type/gpu/0/maxResolution`")


os.setenv('VER', 'Invintium')
os.setenv('NAME', 'SwiftOS')


local ch = io.open('/system/systemDATA/auth/login')
local ch1 = ch:read()
ch:close()

if ch1 == '' or ch1 == nil then
term.clear()
os.execute('/system/SwiftOS/gui/welcome.lua')
else
  os.execute('/system/systemDATA/auth/auth.lua')
end