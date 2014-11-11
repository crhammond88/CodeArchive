import fisica.util.nonconvex.*;
import fisica.*;

//Defense game

import org.jbox2d.util.nonconvex.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.testbed.*;
import org.jbox2d.collision.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.p5.*;
import org.jbox2d.dynamics.*;


// audio stuff
Maxim maxim;
AudioPlayer enemySound, wallSound, crateSound, baseSound;


Physics physics; // The physics handler
// rigid bodies
Body enemy;
Body crate;
Body base;
Body square;

boolean dead;

// a handler that will detect collisions
CollisionDetector detector; 

// establish object sizes
int crateSize = 80;
int baseSize = 150;
int enemySize = 40;
int squareX;
int squareY;

boolean draggingCrate = false;

// create image vars
PImage enemyImage, background, crateImage;


// gameplay vars
int score = 100;
int enemySpeed = 30;


// setup game envir
void setup() {
  // screen setup
  size(1024,768);
  frameRate(60);
  
  // load images
  background = loadImage("tree.jpeg");
  enemyImage = loadImage("antR1.png");
  crateImage = loadImage("crate.jpeg");
  imageMode(CENTER);
  
   /**
   * Set up a physics world. This takes the following parameters:
   * 
   * parent The PApplet this physics world should use
   * gravX The x component of gravity, in meters/sec^2
   * gravY The y component of gravity, in meters/sec^2
   * screenAABBWidth The world's width, in pixels - should be significantly larger than the area you intend to use
   * screenAABBHeight The world's height, in pixels - should be significantly larger than the area you intend to use
   * borderBoxWidth The containing box's width - should be smaller than the world width, so that no object can escape
   * borderBoxHeight The containing box's height - should be smaller than the world height, so that no object can escape
   * pixelsPerMeter Pixels per physical meter
   */
  physics = new Physics(this, width, height, 0, -10, width*2, height*2, width, height, 100);
  // this overrides the debug render of the physics engine
  // with the method myCustomRenderer
  // comment out to use the debug renderer 
  // (currently broken in JS)
  //physics.setCustomRenderingMethod(this, "myCustomRenderer");


  
  // set up the objects  
  // Rect parameters are the top left 
  // and bottom right corners
  physics.setDensity(0.0);
  physics.setSensor(true);
  base = physics.createRect((width/2 - 73), 580, (width/2 + 30), height);
  physics.setSensor(false);
  physics.setDensity(10.0);
  crate = physics.createRect(600, height-crateSize, 600+crateSize, height);
  // circle parameters are center x,y and radius
  physics.setDensity(5.0);
  enemy = physics.createCircle(enemySize/2, height-(enemySize/2), enemySize/2);
  
  
  // sets up the collision callbacks
  detector = new CollisionDetector (physics, this);
  
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
  
  
}
  
void draw() {
  // draw the background
  image(background, width/2, height/2, width, height);

  // we can call the renderer here if we want 
  // to run both our renderer and the debug renderer
  //myCustomRenderer(physics.getWorld());

  fill(0);
  text("score: " + score, 20, 20);
  
  try{
    Vec2 pos = physics.getCMPosition(enemy);
    if(pos.x < width/2){
    physics.applyForce(enemy, enemySpeed, 0);
    }
    else{
    physics.applyForce(enemy, 0 - enemySpeed, 0);
    }
  } catch(NullPointerException e){println("catching in draw");}

  // kill dead enemy and respawn it
  if(dead){
      physics.removeBody(enemy);
      physics.setDensity(5.0);
      float choice = random(10);
      if(choice > 5.0){ 
        enemy = physics.createCircle(enemySize/2, height-(enemySize/2), enemySize/2); 
      }
      else{
        enemy = physics.createCircle(width - enemySize/2, height-(enemySize/2), enemySize/2); 
      }
      dead = false;
  }
  

}


void mousePressed()
{
  if(mouseButton == LEFT){
    Vec2 cratePos = physics.getCMPosition(crate);
    int epsilon = 40;
    if(cratePos.x - mouseX < epsilon && cratePos.y - mouseY < epsilon){
      draggingCrate = true;
    }
    else{
      try{
        physics.removeBody(square);
      } catch (NullPointerException e){}
      
      draggingCrate = false;
      squareX = mouseX;
      squareY = mouseY;
    }
  }
}
  

void mouseReleased()
{
  if(mouseButton == LEFT){
    if (!draggingCrate){
      // select correct corners
      int y1, y2, x1, x2;
      int epsilon = 15;
      if (abs(squareX - mouseX) < epsilon && abs(squareY - mouseY) < epsilon){
        x1 = squareX;
        y1 = squareY;
        x2 = squareX + 25;
        y2 = squareY + 25;
      }
      else if(abs(squareX - mouseX) < epsilon){
        x1 = squareX;
        y1 = squareY;
        x2 = squareX + 25;
        y2 = mouseY;
      }
      else if(abs(squareY - mouseY) < epsilon){
        x1 = squareX;
        y1 = squareY;
        x2 = mouseX;
        y2 = squareY + 25;
      }
        
      else{
        x1 = min(squareX, mouseX);
        x2 = max(squareX, mouseX);
        y1 = min(squareY, mouseY);
        y2 = max(squareY, mouseY);
      }
      // Rect parameters are the top left 
      // and bottom right corners
      physics.setDensity(10.0);
      square = physics.createRect(x1, y1, x2, y2);
    }
  
    draggingCrate = false;
  }
}

void mouseDragged(){
  if(draggingCrate){
    physics.removeBody(crate);
    crate = physics.createRect(mouseX, mouseY, mouseX + crateSize, mouseY + crateSize);
  }
}



void collision(Body b1, Body b2, float impulse)
{
    
  if ((b1 == enemy && b2 == base)
    || (b2 == enemy && b1 == base))
    {
        score -= 1;
    }

    
  // test
  if (b1.getMass() == 0 || b2.getMass() == 0) {// b1 or b2 are walls
    // wall sound
    //println("wall speed "+(impulse/100));
    wallSound.cue(0);
    wallSound.speed(impulse / 100);// 
    wallSound.play();
  }
  if (b1 == enemy || b2 == enemy) { // b1 or b2 are the enemy
    // enemy sound
    enemySound.cue(0);
    enemySound.speed(impulse / 10);
    enemySound.play();
  }
  if (b1 == crate || b2 == crate){// its a crate
    crateSound.cue(0);
    crateSound.speed(0.5 + (impulse / 10000));// 10000 as the crates move slower??
    crateSound.play();
  }
  if (b1 == base || b2 == base){
    baseSound.cue(0);
    baseSound.speed(1.5);
    baseSound.play();
  }
  
  // check for square
  try{
    if (b1 == square && b2 == enemy || b1 == enemy && b2 == square){
      score += 1;
      dead = true;   
    }
  } catch(NullPointerException e){println("tried");}
  
}






