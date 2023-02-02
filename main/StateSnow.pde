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

float inc = 0;
int alphaSnow = 255;


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
    int nextID = super.stateMgr.getCurrentStateID() >= splitOrder.length ? gradients.length-1 : splitOrder[super.stateMgr.nextStateID(super.stateMgr.getCurrentStateID()) -1]-1;  
    
    background(118, 144, 172);
    fill(gradients[nextID][1],255 - alphaSnow);
    rect(0,height/2,width,height);

    setGradient(0, 0, width, height/2, color(223, 239, 246), color(118, 144, 172));
    setGradient(0, 0, width, height/2, color(gradients[nextID][0],255 - alphaSnow), color(gradients[nextID][1], 255-alphaSnow));
    
   
    //text((int)frameRate + " FPS", width / 2, 10);
    
    int start = super.stateMgr.stateStamp;
    int timeNow = millis();//super.stateMgr.getTimeInState();
    int end = start + duration;
    int drawAmount, drawAmountSnow;
    
    if(timeNow < duration/3+start){
      drawAmount = (int) map(timeNow, start, end - (duration/3)*2, 0, amountFlakes); 
      drawAmountSnow = (int) map(timeNow, start, end - (duration/3)*2, 0, xPos.length); 
    } else if(timeNow > (duration/3)*2 +start) {
      drawAmount = amountFlakes;
      drawAmountSnow = (int) map(timeNow, start + (duration/3)*2, end, xPos.length/2, 0);
      
      alphaSnow = (int) map(timeNow, start + (duration/4)*3, end,255, 0);
    }else {
      drawAmount = amountFlakes;
      drawAmountSnow = xPos.length;
      inc += 0.1;
    }
    
    

    
    
    if(drawAmount > amountFlakes) drawAmount = amountFlakes-1;
    
    for (int i = 0; i<drawAmount;i++){
        noStroke();
        fill(255, alphaSnow);
        ellipse(snowFloor[i][0], snowFloor[i][1],5+inc,5+inc);
    }
    
    
    //FALLING SNOW
    for(int i = 0; i < drawAmountSnow; i++) {
  
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
    
    //if(osCompatible) drawWinterPath(w1);
    
    fill(0, 255/4);
    rect(0,0,width,height);
    
    fill(255);
    textSize(40);
    text("What was your part in the project?", width/2, height/4);

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
