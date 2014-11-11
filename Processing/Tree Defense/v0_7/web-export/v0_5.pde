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
int ammoSize = 50;
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
int health = 50;
int enemySpeed = 100;
int numEnemies = 15;
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
  
  anchor = new FCircle(ammoSize/4);
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
///*
// * The MIT License (MIT)
// *
// * Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies
// *
// * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
// * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//*/
//
//import java.util.ArrayList;
//import java.io.File;
//import java.io.FileInputStream;
//import java.io.FileNotFoundException;
//import java.io.IOException;
//import java.io.BufferedInputStream;
//import java.net.MalformedURLException;
//import java.net.URL;
//import javax.sound.sampled.AudioFormat;
//import javax.sound.sampled.AudioSystem;
//import javax.sound.sampled.DataLine;
//import javax.sound.sampled.LineUnavailableException;
//import javax.sound.sampled.SourceDataLine;
//
//import processing.core.*; 
//import processing.data.*; 
//import processing.event.*; 
//import processing.opengl.*; 
//
////import android.content.res.Resources;
//// import android.app.Activity; 
//// import android.os.Bundle; 
//// import android.media.*;
//// import android.media.audiofx.Visualizer;
//// import android.content.res.AssetFileDescriptor;
//// import android.hardware.*;
//
//
//public class Maxim {
//
//    private float sampleRate;
//
//    public final float[] mtof = {
//	0f, 8.661957f, 9.177024f, 9.722718f, 10.3f, 10.913383f, 11.562325f, 12.25f, 12.978271f, 13.75f, 14.567617f, 15.433853f, 16.351599f, 17.323914f, 18.354048f, 19.445436f, 20.601723f, 21.826765f, 23.124651f, 24.5f, 25.956543f, 27.5f, 29.135235f, 30.867706f, 32.703197f, 34.647827f, 36.708096f, 38.890873f, 41.203445f, 43.65353f, 46.249302f, 49.f, 51.913086f, 55.f, 58.27047f, 61.735413f, 65.406395f, 69.295654f, 73.416191f, 77.781746f, 82.406891f, 87.30706f, 92.498604f, 97.998856f, 103.826172f, 110.f, 116.540939f, 123.470825f, 130.81279f, 138.591309f, 146.832382f, 155.563492f, 164.813782f, 174.61412f, 184.997208f, 195.997711f, 207.652344f, 220.f, 233.081879f, 246.94165f, 261.62558f, 277.182617f, 293.664764f, 311.126984f, 329.627563f, 349.228241f, 369.994415f, 391.995422f, 415.304688f, 440.f, 466.163757f, 493.883301f, 523.25116f, 554.365234f, 587.329529f, 622.253967f, 659.255127f, 698.456482f, 739.988831f, 783.990845f, 830.609375f, 880.f, 932.327515f, 987.766602f, 1046.502319f, 1108.730469f, 1174.659058f, 1244.507935f, 1318.510254f, 1396.912964f, 1479.977661f, 1567.981689f, 1661.21875f, 1760.f, 1864.655029f, 1975.533203f, 2093.004639f, 2217.460938f, 2349.318115f, 2489.015869f, 2637.020508f, 2793.825928f, 2959.955322f, 3135.963379f, 3322.4375f, 3520.f, 3729.31f, 3951.066406f, 4186.009277f, 4434.921875f, 4698.63623f, 4978.031738f, 5274.041016f, 5587.651855f, 5919.910645f, 6271.926758f, 6644.875f, 7040.f, 7458.620117f, 7902.132812f, 8372.018555f, 8869.84375f, 9397.272461f, 9956.063477f, 10548.082031f, 11175.303711f, 11839.821289f, 12543.853516f, 13289.75f
//    };
//
//    private AudioThread audioThread;
//    private PApplet processing;
//
//    public Maxim (PApplet processing) {
//	this.processing = processing;
//	sampleRate = 44100f;
//	audioThread = new AudioThread(sampleRate, 4096, false);
//	audioThread.start();
//	    
//    }
//
//    public float[] getPowerSpectrum() {
//	return audioThread.getPowerSpectrum();
//    }
//
//    /** 
//     *  load the sent file into an audio player and return it. Use
//     *  this if your audio file is not too long want precision control
//     *  over looping and play head position
//     * @param String filename - the file to load
//     * @return AudioPlayer - an audio player which can play the file
//     */
//    public AudioPlayer loadFile(String filename) {
//	// this will load the complete audio file into memory
//	AudioPlayer ap = new AudioPlayer(filename, sampleRate, processing);
//	audioThread.addAudioGenerator(ap);
//	// now we need to tell the audiothread
//	// to ask the audioplayer for samples
//	return ap;
//    }
//
//    /**
//     * Create a wavetable player object with a wavetable of the sent
//     * size. Small wavetables (<128) make for a 'nastier' sound!
//     * 
//     */
//    public WavetableSynth createWavetableSynth(int size) {
//	// this will load the complete audio file into memory
//	WavetableSynth ap = new WavetableSynth(size, sampleRate);
//	audioThread.addAudioGenerator(ap);
//	// now we need to tell the audiothread
//	// to ask the audioplayer for samples
//	return ap;
//    }
//    // /**
//    //  * Create an AudioStreamPlayer which can stream audio from the
//    //  * internet as well as local files.  Does not provide precise
//    //  * control over looping and playhead like AudioPlayer does.  Use this for
//    //  * longer audio files and audio from the internet.
//    //  */
//    // public AudioStreamPlayer createAudioStreamPlayer(String url) {
//    //     AudioStreamPlayer asp = new AudioStreamPlayer(url);
//    //     return asp;
//    // }
//}
//
//
//
//
///**
// * This class can play audio files and includes an fx chain 
// */
//public class AudioPlayer implements Synth, AudioGenerator {
//    private FXChain fxChain;
//    private boolean isPlaying;
//    private boolean isLooping;
//    private boolean analysing;
//    private FFT fft;
//    private int fftInd;
//    private float[] fftFrame;
//    private float[] powerSpectrum;
//
//    //private float startTimeSecs;
//    //private float speed;
//    private int length;
//    private short[] audioData;
//    private float startPos;
//    private float readHead;
//    private float dReadHead;
//    private float sampleRate;
//    private float masterVolume;
//
//    float x1, x2, y1, y2, x3, y3;
//
//    public AudioPlayer(float sampleRate) {
//	fxChain = new FXChain(sampleRate);
//	this.sampleRate = sampleRate;
//    }
//
//    public AudioPlayer (String filename, float sampleRate, PApplet processing) {
//	//super(filename);
//	this(sampleRate);
//	try {
//	    // how long is the file in bytes?
//	    //long byteCount = getAssets().openFd(filename).getLength();
//	    File f = new File(processing.dataPath(filename));
//	    long byteCount = f.length();
//	    //System.out.println("bytes in "+filename+" "+byteCount);
//
//	    // check the format of the audio file first!
//	    // only accept mono 16 bit wavs
//	    //InputStream is = getAssets().open(filename); 
//	    BufferedInputStream bis = new BufferedInputStream(new FileInputStream(f));
//
//	    // chop!!
//
//	    int bitDepth;
//	    int channels;
//	    boolean isPCM;
//	    // allows us to read up to 4 bytes at a time 
//	    byte[] byteBuff = new byte[4];
//
//	    // skip 20 bytes to get file format
//	    // (1 byte)
//	    bis.skip(20);
//	    bis.read(byteBuff, 0, 2); // read 2 so we are at 22 now
//	    isPCM = ((short)byteBuff[0]) == 1 ? true:false; 
//	    //System.out.println("File isPCM "+isPCM);
//
//	    // skip 22 bytes to get # channels
//	    // (1 byte)
//	    bis.read(byteBuff, 0, 2);// read 2 so we are at 24 now
//	    channels = (short)byteBuff[0];
//	    //System.out.println("#channels "+channels+" "+byteBuff[0]);
//	    // skip 24 bytes to get sampleRate
//	    // (32 bit int)
//	    bis.read(byteBuff, 0, 4); // read 4 so now we are at 28
//	    sampleRate = bytesToInt(byteBuff, 4);
//	    //System.out.println("Sample rate "+sampleRate);
//	    // skip 34 bytes to get bits per sample
//	    // (1 byte)
//	    bis.skip(6); // we were at 28...
//	    bis.read(byteBuff, 0, 2);// read 2 so we are at 36 now
//	    bitDepth = (short)byteBuff[0];
//	    //System.out.println("bit depth "+bitDepth);
//	    // convert to word count...
//	    bitDepth /= 8;
//	    // now start processing the raw data
//	    // data starts at byte 36
//	    int sampleCount = (int) ((byteCount - 36) / (bitDepth * channels));
//	    audioData = new short[sampleCount];
//	    int skip = (channels -1) * bitDepth;
//	    int sample = 0;
//	    // skip a few sample as it sounds like shit
//	    bis.skip(bitDepth * 4);
//	    while (bis.available () >= (bitDepth+skip)) {
//		bis.read(byteBuff, 0, bitDepth);// read 2 so we are at 36 now
//		//int val = bytesToInt(byteBuff, bitDepth);
//		// resample to 16 bit by casting to a short
//		audioData[sample] = (short) bytesToInt(byteBuff, bitDepth);
//		bis.skip(skip);
//		sample ++;
//	    }
//
//	    float secs = (float)sample / (float)sampleRate;
//	    //System.out.println("Read "+sample+" samples expected "+sampleCount+" time "+secs+" secs ");      
//	    bis.close();
//
//
//	    // unchop
//	    readHead = 0;
//	    startPos = 0;
//	    // default to 1 sample shift per tick
//	    dReadHead = 1;
//	    isPlaying = false;
//	    isLooping = true;
//	    masterVolume = 1;
//	} 
//	catch (FileNotFoundException e) {
//
//	    e.printStackTrace();
//	}
//	catch (IOException e) {
//	    e.printStackTrace();
//	}
//    }
//
//    public void setAnalysing(boolean analysing_) {
//	this.analysing = analysing_;
//	if (analysing) {// initialise the fft
//	    fft = new FFT();
//	    fftInd = 0;
//	    fftFrame = new float[1024];
//	    powerSpectrum = new float[fftFrame.length/2];
//	}
//    }
//
//    public float getAveragePower() {
//	if (analysing) {
//	    // calc the average
//	    float sum = 0;
//	    for (int i=0;i<powerSpectrum.length;i++){
//		sum += powerSpectrum[i];
//	    }
//	    sum /= powerSpectrum.length;
//	    return sum;
//	}
//	else {
//	    System.out.println("call setAnalysing to enable power analysis");
//	    return 0;
//	}
//    }
//    public float[] getPowerSpectrum() {
//	if (analysing) {
//	    return powerSpectrum;
//	}
//	else {
//	    System.out.println("call setAnalysing to enable power analysis");
//	    return null;
//	}
//    }
//
//    /** 
//     *convert the sent byte array into an int. Assumes little endian byte ordering. 
//     *@param bytes - the byte array containing the data
//     *@param wordSizeBytes - the number of bytes to read from bytes array
//     *@return int - the byte array as an int
//     */
//    private int bytesToInt(byte[] bytes, int wordSizeBytes) {
//	int val = 0;
//	for (int i=wordSizeBytes-1; i>=0; i--) {
//	    val <<= 8;
//	    val |= (int)bytes[i] & 0xFF;
//	}
//	return val;
//    }
//
//    /**
//     * Test if this audioplayer is playing right now
//     * @return true if it is playing, false otherwise
//     */
//    public boolean isPlaying() {
//	return isPlaying;
//    }
//
//    /**
//     * Set the loop mode for this audio player
//     * @param looping 
//     */
//    public void setLooping(boolean looping) {
//	isLooping = looping;
//    }
//
//    /**
//     * Move the start pointer of the audio player to the sent time in ms
//     * @param timeMs - the time in ms
//     */
//    public void cue(int timeMs) {
//	//startPos = ((timeMs / 1000) * sampleRate) % audioData.length;
//	//readHead = startPos;
//	//System.out.println("AudioPlayer Cueing to "+timeMs);
//	if (timeMs >= 0) {// ignore crazy values
//	    readHead = (((float)timeMs / 1000f) * sampleRate) % audioData.length;
//	    //System.out.println("Read head went to "+readHead);
//	}
//    }
//
//    /**
//     *  Set the playback speed,
//     * @param speed - playback speed where 1 is normal speed, 2 is double speed
//     */
//    public void speed(float speed) {
//	//System.out.println("setting speed to "+speed);
//	dReadHead = speed;
//    }
//
//    /**
//     * Set the master volume of the AudioPlayer
//     */
//
//    public void volume(float volume) {
//	masterVolume = volume;
//    }
//
//    /**
//     * Get the length of the audio file in samples
//     * @return int - the  length of the audio file in samples
//     */
//    public int getLength() {
//	return audioData.length;
//    }
//    /**
//     * Get the length of the sound in ms, suitable for sending to 'cue'
//     */
//    public float getLengthMs() {
//	return ((float) audioData.length / sampleRate * 1000f);
//    }
//
//    /**
//     * Start playing the sound. 
//     */
//    public void play() {
//	isPlaying = true;
//    }
//
//    /**
//     * Stop playing the sound
//     */
//    public void stop() {
//	isPlaying = false;
//    }
//
//    /**
//     * implementation of the AudioGenerator interface
//     */
//    public short getSample() {
//	if (!isPlaying) {
//	    return 0;
//	}
//	else {
//	    short sample;
//	    readHead += dReadHead;
//	    if (readHead > (audioData.length - 1)) {// got to the end
//		//% (float)audioData.length;
//		if (isLooping) {// back to the start for loop mode
//		    readHead = readHead % (float)audioData.length;
//		}
//		else {
//		    readHead = 0;
//		    isPlaying = false;
//		}
//	    }
//
//	    // linear interpolation here
//	    // declaring these at the top...
//	    // easy to understand version...
//	    //      float x1, x2, y1, y2, x3, y3;
//	    x1 = floor(readHead);
//	    x2 = x1 + 1;
//	    y1 = audioData[(int)x1];
//	    y2 = audioData[(int) (x2 % audioData.length)];
//	    x3 = readHead;
//	    // calc 
//	    y3 =  y1 + ((x3 - x1) * (y2 - y1));
//	    y3 *= masterVolume;
//	    sample = fxChain.getSample((short) y3);
//	    if (analysing) {
//		// accumulate samples for the fft
//		fftFrame[fftInd] = (float)sample / 32768f;
//		fftInd ++;
//		if (fftInd == fftFrame.length - 1) {// got a frame
//		    powerSpectrum = fft.process(fftFrame, true);
//		    fftInd = 0;
//		}
//	    }
//
//	    //return sample;
//	    return (short)y3;
//	}
//    }
//
//    public void setAudioData(short[] audioData) {
//	this.audioData = audioData;
//    }
//
//    public short[] getAudioData() {
//	return audioData;
//    }
//
//    public void setDReadHead(float dReadHead) {
//	this.dReadHead = dReadHead;
//    }
//
//    ///
//    //the synth interface
//    // 
//
//    public void ramp(float val, float timeMs) {
//	fxChain.ramp(val, timeMs);
//    } 
//
//
//
//    public void setDelayTime(float delayMs) {
//	fxChain.setDelayTime( delayMs);
//    }
//
//    public void setDelayFeedback(float fb) {
//	fxChain.setDelayFeedback(fb);
//    }
//
//    public void setFilter(float cutoff, float resonance) {
//	fxChain.setFilter( cutoff, resonance);
//    }
//}
//
///**
// * This class can play wavetables and includes an fx chain
// */
//public class WavetableSynth extends AudioPlayer {
//
//    private short[] sine;
//    private short[] saw;
//    private short[] wavetable;
//    private float sampleRate;
//
//    public WavetableSynth(int size, float sampleRate) {
//	super(sampleRate);
//	sine = new short[size];
//	for (float i = 0; i < sine.length; i++) {
//	    float phase;
//	    phase = TWO_PI / size * i;
//	    sine[(int)i] = (short) (sin(phase) * 32768);
//	}
//	saw = new short[size];
//	for (float i = 0; i<saw.length; i++) {
//	    saw[(int)i] = (short) (i / (float)saw.length *32768);
//	}
//
//	this.sampleRate = sampleRate;
//	setAudioData(sine);
//	setLooping(true);
//    }
//
//    public void setFrequency(float freq) {
//	if (freq > 0) {
//	    //System.out.println("freq freq "+freq);
//	    setDReadHead((float)getAudioData().length / sampleRate * freq);
//	}
//    }
//
//    public void loadWaveForm(float[] wavetable_) {
//	if (wavetable == null || wavetable_.length != wavetable.length) {
//	    // only reallocate if there is a change in length
//	    wavetable = new short[wavetable_.length];
//	}
//	for (int i=0;i<wavetable.length;i++) {
//	    wavetable[i] = (short) (wavetable_[i] * 32768);
//	}
//	setAudioData(wavetable);
//    }
//}
//
//public interface Synth {
//    public void volume(float volume);
//    public void ramp(float val, float timeMs);  
//    public void setDelayTime(float delayMs);  
//    public void setDelayFeedback(float fb);  
//    public void setFilter(float cutoff, float resonance);
//    public void setAnalysing(boolean analysing);
//    public float getAveragePower();
//    public float[] getPowerSpectrum();
//}
//
//public class AudioThread extends Thread
//{
//    private int minSize;
//    //private AudioTrack track;
//    private short[] bufferS;
//    private byte[] bOutput;
//    private ArrayList audioGens;
//    private boolean running;
//
//    private FFT fft;
//    private float[] fftFrame;
//    private SourceDataLine sourceDataLine;
//    private int blockSize;
//
//    public AudioThread(float samplingRate, int blockSize) {
//	this(samplingRate, blockSize, false);
//    }
//
//    public AudioThread(float samplingRate, int blockSize, boolean enableFFT)
//    {
//	this.blockSize = blockSize;
//	audioGens = new ArrayList();
//	// we'll do our dsp in shorts
//	bufferS = new short[blockSize];
//	// but we'll convert to bytes when sending to the sound card
//	bOutput = new byte[blockSize * 2];
//	AudioFormat audioFormat = new AudioFormat(samplingRate, 16, 1, true, false);
//	DataLine.Info dataLineInfo = new DataLine.Info(SourceDataLine.class, audioFormat);
//	    
//	sourceDataLine = null;
//	// here we try to initialise the audio system. try catch is exception handling, i.e. 
//	// dealing with things not working as expected
//	try {
//	    sourceDataLine = (SourceDataLine) AudioSystem.getLine(dataLineInfo);
//	    sourceDataLine.open(audioFormat, bOutput.length);
//	    sourceDataLine.start();
//	    running = true;
//	} catch (LineUnavailableException lue) {
//	    // it went wrong!
//	    lue.printStackTrace(System.err);
//	    System.out.println("Could not initialise audio. check above stack trace for more info");
//	    //System.exit(1);
//	}
//
//
//	if (enableFFT) {
//	    try {
//		fft = new FFT();
//	    }
//	    catch(Exception e) {
//		System.out.println("Error setting up the audio analyzer");
//		e.printStackTrace();
//	    }
//	}
//    }
//
//    // overidden from Thread
//    public void run() {
//	running = true;
//	while (running) {
//	    //System.out.println("AudioThread : ags  "+audioGens.size());
//	    for (int i=0;i<bufferS.length;i++) {
//		// we add up using a 32bit int
//		// to prevent clipping
//		int val = 0;
//		if (audioGens.size() > 0) {
//		    for (int j=0;j<audioGens.size(); j++) {
//			AudioGenerator ag = (AudioGenerator)audioGens.get(j);
//			val += ag.getSample();
//		    }
//		    val /= audioGens.size();
//		}
//		bufferS[i] = (short) val;
//	    }
//	    // send it to the audio device!
//	    sourceDataLine.write(shortsToBytes(bufferS, bOutput), 0, bOutput.length);
//	}
//    }
//	
//    public void addAudioGenerator(AudioGenerator ag) {
//	audioGens.add(ag);
//    }
//
//    /**
//     * converts an array of 16 bit samples to bytes
//     * in little-endian (low-byte, high-byte) format.
//     */
//    private byte[] shortsToBytes(short[] sData, byte[] bData) {
//	int index = 0;
//	short sval;
//	for (int i = 0; i < sData.length; i++) {
//	    //short sval = (short) (fData[j][i] * ShortMaxValueAsFloat);
//	    sval = sData[i];
//	    bData[index++] = (byte) (sval & 0x00FF);
//	    bData[index++] = (byte) ((sval & 0xFF00) >> 8);
//	}
//	return bData;
//    }
//
//    /**
//     * Returns a recent snapshot of the power spectrum 
//     */
//    public float[] getPowerSpectrum() {
//	// process the last buffer that was calculated
//	if (fftFrame == null) {
//	    fftFrame = new float[bufferS.length];
//	}
//	for (int i=0;i<fftFrame.length;i++) {
//	    fftFrame[i] = ((float) bufferS[i] / 32768f);
//	}
//	return fft.process(fftFrame, true);
//	//return powerSpectrum;
//    }
//}
//
///**
// * Implement this interface so the AudioThread can request samples from you
// */
//public interface AudioGenerator {
//    /** AudioThread calls this when it wants a sample */
//    short getSample();
//}
//
//
//public class FXChain  {
//    private float currentAmp;
//    private float dAmp;
//    private float targetAmp;
//    private boolean goingUp;
//    private Filter filter;
//
//    private float[] dLine;   
//
//    private float sampleRate;
//
//    public FXChain(float sampleRate_) {
//	sampleRate = sampleRate_;
//	currentAmp = 1;
//	dAmp = 0;
//	// filter = new MickFilter(sampleRate);
//	filter = new RLPF(sampleRate);
//
//	//filter.setFilter(0.1, 0.1);
//    }
//
//    public void ramp(float val, float timeMs) {
//	// calc the dAmp;
//	// - change per ms
//	targetAmp = val;
//	dAmp = (targetAmp - currentAmp) / (timeMs / 1000 * sampleRate);
//	if (targetAmp > currentAmp) {
//	    goingUp = true;
//	}
//	else {
//	    goingUp = false;
//	}
//    }
//
//
//    public void setDelayTime(float delayMs) {
//    }
//
//    public void setDelayFeedback(float fb) {
//    }
//
//    public void volume(float volume) {
//    }
//
//
//    public short getSample(short input) {
//	float in;
//	in = (float) input / 32768;// -1 to 1
//
//	in =  filter.applyFilter(in);
//	if (goingUp && currentAmp < targetAmp) {
//	    currentAmp += dAmp;
//	}
//	else if (!goingUp && currentAmp > targetAmp) {
//	    currentAmp += dAmp;
//	}  
//
//	if (currentAmp > 1) {
//	    currentAmp = 1;
//	}
//	if (currentAmp < 0) {
//	    currentAmp = 0;
//	}  
//	in *= currentAmp;  
//	return (short) (in * 32768);
//    }
//
//    public void setFilter(float f, float r) {
//	filter.setFilter(f, r);
//    }
//}
//
//
//// /**
////  * Represents an audio source is streamed as opposed to being completely loaded (as WavSource is)
////  */
//// public class AudioStreamPlayer {
//// 	/** a class from the android API*/
//// 	private MediaPlayer mediaPlayer;
//// 	/** a class from the android API*/
//// 	private Visualizer viz; 
//// 	private byte[] waveformBuffer;
//// 	private byte[] fftBuffer;
//// 	private byte[] powerSpectrum;
//
//// 	/**
//// 	 * create a stream source from the sent url 
//// 	 */
//// 	public AudioStreamPlayer(String url) {
//// 	    try {
//// 		mediaPlayer = new MediaPlayer();
//// 		//mp.setAuxEffectSendLevel(1);
//// 		mediaPlayer.setLooping(true);
//
//// 		// try to parse the URL... if that fails, we assume it
//// 		// is a local file in the assets folder
//// 		try {
//// 		    URL uRL = new URL(url);
//// 		    mediaPlayer.setDataSource(url);
//// 		}
//// 		catch (MalformedURLException eek) {
//// 		    // couldn't parse the url, assume its a local file
//// 		    AssetFileDescriptor afd = getAssets().openFd(url);
//// 		    //mp.setDataSource(afd.getFileDescriptor(),afd.getStartOffset(),afd.getLength());
//// 		    mediaPlayer.setDataSource(afd.getFileDescriptor());
//// 		    afd.close();
//// 		}
//
//// 		mediaPlayer.prepare();
//// 		//mediaPlayer.start();
//// 		//System.out.println("Created audio with id "+mediaPlayer.getAudioSessionId());
//// 		viz = new Visualizer(mediaPlayer.getAudioSessionId());
//// 		viz.setEnabled(true);
//// 		waveformBuffer = new byte[viz.getCaptureSize()];
//// 		fftBuffer = new byte[viz.getCaptureSize()/2];
//// 		powerSpectrum = new byte[viz.getCaptureSize()/2];
//// 	    }
//// 	    catch (Exception e) {
//// 		System.out.println("StreamSource could not be initialised. Check url... "+url+ " and that you have added the permission INTERNET, RECORD_AUDIO and MODIFY_AUDIO_SETTINGS to the manifest,");
//// 		e.printStackTrace();
//// 	    }
//// 	}
//
//// 	public void play() {
//// 	    mediaPlayer.start();
//// 	}
//
//// 	public int getLengthMs() {
//// 	    return mediaPlayer.getDuration();
//// 	}
//
//// 	public void cue(float timeMs) {
//// 	    if (timeMs >= 0 && timeMs < getLengthMs()) {// ignore crazy values
//// 		mediaPlayer.seekTo((int)timeMs);
//// 	    }
//// 	}
//
//// 	/**
//// 	 * Returns a recent snapshot of the power spectrum as 8 bit values
//// 	 */
//// 	public byte[] getPowerSpectrum() {
//// 	    // calculate the spectrum
//// 	    viz.getFft(fftBuffer);
//// 	    short real, imag;
//// 	    for (int i=2;i<fftBuffer.length;i+=2) {
//// 		real = (short) fftBuffer[i];
//// 		imag = (short) fftBuffer[i+1];
//// 		powerSpectrum[i/2] = (byte) ((real * real)  + (imag * imag));
//// 	    }
//// 	    return powerSpectrum;
//// 	}
//
//// 	/**
//// 	 * Returns a recent snapshot of the waveform being played 
//// 	 */
//// 	public byte[] getWaveForm() {
//// 	    // retrieve the waveform
//// 	    viz.getWaveForm(waveformBuffer);
//// 	    return waveformBuffer;
//// 	}
//// } 
//
///**
// * Use this class to retrieve data about the movement of the device
// */
//public class Accelerometer  {
//    //private SensorManager sensorManager;
//    //private Sensor accelerometer;
//    private float[] values;
//
//    public Accelerometer() {
//	//sensorManager = (SensorManager)getSystemService(SENSOR_SERVICE);
//	//accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
//	//sensorManager.registerListener(this, accelerometer, SensorManager.SENSOR_DELAY_NORMAL);
//	values = new float[3];
//	System.out.println("Java accelerometer will generate values of zero!");
//    }
//
//    public float[] getValues() {
//	return values;
//    }
//
//    public float getX() {
//	return values[0];
//    }
//
//    public float getY() {
//	return values[1];
//    }
//
//    public float getZ() {
//	return values[2];
//    }
//
//}
//
//public interface Filter {
//    public void setFilter(float f, float r);
//    public float applyFilter(float in);
//}
//
///** https://github.com/supercollider/supercollider/blob/master/server/plugins/FilterUGens.cpp */
//
//public class RLPF implements Filter {
//    float a0, b1, b2, y1, y2;
//    float freq;
//    float reson;
//    float sampleRate;
//    boolean changed;
//
//    public RLPF(float sampleRate_) {
//	this.sampleRate = sampleRate_;
//	reset();
//	this.setFilter(sampleRate / 4, 0.01f);
//    }
//    private void reset() {
//	a0 = 0.f;
//	b1 = 0.f;
//	b2 = 0.f;
//	y1 = 0.f;
//	y2 = 0.f;
//    }
//    /** f is in the range 0-sampleRate/2 */
//    public void setFilter(float f, float r) {
//	// constrain 
//	// limit to 0-1 
//	f = constrain(f, 0, sampleRate/4);
//	r = constrain(r, 0, 1);
//	// invert so high r -> high resonance!
//	r = 1-r;
//	// remap to appropriate ranges
//	f = map(f, 0f, sampleRate/4, 30f, sampleRate / 4);
//	r = map(r, 0f, 1f, 0.005f, 2f);
//
//	System.out.println("rlpf: f "+f+" r "+r);
//
//	this.freq = f * TWO_PI / sampleRate;
//	this.reson = r;
//	changed = true;
//    }
//
//    public float applyFilter(float in) {
//	float y0;
//	if (changed) {
//	    float D = tan(freq * reson * 0.5f);
//	    float C = ((1.f-D)/(1.f+D));
//	    float cosf = cos(freq);
//	    b1 = (1.f + C) * cosf;
//	    b2 = -C;
//	    a0 = (1.f + C - b1) * .25f;
//	    changed = false;
//	}
//	y0 = a0 * in + b1 * y1 + b2 * y2;
//	y2 = y1;
//	y1 = y0;
//	if (Float.isNaN(y0)) {
//	    reset();
//	}
//	return y0;
//    }
//}
//
///** https://github.com/micknoise/Maximilian/blob/master/maximilian.cpp */
//
//class MickFilter implements Filter {
//
//    private float f, res;
//    private float cutoff, z, c, x, y, out;
//    private float sampleRate;
//
//    MickFilter(float sampleRate) {
//	this.sampleRate = sampleRate;
//    }
//
//    public void setFilter(float f, float r) {
//	f = constrain(f, 0, 1);
//	res = constrain(r, 0, 1);
//	f = map(f, 0, 1, 25, sampleRate / 4);
//	r = map(r, 0, 1, 1, 25);
//	this.f = f;
//	this.res = r;    
//
//	//System.out.println("mickF: f "+f+" r "+r);
//    }
//    public float applyFilter(float in) {
//	return lores(in, f, res);
//    }
//
//    public float lores(float input, float cutoff1, float resonance) {
//	//cutoff=cutoff1*0.5;
//	//if (cutoff<10) cutoff=10;
//	//if (cutoff>(sampleRate*0.5)) cutoff=(sampleRate*0.5);
//	//if (resonance<1.) resonance = 1.;
//
//	//if (resonance>2.4) resonance = 2.4;
//	z=cos(TWO_PI*cutoff/sampleRate);
//	c=2-2*z;
//	float r=(sqrt(2.0f)*sqrt(-pow((z-1.0f), 3.0f))+resonance*(z-1))/(resonance*(z-1));
//	x=x+(input-y)*c;
//	y=y+x;
//	x=x*r;
//	out=y;
//	return out;
//    }
//}
//
//
///*
// * This file is part of Beads. See http://www.beadsproject.net for all information.
// * CREDIT: This class uses portions of code taken from MPEG7AudioEnc. See readme/CREDITS.txt.
// */
//
///**
// * FFT performs a Fast Fourier Transform and forwards the complex data to any listeners. 
// * The complex data is a float of the form float[2][frameSize], with real and imaginary 
// * parts stored respectively.
// * 
// * @beads.category analysis
// */
//public class FFT {
//
//    /** The real part. */
//    protected float[] fftReal;
//
//    /** The imaginary part. */
//    protected float[] fftImag;
//
//    private float[] dataCopy = null;
//    private float[][] features;
//    private float[] powers;
//    private int numFeatures;
//
//    /**
//     * Instantiates a new FFT.
//     */
//    public FFT() {
//	features = new float[2][];
//    }
//
//    /* (non-Javadoc)
//     * @see com.olliebown.beads.core.UGen#calculateBuffer()
//     */
//    public float[] process(float[] data, boolean direction) {
//	if (powers == null) powers = new float[data.length/2];
//	if (dataCopy==null || dataCopy.length!=data.length)
//	    dataCopy = new float[data.length];
//	System.arraycopy(data, 0, dataCopy, 0, data.length);
//
//	fft(dataCopy, dataCopy.length, direction);
//	numFeatures = dataCopy.length;
//	fftReal = calculateReal(dataCopy, dataCopy.length);
//	fftImag = calculateImaginary(dataCopy, dataCopy.length);
//	features[0] = fftReal;
//	features[1] = fftImag;
//	// now calc the powers
//	return specToPowers(fftReal, fftImag, powers);
//    }
//
//    public float[] specToPowers(float[] real, float[] imag, float[] powers) {
//	float re, im;
//	double pow;
//	for (int i=0;i<powers.length;i++) {
//	    //real = spectrum[i][j].re();
//	    //imag = spectrum[i][j].im();
//	    re = real[i];
//	    im = imag[i];
//	    powers[i] = (re*re + im * im);
//	    powers[i] = (float) Math.sqrt(powers[i]) / 10;
//	    // convert to dB
//	    pow = (double) powers[i];
//	    powers[i] = (float)(10 *  Math.log10(pow * pow)); // (-100 - 100)
//	    powers[i] = (powers[i] + 100) * 0.005f; // 0-1
//	}
//	return powers;
//    }
//
//    /**
//     * The frequency corresponding to a specific bin 
//     * 
//     * @param samplingFrequency The Sampling Frequency of the AudioContext
//     * @param blockSize The size of the block analysed
//     * @param binNumber 
//     */
//    public  float binFrequency(float samplingFrequency, int blockSize, float binNumber)
//    {    
//	return binNumber*samplingFrequency/blockSize;
//    }
//
//    /**
//     * Returns the average bin number corresponding to a particular frequency.
//     * Note: This function returns a float. Take the Math.round() of the returned value to get an integral bin number. 
//     * 
//     * @param samplingFrequency The Sampling Frequency of the AudioContext
//     * @param blockSize The size of the fft block
//     * @param freq  The frequency
//     */
//
//    public  float binNumber(float samplingFrequency, int blockSize, float freq)
//    {
//	return blockSize*freq/samplingFrequency;
//    }
//
//    /** The nyquist frequency for this samplingFrequency 
//     * 
//     * @params samplingFrequency the sample
//     */
//    public  float nyquist(float samplingFrequency)
//    {
//	return samplingFrequency/2;
//    }
//
//    /*
//     * All of the code below this line is taken from Holger Crysandt's MPEG7AudioEnc project.
//     * See http://mpeg7audioenc.sourceforge.net/copyright.html for license and copyright.
//     */
//
//    /**
//     * Gets the real part from the complex spectrum.
//     * 
//     * @param spectrum
//     *            complex spectrum.
//     * @param length 
//     *       length of data to use.
//     * 
//     * @return real part of given length of complex spectrum.
//     */
//    protected  float[] calculateReal(float[] spectrum, int length) {
//	float[] real = new float[length];
//	real[0] = spectrum[0];
//	real[real.length/2] = spectrum[1];
//	for (int i=1, j=real.length-1; i<j; ++i, --j)
//	    real[j] = real[i] = spectrum[2*i];
//	return real;
//    }
//
//    /**
//     * Gets the imaginary part from the complex spectrum.
//     * 
//     * @param spectrum
//     *            complex spectrum.
//     * @param length 
//     *       length of data to use.
//     * 
//     * @return imaginary part of given length of complex spectrum.
//     */
//    protected  float[] calculateImaginary(float[] spectrum, int length) {
//	float[] imag = new float[length];
//	for (int i=1, j=imag.length-1; i<j; ++i, --j)
//	    imag[i] = -(imag[j] = spectrum[2*i+1]);
//	return imag;
//    }
//
//    /**
//     * Perform FFT on data with given length, regular or inverse.
//     * 
//     * @param data the data
//     * @param n the length
//     * @param isign true for regular, false for inverse.
//     */
//    protected  void fft(float[] data, int n, boolean isign) {
//	float c1 = 0.5f; 
//	float c2, h1r, h1i, h2r, h2i;
//	double wr, wi, wpr, wpi, wtemp;
//	double theta = 3.141592653589793/(n>>1);
//	if (isign) {
//	    c2 = -.5f;
//	    four1(data, n>>1, true);
//	} 
//	else {
//	    c2 = .5f;
//	    theta = -theta;
//	}
//	wtemp = Math.sin(.5*theta);
//	wpr = -2.*wtemp*wtemp;
//	wpi = Math.sin(theta);
//	wr = 1. + wpr;
//	wi = wpi;
//	int np3 = n + 3;
//	for (int i=2,imax = n >> 2, i1, i2, i3, i4; i <= imax; ++i) {
//	    /** @TODO this can be optimized */
//	    i4 = 1 + (i3 = np3 - (i2 = 1 + (i1 = i + i - 1)));
//	    --i4; 
//	    --i2; 
//	    --i3; 
//	    --i1; 
//	    h1i =  c1*(data[i2] - data[i4]);
//	    h2r = -c2*(data[i2] + data[i4]);
//	    h1r =  c1*(data[i1] + data[i3]);
//	    h2i =  c2*(data[i1] - data[i3]);
//	    data[i1] = (float) ( h1r + wr*h2r - wi*h2i);
//	    data[i2] = (float) ( h1i + wr*h2i + wi*h2r);
//	    data[i3] = (float) ( h1r - wr*h2r + wi*h2i);
//	    data[i4] = (float) (-h1i + wr*h2i + wi*h2r);
//	    wr = (wtemp=wr)*wpr - wi*wpi + wr;
//	    wi = wi*wpr + wtemp*wpi + wi;
//	}
//	if (isign) {
//	    float tmp = data[0]; 
//	    data[0] += data[1];
//	    data[1] = tmp - data[1];
//	} 
//	else {
//	    float tmp = data[0];
//	    data[0] = c1 * (tmp + data[1]);
//	    data[1] = c1 * (tmp - data[1]);
//	    four1(data, n>>1, false);
//	}
//    }
//
//    /**
//     * four1 algorithm.
//     * 
//     * @param data
//     *            the data.
//     * @param nn
//     *            the nn.
//     * @param isign
//     *            regular or inverse.
//     */
//    private  void four1(float data[], int nn, boolean isign) {
//	int n, mmax, istep;
//	double wtemp, wr, wpr, wpi, wi, theta;
//	float tempr, tempi;
//
//	n = nn << 1;        
//	for (int i = 1, j = 1; i < n; i += 2) {
//	    if (j > i) {
//		// SWAP(data[j], data[i]);
//		float swap = data[j-1];
//		data[j-1] = data[i-1];
//		data[i-1] = swap;
//		// SWAP(data[j+1], data[i+1]);
//		swap = data[j];
//		data[j] = data[i]; 
//		data[i] = swap;
//	    }      
//	    int m = n >> 1;
//	    while (m >= 2 && j > m) {
//		j -= m;
//		m >>= 1;
//	    }
//	    j += m;
//	}
//	mmax = 2;
//	while (n > mmax) {
//	    istep = mmax << 1;
//	    theta = 6.28318530717959 / mmax;
//	    if (!isign)
//		theta = -theta;
//	    wtemp = Math.sin(0.5 * theta);
//	    wpr = -2.0 * wtemp * wtemp;
//	    wpi = Math.sin(theta);
//	    wr = 1.0;
//	    wi = 0.0;
//	    for (int m = 1; m < mmax; m += 2) {
//		for (int i = m; i <= n; i += istep) {
//		    int j = i + mmax;
//		    tempr = (float) (wr * data[j-1] - wi * data[j]);  
//		    tempi = (float) (wr * data[j]   + wi * data[j-1]);  
//		    data[j-1] = data[i-1] - tempr;
//		    data[j]   = data[i] - tempi;
//		    data[i-1] += tempr;
//		    data[i]   += tempi;
//		}
//		wr = (wtemp = wr) * wpr - wi * wpi + wr;
//		wi = wi * wpr + wtemp * wpi + wi;
//	    }
//	    mmax = istep;
//	}
//    }
//}
//


