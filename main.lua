require('math.ClassVector')
require('Entity.ClassEntity')
require('Entity.ClassEnemy')
require('Entity.ClassPlayer')

local maxEntities = 10000
Entities = {}

function love.load()
    love.window.setTitle("test")
    NoseCat = love.graphics.newImage("Sprites/NoseCat.png")
    SpriteBatch = love.graphics.newSpriteBatch(NoseCat)

    for i = 1, maxEntities do
        Entities[i] = Entity:new()
        Entities[i].pos.x = i
    end

    myPlayer = Player:new()
    --EntityTest = Entity:new()
    --EntityTest.target = Vector:new(150, 150)
end

function love.update(dt)

    local playerDir = myPlayer.getInput()
    myPlayer.target = myPlayer.pos + playerDir
    myPlayer:move_(dt)

    SpriteBatch:clear()
    local mouse = Vector:new(love.mouse.getPosition())
    for _, entity in ipairs(Entities) do
        if entity.type == 0 then
            --goto continue
        end
        entity.target = mouse
        entity:move(dt)

        --check if its on screeen to acoid overdraw
        SpriteBatch:add(entity.pos.x, entity.pos.y, 0, 0.2)
        ::continue::
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(NoseCat, myPlayer.pos.x, myPlayer.pos.y)
    love.graphics.draw(SpriteBatch)
    love.graphics.print(love.timer.getFPS())
end