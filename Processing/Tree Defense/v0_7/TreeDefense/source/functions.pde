void breakTri()
{
  for(int i = 0; i < numTriangles; i++)
  {
    if(tExists[i])
    {
      if(millis() - tTime[i] > tDuration)
      {
        world.remove(triangles[i]);
        tExists[i] = false;
      }
    }
  }
}



void breakSquare()
  {
    if(squareExists)
    {
      if(millis() - squareTime > squareDuration)
      {
        world.remove(square);
        squareExists = false;
        squareBreakTime = millis();
      }
      else
      {
        float alpha = map(squareSize, 0, (height + width)/2, 250, 150);
        int timeAlive = millis() - squareTime;
        red = (int)(map(timeAlive, 0, squareDuration, 0, 170));
        green = 5;
        blue = (int)(map(timeAlive, 0, squareDuration, 100, 10));
        square.setFill(red, green, blue, alpha);
        square.setStroke(red + 10, green, blue + 10, alpha);
      }
    }
  }

void circleColor()
{
  for(int i = 0; i < numCircles; i++)
  {
    if(circleExists[i])
    {
      if(millis() - circleTime[i] > circleDuration)
      {
        world.remove(circles[i]);
        circleExists[i] = false;
      }
      else{
        float center = dist(circles[i].getX(),circles[i].getY(),width/2,height/2);
        red = (int)(map(circles[i].getX(), 0, width, 0, 255));
        //green = (int)(map(center, 0, height, 255, 0));// inverse distance from center
        green = (int)(map(circles[i].getY(), 0, height, 255, 0));
        blue = (int)(map(circles[i].getX(), 0, width, 255, 0)); // inverse width
        circles[i].setFill(red, green, blue);
      }
    }
  }
}



void boom()
{
  if(crateLive && !booming && millis() - crateTime > crateBoom)
  {
    explosion.setPosition(crate.getX(), crate.getY());
    world.add(explosion);
    crate.setPosition((190 + 325)/2, 280 - crateSize/2 - 1);
    crateLive = false;
    boomTime = millis();
    booming = true;
    world.remove(crate);
  }
}
    
void endBoom()
{
  if(booming && millis() - boomTime > boomDuration)
  {
    world.remove(explosion);
    booming = false;
    crateGone = true;
    crateGoneTime = millis();
  }
}
  
void respawnCrate()
{
  if(crateGone && millis() - crateGoneTime > crateCD)
  {
    crate.setImageAlpha(255);
    world.add(crate);
    crateGone = false;
  }
}



void respawnStick()
{
  if((millis() - stickDropped > stickCD) && !stickGrabbed && stickUsed)
  {
      world.add(stickBranch);
      stickUsed = false;
      stick.setDensity(0);
      stick.setPosition(width/2 + 10 + stickY/2, height/2 + 100 - stickX);
      world.add(stick);
  }
}


void dropStick()
{
  if(millis() - stickTime > stickDuration && stickGrabbed)
  {
    world.remove(stickJoint);
    world.remove(stick);
    stickGrabbed = false;
    stickDropped = millis();
  }
}

void launchCata()
{
  if(flying && (millis() - launchTime > flightTime))
  {
    world.remove(cata);
    isCata = false;
    flying = false;
    launched = false;
    cataTime = millis();
    empty = true;
    ammo.setGroupIndex(-2);
    ammoChanged = false;
    posChanged = false;
    ammo.setGrabbable(false);
  }
}  

void reloadCata()
{
    if(!ammoChanged && empty && !isCata && !launched && millis() - cataTime > cataReset)
    {
      disableAmmo();
    }
}

void disableAmmo()
{

    ammo.setGroupIndex(-1);
    changeTime = millis();
    ammoChanged = true;

}

void reloadAmmo()
{
  if(!posChanged && ammoChanged && millis() - changeTime > delay)
  {   
    ammo.setPosition(cataX, cataY);
    ammo.setGrabbable(true);
    posChanged = true;
  }
}

void spawnTriAmmo()
{
 if(triAmmoExists)
 {
   fill(180, 30, 50);
   stroke(0);
   strokeWeight(2);
   triangle(triAmmoX, triAmmoY - triAmmoSize/2, triAmmoX - triAmmoSize/2, triAmmoY + triAmmoSize/2, triAmmoX + triAmmoSize/2, triAmmoY + triAmmoSize/2); 
 } 
}

void spawnCircleAmmo()
{
 if(circleAmmoExists)
 {
   fill(40, 20, 170);
   stroke(0);
   strokeWeight(2);
   ellipse(circleAmmoX, circleAmmoY, circleAmmoSize, circleAmmoSize); 
 } 
}

