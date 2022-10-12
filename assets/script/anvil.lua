local img = love.graphics.newImage("assets/img/anvil.png")
--local quad = love.graphics.newQuad(0, 0, 16, 16, img:getWidth(), img:getHeight())

function IsColliding(x1, y1, x2, y2, SX1, SY1, SX2, SY2)
    if type(x1)=="table" then
        SY2 = y1.h
        SX2 = y1.w
        y2 = y1.y
        x2 = y1.x

        SY1 = x1.h
        SX1 = x1.w
        y1 = x1.y
        x1 = x1.x
    end
    if not SY1 then
        SY1=SX1
        SX2=SX1
        SY2=SX1
    end
    if x1+SX1 >= x2 and x2+SX2 >= x1 then
        if y1+SY1 >= y2 and y2+SY2 >= y1 then
            return true
        else
            return false
        end
    else
        return false
    end
end

local Anvil = {
    x=10,
    y=0,
}
--[[
Anvil.grid = Anim8.newGrid(16, 26, img:getWidth(), img:getHeight())
Anvil.animRun = Anim8.newAnimation(Anvil.grid("1-2", 1), 0.15)
]]

function Anvil:spawn(x, y)
    self.x=x
    self.y=y
end

function Anvil:update(dt)
    self.y=self.y+1+SCORE/5000
    if self.y>100 then 
        self:spawn(10, math.random(-20, -5))
    end
end

function Anvil:draw()
    love.graphics.scale(3, 3)
    love.graphics.draw(img, self.x, self.y-5)
    love.graphics.draw(img, self.x+98, self.y-5)
    love.graphics.scale(1/3, 1/3)
end

function NewAnvil()
    return {
        x=120,
        y=0,
        w=10,
        h=10,
        update = function (self, dt, isMenu)
            self.y=self.y+1+SCORE/5000

            if self.y>100 then 
                Anvil.spawn(self, math.random(120), math.random(-20, -5))
            end
            if IsColliding(self, Player) and not isMenu then
                Player.died=true
            end
        end,
        draw = function (self, isMenu)
            love.graphics.draw(img, self.x-4, self.y-5)
        end
    }
end

return Anvil

