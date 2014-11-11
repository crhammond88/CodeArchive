void setLevel()
{  
  
  if(!practice && !survival)
  {
    if(level == 1 && millis() - pauseMessageTime > levelOneDuration)
    {
      level = 2;
      smallEnemyOn = true;
      levelTwoTime = millis();
    }
    else if(level == 2 && millis() - levelTwoTime > levelTwoDuration)
    {
      level = 3;
      enemyCD += 1000;
      flyingEnemyOn = true;
      levelThreeTime = millis();
    }
    else if(level == 3 && millis() - levelThreeTime > levelThreeDuration)
    {
      level = 4;
      smallEnemyCD += 1000;
      largeEnemyOn = true;
      levelTime = millis();
    }
    else if(level >= 4 && millis() - levelTime > levelDuration)
    {
      level += 1;
      levelTime = millis();
      levelDuration += 5000;
      smallEnemyDamage += 1;
      largeEnemyDamage += level;
      enemyDamage += 2;
      flyingEnemyDamage += 1;
      if(enemyCD > 1000)
      {
        enemyCD -= 500;
      }
      if(largeEnemyCD > 3000)
      {
        largeEnemyCD -= 1000;
      }
      if(flyingEnemyCD > 1000);
      {
        flyingEnemyCD -= 500;
      }
      if(smallEnemyCD > 1000)
      {
        smallEnemyCD -= 500;
      }
    }
  }
}
