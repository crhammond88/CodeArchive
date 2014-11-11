void mousePressed()
{
  if(menu)
  {
    if(abs(mouseX - playButtonX) < menuWidth && abs(mouseY - playButtonY) < menuHeight)
    {
      restart();
      menu = false;
      stopGame = false;
    }
  }
  else if(gameOver)
  {
    if(abs(mouseX - playButtonX) < menuWidth && abs(mouseY - playButtonY) < menuHeight)
    {
      println("Here");
      gameOver = false;
    }
  }
  else
  {
    if(mouseButton == LEFT){
      if(abs(crate.getX() - mouseX) < crateSize/2 && abs(crate.getY() - mouseY) < crateSize/2){
        clicking = true;
        if(!crateLive && !crateGone && !booming)
        {
          crateGrabbed = true;
        }
      }
      else if(abs(ammo.getX() - mouseX) < ammoSize/2 && abs(ammo.getY() - mouseY) < ammoSize/2){
        clicking = true;
        if(empty)
        {
          ammoClicked = true;
        }
        else
        {
          launched = true;
        }
      }
      else if((abs(blobyStartX - mouseX) < 100 && abs(blobyStartY - 65 - mouseY) < 70) && !raindrop){
        makeBloby();
        clicking = true;
        raindrop = true;
        blobyTime = millis();
      }
      // pick up stick
      else if(abs(stick.getX() - mouseX) < stickY/2 && abs(stick.getY() - mouseY) < stickY/2 && !stickGrabbed && !stickUsed)
      {
        stick.setDensity(10);
        clicking = true;
        stickUsed = true;
        stickGrabbed = true;
        stickJoint = new FMouseJoint(stick, mouseX, mouseY);
        stickJoint.setDrawable(false);
        world.add(stickJoint);
        stickTime = millis();
        world.remove(stickBranch);
      }
      //brush conditions
      else if(abs(mouseX - squareBrushX) < buttonSize/2 && abs(mouseY - squareBrushY) < buttonSize/2)
      {
        clicking = true;
        squareBrush = true;
        circleBrush = false;
        polyBrush = false;
      }
      else if(abs(mouseX - circleBrushX) < buttonSize/2 && abs(mouseY - circleBrushY) < buttonSize/2)
      {
        clicking = true;
        circleBrush = true;
        squareBrush = false;
        polyBrush = false;
      }
      else if(abs(mouseX - polyBrushX) < buttonSize/2 && abs(mouseY - polyBrushY) < buttonSize/2)
      {
        clicking = true;
        polyBrush = true;
        circleBrush = false;
        squareBrush = false;
      }
      // circle brush implementation
      else if(circleBrush && circleAmmo > 0)
      {     
        int circleNum = circleCount % numCircles;
        FCircle attack = circles[circleNum];
        float center = dist(attack.getX(),attack.getY(),width/2,height/2);
        red = (int)(map(attack.getY(), 0, height, 255, 0));// inverse height
        green = (int)(map(center, 0, height, 255, 0));// inverse distance from center
        blue = (int)(map(attack.getX(), 0, width, 255, 0));// inverse width
        circleExists[circleNum] = true;
        world.remove(attack);
        attack.setFill(red, green, blue);
        attack.setPosition(mouseX, mouseY);
        world.add(attack);
        circleCount++;
        circleTime[circleNum] = millis();
        circleDamage = (int)(map(mouseY, 0, height, circleMaxDamage, circleMinDamage));
        circleAmmo -= 1;
      }
      else if(squareBrush && !squareExists)
      {    
          clickX = mouseX;
          clickY = mouseY;
      }
    }
  }
}

void mouseMoved()
{
  if(stickGrabbed)
  {
    stickJoint.setTarget(mouseX + 20, mouseY - 10);
  }
  
  if(triAmmoExists && abs(mouseX - triAmmoX) < triAmmoSize/2 && abs(mouseY - triAmmoY) < triAmmoSize/2)
  {
    triangleAmmo += triAmmoItem;
    triAmmoExists = false; 
  }
  if(circleAmmoExists && abs(mouseX - circleAmmoX) < circleAmmoSize/2 && abs(mouseY - circleAmmoY) < circleAmmoSize/2)
  {
    circleAmmo += circleAmmoItem;
    circleAmmoExists = false; 
  }
  if(healthItemExists && abs(mouseX - healthItemX) < healthItemSize/2 && abs(mouseY - healthItemY) < healthItemSize/2)
  {
    health += healthItem;
    healthItemExists = false; 
  }
}

