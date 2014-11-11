//Defense game

// import physics (JBox2D wrapped)
import fisica.util.nonconvex.*;
import fisica.*;


// audio stuff
Maxim maxim;
AudioPlayer enemySound, wallSound, crateSound, baseSound;


FWorld world; // The physics world handler


// walls
FLine floor;
FLine wallR;
FLine wallL;
FLine ceiling;


// actors
FCircle enemy;
FBox crate;
FBox square;
FBlob bloby;
FCircle ammo;
FBox stick;
FCircle [] circles;
FPoly [] triangles;


int circleCount = 0;
int triangleCount = 0;


//joints
FMouseJoint cata;
FMouseJoint stickJoint;

// sensors
FBox base;
FCircle anchor;

//brush selector locations
int buttonSize;
int spacing;
int squareBrushX;
int squareBrushY;
int circleBrushX;
int circleBrushY;
int polyBrushX;
int polyBrushY;
int red;
int green;
int blue;



// establish object sizes
int ammoSize = 30;
int crateSize = 80;
int enemySize = 40;
int baseSize = 50;
int clickX;
int clickY;
int blobySize = 5;
int blobyStartX = 100;
int blobyStartY = 200;
int flightTime = 250;
int launchTime;
int cataX;
int cataY;
int stickX = 10;
int stickY = 100;
int numTriangles = 500;
int triangleSize = 8;
int numCircles = 10;
int circleSize = 25;

boolean clicking = false;
boolean launched = false;
boolean empty = false;
boolean flying = false;
boolean isCata = true;
boolean dead = false;
boolean raindrop = false;
boolean stickGrabbed = false;
boolean squareBrush = false;
boolean circleBrush = false;
boolean polyBrush = false;

// create image vars
PImage enemyImage, background, crateImage;


// gameplay vars
int score = 100;
int enemySpeed = 300;



