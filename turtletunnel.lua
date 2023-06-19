rednet.open("left", 78)

term.clear()
term.setCursorPos(1,1)


if turtle.getItemDetail() then
    if turtle.getItemDetail().name == "minecraft:coal" then
        turtle.refuel(turtle.getItemCount())
    end
end

id,msg = rednet.receive()
if msg == "startup" then
    for i = 1, 100 do
        --up
        local has_block, data = turtle.inspectUp()
        if has_block then
            sleep(.01)
            local up = data.name
        else
            local up = "No Block Found"
        end
        --front
        local has_block, data = turtle.inspect()
        if has_block then
            sleep(.01)
            local front = data.name
        else
            local front = "No Block Found"
        end
        --down
        local has_block, data = turtle.inspectDown()
        if has_block then
            local down = data.name
        else
            local down = "No Block Found"
        end
        turtle.digUp()
        turtle.digDown()
        turtle.dig()
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    for j = 1,100 do
        turtle.forward()
    end
else
    print("not a valid message")
end