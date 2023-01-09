import processing.core.PVector;

float yIncrement = 0.02;
float zIncrement = 0.00025;
float scl = 20;
float zoff = 0;

int cols = floor(windowWidth / scl) + 1;
int rowsWall = round(wallHeight/3 / scl) + 1;
int rowsFloor = round(wallHeight/scl) + 1;

// array with file paths
String[] audioFiles = {s1, s2, s3, s4, s5};

int interval;

class Grass extends BaseState {
  
  Grass() {
    super();
  }
  
  Grass(StateMgr _stateMgr, int _duration) {
    super(_stateMgr, _duration); 
    interval = duration / audioFiles.length;
  }
  
  void draw() {
    clear();
    background(73, 106, 45);

    setGradient(0, 0, width, height/2, color(177, 213, 174), color(73, 106, 45));
    
    grassFloor();
    grassWall();
    
    text((int)frameRate + " FPS", width / 2, 100);


    //if(osCompatible) drawSpringPath(fl1);

  } 
  
  
  
  void grassFloor(){
    float yoff = 0;
    for (int y = 0; y < rowsFloor; y++){
      float xoff = 0;
      for (int x = 0; x < cols; x++){
        float angle = noise(xoff, yoff, zoff) * TWO_PI;
        xoff += yIncrement;
        PVector vector = PVector.fromAngle(angle);
        vector.setMag(1);
  
        fill(255);
        noStroke();
        push();
          translate(x * scl, y * scl + wallHeight);
          rotate(vector.heading());
          quad(0,0,0,1,scl+10,scl+10,1,0);
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
      zoff += 0.00025;
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
