require('Entity.ClassEntity')

Enemy = Entity:new()
---@diagnostic disable-next-line: duplicate-set-field
function Enemy:new()
    local newObj = Entity.new(self) 
    newObj.type = 1
    newObj.health = 100
    newObj.damage = 10
    newObj.speed = 5

    self.__index = self
    return setmetatable(newObj, self)
end