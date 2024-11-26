require('math.ClassVector')
require('Entity.ClassEntity')
require('Entity.EntityTypesStats')

-- local speed = 500 --acts as accel in accelerate and as velocity in move
-- local maxSpeed = 500

Player = Entity:new()
---@diagnostic disable-next-line: duplicate-set-field
function Player:new()
    local newObj = Entity.new(self)
    newObj.type = 1
    --newObj.health = 100
    --newObj.damage = 10
    --newObj.maxspeed = 5

    self.__index = self
    return setmetatable(newObj, self)
end

function Player.getInput()
    local inputVec = Vector:new(0,0)
    if love.keyboard.isDown("w") then
        inputVec.y = inputVec.y - 1
    end
    if love.keyboard.isDown("s") then
        inputVec.y = inputVec.y + 1
    end
    if love.keyboard.isDown("a") then
        inputVec.x = inputVec.x - 1
    end
    if love.keyboard.isDown("d") then
        inputVec.x = inputVec.x + 1
    end
    return inputVec
end

