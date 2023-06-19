rednet.open("back", 0)

local should = true



while true do
    local event, key, is_held = os.pullEvent("key")
    if keys.getName(key) == "up" then
        rednet.broadcast("up")
    elseif keys.getName(key) == "down" then
        rednet.broadcast("down")
    elseif keys.getName(key) == "w" then
        rednet.broadcast("w")
    elseif keys.getName(key) == "s" then
        rednet.broadcast("s")
    elseif keys.getName(key) == "a" then
        rednet.broadcast("a")
    elseif keys.getName(key) == "d" then
        rednet.broadcast("d")
    elseif keys.getName(key) == "g" then
        term.clear()
        term.setCursorPos(1,1)
        term.write("Sign Text: ")
        signtext = io.read("*l")
        rednet.broadcast("sign".. signtext)
        local event, key, is_held = os.pullEvent("key")
        rednet.broadcast("signdone")
    elseif keys.getName(key) == "r" then
        rednet.broadcast("refuel")
    else
        term.clear()
        term.setCursorPos(1,1)
        term.write("Not an applicable key")
        should = false
    end




    if should then
        term.clear()
        term.setCursorPos(1,1)

        --up
        id, msg = rednet.receive()
        if msg == "na" then
            term.write("No Block Above")
        else
            term.write(msg:gsub("minecraft:", ""))
        end

        --front
        term.setCursorPos(1,2)
        id, msg = rednet.receive()
        if msg == "na" then
            term.write("No Block In Front")
        else
            term.write(msg:gsub("minecraft:", ""))
        end

        --down
        term.setCursorPos(1,3)
        id, msg = rednet.receive()
        if msg == "na" then
            term.write("No Block Below")
        else
            term.write(msg:gsub("minecraft:", ""))
        end
    end
    should = true

end