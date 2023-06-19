monitor = peripheral.find("monitor")

monitor.clear()
monitor.setTextScale(.5)
local l,w = monitor.getSize()

local locked = false

function drawPixel(x,y,c)
monitor.setCursorPos(x,y)
monitor.setBackgroundColor(c)
monitor.write(" ")
monitor.setBackgroundColor(colors.black)
end
 
function load(name)
    local file = io.open(name..".txt", "r")
    local i = 1
    local j = 1
    for line in file:lines() do
        i = i+1
        if i == l+1 then
            i = 1
            j = j+1
            if j == w then break end
        end
        drawPixel(i-1,j,tonumber(line))
    end   
end



while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    if redstone.getInput("back") then
        locked = true
    else
        locked = false
    end
    if locked then
        monitor.setTextScale(.5)
        load("saveslot2")
    else
        redstone.setOutput("top", true)
        redstone.setOutput("right", true)
        sleep(1)
        redstone.setOutput("top", false)
        redstone.setOutput("right", false)
        sleep(7.7)
        monitor.setTextScale(.5)
        load("saveslot1")
    end
end