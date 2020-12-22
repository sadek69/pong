function love.load()
  w = love.graphics.getWidth()
  h = love.graphics.getHeight()
  love.math.random()

  --raketka igroka
  mybox={}
  mybox.x=580
  mybox.y=h/2-25
  mybox.x1=10
  mybox.y1=50
  mybox.speed=7
  --raketka ai
  box={}
  box.x=20
  box.y=h/2-25
  box.x1=10
  box.y1=50
  box.speed=6

  ball={}
  ball.x= w/2
  ball.y= h/2
  ball.speedx=5
  ball.speedy=0

  myscore = 0
  aiscore = 0

  text=""


end

function collision(x,y)
  --proverjaem po vertijalnoi koordinate 0+50 i po gorizontalnoi
  if x.y <= y.y+50 and x.y >= y.y-0 and x.x <= y.x+10 and x.x >= y.x then return true
  else
    return false
  end

end



function love.update(dt)

  --obnovljaem koordinati mja4a
  ball.x=ball.x+ball.speedx
  ball.y=ball.y+ball.speedy
  --stolknovenie ball so polom i potolkom i stenami
  if ball.y < 10 then ball.speedy=-ball.speedy end
  if ball.y >390 then ball.speedy=-ball.speedy end
  if ball.x < 10 then
    ball.speedx=-ball.speedx
    myscore=myscore+1
  end
  if ball.x > 590 then
    ball.speedx=-ball.speedx
    aiscore=aiscore+1
  end
  --stolknovenie s raketkoi igroka
  if collision(ball,mybox) then
    ball.speedy=love.math.random( -5, 5 )
    ball.speedx=-ball.speedx
  end

  --stolknovenie s raketkoi protivnika
  if collision(ball,box) then
    ball.speedy=love.math.random( -5, 5 )
    ball.speedx=-ball.speedx
  end

  -- klaviatura i koordinati raketki igroka igroka
  if love.keyboard.isDown('up') then
    mybox.y = mybox.y -mybox.speed
    text=mybox.y
  elseif love.keyboard.isDown('down') then
    mybox.y = mybox.y +mybox.speed
    text=mybox.y
  end

  -- granici ekrana dlja raketki igroka
  if mybox.y < 0 then mybox.y=mybox.y+10
  elseif mybox.y > 350 then mybox.y=mybox.y-10 end

  --dvizenie raketki ai
  if ball.y > box.y then box.y=box.y+box.speed end
  if ball.y < box.y then box.y=box.y-box.speed end

  -- granici ekrana raketki ai
  if box.y < 0 then box.y=mybox.y+10
  elseif box.y > 350 then box.y=box.y-10 end

 


end

function love.keypressed(key)


  if key == 'escape' then  love.event.quit() end

end

function love.draw()
  --fon
  love.graphics.setBackgroundColor( .52, .53, .57, 0)


  --otrisovka objektov
  love.graphics.setColor(.29,.37,.65)
  love.graphics.rectangle('fill',mybox.x,mybox.y,mybox.x1,mybox.y1)
  love.graphics.setColor(.26,.47,.51)
  love.graphics.rectangle('fill',box.x,box.y,box.x1,box.y1)


  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.print(tostring(aiscore),w/2-25, 10, 0, 2, 2)
  love.graphics.print(tostring(myscore),w/2+25, 10, 0, 2, 2)



  love.graphics.setColor(.74, .37, .48)
  love.graphics.circle( 'fill', ball.x, ball.y, 10, 10 )


end
