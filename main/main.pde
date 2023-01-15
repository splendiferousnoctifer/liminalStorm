import processing.sound.*;

boolean debug = true;
boolean osCompatible;
String operatingSystem = System.getProperty("os.name");

SoundFile ambient;

float cursor_size = 25;
PFont font;

public int scaleFactor = 4;
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
    splitDurations = new int[] {300,300,30000,300, 300};
    splitOrder = new int[] {1,2,3,4};
  } else {
    splitDurations = timeSplit.splitInterval();
    splitOrder = timeSplit.assignNumbers(splitDurations);
  }
  
  
  GRASS = stateMgr.addState(new Grass(stateMgr, splitDurations[0]));

  stateOrder(splitOrder, splitDurations);
  
  END = stateMgr.addState(new End(stateMgr, 10000));
  
  stateMgr.setState(GRASS);  
  
  //ambient = new SoundFile(this, "sound/ambient.mp3");
  //ambient.loop();
  
  println("Time Intervals: ", Arrays.toString(splitDurations));
  println("Order of Intervals: ", Arrays.toString(splitOrder));
  println("Setup Done! \n");
  
}

void draw() {
  stateMgr.getCurrentState().draw();
  stateMgr.updateStates();
  
  int currentID = stateMgr.getCurrentStateID();
  
  if ( currentID == splitDurations.length) {
    stateMgr.setState(END);
  } else if (stateMgr.getTimeInState() > splitDurations[currentID] && currentID < splitDurations.length){ //<>//
    stateMgr.setState(stateMgr.nextStateID(currentID));
  } 
  
  int currentState = (currentID == 0 || currentID >= 4) ? 0 : splitOrder[currentID-1];
    
 //if(osCompatible) {
    switch (currentState) {
        case 0: //grass
          drawSpringPath(fl1);
          break;
        case 1: //rain
          drawRainPath(umbrella);
          break;
        case 2: //leaves
          drawPath(mu0);
          break;
        case 3: //snow
         drawWinterPath(wi3); 
          break;
        case 4: //storm
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
  
  mu0 = loadImage(m0);
  mu0.resize(0, screen_cursor);
  
  // rain path
  umbrella = loadImage(rainPath);
  umbrella.resize(0,screen_cursor);
  
  // grass path (flowers)
  fl1 = loadImage(f1);
  file = new SoundFile(this, soundPath);
  
  // winter path
  wi3 = loadImage(w3);
  wi3.resize(0,screen_cursor);
  winter = new SoundFile(this, wPath);
}
