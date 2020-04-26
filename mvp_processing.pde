import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.serial.*;


/**
*Reads serial output from arduino and translates it to sound
*/

Serial myPort;

Minim minim;
AudioOutput out;
Oscil testTone;
Oscil G;
Oscil A;


String serialInput;
int val;
int LF;

void setup(){
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  //printArray(Serial.list());
  
  minim = new Minim(this);
  out = minim.getLineOut(); //get default audio out device
  //out.mute();
  
  
  //test with A440, the international standard for tuning
  //testTone = new Oscil( 440, 1, Waves.SINE );
  //testTone.patch(out);
  
  G = new Oscil(Frequency.ofPitch("Bb3"), 0, Waves.SINE);
  A = new Oscil(Frequency.ofPitch("C4"), 0, Waves.SINE);
  G.patch(out);
  A.patch(out);
  
  LF = 10; //ASCII newline
  
  
}

void draw(){
  if(myPort.available() >0) {
    //val = Integer.parseInt(String.valueOf(myPort.read()), 2);
    serialInput = myPort.readStringUntil('\n');
    //val =myPort.read();
    if(serialInput != null){
      try{
      val = Integer.parseInt(serialInput.trim());
      println(val);
      } catch (NumberFormatException e){
        println(e);
      }
    }
    //println(val);
    
  }
  
  //if(val > 0 && out.isMuted()) {
  //  out.unmute();
    
  //}
  
  if(val == 1) {
    //testTone.setAmplitude(1.0);
    G.setAmplitude(1.0);
  }
  
  else if(val == 2){
    A.setAmplitude(1.0);
  }
  
  else if(val == 0) {
    //out.mute();  //first iteration using one tone only
    //testTone.setAmplitude(0.0);
    A.setAmplitude(0.0);
    G.setAmplitude(0.0);
  }
  
  
  
  
  
  
  
  //testTone.setAmplitude(0);
  
  //background(acolor*150, 255, 255);
  
}
