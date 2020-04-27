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
Oscil OG;

Oscil Gs;
Oscil OGs;

Oscil A;
Oscil OA;

Oscil B;
Oscil OB;

Oscil C;
Oscil OC;

Oscil Cs;
Oscil OCs;



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
  Gs = new Oscil(Frequency.ofPitch("B3"), 0, Waves.SINE);
  
  A = new Oscil(Frequency.ofPitch("C4"), 0, Waves.SINE);
  
  B = new Oscil(Frequency.ofPitch("D4"), 0, Waves.SINE);
  
  C = new Oscil(Frequency.ofPitch("Eb4"), 0, Waves.SINE);
  Cs = new Oscil(Frequency.ofPitch("E4"), 0, Waves.SINE);
  G.patch(out);
  Gs.patch(out);
  
  A.patch(out);
  
  B.patch(out);
  
  C.patch(out);
  Cs.patch(out);
  
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
  
  if(val == 2){
    
    C.setAmplitude(0.0);
    B.setAmplitude(0.0);
    A.setAmplitude(0.0);
    G.setAmplitude(0.0);
    Gs.setAmplitude(0.0);
    
    Cs.setAmplitude(1.0);
  }
  
  if(val == 4){
    Cs.setAmplitude(0.0);
    
    B.setAmplitude(0.0);
    A.setAmplitude(0.0);
    G.setAmplitude(0.0);
    Gs.setAmplitude(0.0);
    
    C.setAmplitude(1.0);
  }
  
  if(val == 8){
    Cs.setAmplitude(0.0);
    C.setAmplitude(0.0);
    
    A.setAmplitude(0.0);
    G.setAmplitude(0.0);
    Gs.setAmplitude(0.0);
    
    B.setAmplitude(1.0);
  }
  
  if(val == 12){
    Cs.setAmplitude(0.0);
    C.setAmplitude(0.0);
    B.setAmplitude(0.0);
    
    G.setAmplitude(0.0);
    Gs.setAmplitude(0.0);
    
    A.setAmplitude(1.0);
  }
  
  if(val == 14){
    Cs.setAmplitude(0.0);
    C.setAmplitude(0.0);
    B.setAmplitude(0.0);
    A.setAmplitude(0.0);
    
    Gs.setAmplitude(0.0);
    
    G.setAmplitude(1.0);
  }
  
  if(val == 15){
    Cs.setAmplitude(0.0);
    C.setAmplitude(0.0);
    B.setAmplitude(0.0);
    A.setAmplitude(0.0);
    G.setAmplitude(0.0);
    
    Gs.setAmplitude(1.0);
  }
  
  
  //if(val == 1) {
  //  G.setAmplitude(1.0);
  //}
  
  //else if(val == 2){
  //  A.setAmplitude(1.0);
  //}
  
  else if(val == 0) {
    //out.mute();  //first iteration using one tone only
    //testTone.setAmplitude(0.0);
    
    Cs.setAmplitude(0.0);
    C.setAmplitude(0.0);
    B.setAmplitude(0.0);
    A.setAmplitude(0.0);
    G.setAmplitude(0.0);
    Gs.setAmplitude(0.0);
  }
  
  
  
  
  
  
  
  //testTone.setAmplitude(0);
  
  //background(acolor*150, 255, 255);
  
}