void mouseDragged()
{
  try{
  if(stickGrabbed)
  {
    stickJoint.setTarget(mouseX + 20, mouseY - 10);
  }
  }catch(NullPointerException e){}
  
  //triangle brush implementation
  if(polyBrush && !clicking && triangleAmmo > 0)
  {
      float speed = dist(pmouseX, pmouseY, mouseX, mouseY);
      float alpha = map(speed, 1, 10, 255, 245);
      red = (int)(map(mouseX, 0, width, 0, 255));
      green = (int)(map(mouseY, 0, height, 0, 255));
      blue = (int)(map(mouseX, 0, width, 255, 0));
      int tNum = triangleCount % numTriangles;
      FPoly attack = triangles[tNum];
      world.remove(attack);
      attack.setFill(red, green, blue, alpha);
      attack.setPosition(mouseX - width/2, mouseY - height/2);
      world.add(attack);
      triangleCount++;
      tTime[tNum] = millis();
      tExists[tNum] = true;
      triangleAmmo -= 1;
  }
 
  if(triAmmoExists && abs(mouseX - triAmmoX) < triAmmoSize/2 && abs(mouseY - triAmmoY) < triAmmoSize/2)
  {
    triangleAmmo += triAmmoItem;
    triAmmoExists = false; 
  }
  if(circleAmmoExists && abs(mouseX - circleAmmoX) < circleAmmoSize/2 && abs(mouseY - circleAmmoY) < circleAmmoSize/2)
  {
    circleAmmo += circleAmmoItem;
    circleAmmoExists = false; 
  }
  if(healthItemExists && abs(mouseX - healthItemX) < healthItemSize/2 && abs(mouseY - healthItemY) < healthItemSize/2)
  {
    health += healthItem;
    healthItemExists = false; 
  }
}
    
void mouseReleased()
{
  if(mouseButton == LEFT){    
    //launch cata
    if (launched && !empty)
    {
      empty = true;
      flying = true;
      launchTime = millis();
      cata.setDamping(1000);
      cata.setFrequency(1000);
    }
    else if(crateGrabbed && !crateLive && !crateGone && !booming)
    {
      crateTime = millis();
      crateLive = true;
      crateGrabbed = false;
      crate.setImageAlpha(205);
    }
    else if (empty && ammoClicked)
    {
      disableAmmo();
      ammoClicked = false;      
    }
    else if (!clicking && squareBrush && !squareExists && (millis() - squareBreakTime > squareCD)){
      float xDiff = abs(clickX - mouseX);
      float yDiff = abs(clickY - mouseY);
      float left = min(clickX, mouseX);
      float right = max(clickX, mouseX);
      float top = min(clickY, mouseY);
      float bottom = max(clickY, mouseY);    
      float epsilon = 15;
      float min = 25;
      float xSize, ySize, xPos, yPos;
      
      if (xDiff < epsilon && yDiff < epsilon){
        xSize = min;
        ySize = min;
        xPos = mouseX;
        yPos = mouseY;
      }
      else if(xDiff < epsilon){
        xSize = min;
        ySize = yDiff;
        xPos = mouseX;
        yPos = (top + bottom)/2;
      }
      else if(yDiff < epsilon){
        xSize = xDiff;
        ySize = min;
        xPos = (left + right)/2;
        yPos = mouseY;
      } 
      else{
        xSize = xDiff;
        ySize = yDiff;
        xPos = (left + right)/2;
        yPos = (top + bottom)/2;
      }
      
 
      squareSize = dist(mouseX, mouseY, clickX, clickY);
      float alpha = map(squareSize, 0, (height + width)/2, 250, 150);
      int timeAlive = millis() - squareTime;
      red = (int)(map(timeAlive, 0, squareDuration, 170, 0));
      green = 5;
      blue = (int)(map(timeAlive, 0, squareDuration, 10, 100));
      square = new FBox(xSize, ySize);
      square.setFill(red, green, blue, alpha);
      square.setStroke(red + 10, green, blue + 10, alpha);
      square.setPosition(xPos, yPos);
      square.setDensity(10.0);
      square.setCategoryBits(0x2);
      square.setStrokeWeight(10);
      square.setGrabbable(false);
      squareDamage = (int)(map(yDiff, 0, height, squareMinDamage, squareMaxDamage));// height
      squareDuration = (int)(map(yDiff, 0, height, squareMaxDur, squareMinDur));// height
      squareCD = (int)(map(xDiff, 0, width, squareMinCD, squareMaxCD));//width
      world.add(square);  
      squareTime = millis();
      squareExists = true;       
    }
  
    clicking = false;
  }
}



