// rain path graphic
PImage umbrella;
String rainPath = "images/rain/Umbrella.png";


// Grass flower graphics
String f1 = "images/flowers/flower0.png";
String f2 = "images/flowers/flower1.png";
String f3 = "images/flowers/flower2.png";
String f4 = "images/flowers/flower3.png";
String f5 = "images/flowers/flower4.png";

PImage fl1;
PImage fl2;
PImage fl3;
PImage fl4;
PImage fl5;


//winter path graphics
String w0 = "images/snow/Snowball.png";
String w1 = "images/snow/Snowflake0.png";
String w2 = "images/snow/Snowflake1.png";
String w3 = "images/snow/Snowflake2.png";
String w4 = "images/snow/Snowflake3.png";

PImage wi0;
PImage wi1;
PImage wi2;
PImage wi3;
PImage wi4;


// leaf path graphics
String m0 = "images/mud/Mud0.png";
String m1 = "images/mud/Mud1.png";
String m2 = "images/mud/Mud2.png";
String quadIm = "images/quad3.png";

PImage mu0;
PImage mu1;
PImage mu2;
PImage quad;

SoundFile grass;
SoundFile rain;
SoundFile leaf;

SoundFile winter;
String wPath = "sound/snowCrunch_single.mp3";

int screen_cursor = 30;

SoundFile file; // leaves
String soundPath = "sound/leaves_crunching.mp3";//"sound/rain_drops_little_thunder.mp3";

String s1 = "sound/snowCrunch_single.mp3";
String s2 = "sound/grass_walking.wav";
String s3 = "sound/leaves_crunching.mp3";
String s4 = "sound/rain_drops_little_thunder.mp3";
String s5= "sound/rain_thunder.mp3";


color[][] gradients = {
     {color(122, 172, 172), color(0, 65, 75)},//rain
     {color(223, 193, 158), color(209, 133, 46)},//leaf
     {color(223, 239, 246), color(118, 144, 172)},//snow
     {color(100), color(40)},//storm
     {color(10), color(0)}
};
String s6 = "sound/grass_step.wav";
String s7 = "sound/puddle_step.mp3";
String s8 = "sound/leaf_step.wav";
