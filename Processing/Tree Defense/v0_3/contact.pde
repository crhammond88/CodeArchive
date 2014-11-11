
void contactStarted(FContact contact){
  FBody b1 = contact.getBody1();
  FBody b2 = contact.getBody2();
  
  for(int i = 0 ; i < numEnemies; i++)
  {
    if(enemyExists[i])
    {
      if (b1 == base && b2 == enemies[i] || b1 == enemies[i] && b2 == base){
        score -= 1; 
      }
    } 
  }
    
  
  //reload catapult
  if(((b1 == anchor && b2 == ammo) 
  || (b1 == ammo && b2 == anchor)) && !isCata && (millis() - launchTime > 800))
  {
    isCata = true;
    launched = true;
    cata.setDamping(0.01);
    cata.setFrequency(0.1);
    empty = false;
    world.add(cata);

  }
    
  
//sound effects
//  // test
//  if (b1 == wallR || b2 == wallR || b1 == wallL || b2 == wallL || b1 == ceiling || b2 == ceiling) {// b1 or b2 are walls
//    // wall sound
//    wallSound.cue(0);
//    wallSound.speed(0.5);
//    wallSound.play();
//  }
//  if (b1 == enemy || b2 == enemy) { // b1 or b2 are the enemy
//    // enemy sound
//    enemySound.cue(0);
//    enemySound.speed(1.0);
//    enemySound.play();
//  }
//  if (b1 == crate || b2 == crate){// its a crate
//    crateSound.cue(0);
//    crateSound.speed(0.4);
//    crateSound.play();
//  }
//  if (b1 == base || b2 == base){
//    baseSound.cue(0);
//    baseSound.speed(1.5);
//    baseSound.play();
//  }
//  
  // check for square
  for(int i = 0 ; i < numEnemies; i++)
  {
    if(enemyExists[i])
    {
      if (b1 == square && b2 == enemies[i] || b1 == enemies[i] && b2 == square)
      {
        enemyHealth[i] -= squareDamage;
        if(enemyHealth[i] <= 0)
        {
          death(i);
        }
      }
      else if(b1 == ammo && b2 == enemies[i] || b1 == enemies[i] && b2 == ammo)
      {
        enemyHealth[i] -= cataDamage;
        if(enemyHealth[i] <= 0)
        {
          death(i);
        }
      }
      else
      {
        for(int k = 1; k < numCircles; k++)
        {
          if(circleExists[k])
          {
            if(b1 == circles[k] && b2 == enemies[i]
            || b1 == enemies[i] && b2 == circles[k])
            {
              enemyHealth[i] -= circleDamage;
              if(enemyHealth[i] <= 0)
              {
                death(i);
              }
            }
          }
        }
        for(int j = 1; j < numTriangles; j++)
        {
          if(tExists[j])
          {
            if (b1 == triangles[j] && b2 == enemies[i]
            || b1 == enemies[i] && b2 == triangles[j])
            {
              enemyHealth[i] -= triangleDamage;
              if(enemyHealth[i] <= 0)
              {
                death(i);
              }
            }
          }
        } 
      }      
    } 
  }
  
}