void contactStarted(FContact contact){
  FBody b1 = contact.getBody1();
  FBody b2 = contact.getBody2();
  
  if(((b1 == anchor && b2 == ammo) 
  || (b1 == ammo && b2 == anchor)) && !isCata && (millis() - launchTime > 800))
  {
    isCata = true;
    cata.setDamping(0.01);
    cata.setFrequency(0.1);
    empty = false;
    world.add(cata);
  }
  else{
    for(int i = 0 ; i < numEnemies; i++)
    {
      if(enemyExists[i])
      {
        if (b1 == base && b2 == enemies[i] || b1 == enemies[i] && b2 == base){
          health -= 1; 
        }
      } 
    }
     // check for attacks
    for(int i = 0 ; i < numEnemies; i++)
    {
      if(enemyExists[i])
      {
        if (b1 == square && b2 == enemies[i] || b1 == enemies[i] && b2 == square)
        {
          enemyHealth[i] -= squareDamage;
          if(enemyHealth[i] <= 0)
          {
            death(i);
          }
        }
        else if(b1 == ammo && b2 == enemies[i] || b1 == enemies[i] && b2 == ammo)
        {
          if(!launched)
          {
            enemyHealth[i] -= cataDamage;
            if(enemyHealth[i] <= 0)
            {
              death(i);
            }
          }
        }
        else if(b1 == explosion && b2 == enemies[i] || b2 == explosion && b1 == enemies[i])
        {
          enemyHealth[i] -= explosionDamage;
          if(enemyHealth[i] <= 0)
          {
            death(i);
          }
        }
        else
        {
          for(int k = 1; k < numCircles; k++)
          {
            if(circleExists[k])
            {
              if(b1 == circles[k] && b2 == enemies[i]
              || b1 == enemies[i] && b2 == circles[k])
              {
                enemyHealth[i] -= circleDamage;
                if(enemyHealth[i] <= 0)
                {
                  death(i);
                }
              }
            }
          }
          for(int j = 1; j < numTriangles; j++)
          {
            if(tExists[j])
            {
              if (b1 == triangles[j] && b2 == enemies[i]
              || b1 == enemies[i] && b2 == triangles[j])
              {
                enemyHealth[i] -= triangleDamage;
                if(enemyHealth[i] <= 0)
                {
                  death(i);
                }
              }
            }
          } 
        }    
      }  
    }
  }
}
  
