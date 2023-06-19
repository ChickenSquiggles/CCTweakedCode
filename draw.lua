monitor = peripheral.find("monitor")
 
--monitor.clear()
 
local l,w = monitor.getSize()
monitor.setTextScale(.5)
 
function drawPixel(x,y,c)
monitor.setCursorPos(x,y)
monitor.setBackgroundColor(c)
monitor.write(" ")
monitor.setBackgroundColor(colors.black)
end
 
function clearGrid()
 
grid = {}
for i = 1, l do
    grid[i] = {}
    for j = 1, w do
        grid[i][j] = 32768
    end
end
 
end
clearGrid()
 
 
function mainDisplay(should)
    for b=1,w do
        drawPixel(l-1,b,256)
        drawPixel(l,b,256)
        drawPixel(1,b,128)
        drawPixel(2,b,128)
    end
    


if w>19 then
    drawPixel(l,w,1)
    drawPixel(l,w-1,2)
    drawPixel(l,w-2,4)
    drawPixel(l,w-3,8)
    drawPixel(l,w-4,16)
    drawPixel(l,w-5,32)
    drawPixel(l,w-6,64)
    drawPixel(l,w-7,128)
    drawPixel(l,w-8,256)
    drawPixel(l,w-9,512)
    drawPixel(l,w-10,1024)
    drawPixel(l,w-11,2048)
    drawPixel(l,w-12,4096)
    drawPixel(l,w-13,8192)
    drawPixel(l,w-14,16384)
    drawPixel(l,w-15,32768)
else
	drawPixel(l-1,w,1)
    drawPixel(l-1,w-1,2)
    drawPixel(l-1,w-2,4)
    drawPixel(l-1,w-3,8)
    drawPixel(l-1,w-4,16)
    drawPixel(l-1,w-5,32)
    drawPixel(l-1,w-6,64)
    drawPixel(l-1,w-7,128)
    drawPixel(l,w,256)
    drawPixel(l,w-1,512)
    drawPixel(l,w-2,1024)
    drawPixel(l,w-3,2048)
    drawPixel(l,w-4,4096)
    drawPixel(l,w-5,8192)
    drawPixel(l,w-6,16384)
    drawPixel(l,w-7,32768)
   end


    drawPixel(1,1,16384)
    drawPixel(1,2,16384)
    drawPixel(2,1,16384)
    drawPixel(2,2,16384)
    
    if should == "l" then
        drawPixel(1,w,32)
    else
        drawPixel(1,w,16384)
    end
    
    drawPixel(1,5,32)
    drawPixel(2,5,32)
    
    drawPixel(1,7,32)
    drawPixel(2,7,32)
    
    drawPixel(1,9,32)
    drawPixel(2,9,32)
 
    
    
    
end
mainDisplay("l")
 
function save(name)
    file = io.open(name .. ".txt", "w")
    for j=1,w do
        for i=1,l do
            file:write(grid[i][j])
            file:write("\n")
        end
    end
    file:close()
end
 
function load(name)
    file = io.open(name..".txt", "r")
    local i = 1
    local j = 1
    for line in file:lines() do
        i = i+1
        if i == l+1 then
            i = 1
            j = j+1
            if j == w then break end
        end
        if i == 1 then
        else
        grid[i-1][j] = tonumber(line)
        end
        drawPixel(i-1,j,tonumber(line))
    end   
end
 
 
 
 
    
local curcolor = 1
local can = true
local lr = "l"
while true do
    local event, side, x, y = os.pullEvent("monitor_touch")
    can = true
    
    --change color
    if x>l-3 or x<3 then can=false end

	if w>19 then
        if x == l and y > w-16 then
            curcolor=2^(w-y)
            drawPixel(l,1,curcolor)
        end
    else
        if x == l and y > w-8 then
            curcolor=2^((w-y)+8)
            drawPixel(l,1,curcolor)
        end
        if x == l-1 and y > w-8 then
            curcolor=2^(w-y)
            drawPixel(l,1,curcolor)
        end
    end

    --clear
    if x < 3 and y < 3 then
        monitor.clear()
        mainDisplay(lr)
        clearGrid()
        drawPixel(l,1,curcolor)
        can=false
    end
    
    --change save/load
    if x<3 and y>w-1 then
        if lr == "l" then
            lr = "r"
            drawPixel(1,w,16384)
        else
            lr = "l"
            drawPixel(1,w,32)
        end
    end
    
    --save/load
    if x<3 and y>4 and y<10 then
        if y%2==1 then
            if lr == "l" then
                save("saveslot" .. (y-3)/2)
            else
                load("saveslot" .. (y-3)/2)
            end
            mainDisplay(lr)
        end
    end
    
    --draw
    if can then
    drawPixel(x,y,curcolor)
    grid[x][y] = curcolor
    end
    
    
end