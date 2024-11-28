require('math.ClassVector')
EntityTypes = require('Entity.EntityTypesStats')
--EntityTypes = Types

Entity = {}
function Entity:new()
    local newObj = {
        type = 0,
        pos = Vector:new(0, 0),
        target = Vector:new(0, 0), --movement direction
        vel = Vector:new(0, 0),
    }

    self.__index = self
    return setmetatable(newObj, self)
end

--accelerates, has maxspeed
function Entity:accelerate(dt)
    local dir = self.target - self.pos
    self.vel = self.vel + dir:normalized() * EntityTypes[self.type].accel * dt
    if self.vel:len2() > EntityTypes[self.type].maxSpeed ^ 2 then
        self.vel = self.vel:normalized() * EntityTypes[self.type].maxSpeed
    end
    self.pos = self.pos + self.vel * dt
end

--moves with const speed
function Entity:move(dt)
    local dir = self.target - self.pos
    if dir:len2() < (EntityTypes[self.type].velocity * dt) ^ 2 then
        return
    end
    self.pos = self.pos + dir:normalized() * EntityTypes[self.type].velocity * dt
end

--moves with const speed
function Entity:move_(dt)
    local dir = self.target - self.pos
    self.pos = self.pos + dir:normalized() * EntityTypes[self.type].velocity * dt
end

function Entity:getPos()
    return self.pos
end

function Entity:getRadius()
    return EntityTypes[self.type].radius
end
