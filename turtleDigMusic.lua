rednet.open("left", 78)

speaker = peripheral.find("speaker")

term.clear()
term.setCursorPos(1,1)


if turtle.getItemDetail() then
    if turtle.getItemDetail().name == "minecraft:coal" then
        turtle.refuel(turtle.getItemCount())
    end
end

id,msg = rednet.receive()
if msg == "startup" then
    speaker.playSound("minecraft:music_disc.stal")
    for i = 1, 100 do
        repeat
            local has_block, data = turtle.inspect()
        until not has_block
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    for j = 1,100 do
        turtle.forward()
    end
    turtle.turnLeft()
    turtle.turnLeft()
    speaker.stop()
else
    print("not a valid message")
end