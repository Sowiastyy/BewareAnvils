local scaleX, scaleY = 6, 6
local background = love.graphics.newImage("assets/img/background.png")
local terrain = love.graphics.newImage("assets/img/terrain.png")
Blackout = 1
playAgainY = 10000

DeathTexts = {"U mad bro?", "Use arrows to move btw", "The goal is to dodge Anvils ;)", "Just Dodge Lol"}
ActualText = "Press R to play again"
local function printFix(n, sum)
    if n>0 then
        return printFix(math.floor(n/10), sum+1)
    else
        return sum
    end
end
function love.draw()

    love.graphics.print("Y: "..Player.y+Player.h)
    love.graphics.print("VF: "..math.floor(SCORE/200), 100)

    love.graphics.scale(scaleX*(love.graphics.getWidth()/800), scaleY*(love.graphics.getHeight()/600))


    love.graphics.draw(background, -SCORE*0.2)
    local disOFF =(math.floor(SCORE/200)*200)
    love.graphics.draw(terrain, -SCORE+disOFF, 33)
    love.graphics.draw(terrain, -SCORE+200+disOFF, 33)
    love.graphics.setColor(1, 1, 1)
    Player:draw()
    if Player.died then

        love.graphics.scale(1/scaleX, 1/scaleY)
        love.graphics.setColor(1, 1, 1)
        love.graphics.print("YOUR SCORE", 270, 50)
        love.graphics.print(SCORE, 385-printFix(SCORE, 0)*6, 100)
        if Blackout>=0.02 then
            Blackout=Blackout-(Blackout*0.02)
        end
        if playAgainY>420 then
            playAgainY=playAgainY-1.5*(playAgainY/100)
        end
        love.graphics.print(ActualText, 400-(FONT:getWidth(ActualText)/2), playAgainY)
        --love.graphics.print("Press R to play again", 160, playAgainY+60)
        love.graphics.setColor(Blackout, Blackout, Blackout)
        return
    end
    for key, value in pairs(Anvils) do
        value:draw()
    end
    love.graphics.scale(1/scaleX*(love.graphics.getWidth()/800), 1/scaleY*(love.graphics.getHeight()/600))

    love.graphics.print(SCORE, 10, 550)
    print(love.timer.getFPS())
end