//sound effects
//  // test
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




 






void breakTri()
{
  for(int i = 0; i < numTriangles; i++)
  {
    if(tExists[i])
    {
      if(millis() - tTime[i] > tDuration)
      {
        world.remove(triangles[i]);
        tExists[i] = false;
      }
    }
  }
}



void breakSquare()
  {
    if(squareExists)
    {
      if(millis() - squareTime > squareDuration)
      {
        world.remove(square);
        squareExists = false;
        squareBreakTime = millis();
      }
      else
      {
        float alpha = map(squareSize, 0, (height + width)/2, 250, 150);
        int timeAlive = millis() - squareTime;
        red = (int)(map(timeAlive, 0, squareDuration, 0, 170));
        green = 5;
        blue = (int)(map(timeAlive, 0, squareDuration, 100, 10));
        square.setFill(red, green, blue, alpha);
        square.setStroke(red + 10, green, blue + 10, alpha);
      }
    }
  }

void circleColor()
{
  for(int i = 0; i < numCircles; i++)
  {
    if(circleExists[i])
    {
      if(millis() - circleTime[i] > circleDuration)
      {
        world.remove(circles[i]);
        circleExists[i] = false;
      }
      else{
        float center = dist(circles[i].getX(),circles[i].getY(),width/2,height/2);
        red = (int)(map(circles[i].getX(), 0, width, 0, 255));
        //green = (int)(map(center, 0, height, 255, 0));// inverse distance from center
        green = (int)(map(circles[i].getY(), 0, height, 255, 0));
        blue = (int)(map(circles[i].getX(), 0, width, 255, 0)); // inverse width
        circles[i].setFill(red, green, blue);
      }
    }
  }
}



