void buttonHighlight(int buttonNum)
{
  if(abs(mouseX - playButtonX) < menuWidth/2 && abs(mouseY - playButtonY * buttonNum) < menuHeight/2)
  {
    rect(playButtonX, playButtonY*buttonNum, menuWidth + 50, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
  }
  else
  {
    rect(playButtonX, playButtonY*buttonNum, menuWidth, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
  }
}

void buttonHighlightWidth(int buttonNum, int widthMulti)
{
    if(abs(mouseX - playButtonX) < menuWidth/2 && abs(mouseY - playButtonY * buttonNum) < menuHeight/2)
  {
    rect(playButtonX, playButtonY*buttonNum, menuWidth *widthMulti + 50, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
  }
  else
  {
    rect(playButtonX, playButtonY*buttonNum, menuWidth *widthMulti, menuHeight, buttonCorners, buttonCorners, buttonCorners, buttonCorners);
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
