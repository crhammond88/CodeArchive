//static public void main(String args[]) {
//    PApplet.main(new String[] { "v0_8" });
//}


//Defense game

// import physics (JBox2D wrapped)
import fisica.util.nonconvex.*;
import fisica.*;


// audio stuff
//Maxim maxim;
//AudioPlayer enemySound, wallSound, crateSound, baseSound;


FWorld world; // The physics world handler


// walls
FLine left;
FLine right;
FLine top;
FLine bottom;


// actors
FCircle [] enemies;
FCircle [] flyingEnemies;
FBox crate;
FCircle explosion;
FBox square;
FBlob bloby;
FCircle ammo;
FBox stick;
FCircle [] circles;
FPoly [] triangles;
FLine branch;
FLine stickBranch;


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

// item vars
float triAmmoX;
float triAmmoY;
boolean triAmmoExists;
int triAmmoSize;
float circleAmmoX;
float circleAmmoY;
boolean circleAmmoExists;
int circleAmmoSize;
float healthItemX;
float healthItemY;
boolean healthItemExists;
int healthItemSize;

// tracking vars
int circleCount;
int triangleCount;


boolean [] deadTest;


// establish object sizes
int ammoSize;
int crateSize;
int baseSize;
int clickX;
int clickY;
int blobySize;
int blobyStartX;
int blobyStartY;
int cataX;
int cataY;
int stickX;
int stickY;
int numTriangles;
int triangleSize;
int numCircles;
int circleSize;
float squareSize;


int playButtonX;
int playButtonY;
int menuHeight;
int menuWidth;
int helpButtonY;
int helpY;
int objX;
int attacksX;
int attacksY;


int buttonRed = 120;
int buttonGreen = 10;
int buttonBlue = 10;
int buttonStroke = 0;
int buttonStrokeWeight = 4;
int buttonText = 0;
int buttonTextSize = 25;
int buttonCorners = 60;
int buttonSelected = 255;
int buttonSelectedWeight = 6;

int popUpWidth = width/3;
int popUpHeight = height/5;

//time vars
int flightTime;
int launchTime;
int stickTime;
int stickDropped;
int [] circleTime;
int circleDuration;
int squareTime;
int squareBreakTime;
int squareDuration;
int squareCD;
int [] tTime;
int tDuration;
int crateTime;
int boomTime;
int boomDuration;
int cataTime;
int changeTime;
int delay;
int crateGoneTime;
int blobyTime;
int survivalTime;


  int levelTwoTime;
  int levelThreeTime;
  int levelFourTime;
  int levelTime;
  
  int levelOneDuration;
  int levelTwoDuration;
  int levelThreeDuration;
  int levelFourDuration;
  int levelDuration;


// enemy vars
int flyingEnemySize;
int numFlyingEnemies;
int flyingEnemyCount;
int flyingEnemyCD;
int flyingEnemyMaxHP;
float flyingEnemySpeed;
int flyingEnemyDamage;

int enemySize;
int numEnemies;
int enemySpeed;
int enemyCD;
int enemyMaxHP;
int enemyCount;
int enemyDamage;

int smallEnemySize;
int numSmallEnemies;
int smallEnemySpeed;
int smallEnemyCD;
int smallEnemyMaxHP;
int smallEnemyCount;
int smallEnemyDamage;

int largeEnemySize;
int numLargeEnemies;
int largeEnemySpeed;
int largeEnemyCD;
int largeEnemyMaxHP;
int largeEnemyCount;
int largeEnemyDamage;


int [] enemyHealth;
boolean [] enemyExists;
int numTotalEnemies;



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
boolean stickUsed = false;
boolean [] circleExists;
boolean squareExists = false;
boolean [] tExists;
boolean crateLive = false;
boolean booming = false;
boolean cataLoaded = true;
boolean crateGrabbed = false;
boolean ammoChanged = false;
boolean posChanged = false;
boolean ammoClicked = false;
boolean crateGone = false;
boolean gameOver = false;
boolean stopGame;
boolean menu;
boolean paused;
boolean helpMenu;
boolean attacksHelp;
boolean enemiesHelp;
boolean circleHelp = false;
boolean triHelp = false;
boolean squareHelp = false;
boolean otherHelp = false;
boolean practice = false;
boolean survival = false;
boolean pauseMessageUp = false;
boolean pauseMessage = false;
boolean smallEnemyOn;
boolean largeEnemyOn;
boolean enemyOn;
boolean flyingEnemyOn;
boolean optionsMenu = false;

int pauseMessageTime;
int pauseMessageDuration = 3000;


// create image vars
PImage enemiesImage, background, crateImage;


