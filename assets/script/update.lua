function love.update(dt)
    Player:update(dt)
    if Player.died then
        return
    end
    if SCORE>table.getn(Anvils)*2000 then
        table.insert(Anvils, NewAnvil())
    end
    for key, value in pairs(Anvils) do
        value:update(dt)
    end
end

function love.keypressed(key)
    --Player:Dash(key)

    if key=="up" and Player.grounded then
        Player:jump(10.5)
    end
    if key=="r" then 
        ResetGame()
    end
end