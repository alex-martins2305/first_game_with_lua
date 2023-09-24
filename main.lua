Screen_height=480
Screen_width=320

Nave={
    src="images/nave.png",
    Nave_width=10,
    Nave_height=10,
    X=(Screen_width-72)/2,
    Y=Screen_height-70,
}

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
    love.window.setMode(Screen_width,Screen_height,{resizable=false})
    love.window.setTitle("Galaxy")
    Background=love.graphics.newImage("images/background.png")
    Nave.image=love.graphics.newImage("images/nave.png")
end

-- Increase the size of the rectangle every frame.
function love.update(dt)
  if love.keyboard.isDown("a","s","w","d","up","down","right","left") then
    moveNave()
  end
end

-- Draw a coloured rectangle.
function love.draw()
    love.graphics.draw(Background,0,0)
    love.graphics.draw(Nave.image,Nave.X,Nave.Y)
    -- In versions prior to 11.0, color component values are (0, 102, 102)
end