// gameplay vars
int experience = 0;
int health;
int healthItem = 5;
int stickDuration = 3000;
int stickCD = 30000;
int stickDamage = 1000;
int triangleDamage = 3;
int triangleAmmo = 500;
int triAmmoItem = 20;
int squareDamage;
int squareMinDamage = 50;
int squareMaxDamage = 500;
int squareMinDur = 500;
int squareMaxDur = 5000;
int squareMinCD = 2000;
int squareMaxCD = 10000;
int circleDamage;
int circleMinDamage = 40;
int circleMaxDamage = 150;
int circleAmmo = 50;
int circleAmmoItem = 10;
int explosionSize = 300;
int crateBoom = 3000;
int explosionDamage = 200;
int crateCD = 5000;
int cataReset = 3000;
int cataDamage = 1000;
int blobyDuration = 5000;
int level;
  
  



// setup game envir
void setup() {
  // screen setup
  size(1024,768);
  frameRate(60);
  frame.setTitle("Tree Defense");

  
  // load images
  background = loadImage("tree.jpeg");
  enemiesImage = loadImage("antR1.png");
  crateImage = loadImage("crate.jpeg");
  
  restart();

//  // load audio
//  maxim = new Maxim(this);
//  enemySound = maxim.loadFile("droid.wav");
//  wallSound = maxim.loadFile("wall.wav");
//  crateSound = maxim.loadFile("crate2.wav");
//  baseSound = maxim.loadFile("bells.wav");
//  // set audio
//  enemySound.setLooping(false);
//  enemySound.volume(1.0);
//  wallSound.setLooping(false);
//  wallSound.volume(1.0);
//  crateSound.setLooping(false);
//  crateSound.volume(1.0);
//  baseSound.setLooping(false);
//  baseSound.volume(1.0);
  
  
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
  if(stopGame)
  {
    if(gameOver)
    {
      gameOverScreen();
    }
    else if(helpMenu)
    {
      callHelp();
    }
    else if(optionsMenu)
    {
      callOptions();
    }
    else
    { 
      callMenu();
    }
  }
  else
  {
    if(health > 0)
    {
      imageMode(CENTER);
      image(background, width/2, height/2, width, height);
      imageMode(CORNER);
    }
    
    // draw brush buttons
    brushButtons();
  
    
    // activate world
    if(paused)
    {
      pauseMenu();
      if(helpMenu)
      {
      callHelp();
      }
    }
    else
    {
      world.step();
      world.draw();
      callPauseMessage();
      
      fill(0);
      textSize(15);
      if(!practice)
      {
        textAlign(LEFT);
        text("Health: " + health, 20, 20);
        textAlign(CENTER);
        text("Triangles: " + triangleAmmo, width/2, 40);
        text("Circles: " + circleAmmo, width/2, 20);
      }
      if(!practice && !survival)
      {
        textAlign(LEFT);
        text("Score: " + experience, 20, 40);
        textAlign(RIGHT);
        text("Level: " + level, width - 20, 20);
        
      }
      if(survival)
      {
        survivalTime = millis() - pauseMessageTime;
        textAlign(LEFT);
        text("Time: " + survivalTime / 1000, 20, 40);
      }

      
      if(squareBreakTime + squareCD - millis() > 0)
      {
        textSize(15);
        fill(255);
        textAlign(CENTER);
        text((squareBreakTime + squareCD - millis()) / 1000 + "." + ((squareBreakTime + squareCD - millis()) / 100) % 10, squareBrushX, squareBrushY + buttonSize/6); 
      }
    
      if(crateLive && crateTime + crateBoom - millis() > 0)
      {
        textSize(40);
        fill(255);
        textAlign(CENTER);
        text((crateTime + crateBoom - millis() + 1000) / 1000, crate.getX(), crate.getY() + crateSize/6); 
      }
      
      if(practice)
      {
        health = 1000;
        circleAmmo = 1000;
        triangleAmmo = 1000;
      }


        
       
      spawnSmallEnemy();
      spawnLargeEnemy();
      spawnEnemy();
      flyingEnemy();
    
      moveSmallEnemy();
      moveLargeEnemy();
      moveEnemy();
      moveFlying();
    
      
      kill();
      
      
      dropStick();
      respawnStick();
      circleColor();
      breakSquare();
      breakTri();
    
      //destroy the joint holding the ammo
      launchCata();
      
      boom();
      endBoom();
      reloadCata();
      reloadAmmo();
      respawnCrate();
      
      gameOver();
      removeBloby();
      
      spawnTriAmmo();
      spawnCircleAmmo();
      spawnHealthItem();
      setLevel();
    }
  }  
}
