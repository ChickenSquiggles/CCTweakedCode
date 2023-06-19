rednet.open("right", 0)


if turtle.getItemDetail() then
    if turtle.getItemDetail().name == "minecraft:coal_block" then
        turtle.refuel(turtle.getItemCount())
    end
end

function moveFor(dist)
    for i=1, dist do
        turtle.forward()
    end
end


function moveForDown(dist)
    for i=1, dist do
        turtle.down()
    end
end

function moveForUp(dist)
    for i=1, dist do
        turtle.up()
    end
end


while true do
    id,msg = rednet.receive()
    if msg == "wooda" then
        --get to room
        turtle.forward()
        moveForDown(5)
        turtle.turnLeft()
        moveFor(18)

        --grab from wooda barrel
        turtle.turnLeft()
        turtle.forward()
        if turtle.suck(1) == false then

            rednet.broadcast("Wooda! V4 is out of stock.")
            sleep(.05)
            --rednet.broadcast("na")
            --head back
            turtle.back()
            turtle.turnLeft()
            moveFor(18)
            moveForUp(5)
            turtle.turnLeft()
            turtle.back()

        else
            --deliver
            turtle.back()
            turtle.turnLeft()
            moveForUp(2)
            turtle.dropUp(1)
            rednet.broadcast("Deposited Wooda! V4")


            --head back
            moveForDown(2)
            moveFor(18)
            moveForUp(5)
            turtle.turnLeft()
            turtle.back()
        end
    end
end