void boom()
{
  if(crateLive && !booming && millis() - crateTime > crateBoom)
  {
    explosion.setPosition(crate.getX(), crate.getY());
    world.add(explosion);
    boomTime = millis();
    booming = true;
    world.remove(crate);
  }
}
    
void endBoom()
{
  if(booming && millis() - boomTime > boomDuration)
  {
    world.remove(explosion);
    crate.setPosition((190 + 325)/2, 280 - crateSize/2 - 1);
    booming = false;
    crateLive = false;
    world.add(crate);
    crate.setImageAlpha(255);
  }
}
  
  
void respawnStick()
{
  if((millis() - stickDropped > stickCD) && !stickGrabbed && stickUsed)
  {
      world.add(stickBranch);
      stickUsed = false;
      stick.setDensity(0);
      stick.setPosition(width/2 + 10 + stickY/2, height/2 + 100 - stickX);
      world.add(stick);
  }
}


void dropStick()
{
  if(millis() - stickTime > stickDuration && stickGrabbed)
  {
    world.remove(stickJoint);
    world.remove(stick);
    stickGrabbed = false;
    stickDropped = millis();
  }
}

void launchCata()
{
  if(flying && (millis() - launchTime > flightTime))
  {
    world.remove(cata);
    isCata = false;
    flying = false;
    launched = false;
    cataTime = millis();
    empty = true;
    ammo.setGroupIndex(-2);
    ammoChanged = false;
    posChanged = false;
    ammo.setGrabbable(false);
  }
}  

