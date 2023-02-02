import processing.sound.*;

boolean debug = true;
boolean osCompatible;
String operatingSystem = System.getProperty("os.name");

SoundFile ambient;

float cursor_size = 25;
PFont font;

public int scaleFactor = 3;
public int windowWidth = 3840/scaleFactor;
public int windowHeight = 2160*2/scaleFactor;
public int wallHeight = windowHeight/2;
public boolean bFullscreen = false;

public int hFloor;
public int wallThird;

boolean ShowTrack = true;
boolean ShowPath = true;
boolean ShowFeet = true;
int amount = 5;


int GRASS;
int RAIN;
int LEAVES;
int SNOW;
int STORM;
int END;

int[] splitDurations, splitOrder;

StateMgr stateMgr;
TimeSplit timeSplit;

PImage[] flowers = new PImage[5];
PImage[] muds = new PImage[3];
PImage[] snows= new PImage[5];;
void settings()
{
  if (bFullscreen)
  {
    fullScreen(P2D, SPAN);
  }
  else
  {
    size(windowWidth, windowHeight);   
  }
}

void setup() {

  loadImages();

  
  // update with actual fullscreen resolutions
  if (bFullscreen)
  {  
    windowWidth = width;
    windowHeight = height;
    wallHeight = windowHeight / 2;  
  }  
  
  frameRate(60);
  
  noStroke();
  fill(0);
  
  wallThird = abs(wallHeight/3); //absolute value for third of wall
  hFloor = wallThird * 2; //two thirds for start of floor extension
  
  
  colorMode(RGB, 255,255,255,255);
  timeSplit = new TimeSplit();
  stateMgr = new StateMgr();

  noStroke();
  
  if (debug){
    splitDurations = new int[] {20000,20000,20000,20000, 20000};
    splitOrder = new int[] {1,2,3,4};
  } else {
    splitDurations = timeSplit.splitInterval();
    splitOrder = timeSplit.assignNumbers(splitDurations);
  }
  
  
  GRASS = stateMgr.addState(new Grass(stateMgr, splitDurations[0]));

  stateOrder(splitOrder, splitDurations);
  
  END = stateMgr.addState(new End(stateMgr, 10000));
  
  stateMgr.setState(RAIN);  
  
  //ambient = new SoundFile(this, "sound/ambient.mp3");
  //ambient.loop();
  
  println("Time Intervals: ", Arrays.toString(splitDurations));
  println("Order of Intervals: ", Arrays.toString(splitOrder));
  println("Setup Done! \n");
  
}

void draw() {
  stateMgr.getCurrentState().draw();
  stateMgr.updateStates();
  
  int currentID = stateMgr.getCurrentStateID(); //<>//
  
  if ( currentID == splitDurations.length) {
    stateMgr.setState(END);
  } else if (stateMgr.getTimeInState() > splitDurations[currentID] && currentID < splitDurations.length){ //<>//
    stateMgr.setState(stateMgr.nextStateID(currentID));
  } 
  
  int currentState = (currentID == 0 || currentID >= 4) ? 0 : splitOrder[currentID-1];
    
 //if(osCompatible) {
    switch (currentState) {
        case 0: //grass
         drawSpringPath(flowers);//fl1);
          break;
        case 1: //rain
          drawRainPath(umbrella);
          break;
        case 2: //leaves
          drawPath(muds);
          break;
        case 3: //snow
          drawWinterPath(snows); 
          break;
        case 4: //storm
         drawRainPath(umbrella);
          break;
     }
  //}
  
  
}

void stateOrder(int[] order, int[] durations) {
    for (int i = 0; i < order.length; i++) {
      switch (order[i]) {
        case 1:
          RAIN = stateMgr.addState(new Rain(stateMgr, durations[i+1]));
          break;
        case 2:
          LEAVES = stateMgr.addState(new Leaves(stateMgr, durations[i+1]));
          break;
        case 3:
          SNOW = stateMgr.addState(new Snow(stateMgr, durations[i+1]));
          break;
        case 4: 
          STORM = stateMgr.addState(new Storm(stateMgr, durations[i+1]));
          break;
      }
    }
}

void keyPressed()
{
  switch(key)
  {
  case 'p':
    ShowPath = !ShowPath;
    break;
  case 't':
    ShowTrack = !ShowTrack;
    break;
  case 'f':
    ShowFeet = !ShowFeet;
    break;
  }
}

void loadImages(){
  font = createFont("Arial", 18);
  textFont(font, 18);
  textAlign(CENTER, CENTER);

  initPlayerTracking();
  ShowTrack = true;
  ShowPath = false; // always shows path of players in tracking
  ShowFeet = true; // always shows feet of players in tracking
  //imageMode(CENTER);
  
  // leaves path
  mu0 = loadImage(m0);
  mu1 = loadImage(m1);
  mu2 = loadImage(m2);
  quad = loadImage(quadIm);
  
  mu0.resize(0, screen_cursor);
  mu1.resize(0, screen_cursor);
  mu2.resize(0, screen_cursor);
  
  muds[0] = mu0;
  muds[1] = mu1;
  muds[2] = mu2;
 

  file = new SoundFile(this, soundPath);
  
  
  // rain path
  umbrella = loadImage(rainPath);
  umbrella.resize(0,screen_cursor);
  
  // grass path (flowers)
  fl1 = loadImage(f1);
  fl2 = loadImage(f2);
  fl3 = loadImage(f3);
  fl4 = loadImage(f4);
  fl5 = loadImage(f5);
 
  fl1.resize(0,screen_cursor);
  fl2.resize(0,screen_cursor);
  fl3.resize(0,screen_cursor);
  fl4.resize(0,screen_cursor);
  fl5.resize(0,screen_cursor);
   
  flowers[0] = fl1;
  flowers[1] = fl2;
  flowers[2] = fl3;
  flowers[3] = fl4;
  flowers[4] = fl5;
   
  // winter path
  wi0 = loadImage(w0);
  wi1 = loadImage(w1);
  wi2 = loadImage(w2);
  wi3 = loadImage(w3);
  wi4 = loadImage(w4);
  
  wi0.resize(0,screen_cursor);
  wi1.resize(0,screen_cursor);
  wi2.resize(0,screen_cursor);
  wi3.resize(0,screen_cursor);
  wi4.resize(0,screen_cursor);
  
  snows[0] = wi0;
  snows[1] = wi1;
  snows[2] = wi2;
  snows[3] = wi3;
  snows[4] = wi4;
 
  grass = new SoundFile(this, s6);
 // rain = new SoundFile(this, s7);
  leaf = new SoundFile(this, s8);
  winter = new SoundFile(this, wPath);
}
