import processing.video.*;
import processing.sound.*;
PImage frame;
Capture reflection;
SoundFile song;
boolean playing = false;


void setup(){
  size (1365, 910); 
  frame = loadImage("pexels-photo-205317.png");
  reflection = new Capture(this, 640,480);
  reflection.start();
  song = new SoundFile(this, "fairydust.wav");

}

/*void captureEvent(Capture reflection){
 reflection.read(); 
}*/
  void mousePressed(){
  reflection.read();
     song.play();
     song.rate(.85);
  }

 void draw() {
   
   image(frame, 0, 0, width, height);
   tint (100, 20);
   image(reflection, 475, 120, 425, 575);
 //  fill(0);
  // text(mouseX+","+mouseY, mouseX, mouseY); 
 }