//Foliage Variables
int amountFol = 1000;
float [] xPosFol = new float[amountFol];
float [] yPosFol = new float[amountFol];
float [] dFol = new float[amountFol]; //Size
int [] rotFol = new int[amountFol]; //Rotation
int minFSizeFol = 2;
int maxFSizeFol = 10;

//Leaves Variables
int amountLeaves=500; // number of snowflakes
float [] xPosLeaves = new float[amountLeaves];
float [] yPosLeaves = new float[amountLeaves];
int [] d = new int[amountLeaves]; //Size.-
int [] speedLeaves = new int[amountLeaves]; //Speed
int [] rot = new int[amountLeaves]; //Rotation
int minFSizeLeaves = 2;
int maxFSizeLeaves = 10;


//Floor flakes Variables

int maxLeaves =30000;
int minLeaves=15000;
int[][] leafFloor;

PImage[] leaves = new PImage[amountLeaves];

int alphaLeaves = 255;

class Leaves extends BaseState {
  
  Leaves() {
    super();
  }
   
  Leaves(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
     quad.resize(0,screen_cursor);
    //Fill Leaves Arrays
    for(int i = 0; i < amountLeaves; i++) { //Creates four arrays with a box for each value
      rot[i] = round(random(0, 360));//random(0, 360));
      xPosLeaves[i] = random(0, width);
      yPosLeaves[i] = random(0,wallHeight);
      d[i] = round(random(minFSizeLeaves, maxFSizeLeaves));
      speedLeaves[i] = round(random(0, 1));
    }
    
    //Fill Foliage Arrays
    for (int i = 0; i < amountFol; i++){
      xPosFol[i] = random(0, width);
      yPosFol[i] = random(wallHeight, height);
      dFol[i] = round(random(minFSizeFol, maxFSizeFol));
      rotFol[i] = round(random(0, 360));
    }
    
   
  
    leafFloor = generateLeafFloor(amountFol);
  }
  
  
 void draw() {    
    clear();
     
     
    int nextID = super.stateMgr.getCurrentStateID() >= splitOrder.length ? gradients.length-1 : splitOrder[super.stateMgr.nextStateID(super.stateMgr.getCurrentStateID()) -1]-1;  

    background(209, 133, 46, alphaLeaves);
    


    setGradient(0, 0, width, height/2, color(223, 193, 158,alphaLeaves), color(209, 133, 46, alphaLeaves));
    setGradient(0, 0, width, height/2, color(gradients[nextID][0],255 - alphaLeaves), color(gradients[nextID][1], 255-alphaLeaves));
    
   
    //FALLING LEAVES
    for(int i = 0; i < xPosLeaves.length; i++) {
      noFill();
      stroke(255);
      strokeWeight(1);
      
      push();
        imageMode(CENTER);
        translate(0, -wallHeight/2);
        rotate(radians(rot[i]));

        //quad(xPosLeaves[i], yPosLeaves[i], xPosLeaves[i]+d[i], yPosLeaves[i]+(d[i]*2), xPosLeaves[i], yPosLeaves[i]+(d[i]*3), xPosLeaves[i]-d[i], yPosLeaves[i]+(d[i]*2));
        image(quad,xPosLeaves[i], yPosLeaves[i]);
      pop();
 
      //Creates movement on the x-axis
      if(speedLeaves[i] == 0) {
        xPosLeaves[i] += map(rot[i], minFSizeLeaves, maxFSizeLeaves, .1, .5); 
      } else {
        xPosLeaves[i] -= map(rot[i], minFSizeLeaves, maxFSizeLeaves, .1, .5);
      }
    }
     
    
    int start = super.stateMgr.stateStamp;
    int timeNow = millis();//super.stateMgr.getTimeInState();
    int end = start + duration;
    int leavesAmount = amountFol;

    //last third
    if (timeNow > (duration/3)*2 +start){      
      alphaLeaves= (int) map(timeNow, start + (duration/3)*2, end,255, 0);
    }
    
    if(timeNow < (duration/3)*2+start + 100){
      leavesAmount = (int) map(timeNow, start, end - duration/3, 0, amountLeaves); 
    }
    
    if(leavesAmount > amountLeaves) leavesAmount = amountLeaves-1;
   
    
    for (int i = 0; i<leavesAmount;i++){
        noStroke();
        //fill(255);
        image(quad,leafFloor[i][0],leafFloor[i][1]);
    }
    
    fill(gradients[nextID][1],255 - alphaLeaves);
    rect(0,height/2,width,height);
    
    //if(osCompatible) drawPath(muds);
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
  
  public int[][] generateLeafFloor(int n) {
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
