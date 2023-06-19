rednet.open("back", 78)



while true do
    local event, key, is_held = os.pullEvent("key")
    if keys.getName(key) == "enter" then
        rednet.broadcast("startup")

    else
        term.clear()
        term.setCursorPos(1,1)
        term.write("Not an applicable key")
    end

end