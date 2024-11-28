local DefaultType = {
    maxSpeed = 500,
    accel = 500,
    velocity = 500,
    radius = 16
}

local Player = {
    maxSpeed = 1000,
    accel = 500,
    velocity = 500,
    radius = 16
}

local Enemy = {
    maxSpeed = 1000,
    accel = 500,
    velocity = 500,
    radius = 16
}


local Types = {}
Types[0] = DefaultType
Types[1] = Player
Types[2] = Enemy
return Types

