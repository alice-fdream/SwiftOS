unicode = require('unicode')
term = require('term')
gpu = require('component').gpu


gpu.setBackground(0x000000)
gpu.setForeground(0xFFFFFF)
term.clear(


while true do
io.write('console_> ')
com = io.read()


if com == 'exit' then
os.exit()

elseif com == 'hey' then
print('Hello, ' .. os.getenv("PLA"))
end
end