void reloadCata()
{
    if(!ammoChanged && empty && !isCata && !launched && millis() - cataTime > cataReset)
    {
      disableAmmo();
    }
}

void disableAmmo()
{

    ammo.setGroupIndex(-1);
    changeTime = millis();
    ammoChanged = true;

}

void reloadAmmo()
{
  if(!posChanged && ammoChanged && millis() - changeTime > delay)
  {   
    ammo.setPosition(cataX, cataY);
    ammo.setGrabbable(true);
    posChanged = true;
  }
}
void kill()
{
  if(dead)
  {
    // kill dead enemies
    for(int i = 0; i < numEnemies; i++)
    { 
      if(deadTest[i])
      {
        world.remove(enemies[i]);
        enemyExists[i] = false;
      }
    }
    dead = false;
  }
}

void death(int n)
{
    experience += 1;
    dead = true;
    deadTest[n] = true; 
}

  
void spawnEnemy()
{
  int epsilon = 15;
  if(millis() % 2000 < epsilon && millis() > 1999)
  {
    int enemyNum = enemyCount % numEnemies;
    if(!enemyExists[enemyNum])
    {
        enemyHealth[enemyNum] = enemyMaxHP;
        world.add(enemies[enemyNum]);
        enemyExists[enemyNum] = true;
        enemyCount++;
        deadTest[enemyNum] = false;
      }
        
  }
}


