float maxDTheta = PI/10;
float minDTheta = PI/20;
float maxTheta = PI/2;
float childGenOdds = .01;

float minBoltWidth = 3;
float maxBoltWidth = 10;

float minJumpLength = 1;
float maxJumpLength = 10;

boolean stormMode = true;
boolean fadeStrikes = true;
boolean randomColors = false;
float maxTimeBetweenStrikes = 3000;

color boltColor;
color skyColor;

lightningBolt bolt;
float lastStrike = 0;
float nextStrikeInNms = 0;

//distance, in milliseconds, of the storm.
float meanDistance = 0;
//if the current time matches the time in this arraylist, it should fire!
ArrayList thunderTimes = new ArrayList();

stormDrop[] stormDrops= new stormDrop[maxDrops];

int alphaStorm = 255;

class Storm extends BaseState {
  
  Storm() {
    super();
  }
  
  Storm(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
    
    //Fill stormDrop Array
    for (int i = 0; i < maxDrops; i++){
      stormDrops[i] = new stormDrop(int(random(width)),-int(random(wallHeight)),(int)random(wallHeight), 1280/2); 
  
    }
    
    //Fill Puddle Array
    for (int i = 0; i < maxPuddles; i++){
      puddles[i] = new Puddle(int(random(width)),-int(random(wallHeight,height)),int(random(wallHeight+50,height)),1280); 
    }
    
    
    //THUNDER
    meanDistance = 1000*.5;
    
    boltColor = color(255);
    skyColor = color(0,0,10,20);
  
    bolt = new lightningBolt(random(0,windowWidth),0,random(minBoltWidth,maxBoltWidth),0,minJumpLength,maxJumpLength,boltColor);
  }
  
  void draw() {
    clear();    
    int nextID = splitOrder[super.stateMgr.nextStateID(super.stateMgr.getCurrentStateID()) -1]-1;  
    
    background(40, alphaStorm);
    fill(gradients[nextID][1],255 - alphaStorm);
    rect(0,height/2,width,height);

    setGradient(0, 0, width, height/2, color(100, alphaStorm), color(40, alphaStorm));
    setGradient(0, 0, width, height/2, color(gradients[nextID][0],255 - alphaStorm), color(gradients[nextID][1], 255-alphaStorm));
        
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
      
      alphaStorm = (int) map(timeNow, start + (duration/3)*2, end,255, 0);
    } else {
      drawAmountDrops = amountDrops;  
      drawAmountPuddles = amountPuddles;
    }
    
  
    for (int i=0;i<drawAmountDrops;i++){
      stormDrops[i].fall();
    }
    
    for (int i=0;i<drawAmountPuddles;i++){
      puddles[i].grow();
    }
  
    //THUNDER
    if(stormMode && millis()-lastStrike>nextStrikeInNms){//time for a new bolt?
      lastStrike = millis();
      nextStrikeInNms = random(0,maxTimeBetweenStrikes);
      
      bolt = new lightningBolt(random(0,windowWidth),0,random(minBoltWidth,maxBoltWidth),0,minJumpLength,maxJumpLength,boltColor);
      bolt.draw();
      //if(playThunder)
      //  thunderTimes.add(bolt.getThunderTime());
    }
    else{
      if(fadeStrikes){
        noStroke();
        fill(skyColor);
        rect(0,0,width,height);
        noFill();
      }
    }
  }  
  
}


int randomSign() //returns +1 or -1
{
  float num = random(-1,1);
  if(num==0)
    return -1;
  else
    return (int)(num/abs(num));
}

color randomColor(){
  return color(random(0,100),99,99);
}

color slightlyRandomColor(color inputCol,float length){
  float h = hue(inputCol);
  h = (h+random(-length,length))%100;
  return color(h,99,99);
}

//CLASS DROP
class stormDrop{
  int x,y,d,z,onde,d1,oldY,oldX;
  float acc;
  boolean s;

  stormDrop(int x,int y, int z, int d){
    this.x=x;
    this.y=y;
    this.d=d;
    this.z=z;
    onde=0;
    d1=d;
    acc=0;
    oldY=y;
    oldX=x;
  }

  void fall(){ //Rain fall
    if(y>0)acc+=0.2;
    stroke(255,255,255,map(z,0,height,0,255));
    strokeWeight(2);
    if (y<z){
      y=int(y+5+acc);
      x=int(x+(acc/2));
      line(x*1.2-200,oldY,x*1.2-200,y);
      oldY=y;
      oldX=x;
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


//CLASS LIGHTNING BOLT
class lightningBolt{
  float lineWidth0,theta,x0,y0,x1,y1,x2,y2,straightJump,straightJumpMax,straightJumpMin,lineWidth;
  color myColor;
  lightningBolt(float x0I, float y0I, float width0, float theta0, float jumpMin, float jumpMax, color inputColor){

    lineWidth0 = width0;
    lineWidth = width0;
    theta = theta0;
    x0 = x0I;
    y0 = y0I;
    x1 = x0I;
    y1 = y0I;
    x2 = x0I;
    y2 = y0I;
    straightJumpMin = jumpMin;
    straightJumpMax = jumpMax;
    myColor = inputColor;
    //it's a wandering line that goes straight for a while,
    //then does a jagged jump (large dTheta), repeats.
    //it does not aim higher than thetaMax
    //(where theta= 0 is down)
    straightJump = random(straightJumpMin,straightJumpMax);
  }

  //tells when the thunder should sound.
  float getThunderTime(){
    return (millis()+meanDistance*(1+random(-.1,.1)));
  }

  void draw()
  {
    while(y2<wallHeight && (x2>0 && x2<width))
    {
      strokeWeight(1);
      
      theta += randomSign()*random(minDTheta, maxDTheta);
      if(theta>maxTheta)
        theta = maxTheta;
      if(theta<-maxTheta)
        theta = -maxTheta;
        
      straightJump = random(straightJumpMin,straightJumpMax);
      x2 = x1-straightJump*cos(theta-HALF_PI);
      y2 = y1-straightJump*sin(theta-HALF_PI);
      
      if(randomColors)
        myColor = slightlyRandomColor(myColor,straightJump);
      
      lineWidth = map(y2, wallHeight,y0, 1,lineWidth0);
      if(lineWidth<0)
        lineWidth = 0;
      stroke(myColor);
      strokeWeight(lineWidth);
      line(x1,y1,x2,y2);
      x1=x2;
      y1=y2;
      
      //think about making a fork
      if(random(0,1)<childGenOdds){//if yes, have a baby!
        float newTheta = theta;
        newTheta += randomSign()*random(minDTheta, maxDTheta);
        if(theta>maxTheta)
          theta = maxTheta;
        if(theta<-maxTheta)
          theta = -maxTheta;
//        nForks++;
        (new lightningBolt(x2, y2, lineWidth, newTheta, straightJumpMin, straightJumpMax,boltColor)).draw();
        //it draws the whole limb before continuing.
      }
    }
  }
}
