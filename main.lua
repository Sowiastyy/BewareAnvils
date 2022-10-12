function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest")
    SCORE = 0
    FONT = love.graphics.setNewFont("assets/img/04B_19__.ttf", 48)
    love.graphics.setFont(FONT)
    Anim8 = require("assets.script.anim8")
    Player = require("assets.script.player")
    Anvil = require("assets.script.anvil")
    Anvils = {
    }



    --require("assets.script.draw")
    Menu = require("assets.script.menu")
    love.draw = Menu.draw
    love.update = Menu.update
end

function ResetGame()
    Anvil = {}
    Anvils = {}
    SCORE=0
    Player.died=false
    Player.x=0
    Player.y=74
    Anvil = NewAnvil()
    SCORE = 0
    Blackout=1
    playAgainY = 5000
    ActualText = DeathTexts[love.math.random(1, 4)]
end

