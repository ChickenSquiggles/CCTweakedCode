s = peripheral.find("speaker")
while true do
    term.clear()
    term.setCursorPos(1,1)
    term.write("Which Disk? : ")
    input = io.read()
    s.playSound("minecraft:music_disc."..input)
    term.clear()
    term.setCursorPos(1,1)
    term.write("Press Any Key To Stop")
    local event, key, is_held = os.pullEvent("key")
    sleep(.5)
    s.stop()
end