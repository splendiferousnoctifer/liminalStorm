import processing.core.PVector;

float yIncrement = 0.05;
int scl = 20;
float zoff = 0;

int cols = floor(windowWidth / scl) + 1;
int rowsWall = round(wallHeight/3 / scl) + 1;
int rowsFloor = round(wallHeight/scl) + 1;
int[][] displace = new int[rowsFloor][cols];


// array with file paths
String[] audioFiles = {s1, s2, s3, s4, s5};

int interval;
int alpha = 255;


class Grass extends BaseState {
  
  Grass() {
    super();
  }
  
  Grass(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
    interval = duration / audioFiles.length;
    
    for (int i = 0; i < rowsFloor; i++) {
        for (int j = 0; j < cols; j++) {
            displace[i][j] = (int) random(scl);
        }
    }
  }
  
  void draw() {
    clear();
    int nextID = super.stateMgr.getCurrentStateID() >= splitOrder.length ? gradients.length-1 : splitOrder[super.stateMgr.nextStateID(super.stateMgr.getCurrentStateID()) -1]-1;  

    background(73, 106, 45);
    fill(gradients[nextID][1],255 - alpha);
    rect(0,height/2,width,height);
    
    

    //setGradient(0, 0, width, height/2, color(177, 213, 174, alpha), color(73, 106, 45,alpha));
    //setGradient(0, 0, width, height/2, color(gradients[nextID][0],255 - alpha), color(gradients[nextID][1], 255-alpha));

    
    grassFloor();
    
    fill(0, 255/4);
    rect(0,0,width,height);
    
    fill(255);
    textSize(40);
    text("What is liminalSeasons?", width/2, height/4);
    //grassWall();
    
    //text((int)frameRate + " FPS", width / 2, 100);


    //if(osCompatible) drawSpringPath(fl1);

  } 
  
  
  
  void grassFloor(){
    
    int start = super.stateMgr.stateStamp;
    int timeNow = millis();//super.stateMgr.getTimeInState();
    int end = start + duration;
    int lenGrass;
    
    //Draw floor Snow with increasing time by mapping it to the duration
    if(timeNow < duration/3+start){
      lenGrass = (int) map(timeNow, start, end - (duration/3)*2, -5, scl+15); 
    } else if (timeNow > (duration/3)*2 +start){
      lenGrass = (int) map(timeNow, start + (duration/3)*2, end,scl+15, -0);
      alpha = (int) map(timeNow, start + (duration/3)*2, end,255, 0);
    } else {
      lenGrass = (int) scl+10;
    }
    
    float yoff = 0;
    for (int i = 0; i < rowsFloor; i++){
      float xoff = 0;
      for (int j = 0; j < cols; j++){
        float angle = noise(xoff, yoff, zoff) * TWO_PI;
        xoff += yIncrement;
        PVector vector = PVector.fromAngle(angle);
        vector.setMag(1);
  
        fill(255);
        noStroke();
        push();
          translate(j * scl + displace[i][j], i * scl + displace[i][j]);
          rotate(vector.heading());
          quad(0,0,0,1,lenGrass,lenGrass,1,0);
        pop();
      }
      yoff += yIncrement;
      zoff += 0.00025;
    }
  }
  
  void grassWall(){
    float yoff = 0;
    for (int y = 0; y < rowsWall; y++){
      float xoff = 0;
      for (int x = 0; x < cols; x++){
        float angle = noise(xoff, yoff, zoff) * -PI;
        xoff += yIncrement;
        PVector vector = PVector.fromAngle(angle);
        vector.setMag(1);
        
  
        fill(255);
        noStroke();
        push();
          translate(x * scl, y * scl/1.5 + 2.3 * wallThird);
          rotate(vector.heading());
          quad(0,0,0,1,scl+10,scl+10,1,0);
        pop();
      }
      yoff += yIncrement;
      zoff += 0.25;
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
  
  
  
}
