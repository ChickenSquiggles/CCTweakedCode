monitor = peripheral.find("monitor")
 
monitor.clear()
monitor.setTextScale(.5)
local l,w = monitor.getSize()


 
function drawPixel(x,y,c)
    monitor.setCursorPos(x,y)
    monitor.setBackgroundColor(c)
    monitor.write(" ")
    monitor.setBackgroundColor(colors.black)
end
 
function clearGrid()
    grid = {}
    for i = 1, l+1 do
        grid[i] = {}
        for j = 1, w+1 do
            grid[i][j] = 32768
        end
    end
end


function mainDisplay()
    drawPixel(l,w,1)
    drawPixel(l,w-1,128)
    drawPixel(l-1,w,256)
    drawPixel(l-1,w-1,32768)
end

function save(name)
    file = io.open(name .. ".txt", "w")
    for j=1,w+1 do
        for i=1,l+1 do
            file:write(grid[i][j])
            file:write("\n")
        end
    end
    file:close()
end

function load(name)
    file = io.open(name..".txt", "r")
    local i = 0
    local j = 1
    for line in file:lines() do
        i = i+1
        if i == l+2 then
            i = 1
            j = j+1
            if j == w+1 then break end
        end
        if i == 1 then
        else
            grid[i][j] = tonumber(line)
        end
        drawPixel(i,j,tonumber(line))
    end   
    file:close()
end  

clearGrid()
load("saveslot1")
mainDisplay()
 
 
 

local curcolor = 1
local can = true
local lr = "l"
while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    can = true
    
    --change color
    if x == l and y == w then
        curcolor=1
        drawPixel(1,w,curcolor)
        can=false
    elseif x == l and y == w-1 then
        curcolor=128
        drawPixel(1,w,curcolor)
        can=false
    elseif x== l-1 and y == w then
        curcolor=256
        drawPixel(1,w,curcolor)
        can=false
    elseif x == l-1 and y == w-1 then
        curcolor=32768
        drawPixel(1,w,curcolor)
        can=false
    end
    
    --draw
    if can then
        drawPixel(x,y,curcolor)
        grid[x][y] = curcolor
    end
    
    save("saveslot1")
end