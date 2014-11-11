//Defense game

// import physics (JBox2D wrapped)
import fisica.util.nonconvex.*;
import fisica.*;


// audio stuff
Maxim maxim;
AudioPlayer enemySound, wallSound, crateSound, baseSound;


FWorld world; // The physics world handler


// walls
FLine left;
FLine right;
FLine top;
FLine bottom;


// actors
FCircle [] enemies;
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


// tracking vars
int circleCount = 0;
int triangleCount = 0;
int enemyCount = 0;
int [] enemyHealth;

boolean [] deadTest;


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
int cataX;
int cataY;
int stickX = 10;
int stickY = 100;
int numTriangles = 150;
int triangleSize = 8;
int numCircles = 30;
int circleSize = 20;
float squareSize;



//time vars
int flightTime = 250;
int launchTime;
int stickTime;
int stickDuration = 8000;
int stickDropped;
int stickCD = 5000;
int [] circleTime;
int circleDuration = 3000;
int squareTime;
int squareBreakTime = 0;
int squareDuration;
int squareCD = 0;
int [] tTime;
int tDuration = 2000;
int crateTime;
int boomTime;
int boomDuration = 100;
int cataTime;
int changeTime;
int delay = 50;



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
boolean squareExists;
boolean [] tExists;
boolean [] enemyExists;
boolean crateLive = false;
boolean booming = false;
boolean cataLoaded = true;
boolean crateGrabbed = false;
boolean ammoChanged = false;
boolean posChanged = false;
boolean ammoClicked = false;

// create image vars
PImage enemiesImage, background, crateImage;


// gameplay vars
int experience = 0;
int health = 1;
int enemySpeed = 100;
int numEnemies = 10;
int enemyMaxHP = 200;
int triangleDamage = 2;
int cataDamage = 200;
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
int explosionSize = 300;
int crateBoom = 3000;
int explosionDamage = 200;
int cataReset = 3000;
int triangleAmmo = 500;
int circleAmmo = 50;




