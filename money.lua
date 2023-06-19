local cardRight = peripheral.wrap("right")
local cardLeft  = peripheral.wrap("left")
if cardLeft.getDiskLabel() == "Cashier" then
    for line in io.lines("disk2/pass.txt") do
        if line == "AdminControl" then
            
        else
            term.write("Not Accepted")
            sleep(1)
            os.shutdown()
        end
    end
else
    term.write("Not Accepted")
    sleep(1)
    os.shutdown()
end
 
function clearScreen()
    term.clear()
    term.setCursorPos(1,1)
end
clearScreen()
 
while true do
    term.write("Which action? : ")
    local choice = io.read("*l")
    clearScreen()
    
    
    if choice == "newCashier" then
        local cmf = io.open("disk/pass.txt", "w")
        cmf:write("AdminControl")
        cardRight.setDiskLabel("Cashier")
        cmf:close()
        print("All Done! Cashier Card Initialized!")
        break
    end
    if choice == "new" or choice == "New" then
        local cmf = io.open("disk/currentMoney.txt", "w")
        term.write("Please Insert The Cardholder's Name: ")
        local cname = io.read("*l")
        cmf:write("0")
        cardRight.setDiskLabel(cname.."'s A! Card")
        cmf:close()
        local cmf = io.open("disk/name.txt", "w")
        cmf:write(cname)
        cmf:close()
        print("All Done! Card Initialized!")
        break
    end
    if choice == "lock" or choice == "lockdown" then
        sp = peripheral.find("speaker")
        redstone.setOutput("front",true)
        while true do
            sleep(.1)
            for j = 1,10 do
                sleep(.001)
                sp.playNote("flute",1,10+j)
            end
            if redstone.getInput("top") then
                break
            end
        end
        redstone.setOutput("front",false)
        break
    end
    


    for line in io.lines("disk/name.txt") do
        name = line
    end
    local ccname = name.."'s A! Card"
    
    
    
    if choice == "set" or choice == "Set" then
        term.write("What ammount of A! Bucks? : ")
        choice = io.read("*l")
        local file = io.open("disk/currentMoney.txt", "w")
        file:write(choice)
        file:close()
        clearScreen()
        term.write("Set the money ammount on "..ccname)
        term.setCursorPos(1,2)
        term.write("to "..choice.." A! Bucks")
    end
    if choice == "get" or choice == "Get" then
        for line in io.lines("disk/currentMoney.txt") do
            term.write(ccname.." has "..line.." A! Bucks")
        end
    end
    
    
    amm = 0
    if choice == "change" or choice == "change" then
        for line in io.lines("disk/currentMoney.txt") do
            amm = line
        end
        term.write("How Much +-? : ")
        choice = io.read("*l")
        local file = io.open("disk/currentMoney.txt", "w")
        file:write(amm+tonumber(choice))
        file:close()
        clearScreen()
        term.write("The money ammount on "..ccname)
        term.setCursorPos(1,2)
        term.write("is now "..amm+tonumber(choice).." A! Bucks")
    end
    if choice == "done" or choice == "done" then
        cardLeft.ejectDisk()
        cardRight.ejectDisk()
        clearScreen()
        term.write("Goodbye!")
        sleep(1)
        os.shutdown()
    end
    
    amm = 0
    name = ""
    for line in io.lines("disk/currentMoney.txt") do
        amm = line
    end
    for line in io.lines("disk/name.txt") do
        name = line
    end
    cardRight.setDiskLabel(name.."'s A! Card - $"..amm)
    
    sleep(2)
    clearScreen()
end