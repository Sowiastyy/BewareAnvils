local Logo = love.graphics.newImage("assets/img/bwa.png")
local background = love.graphics.newImage("assets/img/background.png")
local terrain = love.graphics.newImage("assets/img/terrain.png")
local Menu = {
    buttons = {
        {
            text="PLAY",
            x=150,
            y=160,
            color={1, 1, 1},
            event = function ()
                require("assets.script.draw")
                require("assets.script.update")
            end
        },
        {
            text="QUIT",
            x=150,
            y=220,
            event = function ()
                love.event.quit()
            end
        },
    }
}
function Menu:update(dt)
    local mx, my = love.mouse.getPosition()
    for key, value in pairs(Menu.buttons) do
        if IsColliding(mx/2, my/2, value.x, value.y, 1, 1, 96, 48) then
            value.color = {1, 0.1, 0.1}
            if love.mouse.isDown(1) then
                value.event()
            end
        else
            value.color = {1, 1, 1}
        end
    end
    Anvil:update(dt)
end

function Menu:draw()
    local scaleX, scaleY = 2, 2
    love.graphics.scale(scaleX*(love.graphics.getWidth()/800), scaleY*(love.graphics.getHeight()/600))
    love.graphics.scale(3, 3)
    love.graphics.draw(background)
    love.graphics.draw(terrain, 0, 33)
    love.graphics.draw(terrain, 200, 33)
    love.graphics.scale(1/3, 1/3)
    Anvil:draw()
    love.graphics.draw(Logo, 96, 0)
    for key, value in pairs(Menu.buttons) do
        love.graphics.setColor(value.color[1]*0.5,value.color[2]*0.5, value.color[3]*0.5)
        love.graphics.print(value.text, value.x+2, value.y+2)
        love.graphics.setColor(value.color)
        love.graphics.print(value.text, value.x, value.y)
        love.graphics.setColor(1, 1, 1)
        

    end
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
end

return Menu