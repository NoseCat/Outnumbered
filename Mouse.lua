require('math.ClassVector')
require('Button')

Mouse = {}
function Mouse:new()
    local newObj = {
        pos = Vector:new(),
        LMB = Button:new(),
        RMB = Button:new(),
        MMB = Button:new()
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Mouse:update()
    self.pos = Vector:new(love.mouse.getPosition())
    self.LMB:update(LMB)
    self.RMB:update(RMB)
    self.MMB:update(MMB)
end

--event handling vvv
LMB = false
RMB = false
MMB = false
function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then -- Left mouse button
        LMB = true
    elseif button == 2 then -- Right mouse button
        RMB = true
    elseif button == 3 then -- Middle mouse button
        MMB = true
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 then -- Left mouse button
        LMB = false
    elseif button == 2 then -- Right mouse button
        RMB = false
    elseif button == 3 then -- Middle mouse button
        MMB = false
    end
end