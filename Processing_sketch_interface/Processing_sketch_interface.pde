import netP5.*;
import oscP5.*;

float a = 1;
float r1 = 1;
float r2 = 1;
float r3 = 1;
float r4 = 1;
float r5 = 1;
float r6 = 1;
int HR;
int Spo2;
int BP;
float sliderX1;
float sliderY1;
int sliderSize = 30;

float amps;
OscP5 osc1;
OscP5 values;

PImage bg;

void setup(){
 size(1440, 900);
 background(0);
 bg = loadImage("Dashboard login.png");
 
 //initialising OSC bridges from Max/MSP
 oscar = new OscP5(this, 6003);
 values = new OscP5(this, 6004);
 
 //listen to OSC message containing sound levels per parameter. arguments are: this, function to run, path.
 osc1.plug(this, "setAmps", "/HR");
 osc1.plug(this, "setAmps2", "/spo2");
 osc1.plug(this, "setAmps3", "/BP");
 
 //listen to OSC messages containing vallues
 values.plug(this, "setVallueHr", "/HR");
 values.plug(this, "setVallueSpo2", "/Spo2");
 values.plug(this, "setVallueBP", "/BP");
 
}

public void setAmps(float amps){
  
  if(amps > 0.01){ 
  r1 = r1 + amps*5;
  r2 = r2 + amps*5;
  }
  
  else{
  r1 = r1 - r1/5;
  r2 = r2 - r2/10;
  }
}

public void setAmps2(float amps2){
  
  r3 = amps2*20;
  r4 = amps2*20;
  
}

public void setAmps3(float amps3){
  
  r5 = amps3*40;
  r6 = amps3*40;
 
}

public void setVallueHr(int HRtemp){
 
  HR = HRtemp;
  
}

public void setVallueSpo2(int Spo2Temp){
 
  Spo2 = Spo2Temp;
  
}

public void setVallueBP(int BPTemp){
 
  BP = BPTemp;
  
}

void draw(){
  background(bg);
  
  if(HR>30){
    fill(200,200,20,80);
    noStroke();
    balls(127+35, 571-HR*3.4+30*3.4, r1, r2, HR, a);
  }
  
  if(Spo2>80){
    fill(20,200,200,80);
    noStroke();
    balls(312+35, 571-Spo2*22.1+80*22.1, r3, r4, Spo2, a);
  }
  
  if(BP>30){
    fill(200,20,20,80);
    noStroke();
    balls(496+35, 571-BP*3.4+30*3.4, r5, r6, BP, a);
  }
  
 a+=2;

}

void balls(float x, float y, float r1, float r2, int value, float a){
 
  float x1 = x+r1*cos(a); 
  float y1 = y+r1*sin(a);
  float x2 = x-r1*cos(a);
  float y2 = y-r1*sin(a);
  float x3 = x+r2*cos(a);
  float y3 = y+r2*sin(a);
  float x4 = x-r2*cos(a);
  float y4 = y-r2*sin(a);
  
  println(mouseX);
  println(mouseY);
  
  ellipse(x1, y1, 70, 70);
  ellipse(x2, y2, 70, 70);
  ellipse(x3, y3, 65, 65);
  ellipse(x4, y4, 65, 65);
  
  textAlign(CENTER);
  textSize(20);
  fill(220);
  text(value, x, y+8);
  
}
  
