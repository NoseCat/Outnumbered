local DefaultType = {
    maxSpeed = 500,
    accel = 500,
    velocity = 500
}

local Player = {
    maxSpeed = 1000,
    accel = 500,
    velocity = 500
}

local Types = {}
Types[0] = DefaultType
Types[1] = Player
return Types

