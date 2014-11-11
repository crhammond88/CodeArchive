void kill()
{
  if(dead)
  {
    // kill dead enemies
    for(int i = 0; i < numTotalEnemies; i++)
    { 
      if(deadTest[i])
      {
        world.remove(enemies[i]);
        enemyExists[i] = false;
      }
    }
    dead = false;
  }
}


void death(int n)
{
    spawnItem(n);
    if(n < numSmallEnemies)
    {
      experience += 1;
    }
    else if(n < numLargeEnemies + numSmallEnemies)
    {
      experience += 10;
    }
    else if(n < numEnemies + numSmallEnemies + numLargeEnemies)
    {
      experience += 2;
    }
    else
    {
      experience += 3;
    }
    dead = true;
    deadTest[n] = true; 
}


void spawnItem(int i)
{
  int random = (int)random(10);
  if(random > 4)
  {
    int itemNum = (int)random(1, 4);
    if(!triAmmoExists && itemNum == 1)
    {
      triAmmoX = enemies[i].getX();
      triAmmoY = enemies[i].getY();
      triAmmoExists = true;
    }
    else if(!circleAmmoExists && itemNum == 2)
    {
      circleAmmoX = enemies[i].getX();
      circleAmmoY = enemies[i].getY();
      circleAmmoExists = true;
    }
    else if(!healthItemExists && itemNum == 3)
    {
      healthItemX = enemies[i].getX();
      healthItemY = enemies[i].getY();
      healthItemExists = true;
    }
  }
}
        
void spawnSmallEnemy()
{
  int epsilon = 15;
  if(millis() % smallEnemyCD < epsilon && millis() > smallEnemyCD)
  {
    int enemyNum = smallEnemyCount % numSmallEnemies;
    if(!enemyExists[enemyNum])
    {
        enemyHealth[enemyNum] = smallEnemyMaxHP;
        world.add(enemies[enemyNum]);
        enemyExists[enemyNum] = true;
        smallEnemyCount++;
        deadTest[enemyNum] = false;
        println("adding enemy: " + enemyNum);
      }
        
  }
}        

void spawnLargeEnemy()
{
  int epsilon = 15;
  if(millis() % largeEnemyCD < epsilon && millis() > largeEnemyCD)
  {
    int enemyNum = (largeEnemyCount % numLargeEnemies) + numSmallEnemies;
    println(enemyNum);
    if(!enemyExists[enemyNum])
    {
        enemyHealth[enemyNum] = largeEnemyMaxHP;
        world.add(enemies[enemyNum]);
        enemyExists[enemyNum] = true;
        largeEnemyCount++;
        deadTest[enemyNum] = false;
        println("adding enemy: " + enemyNum);
     }    
  }
}

void spawnEnemy()
{
  int epsilon = 15;
  if(millis() % enemyCD < epsilon && millis() > enemyCD)
  {
    int enemyNum = (enemyCount % numEnemies) + numSmallEnemies + numLargeEnemies;
    if(!enemyExists[enemyNum])
    {
        enemyHealth[enemyNum] = enemyMaxHP;
        world.add(enemies[enemyNum]);
        enemyExists[enemyNum] = true;
        enemyCount++;
        deadTest[enemyNum] = false;
        println("adding enemy: " + enemyNum);
      }
        
  }
}


void flyingEnemy()
{
  int epsilon = 15;
  if(millis() % flyingEnemyCD < epsilon && millis() > flyingEnemyCD)
  {
    int enemyNum = (flyingEnemyCount % numFlyingEnemies) + numEnemies + numLargeEnemies + numSmallEnemies;
    if(!enemyExists[enemyNum])
    {
        enemyHealth[enemyNum] = flyingEnemyMaxHP;
        world.add(enemies[enemyNum]);
        enemyExists[enemyNum] = true;
        flyingEnemyCount++;
        deadTest[enemyNum] = false;
        println("adding enemy: " + enemyNum);
      }
        
  }
}



void moveSmallEnemy()
{
  for(int i = 0; i < numSmallEnemies; i++)
  {
    if(enemyExists[i])
    {
      if(enemies[i].getX() < width/2){
      enemies[i].setForce(smallEnemySpeed, 0);
      }
      else{
      enemies[i].setForce(0 - smallEnemySpeed, 0);
      }
    }
  }
}


void moveLargeEnemy()
{
  for(int i = numSmallEnemies; i < numLargeEnemies + numSmallEnemies; i++)
  {
    if(enemyExists[i])
    {
      if(enemies[i].getX() < width/2){
      enemies[i].setForce(largeEnemySpeed, 0);
      }
      else{
      enemies[i].setForce(0 - largeEnemySpeed, 0);
      }
    }
  }
}

//moves enemy depending on position
void moveEnemy()
{
  for(int i = numLargeEnemies + numSmallEnemies; i < numEnemies + numLargeEnemies + numSmallEnemies; i++)
  {
    if(enemyExists[i])
    {
      if(enemies[i].getX() < width/2){
      enemies[i].setForce(enemySpeed, 0);
      }
      else{
      enemies[i].setForce(0 - enemySpeed, 0);
      }
    }
  }
}

void moveFlying()
{
  for(int i = numEnemies + numSmallEnemies + numLargeEnemies; i < numTotalEnemies; i++)
  {
    if(enemyExists[i])
    {
      if(enemies[i].getX() < width/2){
      enemies[i].setForce(flyingEnemySpeed, 0);
      }
      else{
      enemies[i].setForce(0 - flyingEnemySpeed, 0);
      }
    }
  }
}


