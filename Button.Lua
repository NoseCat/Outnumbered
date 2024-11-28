
Button = {}

function Button:new()
    local newObj = {
        Pressed = false,
        JustPressed = false,
        JustReleased = false
    }

    self.__index = self
    return setmetatable(newObj, self)
end

function Button:update(Pressed)
    if not self.Pressed and Pressed then
        self.JustPressed = true
    else
        self.JustPressed = false
    end
    if self.Pressed and not Pressed then
        self.JustReleased = true
    else
        self.JustReleased = false
    end
    self.Pressed = Pressed
end