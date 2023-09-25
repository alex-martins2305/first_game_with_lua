Screen_height=480
Screen_width=320
Max_Enemys=12

Nave={
    src="images/nave.png",
    Nave_width=10,
    Nave_height=10,
    X=(Screen_width-72)/2,
    Y=Screen_height-70,
}

Enemys={}
function cria_Enemy()
    Enemy={
        EX=math.random(Screen_width),
        EY=-60,
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

function moveNave()
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        Nave.Y=Nave.Y-1
      end
      if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        Nave.Y=Nave.Y+1
      end
      if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
        Nave.X=Nave.X-1
      end
      if love.keyboard.isDown("d") or love.keyboard.isDown("right") then
        Nave.X=Nave.X+1
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
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
  if love.keyboard.isDown("a","s","w","d","up","down","right","left") then
    moveNave()
  end
  remove_Enemys()
  if #Enemys<Max_Enemys then
    cria_Enemy()
  end
  move_Enemy()
end

function love.draw()
    love.graphics.draw(Background,0,0)
    love.graphics.draw(Nave.image,Nave.X,Nave.Y)
    for k, Enemy in pairs(Enemys) do
        love.graphics.draw(Enemy_Nave,Enemy.EX,Enemy.EY)
    end
end