// setup game envir
void setup() {
  // screen setup
  size(1024,768);
  frameRate(60);
  
  // load images
  background = loadImage("tree.jpeg");
  enemyImage = loadImage("antR1.png");
  crateImage = loadImage("crate.jpeg");
  

  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 1000);
  
  // set up bounds
  floor = new FLine(0, height, width, height);
  floor.setDensity(0.0);
  floor.setDrawable(false);
  floor.setGrabbable(false);
  world.add(floor);
  
  ceiling = new FLine(width, 0, 0, 0);
  ceiling.setDensity(0.0);
  ceiling.setDrawable(true);
  ceiling.setGrabbable(false);
  ceiling.setFill(120, 20, 20);
  world.add(ceiling);
  
  wallR = new FLine(width, height, width, 0);
  wallR.setDensity(0.0);;
  wallR.setGrabbable(false);
  wallR.setDrawable(false);
  world.add(wallR);
  
  wallL = new FLine(0, 0, 0, height);
  wallL.setDrawable(false);
  wallL.setGrabbable(false);
  wallL.setDensity(0.0);
  world.add(wallL);
  
  // set up the objects  
  base = new FBox(baseSize, baseSize);
  base.setPosition(width/2 - baseSize/2, height - baseSize/2);
  base.setDensity(0.0);
  base.setSensor(true);
  base.setDrawable(false);
  base.setGrabbable(false);
  world.add(base);
  

  crate = new FBox(crateSize, crateSize);
  crate.setPosition(width/2 + 80, height - crateSize/2 -1);
  crate.setSensor(false);
  crate.setDensity(5.0);
  crate.setFill(20, 20, 20);
  crate.attachImage(crateImage);
  crate.setGrabbable(true);
  world.add(crate);
  
  enemy = new FCircle(enemySize);
  enemy.setDensity(5.0);
  enemy.setPosition(enemySize/2 + 1, height - enemySize/2 -1); 
  enemy.setFill(200, 10, 10);
  enemy.setNoStroke();
  enemy.setGrabbable(false);
  world.add(enemy);
  
  cataX = width/2;
  cataY= height/2;
  
  ammo = new FCircle(ammoSize);
  ammo.setDensity(100);
  ammo.setBullet(true);
  ammo.setPosition(cataX, cataY);
  ammo.setFill(100, 100, 100);
  ammo.setStroke(0, 0, 0);
  ammo.setRestitution(.4);
  ammo.setStrokeWeight(6);
  ammo.setGrabbable(true);
  world.add(ammo);
  
  cata = new FMouseJoint(ammo, cataX, cataY) ;
  cata.setStroke(205, 133, 63);
  cata.setStrokeWeight(2);
  cata.setDamping(0.01);
  cata.setFrequency(0.1);
  world.add(cata);
  
  anchor = new FCircle(ammoSize/2);
  anchor.setFill(0);
  anchor.setPosition(width/2, height/2);
  anchor.setSensor(true);
  anchor.setDensity(0);
  anchor.setGrabbable(false);
  world.add(anchor);
  
  stick = new FBox(stickX, stickY);
  stick.setFill(139, 69, 19);
  stick.setDensity(10);
  stick.setPosition(300, height - stickY);
  stick.setStroke(0);
  stick.setStrokeWeight(2);
  stick.setGrabbable(false);
  world.add(stick);
  
 
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
  bloby.setFriction(0);


  circles = new FCircle[numCircles];
  for(int i = 0; i < circles.length; i++)
  {
    circles[i] = new FCircle(circleSize);
    circles[i].setGrabbable(false);
    circles[i].setDensity(5.0);
    circles[i].setNoStroke();
  }
  
  triangles = new FPoly[numTriangles];
  for(int i = 0; i < triangles.length; i++)
  {
    triangles[i] = new FPoly();
    triangles[i].vertex(width/2, height/2);
    triangles[i].vertex(width/2 + triangleSize, height/2 + triangleSize);
    triangles[i].vertex(width/2 - triangleSize, height/2 + triangleSize);
    triangles[i].vertex(width/2, height/2);
    triangles[i].setGrabbable(false);
    triangles[i].setDensity(1.0);
    triangles[i].setNoStroke();
  }




  // load audio
  maxim = new Maxim(this);
  enemySound = maxim.loadFile("droid.wav");
  wallSound = maxim.loadFile("wall.wav");
  crateSound = maxim.loadFile("crate2.wav");
  baseSound = maxim.loadFile("bells.wav");
  // set audio
  enemySound.setLooping(false);
  enemySound.volume(1.0);
  wallSound.setLooping(false);
  wallSound.volume(1.0);
  crateSound.setLooping(false);
  crateSound.volume(1.0);
  baseSound.setLooping(false);
  baseSound.volume(1.0);
  
  
  //brush selector locations
  buttonSize = 40;
  spacing = 10;
  squareBrushX = width/2 + buttonSize/2 + spacing;
  squareBrushY = height/3 + buttonSize/2 + spacing;
  circleBrushX = width/2;
  circleBrushY = height/3 - spacing;
  polyBrushX = width/2 - buttonSize/2 - spacing;
  polyBrushY = height/3 + buttonSize/2 + spacing;
  
}
  
void draw() {
  // draw the background
  imageMode(CENTER);
  image(background, width/2, height/2, width, height);
  imageMode(CORNER);
  

  
  // draw brush buttons
  fill(120, 30, 5);
  stroke(0);
  strokeWeight(2);
  ellipse(squareBrushX, squareBrushY, buttonSize, buttonSize);
  ellipse(circleBrushX, circleBrushY, buttonSize, buttonSize);
  ellipse(polyBrushX, polyBrushY, buttonSize, buttonSize);
  fill(50, 5, 100);
  rectMode(CENTER);
  rect(squareBrushX, squareBrushY, buttonSize/2, buttonSize/2);
  fill(40, 20, 170);
  ellipse(circleBrushX, circleBrushY, buttonSize/2, buttonSize/2);
  fill(180, 30, 50);
  triangle(polyBrushX, polyBrushY - buttonSize/4, polyBrushX - buttonSize/4, polyBrushY + buttonSize/4, polyBrushX + buttonSize/4, polyBrushY + buttonSize/4);
  
  
  
  // activate world
  world.step();
  world.draw();

  fill(0);
  text("score: " + score, 20, 20);
  
  moveEnemy();
  kill();

  //destroy the joint holding the ammo
  if(flying && (millis() - launchTime > flightTime))
  {
    world.remove(cata);
    isCata = false;
    flying = false;
  }

}



