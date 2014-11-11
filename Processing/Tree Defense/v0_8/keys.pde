void keyPressed()
{
 if(key ==  'q')
 {
      polyBrush = true;
      circleBrush = false;
      squareBrush = false;

 }
 else if(key == 'w')
 {
      circleBrush = true;
      squareBrush = false;
      polyBrush = false;
 }
 else if(key == 'e')
 {
      squareBrush = true;
      circleBrush = false;
      polyBrush = false;
 }
 else if(key == 'p' && !survival)
 {
   paused = !paused;
 }
}
