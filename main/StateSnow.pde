//Snow Variables
int amountSnow=1000; // number of snowflakes
float [] xPos = new float[amountSnow];
float [] yPos = new float[amountSnow];
int [] speed = new int[amountSnow]; //Speed
int [] fSize = new int[amountSnow]; //Flake Size
int minFSize = 3;
int maxFSize = 6;

//Floor flakes Variables
int amountFlakes=10000; // number of flakes
int maxFlakes =30000;
int minFlakes=15000;
int[][] snowFloor;

class Snow extends BaseState {
  
  Snow() {
    super();
  }
  
  Snow(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
    
    //Fill Snow Arrays
    for(int i = 0; i < amountSnow; i++) { //Creates four arrays with a box for each value
      fSize[i] = round(random(minFSize, maxFSize));
      xPos[i] = random(0, width);
      yPos[i] = random(0, wallHeight);
      speed[i] = round(random(0, 1));
    }
  
    snowFloor = generateSnowFloor(amountFlakes);
  }
  
  void draw() {    
    clear();
    background(118, 144, 172);
    
    setGradient(0, 0, width, wallHeight, color(223, 239, 246), color(118, 144, 172));
   
    text((int)frameRate + " FPS", width / 2, 10);
  
    //FALLING SNOW
    for(int i = 0; i < xPos.length; i++) {
  
      fill(255,255,255);
      noStroke();
      ellipse(xPos[i], yPos[i], fSize[i], fSize[i]); //Create flake with values from the four arrays
     
      //Creates movement on the x-axis
      if(speed[i] == 0) {
        xPos[i] += map(fSize[i], minFSize, maxFSize, .1, .5); 
      } else {
        xPos[i] -= map(fSize[i], minFSize, maxFSize, .1, .5);
      }
     
      //Keep adding size of flae to speed to create movement in the y-axis
      yPos[i] += fSize[i]/5 + speed[i]; 
      
  
     //Creates endless loop of flakes
      if(xPos[i] > width + fSize[i] || xPos[i] < -fSize[i] || yPos[i] > wallHeight + fSize[i]) {
        xPos[i] = random(0, width);
        yPos[i] = -fSize[i];
      }  
    } 
    
    int timeNow = super.stateMgr.getTimeInState();
    int start = super.stateMgr.stateStamp;
    int end = start + duration;
    int drawAmount;
    
    //Draw floor Snow with increasing time by mapping it to the duration
    if(timeNow < duration/2){
      drawAmount = (int) map(timeNow, start, end, 0, amountFlakes);  
    } else {
      drawAmount = amountFlakes;
      int alpha = (int)map(timeNow,start + int(duration/2), end, 0,255);
      fill(255,alpha);
      rect(0, wallHeight, width, windowHeight);
    } 
    
    for (int i = 0; i<drawAmount;i++){
        noStroke();
        fill(255);
        ellipse(snowFloor[i][0], snowFloor[i][1],5,5);
    }
    
    if(osCompatible) drawWinterPath(w1);
  } 
  
  void setGradient(int x, int y, float w, float h, color c1, color c2) {  
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      strokeWeight(2);
      stroke(c);
      line(x, i, x+w, i);
    }
  }
  
  public int[][] generateSnowFloor(int n) {
    Random random = new Random();
    int[][] coordinates = new int[n][2];
    for (int i = 0; i < n; i++) {
        int x = random.nextInt(width);
        int y = random.nextInt(wallHeight,height);
        coordinates[i] = new int[] {x, y};
    }
    return coordinates;
  }
  
}
