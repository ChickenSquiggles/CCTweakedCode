rednet.open("right", 0)
while true do
    id, msg = rednet.receive()
    if msg == "up" then
        turtle.up()
    end
    if msg == "down" then
        turtle.down()
    end
    if msg == "w" then
        turtle.forward()
    end
    if msg == "s" then
        turtle.back()
    end
    if msg == "a" then
        turtle.turnLeft()
    end
    if msg == "d" then
        turtle.turnRight()
    end
    if msg:sub(1,4) == "sign" then
        turtle.select(1)
        turtle.placeUp(msg:sub(5,string.len(msg)))
    end
    if msg == "signdone" then
        turtle.digUp()
    end
    if msg == "refuel" then
        turtle.select(16)
        turtle.refuel(1)
    end


    --up
    local has_block, data = turtle.inspectUp()
    if has_block then
        sleep(.01)
        rednet.broadcast(data.name)
    else
        rednet.broadcast("na")
    end


    --front
    local has_block, data = turtle.inspect()
    if has_block then
        sleep(.01)
        rednet.broadcast(data.name)
    else
        rednet.broadcast("na")
    end

    --down
    local has_block, data = turtle.inspectDown()
    if has_block then
        sleep(.01)
        rednet.broadcast(data.name)
    else
        rednet.broadcast("na")
    end
end