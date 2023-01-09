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
int [] d = new int[amountLeaves]; //Size
int [] speedLeaves = new int[amountLeaves]; //Speed
int [] rot = new int[amountLeaves]; //Rotation
int minFSizeLeaves = 2;
int maxFSizeLeaves = 10;


class Leaves extends BaseState {
  
  Leaves() {
    super();
  }
  
  Leaves(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
    
    //Fill Leaves Arrays
    for(int i = 0; i < amountLeaves; i++) { //Creates four arrays with a box for each value
      rot[i] = round(random(0, 360));
      xPosLeaves[i] = random(0, width);
      yPosLeaves[i] = random(0, wallHeight);
      d[i] = round(random(minFSizeLeaves, maxFSizeLeaves));
      speedLeaves[i] = round(random(0, 1));
    }
    
    //Fill Foliage Arrays
    for (int i = 0; i < amountFol; i++){
      xPosFol[i] = random(0, width);
      yPosFol[i] = random(0, wallHeight);
      dFol[i] = round(random(minFSizeFol, maxFSizeFol));
      rotFol[i] = round(random(0, 360));
    }
  }
  
  void draw() {
    clear();
    background(209, 133, 46);
    
    setGradient(0, 0, width, wallHeight, color(223, 193, 158), color(209, 133, 46));
    text((int)frameRate + " FPS", width / 2, 10);
  
    //FALLING LEAVES
    for(int i = 0; i < xPosLeaves.length; i++) {
  
      noFill();
      stroke(255);
      strokeWeight(1);
      rotate(rot[i]);
      quad(xPosLeaves[i], yPosLeaves[i], xPosLeaves[i]+d[i], yPosLeaves[i]+(d[i]*2), xPosLeaves[i], yPosLeaves[i]+(d[i]*3), xPosLeaves[i]-d[i], yPosLeaves[i]+(d[i]*2));
     
      //Creates movement on the x-axis
      if(speedLeaves[i] == 0) {
        xPosLeaves[i] += map(rot[i], minFSizeLeaves, maxFSizeLeaves, .1, .5); 
      } else {
        xPosLeaves[i] -= map(rot[i], minFSizeLeaves, maxFSizeLeaves, .1, .5);
      }
     
      //Keep adding size of flake to speed to create movement in the y-axis
      yPosLeaves[i] += (d[i] + speedLeaves[i])/3;  
      
  
     //Creates endless loop of flakes
      if(xPosLeaves[i] > width + rot[i] || xPos[i] < -rot[i] || yPosLeaves[i] > wallHeight + rot[i]) {
        xPos[i] = random(0, width);
        yPosLeaves[i] = -rot[i];
      }  
    }
    
    //FOLIAGE
    for(int i = 0; i < xPosFol.length; i++) {
      stroke(255);
      noFill();
      rotate(rotFol[i]);
      //Scale leaf
      int m = millis();
      if (m < 1500){
        if(dFol[i]>5){
           dFol[i] -= .2;
        }
      }
      quad(xPosFol[i], yPosFol[i], xPosFol[i]+dFol[i], yPosFol[i]+(dFol[i]*2), xPosFol[i], yPosFol[i]+(dFol[i]*3), xPosFol[i]-dFol[i], yPosFol[i]+(dFol[i]*2));
    }   
    
    
    //I guess thats Leaves?
    //if(osCompatible) drawPath(img2);

  }
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