void spawnHealthItem()
{
 if(healthItemExists)
 {
   fill(255);
   stroke(0);
   strokeWeight(2);
   rect(healthItemX, healthItemY, healthItemSize, healthItemSize, 10);
   fill(200, 20, 20);
   noStroke();
   rect(healthItemX, healthItemY, healthItemSize/2, healthItemSize/6);
   rect(healthItemX, healthItemY, healthItemSize/6, healthItemSize/2);
 } 
}

void makeBloby()
{
  
  bloby = new FBlob();
  bloby.vertex(blobyStartX, blobyStartY);
  bloby.vertex(blobyStartX + blobySize * 2, blobyStartY - blobySize);
  bloby.vertex(blobyStartX + blobySize * 3, blobyStartY - blobySize * 2);
  bloby.vertex(blobyStartX + blobySize * 4, blobyStartY - blobySize * 3);
  bloby.vertex(blobyStartX + blobySize * 4, blobyStartY - blobySize * 4);
  bloby.vertex(blobyStartX + blobySize * 3, blobyStartY - blobySize * 5);
  bloby.vertex(blobyStartX + blobySize * 2, blobyStartY - blobySize * 6);
  bloby.vertex(blobyStartX + blobySize, blobyStartY - blobySize * 7);
  bloby.vertex(blobyStartX, blobyStartY - blobySize * 8);
  bloby.vertex(blobyStartX - blobySize, blobyStartY - blobySize * 7);
  bloby.vertex(blobyStartX - blobySize * 2, blobyStartY - blobySize * 6);
  bloby.vertex(blobyStartX - blobySize * 3, blobyStartY - blobySize * 5);
  bloby.vertex(blobyStartX - blobySize * 4, blobyStartY - blobySize * 4);
  bloby.vertex(blobyStartX - blobySize * 3, blobyStartY - blobySize * 2);
  bloby.vertex(blobyStartX - blobySize * 2, blobyStartY - blobySize);
  bloby.vertex(blobyStartX, blobyStartY);
  bloby.setFill(15, 15, 195);
  bloby.setNoStroke();
  bloby.setRestitution(1.0);
  bloby.setGrabbable(false);
  bloby.setDensity(2.0);
  bloby.setCategoryBits(0x2);
  bloby.setFriction(0.1);
  world.add(bloby);
}

void removeBloby()
{
  if(raindrop && millis() - blobyTime > blobyDuration)
  {
    world.remove(bloby);
    raindrop = false;
  }
}

void gameOver()
{
  if(health < 0 || gameOver)
  {
    gameOver = true;
    world.clear();
    background(0);
    textSize(100);
    textAlign(CENTER);
    fill(255);
    String s = "GAME OVER";
    text(s, width/2, height/2);
    String t = "Score: " + experience; 
    textSize(50);
    text(t, width/2, height/2 + 100);
    stopGame = true;
    fill(10, 40, 150);
    stroke(255);
    rectMode(CENTER);
    rect(playButtonX, playButtonY, menuWidth, menuHeight, 20, 20, 20, 20);
    fill(255);
    textSize(30);
    textAlign(CENTER);
    text("MENU", playButtonX,  playButtonY + 10);
  }
}



void brushButtons()
{
  if(millis() - squareBreakTime > squareCD && !squareExists)
  {
    fill(120, 30, 5);
  }
  else
  {
    fill(50, 10, 0);
  }
  if(squareBrush)
  {
    stroke(245);
    strokeWeight(3);
  }
  else
  {
    stroke(0);
    strokeWeight(2);
  }
  ellipse(squareBrushX, squareBrushY, buttonSize, buttonSize);
  if(circleAmmo > 0)
  {
    fill(120, 30, 5);
  }
  else
  {
    fill(50, 10, 0);
  }
  if(circleBrush)
  {
    stroke(245);
    strokeWeight(3);
  }
  else
  {
    stroke(0);
    strokeWeight(2);
  }
  ellipse(circleBrushX, circleBrushY, buttonSize, buttonSize);
  if(triangleAmmo > 0)
  {
    fill(120, 30, 5);
  }
  else
  {
    fill(50, 10, 0);
  }
  if(polyBrush)
  {
    stroke(245);
    strokeWeight(3);
  }
  else
  {
    stroke(0);
    strokeWeight(2);
  }
  ellipse(polyBrushX, polyBrushY, buttonSize, buttonSize);
  
  stroke(0);
  strokeWeight(2);
  fill(50, 5, 100);
  rectMode(CENTER);
  rect(squareBrushX, squareBrushY, buttonSize/2, buttonSize/2);
  fill(40, 20, 170);
  ellipse(circleBrushX, circleBrushY, buttonSize/2, buttonSize/2);
  fill(180, 30, 50);
  triangle(polyBrushX, polyBrushY - buttonSize/4, polyBrushX - buttonSize/4, polyBrushY + buttonSize/4, polyBrushX + buttonSize/4, polyBrushY + buttonSize/4);
}