void kill()
{
  // kill dead enemy and respawn it
  if(dead){
      world.remove(enemy);
      float choice = random(10);
      if(choice > 5.0){ 
        enemy.setPosition(enemySize/2 + 1, height - enemySize/2 -1);  
        world.add(enemy);
      }
      else{
        enemy.setPosition(width - enemySize, height - enemySize); 
        world.add(enemy);
      }
      dead = false;
  }
}
  

//moves enemy depending on position
void moveEnemy()
{
  try{
    if(enemy.getX() < width/2){
    enemy.addForce(enemySpeed, 0);
    }
    else{
    enemy.addForce(0 - enemySpeed, 0);
    }
  } catch(NullPointerException e){println("catching in draw");}
}

void mousePressed()
{
  if(mouseButton == LEFT){
    if(abs(crate.getX() - mouseX) < crateSize/2 && abs(crate.getY() - mouseY) < crateSize/2){
      clicking = true;
    }
    else if(abs(ammo.getX() - mouseX) < ammoSize/2 && abs(ammo.getY() - mouseY) < ammoSize/2){
      clicking = true;
      launched = true;
    }
    else if((abs(blobyStartX - mouseX) < 100 && abs(blobyStartY - 65 - mouseY) < 70) && !raindrop){
      world.add(bloby);
      clicking = true;
      raindrop = true;
    }
    else if(abs(stick.getX() - mouseX) < stickY/2 && abs(stick.getY() - mouseY) < stickY/2 && !stickGrabbed)
    {
      clicking = true;
      stickGrabbed = true;
      stickJoint = new FMouseJoint(stick, mouseX + 20, mouseY - 10);
      stickJoint.setDrawable(false);
      world.add(stickJoint);
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
    else if(circleBrush)
    {
      float center = dist(mouseX,mouseY,width/2,height/2);
      float speed = dist(pmouseX, pmouseY, mouseX, mouseY);
      red = (int)(random(0,150));
      green = (int)(random(0,150));
      blue = (int)(random(150,255));
      FCircle attack = circles[circleCount % numCircles];
      world.remove(attack);
      attack.setFill(red, green, blue);
      attack.setPosition(mouseX, mouseY);
      world.add(attack);
      circleCount++;
    }
      
    //else nothing's been clicked
    else
    {
      // remove the square if squareBrush is active
      if(squareBrush){
        try{
          world.remove(square);
        } catch (NullPointerException e){}
      }
      clicking = false;
    }
        
    clickX = mouseX;
    clickY = mouseY;
  }
}

void mouseMoved()
{
  if(stickGrabbed)
  {
    stickJoint.setTarget(mouseX + 20, mouseY - 10);
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
  if(polyBrush)
  {
      red = (int)(map(mouseX, 0, width, 0, 255));
      green = (int)(map(mouseY, 0, height, 0, 255));
      blue = (int)(map(mouseX, 0, width, 255, 0));
      FPoly attack = triangles[triangleCount % numTriangles];
      world.remove(attack);
      attack.setFill(red, green, blue);
      attack.setPosition(mouseX - width/2, mouseY - height/2);
      world.add(attack);
      triangleCount++;
  }
 
  
}
    
void mouseReleased()
{
  if(mouseButton == LEFT){
    
    //launch cata
    if (launched && !empty){
      empty = true;
      flying = true;
      launchTime = millis();
      cata.setDamping(1000);
      cata.setFrequency(1000);
    }
    else if (!clicking && squareBrush){
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
      
      float size = dist(mouseX, mouseY, clickX, clickY);
      red = (int)(map(size, 0, height*3, 50, 100));
      green = 5;
      blue = (int)(map(size, 0, height, 100, 10));
      square = new FBox(xSize, ySize);
      square.setPosition(xPos, yPos);
      square.setDensity(10.0);
      square.setStrokeWeight(map(size, 0, height, 3, 6));
      square.setStroke(0);
      square.setFill(red, green, blue);
      square.setGrabbable(false);
      world.add(square);  
        
    }
  
    clicking = false;
  }
}




void contactStarted(FContact contact){
  FBody b1 = contact.getBody1();
  FBody b2 = contact.getBody2();
    
  if ((b1 == enemy && b2 == base)
    || (b2 == enemy && b1 == base))
    {
        score -= 1;
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
  try{
    if (b1 == square && b2 == enemy || b1 == enemy && b2 == square){
      score += 1;
      dead = true;   
    }
  } catch(NullPointerException e){println("tried");}
  
}