//moves enemy depending on position
void moveEnemy()
{
  for(int i = 0; i < numEnemies; i++)
  {
    if(enemyExists[i])
    {
      if(enemies[i].getX() < width/2){
      enemies[i].addForce(enemySpeed, 0);
      }
      else{
      enemies[i].addForce(0 - enemySpeed, 0);
      }
    }
  }
}




void gameOver()
{
  if(health < 0)
  {
    world.clear();
    background(0);
    textSize(100);
    fill(255);
    String s = "GAME OVER";
    text(s, width/2 - textWidth(s)/2, height/2);
    String t = "Score: " + experience; 
    textSize(50);
    text(t, width/2 - textWidth(t)/2, height/2 + 100);
  }
}


void mousePressed()
{
  if(mouseButton == LEFT){
    if(abs(crate.getX() - mouseX) < crateSize/2 && abs(crate.getY() - mouseY) < crateSize/2){
      clicking = true;
      crateGrabbed = true;
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
      world.add(bloby);
      clicking = true;
      raindrop = true;
    }
    // pick up stick
    else if(abs(stick.getX() - mouseX) < stickY/2 && abs(stick.getY() - mouseY) < stickY/2 && !stickGrabbed && !stickUsed)
    {
      clicking = true;
      stickUsed = true;
      stickGrabbed = true;
      stickJoint = new FMouseJoint(stick, mouseX + 20, mouseY - 10);
      stickJoint.setDrawable(false);
      stick.setDensity(10);
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

void mouseMoved()
{
  try{
    if(stickGrabbed)
    {
      stickJoint.setTarget(mouseX + 20, mouseY - 10);
    }
  }catch(NullPointerException e){}
  
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
    else if(crateGrabbed)
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




