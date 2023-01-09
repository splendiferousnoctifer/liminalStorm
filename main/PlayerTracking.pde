
// Version 3.2
// This example uses PharusClient class to access pharus data
// Pharus data is encapsulated into Player objects
// PharusClient provides an event callback mechanism whenever a player is been updated
import processing.sound.*;
import processing.sound.SoundFile;
import java.awt.Point;

PharusClient pc;
float stepDistance = 3; // distance between player steps

float lastTime = 0;
float delta = 0;
float timeInMs = 12; // small delay to let the sound play



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

// added for liminal storm
// takes path to image as an argument for drawing footprints
void drawFootprints(PImage img, PImage singlePrint) 
{
  
  int maxPoints = 30; //TODO adapt dynamically to number of players
  
  // reference for hashmap: https://processing.org/reference/HashMap.html
  for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  { 
    Player p = playersEntry.getValue();
    
      // show the feet of each track
        if (p.getNumPathPoints() > 1) {
          int numPoints = p.getNumPathPoints();
           
          float startX = p.getPathPointX(numPoints - 1);
          float startY = p.getPathPointY(numPoints - 1);
          
          /*file.play();
          file.stop();
          file.play();
          file.stop();*/
          for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxPoints); pointID--) 
          {
            float endX = p.getPathPointX(pointID);
            float endY = p.getPathPointY(pointID);
            if(dist(startX,startY,endX,endY)>stepDistance){
              for (Foot f : p.feet) {
                translate(endX,endY);
                float a = atan2(endY-startY,endX-startX) + radians(90);
                rotate(a);
                //file.play();
                //file.stop();
                //image(img, f.x, f.y); // TODO: load individual footsteps image
                //rect(f.x, f.y, cursor_size / 3, cursor_size / 3);
                image(img, startX, startY); // both footprints
            }
            startX = endX;
            startY = endY;
          }
          
        
        }
      }
  }
}



void drawPath(PImage image){
  // defines the number of images drawn, when the limit is reached the oldest ones are "deleted"
  int maxPoints = 100; // change accordingly
  //imageMode(CENTER);
  
  for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  {
    Player p = playersEntry.getValue();
    delta = millis()- lastTime;
    // render path of each track
    
    if (p.getNumPathPoints() > 1)
      {
        stroke(70, 100, 150, 25.0f);        
        int numPoints = p.getNumPathPoints();
        
        // show the motion path of each track on the floor    
        float startX = p.getPathPointX(numPoints - 1);
        float startY = p.getPathPointY(numPoints - 1);
         
        file.stop();
       
        for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxPoints); pointID--) 
        {
            float endX = p.getPathPointX(pointID);
            float endY = p.getPathPointY(pointID);
          if(dist(startX,startY,endX,endY)>stepDistance){
        
           
            if(delta == timeInMs){
              file.loop(); // Loops over audio file
              break;
            }
           
            float a = atan2(endY-startY,endX-startX); //+ radians(90);
            image(image, startX, startY);
           // translate(endX,endY); // TRANSLATION ISSUE
             //rotate(a);
            //image(image, startX, startY);
            //image(image, startX, startY);
            //file.stop();
            //print("a:" + a + " ");
            
            // play snow crunch sound here
             //line(startX, startY, endX, endY);
          }
          startX = endX;
          startY = endY;
          
          
          //fill(0);
         // file.play();
        
          
        }
      }
      lastTime = millis();
   }
   
  
}

int diameterx =  int(random(15,25));

