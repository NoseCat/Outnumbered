Vector = {}

function Vector:new(a, b)
    local newObj = {x = a, y = b}

    self.__index = self
    return setmetatable(newObj, self)
end

function Vector.__add(a, b)
    return Vector:new(a.x + b.x, a.y + b.y)
end

function Vector.__sub(a, b)
    return Vector:new(a.x - b.x, a.y - b.y)
end

function Vector.__mul(a, b)
    return Vector:new(a.x * b, a.y * b)
end

function Vector.mulScalar(a, b)
    return Vector:new(a.x * b.x, a.y * b.y)
end

function Vector.__div(a, b)
    return Vector:new(a.x / b, a.y / b)
end

function Vector:len()
    return math.sqrt(self.x^2 + self.y^2)
end

--length ^2, faster
function Vector:len2()
    return self.x^2 + self.y^2
end

function Vector:normalized()
    local len = self:len()
    if len == 0 then
        return Vector:new(0,0)
    end
    return Vector:new(self.x / len, self.y / len)
end