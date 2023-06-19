local dfpwm = require("cc.audio.dfpwm")
local speaker = peripheral.find("speaker")
local monitor = peripheral.find("monitor")
local drive = peripheral.wrap("left")
monitor.setTextScale(.5)
monitor.clear()
l,w = monitor.getSize()

while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    if drive:hasData() then
        local file = io.open("disk/name.txt","r")
        local songName

        for line in file:lines() do
            songName = line
        end
        local showText = "Now Playing: " .. songName:gsub("_"," ")

        monitor.clear()
        monitor.setCursorPos((l/2)-(#showText/2), w/2)
        monitor.write(showText)


        local decoder = dfpwm.make_decoder()
        for chunk in io.lines("disk/"..songName..".dfpwm", 16 * 1024) do
            local buffer = decoder(chunk)

            while not speaker.playAudio(buffer, 2) do
                os.pullEvent("speaker_audio_empty")
            end
        end
    else
        local showText = "No Drive Inserted"

        monitor.clear()
        monitor.setCursorPos((l/2)-(#showText/2), w/2)
        monitor.write(showText)
    end

end