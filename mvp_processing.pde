import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.serial.*;

/**
  @author Stephen Robinson
  @version April 27, 2020
  
  mvp_processing reads in a single integer value (val) from the specified serial port (myPort)
  using the serial library. Then utilizes the minim audio library to output a pitch to the
  default audio device by muting and unmuting several oscillator objects of each pitch.
*/


//Global Variables

Serial myPort; //the serial port from which input will be read

Minim minim; //used with 
AudioOutput out; //the default audio output device

Oscil[] pitchArray; //holds each oscillator used to generate a pitch

String serialInput;
int val;

/**
  Establishes the serial port port where the arduino is connected via USB. Gets the default
  audio device then initializes all oscilators for each pitch and sets their amplitde to 0 (no volume).
  Patches each oscillator to the default audio out device.
*/
void setup(){
  String portName = Serial.list()[3]; //get USB port where arduino is connected
  myPort = new Serial(this, portName, 9600); //set up serial port using portName and transmission rate (9600 baud)
  //printArray(Serial.list());
  
  minim = new Minim(this); //used to find the default audio device
  out = minim.getLineOut(); //stores the default audio out device
  
  pitchArray = new Oscil[14];
  
  pitchArray[0] = new Oscil(Frequency.ofPitch("Bb3"), 0, Waves.SINE);  //G3
  pitchArray[1] = new Oscil(Frequency.ofPitch("B3"), 0, Waves.SINE);   //G#3
  pitchArray[2] = new Oscil(Frequency.ofPitch("C4"), 0, Waves.SINE);   //A3
  pitchArray[3] = new Oscil(Frequency.ofPitch("Db4"), 0, Waves.SINE);  //A#3
  pitchArray[4] = new Oscil(Frequency.ofPitch("D4"), 0, Waves.SINE);   //B3
  pitchArray[5] = new Oscil(Frequency.ofPitch("Eb4"), 0, Waves.SINE);  //C4
  pitchArray[6] = new Oscil(Frequency.ofPitch("E4"), 0, Waves.SINE);   //C#4
  
  pitchArray[7] = new Oscil(Frequency.ofPitch("Bb4"), 0, Waves.SINE);  //G4
  pitchArray[8] = new Oscil(Frequency.ofPitch("B4"), 0, Waves.SINE);   //G#4
  pitchArray[9] = new Oscil(Frequency.ofPitch("C5"), 0, Waves.SINE);   //A4
  pitchArray[10] = new Oscil(Frequency.ofPitch("Db5"), 0, Waves.SINE); //A#4
  pitchArray[11] = new Oscil(Frequency.ofPitch("D5"), 0, Waves.SINE);  //B4
  pitchArray[12] = new Oscil(Frequency.ofPitch("Eb5"), 0, Waves.SINE); //C5
  pitchArray[13] = new Oscil (Frequency.ofPitch("E5"), 0, Waves.SINE); //C#5
  
  //connect each oscillator to default audio out
  for(Oscil o : pitchArray){
    o.patch(out);
  }
   
}

/**
  Loops indefinitely, reading from the established serial port myPort, parses the serial input as
  an integer named val and then unmutes the oscillator (sets the amplitude to 1.0) mapped to that value and mutes
  (sets the amplitude to 0.0) all others using the helper function muteAllExcept(int index). 
  If the val is equal to 0, the helper function muteAll() is used to set the amplitude of all oscilators to 0.0.
*/
void draw(){
  if(myPort.available() >0) {
    
    serialInput = myPort.readStringUntil('\n'); //take the next line of input from serial port
    
    //attempts to parse the input as an integer and print for debugging
    //catches a NumberFormatException if a partial packet was sent that cannot be parsed
    if(serialInput != null){
      try{
      val = Integer.parseInt(serialInput.trim());
      println(val);
      } catch (NumberFormatException e){
        println(e);
      }
    }
  }
  
  //switch on the input and call the appropriate helper method
  switch(val) {
    case 0:
      muteAll();
      break;
    
    //C#4
    case 2:
      muteAllExcept(6);
      break;
    
    //C4
    case 4:
      muteAllExcept(5);
      break;
    
    //B3
    case 8:
      muteAllExcept(4);
      break;
    
    //A3
    case 12:
      muteAllExcept(2);
      break;
    
    //A#3
    case 13:
      muteAllExcept(3);
      break;
    
    //G3
    case 14:
      muteAllExcept(0);
      break;
     
    //G#3
    case 15:
      muteAllExcept(1);
      break;
      
    //C#5
    case 18:
      muteAllExcept(13);
      break;
    
    //C5
    case 20:
      muteAllExcept(12);
      break;
    
    //B4
    case 24:
      muteAllExcept(11);
      break;
    
    //A4
    case 28:
      muteAllExcept(9);
      break;
    
    //A#4
    case 29:
      muteAllExcept(10);
      break;
    
    //G4
    case 30:
      muteAllExcept(7);
      break;
     
    //G#4
    case 31:
      muteAllExcept(8);
      break;
  }
  
}

/**
  Simply calls the muteAllExcept function with an index outside of the array,
  ensuring that the amplitude of all oscilators is set to 0.0.
*/
void muteAll(){
  muteAllExcept(-1); //call with index not in the array
}

/**
  Loops once throught the pitchArray setting the amplitude of the oscillator at
  the specified index parameter to 1.0 and setting all others to 0.0.
  
  @param index the index of the oscillator in the array which will "be unmuted"
*/
void muteAllExcept(int index){
  for(int i = 0; i < pitchArray.length; i ++){
    
    if(i != index) {
      pitchArray[i].setAmplitude(0.0);
    } else {
      pitchArray[i].setAmplitude(1.0);
    }
  }
  
}
