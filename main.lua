require('math.ClassVector')
require('Entity.ClassEntity')
require('Entity.ClassEnemy')
require('Entity.ClassPlayer')
require('Mouse')
require('Button')
require('Chunks')

local maxEntities = 10000
Entities = {}

CollisionsCounter = 0
function CircleCollide(c1, c2)
    local disVec = c1:getPos() - c2:getPos()
    local dis = math.sqrt(disVec.x^2 + disVec.y^2)
    disVec = Vector:new(disVec.x/dis, disVec.y/dis)

    if (c1:getPos() - c2:getPos()):len2() < (c1:getRadius() + c2:getRadius())^2 then
        local push = c1:getRadius() + c2:getRadius() - dis
        push = push / 4
        c1.pos = c1.pos + disVec * push
        c2.pos = c2.pos - disVec * push
    end
    CollisionsCounter = CollisionsCounter + 1
end

function EntitiesCollide(e1, e2)
    if e1 ~= e2 then
        CircleCollide(Entities[e1], Entities[e2])
    end
end

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

enemies = 0
function love.update(dt)
    myPlayer:updateMouse()

    local playerDir = myPlayer.getInput()
    myPlayer.target = myPlayer.pos + playerDir
    myPlayer:move_(dt)

    if myPlayer.Mouse.LMB.JustPressed then
        for i = 1, 100 do
            enemies = enemies + 1
            Entities[enemies].type = 2
            Entities[enemies].pos.x = myPlayer.Mouse.pos.x + math.random(50)
            Entities[enemies].pos.y = myPlayer.Mouse.pos.y + math.random(50)
        end
    end

    SpriteBatch:clear()
    EnemyCounter = 0
    ChunksClear()

    for i = 1, maxEntities do
        if Entities[i].type == 0 then
            goto continue1
        end

        EnemyCounter = EnemyCounter + 1
        Entities[i].target = myPlayer.pos
        Entities[i]:accelerate(dt)

        ChunksPlaceVal(Entities[i].pos.x, Entities[i].pos.y, i)

        --check if its on screeen to avoid overdraw
        SpriteBatch:add(Entities[i].pos.x - (NoseCat:getWidth()/2) * 0.5, Entities[i].pos.y - (NoseCat:getHeight()/2) * 0.5, 0, 0.5)
        ::continue1::
    end
    ChunksChunkAndAdjecentDoValForVal(EntitiesCollide)
end

function love.draw()
    ChunksDraw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(NoseCat, myPlayer.pos.x - NoseCat:getWidth()/2, myPlayer.pos.y - NoseCat:getHeight()/2)
    love.graphics.draw(SpriteBatch)
    love.graphics.print(love.timer.getFPS() .. " " .. enemies .. " " .. CollisionsCounter)
    CollisionsCounter = 0
end


