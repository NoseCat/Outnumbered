Chunks = {}
ChunkSize = 100
function ChunksPlaceVal(x, y, val)
    local ChunkX = math.floor(x / ChunkSize)
    local ChunkY = math.floor(y / ChunkSize)

    if Chunks[ChunkY] == nil then
        Chunks[ChunkY] = {}
        Chunks[ChunkY][ChunkX] = {}
        Chunks[ChunkY][ChunkX][1] = val
    elseif Chunks[ChunkY][ChunkX] == nil then
        Chunks[ChunkY][ChunkX] = {}
        Chunks[ChunkY][ChunkX][1] = val
    else
        local size = #Chunks[ChunkY][ChunkX]
        Chunks[ChunkY][ChunkX][size + 1] = val
    end
end

function ChunksClear()
    Chunks = nil
    Chunks = {}
end

function ChunkCheckAdjacent(x, y)
    local u, d, l, r, ur, dr, ul, dl = false, false, false, false, false, false, false, false

    r = Chunks[y][x + 1] ~= nil
    l = Chunks[y][x - 1] ~= nil

    if Chunks[y - 1] ~= nil then
        u = Chunks[y - 1][x] ~= nil
        ur = Chunks[y - 1][x + 1] ~= nil
        ul = Chunks[y - 1][x - 1] ~= nil
    end
    if Chunks[y + 1] ~= nil then
        d = Chunks[y + 1][x] ~= nil
        dr = Chunks[y + 1][x + 1] ~= nil
        dl = Chunks[y + 1][x - 1] ~= nil
    end
    return u, d, l, r, ur, dr, ul, dl
end

function ChunksDraw()
    for chunkY in pairs(Chunks) do
        for chunkX in pairs(Chunks[chunkY]) do
            love.graphics.setColor(1, 0, 0)
            love.graphics.setLineWidth(1)
            love.graphics.rectangle("line", chunkX * ChunkSize, chunkY * ChunkSize, ChunkSize, ChunkSize)
            love.graphics.print(#Chunks[chunkY][chunkX], chunkX * ChunkSize, chunkY * ChunkSize)
            love.graphics.print("\n" .. chunkX .. " " .. chunkY, chunkX * ChunkSize, chunkY * ChunkSize)
        end
    end
end

function MergeTables(table1, table2)
    for key, value in pairs(table2) do
        table1[key] = value
    end
    return table1
end

function ChunkAndAdjacentDoValForVal(chunkX, chunkY, func)
    local u, d, l, r, ur, dr, ul, dl = ChunkCheckAdjacent(chunkX, chunkY)
    local allVals = {}
    allVals = MergeTables(allVals, Chunks[chunkY][chunkX])
    if r then
        allVals = MergeTables(allVals, Chunks[chunkY][chunkX + 1])
    end
    if l then
        allVals = MergeTables(allVals, Chunks[chunkY][chunkX - 1])
    end
    if u then
        allVals = MergeTables(allVals, Chunks[chunkY - 1][chunkX])
    end
    if d then
        allVals = MergeTables(allVals, Chunks[chunkY + 1][chunkX])
    end
    if ur then
        allVals = MergeTables(allVals, Chunks[chunkY - 1][chunkX + 1])
    end
    if ul then
        allVals = MergeTables(allVals, Chunks[chunkY - 1][chunkX - 1])
    end
    if dr then
        allVals = MergeTables(allVals, Chunks[chunkY + 1][chunkX +1])
    end
    if dl then
        allVals = MergeTables(allVals, Chunks[chunkY + 1][chunkX - 1])
    end

    for _, value1 in pairs(allVals) do
        for _, value2 in pairs(allVals) do
            func(value1, value2)
        end
    end

end

function ChunksChunkAndAdjecentDoValForVal(func)
    for chunkY in pairs(Chunks) do
        for chunkX in pairs(Chunks[chunkY]) do
            ChunkAndAdjacentDoValForVal(chunkX, chunkY, func)
        end
    end
end


