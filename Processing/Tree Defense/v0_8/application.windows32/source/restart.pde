void restart()
{
  // set vars
  triAmmoSize = 35;
  circleAmmoSize = 40;
  healthItemSize = 50;
  
  circleCount = 0;
  triangleCount = 0;
  triAmmoExists = false;
  circleAmmoExists = false;
  healthItemExists = false;
  ammoSize = 50;
  
  
  menuHeight = 80;
  menuWidth = 200;
  playButtonX =  width/2;
  playButtonY = height/7;
  helpButtonY = playButtonY * 4;
  objX = width/4;
  helpY = 4 * height/5;
  attacksX = width/6;
  attacksY = 4 * height/6;
      
  popUpWidth = width/3;
  popUpHeight = height/5;
  
   circleHelp = false;
   triHelp = false;
   squareHelp = false;
   otherHelp = false;
 
 
  crateSize = 80;
  baseSize = 80;
  blobySize = 5;
  blobyStartX = 100;
  blobyStartY = 200;
  stickX = 10;
  stickY = 100;
 
  numTriangles = 150;
  triangleSize = 8;
  numCircles = 30;
  circleSize = 20;
  
  
  flightTime = 250;
  circleDuration = 3000;
  squareBreakTime = 0;
  squareCD = 0;
  tDuration = 2000;
  boomDuration = 100;
  delay = 50;
  blobyTime = 0;


  // enemy vars
  flyingEnemySize = 40;
  numFlyingEnemies = 15;
  flyingEnemyCount = 0;
  flyingEnemyCD = 9000;
  flyingEnemyMaxHP = 50;
  flyingEnemySpeed = 0.2;
  flyingEnemyDamage = 1;
  
  enemySize = 45;
  numEnemies = 15;
  enemySpeed = 7000;
  enemyCD = 7000;
  enemyMaxHP = 200;
  enemyCount = 0;
  enemyDamage = 10;
  
  smallEnemySize = 20;
  numSmallEnemies = 10;
  smallEnemySpeed = 2000;
  smallEnemyCD = 5000;
  smallEnemyMaxHP = 100;
  smallEnemyCount = 0;
  smallEnemyDamage = 5;
  
  largeEnemySize = 100;
  numLargeEnemies = 5;
  largeEnemySpeed = 8000;
  largeEnemyCD = 20000;
  largeEnemyMaxHP = 2000;
  largeEnemyCount = 0;
  largeEnemyDamage = 100;
  
  numTotalEnemies = numEnemies + numFlyingEnemies + numSmallEnemies + numLargeEnemies;
  
  level = 1;
  
 clicking = false;
 launched = false;
 empty = false;
 flying = false;
 isCata = true;
 dead = false;
 raindrop = false;
 stickGrabbed = false;
 squareBrush = false;
 circleBrush = false;
 polyBrush = false;
 stickUsed = false;
 squareExists = false;
 crateLive = false;
 booming = false;
 cataLoaded = true;
 crateGrabbed = false;
 ammoChanged = false;
 posChanged = false;
 ammoClicked = false;
 crateGone = false;
 gameOver = false;
 stopGame = true;
 menu = false;
 paused = false;
 helpMenu = false;
 attacksHelp = false;
 enemiesHelp = false;
 practice = false;
 survival = false;
 pauseMessageUp = false;
 pauseMessage = false;
 smallEnemyOn = false;
 largeEnemyOn = false;
 enemyOn = false;
 flyingEnemyOn = false;
 optionsMenu = false;
 
 levelOneDuration = 15000;
 levelTwoDuration = 20000;
 levelThreeDuration = 30000;
 levelFourDuration = 40000;
 levelDuration = 40000;
 
 
 
 experience = 0;
 health = 1000;
 healthItem = 1;
 stickDuration = 3000;
 stickCD = 30000;
 stickDamage = 1000;
 triangleDamage = 3;
 triangleAmmo = 500;
 triAmmoItem = 20;
 squareMinDamage = 50;
 squareMaxDamage = 500;
 squareMinDur = 500;
 squareMaxDur = 5000;
 squareMinCD = 2000;
 squareMaxCD = 10000;
 circleMinDamage = 40;
 circleMaxDamage = 150;
 circleAmmo = 50;
 circleAmmoItem = 10;
 explosionSize = 300;
 crateBoom = 3000;
 explosionDamage = 200;
 crateCD = 5000;
 cataReset = 3000;
 cataDamage = 1000;
 blobyDuration = 5000;
 pauseMessageDuration = 3000;
 
 
  // setup world
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 1000);
  world.setEdges(color(255,0));
  
  world.left.setCategoryBits(0x2);
  world.right.setCategoryBits(0x2);
  world.top.setCategoryBits(0x2);
  world.bottom.setCategoryBits(0x2);
  
  
  // setup the objects  
  base = new FBox(baseSize, baseSize * 10);
  base.setPosition(width/2 - baseSize/4, height - baseSize/2);
  base.setDensity(0.0);
  base.setSensor(true);
  base.setDrawable(false);
  base.setGrabbable(false);
  base.setCategoryBits(0x2);
  world.add(base);
  
  
  
  deadTest = new boolean[numTotalEnemies];
  enemyHealth = new int[numTotalEnemies];
  enemyExists = new boolean[numTotalEnemies];
  enemies = new FCircle[numTotalEnemies];
  for(int i = 0; i < numSmallEnemies; i++)
  {
    enemies[i] = new FCircle(smallEnemySize);
    enemies[i].setDensity(1.0);
    enemies[i].setRestitution(1.0);
    float choice = random(10);
    if(choice > 5.0)
    { 
      enemies[i].setPosition(smallEnemySize, height - smallEnemySize);  
    }
    else
    {
      enemies[i].setPosition(width - smallEnemySize + 1, height - smallEnemySize); 
    }
    enemies[i].setFill(150, 100, 10);
    enemies[i].setStrokeWeight(4);
    enemies[i].setStroke(0);
    enemies[i].setDamping(0.5);
    enemies[i].setGrabbable(false);
    enemies[i].setCategoryBits(0x2);
    enemies[i].setFilterBits(0x2);
    enemies[i].setGroupIndex(-1);
  }
  
  for(int i = numSmallEnemies; i < numLargeEnemies + numSmallEnemies; i++)
  {
    enemies[i] = new FCircle(largeEnemySize);
    enemies[i].setDensity(1.0);
    enemies[i].setRestitution(1.0);
    float choice = random(10);
    if(choice > 5.0)
    { 
      enemies[i].setPosition(largeEnemySize, height - largeEnemySize);  
    }
    else
    {
      enemies[i].setPosition(width - largeEnemySize + 1, height - largeEnemySize); 
    }
    enemies[i].setFill(40);
    enemies[i].setStrokeWeight(9);
    enemies[i].setStroke(150, 10, 10);
    enemies[i].setDamping(0.5);
    enemies[i].setGrabbable(false);
    enemies[i].setCategoryBits(0x2);
    enemies[i].setFilterBits(0x2);
    enemies[i].setGroupIndex(-1);
  }
  for(int i = numLargeEnemies + numSmallEnemies; i < numEnemies + numLargeEnemies + numSmallEnemies; i++)
  {
    enemies[i] = new FCircle(enemySize);
    enemies[i].setDensity(1.0);
    enemies[i].setRestitution(1.0);
    float choice = random(10);
    if(choice > 5.0)
    { 
      enemies[i].setPosition(enemySize, height - enemySize);  
    }
    else
    {
      enemies[i].setPosition(width - enemySize + 1, height - enemySize); 
    }
    enemies[i].setFill(10, 10, 10);
    enemies[i].setStrokeWeight(4);
    enemies[i].setStroke(200, 10, 10);
    enemies[i].setDamping(0.5);
    enemies[i].setGrabbable(false);
    enemies[i].setCategoryBits(0x2);
    enemies[i].setFilterBits(0x2);
    enemies[i].setGroupIndex(-1);
  }
  for(int i = numLargeEnemies + numSmallEnemies + numEnemies; i < numTotalEnemies; i++)
  {
    enemies[i] = new FCircle(enemySize);
    enemies[i].setDensity(0.000001);
    enemies[i].setRestitution(1.0);
    float choice = random(10);
    if(choice > 5.0)
    { 
      enemies[i].setPosition(enemySize, height/2);  
    }
    else
    {
      enemies[i].setPosition(width - enemySize + 1, height/2); 
    }
    enemies[i].setFill(220, 220, 30);
    enemies[i].setDamping(0.5);
    enemies[i].setStrokeWeight(4);
    enemies[i].setStroke(0);
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
  
  anchor = new FCircle(ammoSize/4);
  anchor.setFill(0);
  anchor.setPosition(width/2, height/2);
  anchor.setSensor(true);
  anchor.setDensity(0);
  anchor.setGrabbable(false);
  anchor.setCategoryBits(0x2);
  world.add(anchor);
  
  

  
  
  
  
  
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
  stick.setSensor(true);
  stick.setCategoryBits(0x2);
  world.add(stick);
  

  stickBranch = new FLine(width/2 + 10, height/2 + 100, width/2 + 10 + stickY, height/2 + 100);
  stickBranch.setDrawable(false);
  stickBranch.setGrabbable(false);
  stickBranch.setDensity(0);
  stickBranch.setGroupIndex(1);
  world.add(stickBranch);
}

