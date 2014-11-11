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
  rect(playButtonX, playButtonY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
  rect(playButtonX, helpButtonY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
  
  fill(buttonText);
  textSize(buttonTextSize);
  textAlign(CENTER);
  text("PLAY", playButtonX, playButtonY + menuHeight/10);
  text("HELP", playButtonX, helpButtonY + menuHeight/10);
  
  

}

void callHelp()
{
  background(0);
  
  
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
    rect(playButtonX, playButtonY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    rect(objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    rect(3 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);

        
    

    
    fill(buttonRed, buttonGreen, buttonBlue);
    rectMode(CENTER);
    if(circleHelp)
    {
      text("Circles do more damage the farther they drop.", width/2, height/2);
      
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
      text("Place Triangles in an enemies path to slow its progess.", width/2, height/2);
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
      text("To use the square attack, click and drag your mouse to create a square of that size.\nTaller squares do more damage, but don't last as long. Wider squares have a longer cooldown before they can be used again.\n.", width/2, height/2);
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
      text("Click the weird branch poking out of the right side of the tree and hit stuff with it to kill everything. It has a long cooldown though.\nThere's also a secret weapon on the level, but I'll let you figure that one out.", width/2, height/2);
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
      text("Click the Circle Icon or Press Q to select the Circle attack.\nClick the Triangle Icon or Press W to select the Triangle attack.\nClick the Square Icon or Press E to select the Square attack.\nThe grey and black thing in the middle is a catapult. Grab it, pull it back, and fire it at bad guys.\nDrag the crate near enemies to use it.", width/2, height/2);
    
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
    rect(playButtonX, playButtonY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    rect(objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    rect(2 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    
    text("Flying enemies are hard to hit, but they have low Health.", width/2, height/2);
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
    rect(playButtonX, playButtonY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    rect(2 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    rect(3 * objX, helpY, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
    
    text("Kill the evil balls before they attack your tree.\nYou'll see your Health and Score in the top left corner.\nYou lose when Health drops to 0.\nYou have three mouse attacks corresponding to the three buttons on the tree.\nClick a button to select that attack, or press Q, W, or E to switch between the three.", width/2, height/2);
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
  stroke(buttonRed, buttonGreen, buttonBlue);
  fill(buttonRed, buttonGreen, buttonBlue);
  text("PAUSE", width/2, height/2);
    
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
