void callMenu()
{
  menu = true;
  float center = dist(mouseX,mouseY,width/2,height/2);
  if(center < 200)
  {
    red = 0;
    green = (int)(map(center, 0, 200, 50, 25));// inverse distance from center
    blue = 0;
  }
  else if(abs(mouseX - width/2) > width/6 && abs(mouseY - height/2) < height/3)
  {
    red = (int)(map(mouseY, 0, height, 100, 0));
    green = 0;
    blue = (int)(map(mouseY, 0, height, 0, 100)); 
  }
  else
  {
    red = (int)(map(mouseY, 0, height, 100, 0));
    green = (int)(map(mouseY, 0, height, 0, 100));
    blue = (int)(map(mouseY, 0, height, 0, 100));  
  }
 

  background(red, green, blue);
  
  fill(buttonRed, buttonGreen, buttonBlue);
  stroke(buttonStroke);
  strokeWeight(buttonStrokeWeight);
  rectMode(CENTER);
  for(int i = 1; i < 7; i++)
  {
    buttonHighlight(i);
  }

  
  fill(buttonText);
  textSize(buttonTextSize);
  textAlign(CENTER);
  text("PLAY", playButtonX, playButtonY + menuHeight/10);
  text("PRACTICE", playButtonX, playButtonY*2 + menuHeight/10);
  text("SURVIVAL", playButtonX, playButtonY*3+ menuHeight/10);
  text("HELP", playButtonX, helpButtonY + menuHeight/10);
  text("HIGH SCORES", playButtonX, playButtonY *5+ menuHeight/10);
  text("OPTIONS", playButtonX, playButtonY *6+ menuHeight/10);
  
  

}

