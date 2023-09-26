Screen_height=480
Screen_width=320
Max_Enemys=8
Max_Meteoros=4

--METEOROS:
Meteoros={}
function cria_Meteoro()
    Meteoro={
        MX=math.random(Screen_width),
        MY=-60,
        M_speed=math.random(3),
        angulo=math.random(90),
        M_angular_speed=math.random(-1,1),
        M_move_X=math.random(-1,1),
        M_width=20,
        M_height=20
    }
    table.insert(Meteoros, Meteoro)
end

function remove_Meteoros()
    for i = #Meteoros, 1, -1 do
        if Meteoros[i].MY > Screen_height then
            table.remove(Meteoros,i)
        end 
    end
end 

function move_Meteoro()
    for k, Meteoro in pairs(Meteoros) do
        Meteoro.MY=Meteoro.MY+ Meteoro.M_speed
        Meteoro.angulo=Meteoro.angulo + 0.01*Meteoro.M_angular_speed
        Meteoro.MY=Meteoro.MY+1
        Meteoro.MX=Meteoro.MX+Meteoro.M_move_X
    end
end

--ENEMYS:
Enemys={}
function cria_Enemy()
    Enemy={
        EX=math.random(Screen_width),
        EY=-60,
        E_height=20,
        E_width=20,
        E_speed=math.random(3)
    }
    table.insert(Enemys, Enemy)
end

function remove_Enemys()
    for i = #Enemys, 1, -1 do
        if Enemys[i].EY > Screen_height then
            table.remove(Enemys,i)
        end 
    end
end 

function move_Enemy()
    for k, Enemy in pairs(Enemys) do
        Enemy.EY=Enemy.EY+ Enemy.E_speed
    end
end

--Nave:
Nave={
    src="images/nave.png",
    Nave_width=20,
    Nave_height=20,
    X=(Screen_width-72)/2,
    Y=Screen_height-70,
    N_speed=2,
    distorcion=1
}

function moveNave()
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        if Nave.Y>0 then
            Nave.Y=Nave.Y-Nave.N_speed
        end
    end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        if Nave.Y<Screen_height-30 then
            Nave.Y=Nave.Y+Nave.N_speed
        end
    end
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        if Nave.X>0 then
            Nave.X=Nave.X-Nave.N_speed
        end
    --     if Nave.distorcion==1 then
    --         Nave.distorcion=0.801
    --     end
    --     if Nave.distorcion==0.8 then
    --         Nave.distorcion=1
    --     end 
    -- else
    --     Nave.distorcion=1
    end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        if Nave.X<Screen_width-Nave.Nave_width then
            Nave.X=Nave.X+Nave.N_speed
        end
    --     if Nave.distorcion==1 then
    --         Nave.distorcion=0.8
    --     end
    --     if Nave.distorcion==0.801 then
    --         Nave.distorcion=1
    --     end
    -- else
    --     Nave.distorcion=1
    end
end

function  destroy_Nave()
    Nave.src="images/nave_explosion.png"
    Nave.image=love.graphics.newImage(Nave.src)
    Nave.Nave_height=50
    Nave.Nave_width=50
    Game_Over=true
end

--Colision:

function Colision(X1,Y1,W1,H1, X2,Y2,W2,H2)
    return X2 < X1+W1 and
           X1 < X2+W2 and
           Y1 < Y2+H2 and
           Y2 < Y1+H1
end

function verify_colisions()
    for k, Enemy in pairs(Enemys) do
        if Colision(Enemy.EX, Enemy.EY, Enemy.E_width, Enemy.E_height, Nave.X, Nave.Y, Nave.Nave_width, Nave.Nave_height) then
            destroy_Nave()
        end
    end
    for k, Meteoro in pairs(Meteoros) do
        if Colision(Meteoro.MX, Meteoro.MY, Meteoro.M_width, Meteoro.M_height, Nave.X, Nave.Y, Nave.Nave_width, Nave.Nave_height) then
            destroy_Nave()
        end
    end
end
-- Load some default values for our rectangle.
function love.load()
    math.randomseed(os.time())
    love.window.setMode(Screen_width,Screen_height,{resizable=false})
    love.window.setTitle("Galaxy")
    Background=love.graphics.newImage("images/background.png")
    Nave.image=love.graphics.newImage("images/nave.png")
    Enemy_Nave=love.graphics.newImage("images/enemy_nave.png")
    Meteoro_img=love.graphics.newImage("images/meteoro.png")
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    if not Game_Over then
        if love.keyboard.isDown("a","s","w","d","up","down","right","left") then
            moveNave()
        end
        remove_Enemys()
        if #Enemys<Max_Enemys then
            cria_Enemy()
        end
        move_Enemy()
        remove_Meteoros()
        if #Meteoros<Max_Meteoros then
            cria_Meteoro()
        end
        move_Meteoro()
        verify_colisions() 
    end
end

function love.draw()
    love.graphics.draw(Background,0,0)
    love.graphics.draw(Nave.image,Nave.X,Nave.Y, 0,Nave.distorcion, 1)
    --love.graphics.draw(Nave.image,Nave.X,Nave.Y)
    for k, Enemy in pairs(Enemys) do
        love.graphics.draw(Enemy_Nave,Enemy.EX,Enemy.EY)
    end
    for k, Meteoro in pairs(Meteoros) do
        love.graphics.draw(Meteoro_img, Meteoro.MX, Meteoro.MY, Meteoro.angulo, 0.7,0.7, 35,35)
    end
    
end