// setup game envir
void setup() {
  // screen setup
  size(1024,768);
  frameRate(60);
  
  // load images
  background = loadImage("tree.jpeg");
  enemiesImage = loadImage("antR1.png");
  crateImage = loadImage("crate.jpeg");
  

  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 1000);
  world.setEdges(color(255,0));
  
  world.left.setCategoryBits(0x2);
  world.right.setCategoryBits(0x2);
  world.top.setCategoryBits(0x2);
  world.bottom.setCategoryBits(0x2);
  
  
  // set up the objects  
  base = new FBox(baseSize, baseSize);
  base.setPosition(width/2 - baseSize/2, height - baseSize/2);
  base.setDensity(0.0);
  base.setSensor(true);
  base.setDrawable(false);
  base.setGrabbable(false);
  base.setCategoryBits(0x2);
  world.add(base);
  
  
  
  deadTest = new boolean[numEnemies];
  enemyHealth = new int[numEnemies];
  enemyExists = new boolean[numEnemies];
  enemies = new FCircle[numEnemies];
  for(int i = 0; i < numEnemies; i++)
  {
    enemies[i] = new FCircle(enemySize);
    enemies[i].setDensity(1.0);
    enemies[i].setRestitution(1.0);
    float choice = random(10);
    if(choice > 5.0)
    { 
      enemies[i].setPosition(enemySize/2 + 1, height - enemySize);  
    }
    else
    {
      enemies[i].setPosition(width - enemySize + 1, height - enemySize); 
    }
    enemies[i].setFill(200, 10, 10);
    enemies[i].setNoStroke();
    enemies[i].setGrabbable(false);
    enemies[i].setCategoryBits(0x2);
    enemies[i].setFilterBits(0x2);
    enemies[i].setGroupIndex(-1);
  }
  
  
  
  cataX = width/2;
  cataY= height/2;
  ammo = new FCircle(ammoSize);
  ammo.setDensity(10);
  ammo.setBullet(true);
  ammo.setPosition(cataX, cataY);
  ammo.setFill(100, 100, 100);
  ammo.setStroke(0, 0, 0);
  ammo.setRestitution(.4);
  ammo.setStrokeWeight(6);
  ammo.setGrabbable(true);
  ammo.setCategoryBits(0x2);
  ammo.setFilterBits(0x2);
  ammo.setGroupIndex(-1);
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
  anchor.setCategoryBits(0x2);
  world.add(anchor);
  
  
 
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
  
  
  
  
  
  circleTime = new int[numCircles];
  circleExists = new boolean[numCircles];
  circles = new FCircle[numCircles];
  for(int i = 0; i < circles.length; i++)
  {
    circles[i] = new FCircle(circleSize);
    circles[i].setGrabbable(false);
    circles[i].setDensity(5.0);
    circles[i].setNoStroke();
    circles[i].setRestitution(1.0);
    circles[i].setCategoryBits(0x2);
  }
  
  
  tExists = new boolean[numTriangles];
  tTime = new int[numTriangles];
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
    triangles[i].setGroupIndex(1);
    triangles[i].setCategoryBits(0x2);
  }


  

  crate = new FBox(crateSize, crateSize);
  crate.setPosition((190 + 325)/2, 280 - crateSize/2);
  crate.setDensity(10.0);
  crate.setGroupIndex(-1);
  crate.attachImage(crateImage);
  crate.setGrabbable(true);
  crate.setGroupIndex(1);
  crate.setFilterBits(0x2);
  world.add(crate);
  
  branch = new FLine(190, 280, 325, 280);
  branch.setDrawable(false);
  branch.setGrabbable(false);
  branch.setDensity(0);
  branch.setGroupIndex(1);
  world.add(branch);
  
  explosion = new FCircle(explosionSize);
  explosion.setFill(200, 10, 10, 200);
  explosion.setGrabbable(false);
  explosion.setNoStroke();
  explosion.setCategoryBits(0x2);
  explosion.setDensity(10);
  explosion.setStatic(true);




   
  stick = new FBox(stickY, stickX);
  stick.setFill(139, 69, 19);
  stick.setDensity(0);
  stick.setPosition(width/2 + 10 + stickY/2, height/2 + 100 - stickX/2);
  stick.setStroke(0);
  stick.setStrokeWeight(2);
  stick.setGrabbable(false);
  stick.setGroupIndex(1);
  world.add(stick);

  stickBranch = new FLine(width/2 + 10, height/2 + 100, width/2 + 10 + stickY, height/2 + 100);
  stickBranch.setDrawable(false);
  stickBranch.setGrabbable(false);
  stickBranch.setDensity(0);
  stickBranch.setGroupIndex(1);
  world.add(stickBranch);



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
  if(health > 0)
  {
    imageMode(CENTER);
    image(background, width/2, height/2, width, height);
    imageMode(CORNER);
  }
  
  
  
  // draw brush buttons
  stroke(0);
  strokeWeight(2);
  if(millis() - squareBreakTime > squareCD && !squareExists)
  {
    fill(120, 30, 5);
  }
  else
  {
    fill(50, 10, 0);
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
  ellipse(circleBrushX, circleBrushY, buttonSize, buttonSize);
  if(triangleAmmo > 0)
  {
    fill(120, 30, 5);
  }
  else
  {
    fill(50, 10, 0);
  }
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
  text("Health: " + health, 20, 20);
  text("Score: " + experience, 20, 40);
  text("Triangles: " + triangleAmmo, width/2 - 50, 40);
  text("Circles: " + circleAmmo, width/2 - 40, 20);
  if(squareBreakTime + squareCD - millis() > 0)
  {
    fill(255);
    text((squareBreakTime + squareCD - millis()) / 1000 + "." + ((squareBreakTime + squareCD - millis()) / 100) % 10, squareBrushX - buttonSize/4, squareBrushY + buttonSize/6); 

  }
  else
  {
    
  }
  
  spawnEnemy();
  moveEnemy();
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
  
  gameOver();
  
}