void callHelp()
{
  background(0);
  
  rectMode(CENTER);
  fill(buttonRed, buttonGreen, buttonBlue);
  strokeWeight(buttonStrokeWeight);
  stroke(buttonStroke);
  buttonHighlight(1);
  
  
  textAlign(CENTER, CENTER);
  fill(buttonText);
  textSize(22);
  
  if(attacksHelp)
  {
    rectMode(CENTER);
    fill(buttonRed, buttonGreen, buttonBlue);
    strokeWeight(buttonSelectedWeight);
    stroke(buttonSelected);
    rect(2 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    strokeWeight(buttonStrokeWeight);
    stroke(buttonStroke);
    rect(objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    rect(3 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);

        
    

    
    fill(255);
    rectMode(CENTER);
    if(circleHelp)
    {
      text("Click the Circle Icon or Press Q to select the Circle attack.\nCircles have a limited ammo.\nPick up the blue Circles that drop from enemies for more ammo!\nCircles do more damage the farther they drop.\nBouncing Circles can be an effective counter to flying enemies.", width/2, height/2);
      fill(buttonRed, buttonGreen, buttonBlue);
      stroke(buttonSelected);
      strokeWeight(buttonSelectedWeight);
      rect(attacksX * 2, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      stroke(buttonStroke);
      strokeWeight(buttonStrokeWeight);
      rect(attacksX, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 3, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 4, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 5, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    }
    else if(triHelp)
    {
      text("Click the Triangle Icon or Press W to select the Triangle attack.\nTriangles have a limited ammo.\nPick up the pink Triangles that drop from enemies for more ammo!\nTriangles don't deal much damage individually, but they can be fired in rapid succession.\nPlace Triangles in an enemy's path to slow its progess!", width/2, height/2);
      fill(buttonRed, buttonGreen, buttonBlue);
      stroke(buttonSelected);
      strokeWeight(buttonSelectedWeight);
      rect(attacksX * 3, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      stroke(buttonStroke);
      strokeWeight(buttonStrokeWeight);
      rect(attacksX * 2, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 4, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 5, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    }
    else if(squareHelp)
    {
      text("Click the Square Icon or Press E to select the Square attack.\nClick and drag your mouse to create a Square at that location.\nTaller Squares do more damage, but don't last as long.\nWider Squares have a longer cooldown before they can be used again.", width/2, height/2);
      fill(buttonRed, buttonGreen, buttonBlue);
      stroke(buttonSelected);
      strokeWeight(buttonSelectedWeight);
      rect(attacksX * 4, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      stroke(buttonStroke);
      strokeWeight(buttonStrokeWeight);
      rect(attacksX * 2, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 3, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 5, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    }
    else if(otherHelp)
    {
      text("The catapult deals very high Damage to enemies.\nThe stick has a long cooldown, so save it until you need it!\nThere's a secret weapon with secret powers.", width/2, height/2);
      fill(buttonRed, buttonGreen, buttonBlue);
      stroke(buttonSelected);
      strokeWeight(buttonSelectedWeight);
      rect(attacksX * 5, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      stroke(buttonStroke);
      strokeWeight(buttonStrokeWeight);
      rect(attacksX * 2, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 3, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 4, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    }
    else
    {
      text("Click the Circle Icon or Press Q to select the Circle attack.\nClick the Triangle Icon or Press W to select the Triangle attack.\nClick the Square Icon or Press E to select the Square attack.\nPull the catapult attached to the tree back to fire it at enemies.\nDrag the crate near enemies.\nClick the stick on the side of the tree to activate it.", width/2, height/2);
      fill(buttonRed, buttonGreen, buttonBlue);
      stroke(buttonSelected);
      strokeWeight(buttonSelectedWeight);
      rect(attacksX, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      stroke(buttonStroke);
      strokeWeight(buttonStrokeWeight);
      rect(attacksX * 2, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 3, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 4, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
      rect(attacksX * 5, attacksY, menuWidth/2, menuHeight/2, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    }
    
    
    
    fill(buttonText);
    textSize(buttonTextSize/2);
    textAlign(CENTER);
    text("OVERVIEW", attacksX,  attacksY + menuHeight/20);
    text("CIRCLES", attacksX *2,  attacksY + menuHeight/20);
    text("TRIANGLES", attacksX*3,  attacksY + menuHeight/20);
    text("SQUARE", attacksX*4,  attacksY + menuHeight/20);
    text("OTHER", attacksX*5,  attacksY + menuHeight/20);
    
  }
  else if(enemiesHelp)
  {
    rectMode(CENTER);
    fill(buttonRed, buttonGreen, buttonBlue);
    strokeWeight(buttonSelectedWeight);
    stroke(buttonSelected);
    rect(3 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    strokeWeight(buttonStrokeWeight);
    stroke(buttonStroke);
    rect(objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    rect(2 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    fill(255);
    text("Enemies reduce your Health based on their Damage when they hit your tree.\nFlying enemies are hard to hit, but they have low Health and Damage.\nLarge enemies have high Health and Damage, but they move slowly.", width/2, height/2);
  }
  else
  {
    rectMode(CENTER);
    fill(buttonRed, buttonGreen, buttonBlue);
    strokeWeight(buttonSelectedWeight);
    stroke(buttonSelected);
    rect(objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    strokeWeight(buttonStrokeWeight);
    stroke(buttonStroke);
    rect(2 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    rect(3 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    fill(255);
    text("Kill the evil balls before they attack your tree!\nHealth is depleted when enemies hit your tree.\nYou lose when Health drops to 0.\nPick up Health packs that drop from enemies to restore Health!\nThere are three mouse attacks corresponding to the three buttons on the tree.\nClick a button to select that attack, or press Q, W, or E to switch between the three.", width/2, height/2);
  }
  
  fill(buttonText);
  textSize(buttonTextSize);
  textAlign(CENTER);
  text("MENU", playButtonX,  playButtonY + menuHeight/10);
  text("OBJECTIVE", objX, helpY + menuHeight/10);
  text("ATTACKS", 2 * objX, helpY + menuHeight/10);
  text("ENEMIES", 3 * objX, helpY + menuHeight/10);
}


void pauseMenu()
{
  background(0);
  textAlign(CENTER, CENTER);
  textSize(150);
  fill(buttonRed, buttonGreen, buttonBlue);
  text("PAUSE", width/2, height/2);
  textSize(30);
  text("(Press P)", width/2, height/2 + height/8);
    
  fill(buttonRed, buttonGreen, buttonBlue);
  stroke(buttonStroke);
  strokeWeight(buttonStrokeWeight);
  rectMode(CENTER);
  rect(playButtonX, playButtonY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
  rect(playButtonX, height - playButtonY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
  
  fill(buttonText);
  textSize(buttonTextSize);
  textAlign(CENTER);
  text("HELP", playButtonX, playButtonY + menuHeight/10);
  text("QUIT", playButtonX, height - playButtonY + menuHeight/10);
}

void callOptions()
{
  background(0);

  
  fill(buttonRed, buttonGreen, buttonBlue);
  stroke(buttonStroke);
  strokeWeight(buttonStrokeWeight);
  rectMode(CENTER);
  rect(width/2, height/8, width/2, height/8, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
  
  textAlign(CENTER, CENTER);
  textSize(50);
  fill(buttonText);
  text("OPTIONS", width/2, height/8);
  
  fill(buttonRed, buttonGreen, buttonBlue);
  stroke(buttonStroke);
  strokeWeight(buttonStrokeWeight);
  rectMode(CENTER);
  buttonHighlightWidth(2, 2);
  buttonHighlightWidth(3, 2);
  buttonHighlightWidth(4, 2);
  buttonHighlight(6);
  
  fill(buttonText);
  textSize(buttonTextSize);
  textAlign(CENTER);
  text("BLACK & RED", playButtonX, playButtonY * 2 + menuHeight/10);
  text("WHITE & BLUE", playButtonX, playButtonY * 3 + menuHeight/10);
  text("GREEN & BLACK", playButtonX, playButtonY * 4 + menuHeight/10);
  text("MENU", playButtonX, playButtonY * 6 + menuHeight/10);
  
  
}