void drawSpringPath(PImage image){
  // defines the number of images drawn, when the limit is reached the oldest ones are "deleted"
  int maxPoints = 100; // change accordingly
  
  for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  {
    Player p = playersEntry.getValue();
    delta = millis()- lastTime;
    // render path of each track
    
    if (p.getNumPathPoints() > 1)
      {
        stroke(70, 100, 150, 25.0f);        
        int numPoints = p.getNumPathPoints();
        
        // show the motion path of each track on the floor    
        float startX = p.getPathPointX(numPoints - 1);
        float startY = p.getPathPointY(numPoints - 1);
         
        //file.stop();
        
       
        for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxPoints); pointID--) 
        {
            float endX = p.getPathPointX(pointID);
            float endY = p.getPathPointY(pointID);
          if(dist(startX,startY,endX,endY)>stepDistance){
            int index = int(random(0,flowers.length));
            if(delta == timeInMs){
             // file.loop(); // Loops over audio file
              break;
            }
           
              
              //scale(random(0.2,0.8));
            
              image(image,startX,startY, diameterx, diameterx);      
            
            
                     
          }
            startX = endX;
            startY = endY;
        }
      }
      lastTime = millis();
   }
   
  
}





void drawRainPath(PImage image){

  // defines the number of images drawn, when the limit is reached the oldest ones are "deleted"
  int maxPoints = 100; // change accordingly
  //imageMode(CENTER);
  
  for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  {
    Player p = playersEntry.getValue();
    delta = millis()- lastTime;
    // render path of each track
    
    if (p.getNumPathPoints() > 1)
      {
        stroke(70, 100, 150, 25.0f);        
        int numPoints = p.getNumPathPoints();
        
        // show the motion path of each track on the floor    
        float startX = p.getPathPointX(numPoints - 1);
        float startY = p.getPathPointY(numPoints - 1);
         
        file.stop();
       
        for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxPoints); pointID--) 
        {
            float endX = p.getPathPointX(pointID);
            float endY = p.getPathPointY(pointID);
          if(dist(startX,startY,endX,endY)>stepDistance){
        
           
            if(delta == timeInMs){
              file.loop(); // Loops over audio file
              break;
            }
           
            float a = atan2(endY-startY,endX-startX); //+ radians(90);
            image(image, startX, startY);
           // translate(endX,endY); // TRANSLATION ISSUE
             //rotate(a);
            //image(image, startX, startY);
            //image(image, startX, startY);
            //file.stop();
            //print("a:" + a + " ");
            
            // play snow crunch sound here
             //line(startX, startY, endX, endY);
          }
          startX = endX;
          startY = endY;
          
          
          //fill(0);
         // file.play();
        
          
        }
      }
      lastTime = millis();
   }
  
}

// winter path

void drawWinterPath(PImage image){
  // defines the number of images drawn, when the limit is reached the oldest ones are "deleted"
  int maxPoints = 100; // change accordingly
  //imageMode(CENTER);
  
  for (HashMap.Entry<Long, Player> playersEntry : pc.players.entrySet()) 
  {
    Player p = playersEntry.getValue();
    delta = millis()- lastTime;
    // render path of each track
    
    if (p.getNumPathPoints() > 1)
      {
        stroke(70, 100, 150, 25.0f);        
        int numPoints = p.getNumPathPoints();
        
        // show the motion path of each track on the floor    
        float startX = p.getPathPointX(numPoints - 1);
        float startY = p.getPathPointY(numPoints - 1);
         
        winter.stop();
       
        for (int pointID = numPoints - 2; pointID > max(0, numPoints - maxPoints); pointID--) 
        {
            float endX = p.getPathPointX(pointID);
            float endY = p.getPathPointY(pointID);
          if(dist(startX,startY,endX,endY)>stepDistance){
        
           
            if(delta == timeInMs){
              //winter.loop(); // Loops over audio file
            // print("delta: " + delta);
              break;
            }
           
            float a = atan2(endY-startY,endX-startX); //+ radians(90);
            //scale(0.02);
           // image(image, startX, startY);
            //translate(endX,endY); // TRANSLATION ISSUE
            //rotate(a);
            //scale(0.02);
            image(image, startX, startY);
            //image(image, startX, startY);
            //image(image, startX, startY);
            //file.stop();
            //print("a:" + a + " ");
            
            // play snow crunch sound here
             //line(startX, startY, endX, endY);
          }
          startX = endX;
          startY = endY;
          
          
          //fill(0);
         // file.play();
        
          
        }
      }
      lastTime = millis();
   }
   
  
}
