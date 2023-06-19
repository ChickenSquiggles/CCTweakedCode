rednet.open("top", 0)
monitor = peripheral.find("monitor")
l,w = monitor.getSize()

monitor.setTextScale(1)



function newBox(sx,sy,msg)
    monitor.setCursorPos(sx,sy)
    monitor.write(msg)
end

function startingVisuals()
    monitor.setTextColor(colors.white)
    monitor.setBackgroundColor(colors.black)
    monitor.clear()
    monitor.setBackgroundColor(colors.brown)
    newBox(3,3,"Wooda! V4")
    monitor.setBackgroundColor(colors.blue)
    monitor.setCursorPos(1,1)
    monitor.write("  A! Corp Product Interface   ")
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.red)
    monitor.setCursorPos(l,1)
    monitor.setBackgroundColor(colors.blue)
    monitor.write("X")
    monitor.setBackgroundColor(colors.black)
    monitor.setTextColor(colors.white)
end

while true do
    monitor.clear()
    startingVisuals()
    local event, side, x, y = os.pullEvent("monitor_touch")


    if x>2 and x < 13 and y >2 and y<4 then
        rednet.broadcast("wooda")
        sleep(1)
        id,msg=rednet.receive()
        monitor.setCursorPos(1,w)
        if msg == "Wooda! V4 is out of stock." then
            monitor.setTextColor(colors.red)
        else
            monitor.setTextColor(colors.green)
        end
        monitor.write(msg)
        monitor.setTextColor(colors.white)
        sleep(5)
    end


    if x>l-1 and y==1 then
        monitor.clear()
        monitor.setCursorPos((l/2)-4,w/2)
        monitor.write("Goodbye!")
        sleep(2)
        monitor.clear()
        os.shutdown()
    end
end