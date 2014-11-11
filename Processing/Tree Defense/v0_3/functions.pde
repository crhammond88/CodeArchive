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

void kill()
{
  // kill dead enemy and respawn it
  if(dead){
      world.remove(enemies[deadNum]);
      dead = false;
      enemyExists[deadNum] = false;
  }
}

void death(int n)
{
    score += 1;
    dead = true;
    deadNum = n; 
}

  
void spawnEnemy()
{
  int epsilon = 15;
  if(millis() % 2000 < epsilon && millis() > 1999)
  {
    int enemyNum = enemyCount % numEnemies;
    if(!enemyExists[enemyNum])
    {
        enemyHealth[enemyNum] = enemyMaxHP;
        world.add(enemies[enemyNum]);
        enemyExists[enemyNum] = true;
        enemyCount++;
      }
        
  }
}


//moves enemy depending on position
void moveEnemy()
{
  for(int i = 0; i < numEnemies; i++)
  {
    if(enemyExists[i])
    {
      if(enemies[i].getX() < width/2){
      enemies[i].addForce(enemySpeed, 0);
      }
      else{
      enemies[i].addForce(0 - enemySpeed, 0);
      }
    }
  }
}



