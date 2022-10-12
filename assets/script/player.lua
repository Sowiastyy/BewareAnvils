
local Player = {
    x=10,
    y=74,
    xo = 4,
    yo = 4,
    w=8,
    h=10,
    r=0,
    spd=30,
    img=love.graphics.newImage("assets/img/player-sheet.png"),
    grounded=false,
    verticalForce=0,
    died=false,


    click = {
        right = 0,
        left = 0,
        interval = 0.1 --Number of seconds between double clicks
    }
}
    Player.grid = Anim8.newGrid(16, 32, Player.img:getWidth(), Player.img:getHeight())
    Player.animRun = Anim8.newAnimation(Player.grid("1-2", 1), 0.15)
    Player.animDeath = Anim8.newAnimation(Player.grid("4-7", 1), 0.05, "pauseAtEnd")
    Player.animDead = Anim8.newAnimation(Player.grid("7-10", 1), {5, 1, 5, 1})
    Player.crouch = Anim8.newAnimation(Player.grid("3-3",1 ), 1.0)
    Player.anim = Player.animRun

    function Player:jump(force)
        Player.verticalForce=force
    end

    function Player:update(dt)
        if Player.died then
            if Player.animDeath.status=="paused" then
                Player.animDeath = Player.animDead
            end
            Player.animDeath:update(dt)
            return
        end
        --#region JUMPING
            if Player.verticalForce>0 then
                Player.y=Player.y+8 --Gravity Pull
                Player.y=Player.y-Player.verticalForce
                Player.verticalForce=Player.verticalForce-0.1
            end
        --#endregion
        --#region SET GROUNDED 
        
            if Player.y+Player.h+Player.yo >= 82 then
                Player.y=68
                Player.grounded = true
            else
                Player.anim:gotoFrame(2)
                Player.grounded=false
            end
        --#endregion
        --#region MOVEMENT
            if love.keyboard.isDown("right") and Player.x<120 then
                Player.x=Player.x+Player.spd         
            elseif love.keyboard.isDown("left") and Player.x>0 then
                Player.x=Player.x-Player.spd
            end
            if love.keyboard.isDown("down") then
                Player.anim = Player.crouch
                Player.h=6
                Player.yo=10
                Player.spd=0.6
                Player.y=Player.y+5
            else
                Player.anim = Player.animRun
                Player.h=10
                Player.yo=4
                Player.spd=1
            end
        --#endregion

        
        Player.anim:update(dt)

        SCORE=SCORE+1
    end

    function Player:Dash(directon)
        if directon=="right" then
            local time = os.time()
            if time <= self.click.right + self.click.interval and Player.x<=110 then
                --Double click
                Player.x=Player.x+10
            else
                self.click.right = time
            end
        elseif directon=="left" then
            local time = os.time()
            if time <= self.click.left + self.click.interval and Player.x>=10 then
                --Double click
                Player.x=Player.x-10
            else
                self.click.left = time
            end
        else
            --print("Variable should have value right|left : "..directon)
        end
    end

    function Player:draw()
        --love.graphics.rectangle("line", self.x, self.y, self.w, self.h)
        if Player.died then

            Player.animDeath:draw(Player.img, 50, 0, self.r, 2, 2)
            love.graphics.setColor(0.75, 0.75, 0.75)
        else
            Player.anim:draw(Player.img, Player.x-self.xo, Player.y-4, self.r, 1, 1)
        end

    end

return Player