
// Version 3.2
// This example uses PharusClient class to access pharus data
// Pharus data is encapsulated into Player objects
// PharusClient provides an event callback mechanism whenever a player is been updated
import processing.sound.*;
import processing.sound.SoundFile;
import java.awt.Point;

PharusClient pc;
float stepDistance = 30; // distance between player steps
int maxPoints = 100;
int pxOffset = -10;
int pyOffset = -5;
float visibility = 1.5;
boolean isFading = true;
boolean audioON = false;


void initPlayerTracking()
{
  pc = new PharusClient(this, wallHeight);
  // age is measured in update cycles, with 25 fps this is 2 seconds
  pc.setMaxAge(50);
  // max distance allowed when jumping between last known position and potential landing position, unit is in pixels relative to window width
  pc.setjumpDistanceMaxTolerance(0.05f);  
}

void drawPlayerTracking()
{
  // reference for hashmap: https://processing.org/reference/HashMap.html
  for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  {
    Player p = playersEntry.getValue();

    // render path of each track
    if (ShowPath)
    {
      if (p.getNumPathPoints() > 1)
      {
        stroke(70, 100, 150, 25.0f);        
        int numPoints = p.getNumPathPoints();
        int maxDrawnPoints = 3000;
        // show the motion path of each track on the floor    
        float startX = p.getPathPointX(numPoints - 1);
        float startY = p.getPathPointY(numPoints - 1);
        for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxDrawnPoints); pointID--) 
        {
          float endX = p.getPathPointX(pointID);
          float endY = p.getPathPointY(pointID);
          line(startX, startY, endX, endY);
          startX = endX;
          startY = endY;
        }
      }
    }

    // render tracks = player
    if (ShowTrack)
    {
      // show each track with the corresponding  id number
      noStroke();
      if (p.isJumping())
      {
        fill(192, 0, 0);
      }
      else
      {
        fill(192, 192, 192);
      }
      ellipse(p.x, p.y, cursor_size, cursor_size);
      fill(0);
      text(p.id /*+ "/" + p.tuioId*/, p.x, p.y);
    }

    // render feet for each track
    if (ShowFeet)
    {
      // show the feet of each track
      stroke(70, 100, 150, 200);
      noFill();
      // paint all the feet that we can find for one character
      for (Foot f : p.feet)
      {
        ellipse(f.x, f.y, cursor_size / 3, cursor_size / 3);
      }
    }
  }
}

void pharusPlayerAdded(Player player)
{
  println("Player " + player.id + " added");
  
  // TODO do something here if needed
}

void pharusPlayerRemoved(Player player)
{
  println("Player " + player.id + " removed");
  
  // TODO do something here if needed  
}


PImage img;
void drawPath(PImage[] image){
  // defines the number of images drawn, when the limit is reached the oldest ones are "deleted"

  for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  {
    Player p = playersEntry.getValue();
    float transparency = 255;
    int numPoints = p.getNumPathPoints();
    int rnd = 0;
    if(numPoints >1){
      float startX = p.getPathPointX(numPoints - 1);
      float startY = p.getPathPointY(numPoints - 1);
      if(numPoints%10==0 && audioON){ 
           leaf.play(); // plays audio file 
          // break;
         }
     for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxPoints); pointID--) 
        {
          float endX = p.getPathPointX(pointID);
          float endY = p.getPathPointY(pointID);
          if (transparency > 0 && isFading) { transparency -=visibility; }
          
          if(pointID%stepDistance==0){
              if(pointID%stepDistance==0){
               rnd = int(random(0, image.length));
               
            }
            if(isFading){
             tint(255, transparency);
            }
             image(image[rnd],startX,startY);

          } 
           startX = endX;
           startY = endY;
           leaf.stop();
    }
    
   }
   
  }
  
    
}

int diameterx = 25;// int(random(15,25));
void drawSpringPath(PImage[] flowers){
  
  int rnd = 4;
  for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  {
    
    Player p = playersEntry.getValue();
    float transparency = 255;
    int numPoints = p.getNumPathPoints();
     
    // render path of each track
  if (p.getNumPathPoints() > 1){
       
        float startX = p.getPathPointX(numPoints - 1);
        float startY = p.getPathPointY(numPoints - 1);
        if(numPoints%10==0 && audioON){ 
         grass.play(); // plays audio file 
        // break;
       }
        
        for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxPoints); pointID--) 
        {
           
          
           float endX = p.getPathPointX(pointID);
           float endY = p.getPathPointY(pointID);
       
          if (transparency > 0 && isFading) { transparency -=visibility; }
         
          if(pointID%stepDistance==0){
            
            if(pointID%stepDistance==0){
              rnd = int(random(0, flowers.length));
               
            }
           
             if(isFading){
               tint(255, transparency);
              }    
             image(flowers[rnd],startX,startY, diameterx, diameterx); 
             
             //print("rnd: " + rnd);
          } 
        
           startX = endX;
           startY = endY;
           grass.stop();

        }
          
    }
     
  }
  
}



void drawRainPath(PImage image){
  
  for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  {
    Player p = playersEntry.getValue();
    int numPoints = p.getNumPathPoints();
    if(numPoints%10==0 && audioON){ 
        // rain.play(); // plays audio file 
        // break;
       }
    image(image, p.x+pxOffset, p.y+pyOffset);
    //rain.stop();
    }
  
}

// winter path

void drawWinterPath(PImage[] snows){
 
 int rnd = 0;
 for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  {
    Player p = playersEntry.getValue();
    float transparency = 255;
    int numPoints = p.getNumPathPoints();
    
    
    if(numPoints >1){
      float startX = p.getPathPointX(numPoints - 1);
      float startY = p.getPathPointY(numPoints - 1);
       if(numPoints%stepDistance==0 && audioON){ 
         winter.play(); // plays audio file 
         //break;
       }
       for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxPoints); pointID--){
            float endX = p.getPathPointX(pointID);
            float endY = p.getPathPointY(pointID);
            if (transparency > 0 && isFading) { transparency -=visibility; }
            if(pointID%stepDistance==0){
              if(pointID%stepDistance==0){
               rnd = int(random(1, snows.length));
               
            }
               if(isFading){
                   tint(255, transparency);
                }
               image(snows[rnd],startX,startY);
               
             // break;
            } 
             startX = endX;
             startY = endY;
             winter.stop();

      }
     
      
     }
   
  }
  
}
