int amountIntervals = 4; //minimum 3

//Drops Variables
int amountDrops=750; // number of drops
int maxDrops =1000;
int minDrops=100;
Drop[] drops=new Drop[maxDrops];

//Puddles Variables
int amountPuddles=150; // number of drops
int maxPuddles =300;
int minPuddles=10;
Puddle[] puddles=new Puddle[maxPuddles];

int alphaRain = 255;


class Rain extends BaseState{
  
  Rain() {
    super();
  }
  
  //Constructor
  Rain(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
    duration = _duration;
      
    //Fill Drop Array
    for (int i = 0; i < maxDrops; i++){
      //drops[i] = new Drop(int(random(width)),-int(random(wallHeight)),(int)map((hFloor+int(random(wallThird))),wallHeight*.75,wallHeight,0,wallHeight),1280); 
      drops[i] = new Drop(int(random(width)),-int(random(wallHeight)),(int)random(wallHeight), 1280/2); 
    }
  
    //Fill Puddle Array
    for (int i = 0; i < maxPuddles; i++){
      puddles[i] = new Puddle(int(random(width)),-int(random(wallHeight,height)),int(random(wallHeight+50,height)),1280); 
    }
  }
  
  void draw() {
    clear();
    amountDrops=750;
    
    int nextID = super.stateMgr.getCurrentStateID() >= splitOrder.length ? gradients.length-1 : splitOrder[super.stateMgr.nextStateID(super.stateMgr.getCurrentStateID()) -1]-1;  

    background(0, 65, 75);
    fill(gradients[nextID][1],255 - alphaRain);
    rect(0,height/2,width,height);
    
    setGradient(0, 0, width, height/2, color(122, 172, 172,alphaRain), color(0, 65, 75,alphaRain));
    setGradient(0, 0, width, height/2, color(gradients[nextID][0],255 - alphaRain), color(gradients[nextID][1], 255-alphaRain));

  
    text((int)frameRate + " FPS", width / 2, 10);

  
    //Draw floor Rain with increasing time by mapping it to the duration
    int start = super.stateMgr.stateStamp;
    int timeNow = millis();//super.stateMgr.getTimeInState();
    int end = start + duration;
    int drawAmountDrops,drawAmountPuddles;
        
    if(timeNow < duration/3+start){
      drawAmountDrops = (int) map(timeNow, start, end - (duration/3)*2, 0, amountDrops);  
      drawAmountPuddles = (int) map(timeNow, start, end - (duration/3)*2, 0, amountPuddles);      
    } else if (timeNow > (duration/3)*2 +start){
      drawAmountDrops = (int) map(timeNow, start + (duration/3)*2, end, amountDrops/2, 0);  
      drawAmountPuddles = (int) map(timeNow, start + (duration/3)*2, end, amountPuddles/2, 0);
      
      alphaRain = (int) map(timeNow, start + (duration/3)*2, end,255, 0);
    } else {
      drawAmountDrops = amountDrops;  
      drawAmountPuddles = amountPuddles;
    }
          
    for (int i = 0; i<drawAmountDrops;i++){
      drops[i].fall();
    }
    
    for (int i=0;i<drawAmountPuddles;i++){
      puddles[i].grow();
    }
    

    
    //if(osCompatible) drawRainPath(img3);
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
}



//CLASS DROP
class Drop{
  int x,y,d,z,onde,d1,oldY;
  float acc;
  boolean s;

  Drop(int x,int y, int z, int d){
    this.x=x;
    this.y=y;
    this.d=d;
    this.z=z;
    onde=0;
    d1=d;
    acc=0;
    oldY=y;
  }

  void fall(){ //Rain fall
    if(y>0)acc+=0.2;
    stroke(200,200,200,map(z,0,height,0,255));
    strokeWeight(2);
    if (y<z){
      y=int(y+4+acc);
      line(x,oldY,x,y);
      oldY=y;
    }
    
    else{ //Floor extension
      noFill();
      stroke(175,175,175,255-map(onde,0,d,0,255));
      strokeWeight(map(onde,0,d,0,4));
      d=d1+(y-wallHeight)*4;
      //ellipse(x,y,onde/10,onde/40);
      onde=onde+7;
      if(onde>d){
        onde=0;
        acc=0;
        x=int(random(width));
        y=-int(random(wallHeight*2));
        oldY=y;
        d=d1;
      }
    }
  }
}

// CLASS PUDDLE
class Puddle{
  int x,y,d,z,rain,d1;
  float acc;
  boolean s;

  Puddle(int x,int y, int z, int d){
    this.x=x;
    this.y=y;
    this.d=d;
    this.z=z;
    rain=0;
    d1=d;
    acc=0;
  }

  void grow(){
    if(y>0)acc+=0.2;
    strokeWeight(0);
    if (y<z){
      y=int(y+14);
      line(x,y,x,y);
    }
    else{
      noFill();
      stroke(255);
      strokeWeight(1);
      d=d1+(y-height);
      ellipse(x,y,rain/10,rain/10);
      rain=rain+7;
      if(rain>d){
        rain=0;
        acc=0;
        x=int(random(width));
        y=-int(random(height*2));
        d=d1;
      }
    }
  }
}
