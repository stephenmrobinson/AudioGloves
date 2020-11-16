import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.serial.*;

/**
  @author Stephen Robinson
  @version November  16, 2020
  
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
  
  pitchArray = new Oscil[33];
  
  //pitchArray[0] = new Oscil(Frequency.ofPitch("Bb3"), 0, Waves.SINE);  //G3
  //pitchArray[1] = new Oscil(Frequency.ofPitch("B3"), 0, Waves.SINE);   //G#3
  //pitchArray[2] = new Oscil(Frequency.ofPitch("C4"), 0, Waves.SINE);   //A3
  //pitchArray[3] = new Oscil(Frequency.ofPitch("Db4"), 0, Waves.SINE);  //A#3
  //pitchArray[4] = new Oscil(Frequency.ofPitch("D4"), 0, Waves.SINE);   //B3
  //pitchArray[5] = new Oscil(Frequency.ofPitch("Eb4"), 0, Waves.SINE);  //C4
  //pitchArray[6] = new Oscil(Frequency.ofPitch("E4"), 0, Waves.SINE);   //C#4
  
  //pitchArray[7] = new Oscil(Frequency.ofPitch("Bb4"), 0, Waves.SINE);  //G4
  //pitchArray[8] = new Oscil(Frequency.ofPitch("B4"), 0, Waves.SINE);   //G#4
  //pitchArray[9] = new Oscil(Frequency.ofPitch("C5"), 0, Waves.SINE);   //A4
  //pitchArray[10] = new Oscil(Frequency.ofPitch("Db5"), 0, Waves.SINE); //A#4
  //pitchArray[11] = new Oscil(Frequency.ofPitch("D5"), 0, Waves.SINE);  //B4
  //pitchArray[12] = new Oscil(Frequency.ofPitch("Eb5"), 0, Waves.SINE); //C5
  //pitchArray[13] = new Oscil (Frequency.ofPitch("E5"), 0, Waves.SINE); //C#5
  
  ////From adding right hand
  
  //pitchArray[14] = new Oscil(Frequency.ofPitch("Ab3"), 0, Waves.SINE);  //F3
  //pitchArray[15] = new Oscil(Frequency.ofPitch("A3"), 0, Waves.SINE);   //F#3
  //pitchArray[16] = new Oscil(Frequency.ofPitch("G3"), 0, Waves.SINE);   //E3
  //pitchArray[17] = new Oscil(Frequency.ofPitch("Gb3"), 0, Waves.SINE); //D#3
  //pitchArray[18] = new Oscil(Frequency.ofPitch("F3"), 0, Waves.SINE);  //D3
  
  //pitchArray[19] = new Oscil(Frequency.ofPitch("Ab4"), 0, Waves.SINE);  //F4
  //pitchArray[20] = new Oscil(Frequency.ofPitch("A4"), 0, Waves.SINE);   //F#4
  //pitchArray[21] = new Oscil(Frequency.ofPitch("G4"), 0, Waves.SINE);   //E4
  //pitchArray[22] = new Oscil(Frequency.ofPitch("Gb4"), 0, Waves.SINE); //Eb4
  //pitchArray[23] = new Oscil(Frequency.ofPitch("F4"), 0, Waves.SINE);  //D4
  
  
  
  pitchArray[0] = new Oscil(Frequency.ofPitch("Db3"), 0, Waves.SINE);   //Bb2
  pitchArray[1] = new Oscil(Frequency.ofPitch("D3"), 0, Waves.SINE);    //B2
  pitchArray[2] = new Oscil(Frequency.ofPitch("Eb3"), 0, Waves.SINE);   //C3
  pitchArray[3] = new Oscil(Frequency.ofPitch("E3"), 0, Waves.SINE);    //C#3
  pitchArray[4] = new Oscil(Frequency.ofPitch("F3"), 0, Waves.SINE);    //D3
  pitchArray[5] = new Oscil(Frequency.ofPitch("Gb3"), 0, Waves.SINE);   //D#3
  pitchArray[6] = new Oscil(Frequency.ofPitch("G3"), 0, Waves.SINE);    //E3
  pitchArray[7] = new Oscil(Frequency.ofPitch("Ab3"), 0, Waves.SINE);   //F3
  pitchArray[8] = new Oscil(Frequency.ofPitch("A3"), 0, Waves.SINE);    //F#3
  
  pitchArray[9] = new Oscil(Frequency.ofPitch("Bb3"), 0, Waves.SINE);   //G3
  pitchArray[10] = new Oscil(Frequency.ofPitch("B3"), 0, Waves.SINE);   //G#3
  pitchArray[11] = new Oscil(Frequency.ofPitch("C4"), 0, Waves.SINE);   //A3
  pitchArray[12] = new Oscil(Frequency.ofPitch("Db4"), 0, Waves.SINE);  //A#3
  pitchArray[13] = new Oscil(Frequency.ofPitch("D4"), 0, Waves.SINE);   //B3
  pitchArray[14] = new Oscil(Frequency.ofPitch("Eb4"), 0, Waves.SINE);  //C4
  pitchArray[15] = new Oscil(Frequency.ofPitch("E4"), 0, Waves.SINE);   //C#4
  pitchArray[16] = new Oscil(Frequency.ofPitch("F4"), 0, Waves.SINE);   //D4
  pitchArray[17] = new Oscil(Frequency.ofPitch("Gb4"), 0, Waves.SINE);  //D#4
  pitchArray[18] = new Oscil(Frequency.ofPitch("G4"), 0, Waves.SINE);   //E4
  pitchArray[19] = new Oscil(Frequency.ofPitch("Ab4"), 0, Waves.SINE);  //F4
  pitchArray[20] = new Oscil(Frequency.ofPitch("A4"), 0, Waves.SINE);   //F#4
  
  pitchArray[21] = new Oscil(Frequency.ofPitch("Bb4"), 0, Waves.SINE);  //G4
  pitchArray[22] = new Oscil(Frequency.ofPitch("B4"), 0, Waves.SINE);   //G#4
  pitchArray[23] = new Oscil(Frequency.ofPitch("C5"), 0, Waves.SINE);   //A4
  pitchArray[24] = new Oscil(Frequency.ofPitch("Db5"), 0, Waves.SINE);  //A#4
  pitchArray[25] = new Oscil(Frequency.ofPitch("D5"), 0, Waves.SINE);   //B4
  pitchArray[26] = new Oscil(Frequency.ofPitch("Eb5"), 0, Waves.SINE);  //C5
  pitchArray[27] = new Oscil (Frequency.ofPitch("E5"), 0, Waves.SINE);  //C#5
  pitchArray[28] = new Oscil(Frequency.ofPitch("F5"), 0, Waves.SINE);   //D5
  pitchArray[29] = new Oscil(Frequency.ofPitch("Gb5"), 0, Waves.SINE);  //D#5
  pitchArray[30] = new Oscil(Frequency.ofPitch("G5"), 0, Waves.SINE);   //E5
  pitchArray[31] = new Oscil(Frequency.ofPitch("Ab5"), 0, Waves.SINE);  //F5
  pitchArray[32] = new Oscil(Frequency.ofPitch("A5"), 0, Waves.SINE);   //F#5
  
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
  
  //TODO: ADD Bb3 and B3 CASES
  
  //switch on the input and call the appropriate helper method
  switch(val) {
    //No input - all oscillators muted
    case 0:
      muteAll();
      break;
    
    //B3
    case 2:
      muteAllExcept(13);
      break;
    
    //B4
    case 3:
      muteAllExcept(25);
      break;
    
    //C4
    case 4:
      muteAllExcept(14);
      break;
      
    //C5
    case 5:
      muteAllExcept(26);
      break;
      
    //A3
    case 6:
      muteAllExcept(11);
      break;
      
    //A4
    case 7:
      muteAllExcept(23);
      break;
    
    //C#4
    case 8:
      muteAllExcept(15);
      break;
      
    //C#5
    case 9:
      muteAllExcept(27);
      break;
      
    //G3
    case 14:
      muteAllExcept(9);
      break;
    
    //G4
    case 15:
      muteAllExcept(21);
      break;
    
    //G#3
    case 30:
      muteAllExcept(10);
      break;
      
    //G#4
    case 31:
      muteAllExcept(22);
      break;
      
    //A#3
    case 34:
      muteAllExcept(12);
      break;
      
    //A#4
    case 35:
      muteAllExcept(24);
      break;
      
    //F3
    case 46:
      muteAllExcept(7);
      break;
      
    //F4
    case 47:
      muteAllExcept(19);
      break;
      
    //F#3
    case 78:
      muteAllExcept(8);
      break;
      
    //F#4
    case 79:
      muteAllExcept(20);
      break;
      
    //E3
    case 110:
      muteAllExcept(6);
      break;
      
    //E4
    case 111:
      muteAllExcept(18);
      break;
      
    //F#3
    case 174:
      muteAllExcept(8);
      break;
      
    //F#4
    case 175:
      muteAllExcept(20);
      break;
      
    //C#4
    case 224:
      muteAllExcept(15);
      break;
      
    //C#5
    case 225:
      muteAllExcept(27);
      break;
      
    //D3
    case 238:
      muteAllExcept(4);
      break;
    
    //Bb2
    case 254:
      muteAllExcept(0);
      break;
      
    //B2
    case 126:
      muteAllExcept(1);
      break;
      
    //D4
    case 239:
      muteAllExcept(16);
      break;
      
    //C3
    case 492:
      muteAllExcept(2);
      break;
      
    //D#3
    case 494:
      muteAllExcept(5);
      break;
      
    //D#4
    case 495:
      muteAllExcept(17);
      break;
      
    //C#3
    case 508:
      muteAllExcept(3);
      break;
      
    //C4
    case 514:
      muteAllExcept(14);
      break;
      
    //C5
    case 515:
      muteAllExcept(26);
      break;
      
    //A#3
    case 518:
      muteAllExcept(12);
      break;
      
    //A#4
    case 519:
      muteAllExcept(24);
      break;
      
    //D5
    case 1025:
      muteAllExcept(28);
      break;
      
    //D#5
    case 1273:
      muteAllExcept(29);
      break;
      
    //E5
    case 1785:
      muteAllExcept(30);
      break;
      
    //F5
    case 5881:
      muteAllExcept(31);
      break;
      
    //F#5
    case 5945:
      muteAllExcept(32);
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
