/**
 * @author Stephen Robinson
 * @version November 16, 2020
 * 
 * Translates pressure from Force Sensitive Resistors on pins 0 - 12 to a serial output integer. 
 * Since I need to pass a single integer which captures the exact combination of active FSRs, each FSR is
 * mapped according to a bit representation scheme. 
 * 
 * No active FSR -> 0
 * FSR 0 -> 1
 * FSR 1 -> 2
 * FSR 3 -> 4
 * FSR 4 -> 8
 * FSR 6 -> 16
 * .
 * .
 * .
 * FSR 12 -> 4096
 * 
 * Each loop, the program will add the mapped number to a total called pitchEncoding which is sent at the end.
 */

//Left Hand Fingers/Thumb
int fsrAnalogPin0 = 0; //LT or Left Thumb
int fsrAnalogPin1 = 1; //L1
int fsrAnalogPin2 = 2; //L2
int fsrAnalogPin3 = 3; //L3
int fsrAnalogPin4 = 4; //L4

//Right Hand Fingers
int fsrAnalogPin5 = 5; //R1
int fsrAnalogPin6 = 6; //R2
int fsrAnalogPin7 = 7; //R3
int fsrAnalogPin8 = 8; //R4

//Right Hand Side
int fsrAnalogPin9 = 9; //RS

//Left Hand Palm/Knuckles
int fsrAnalogPin10 = 10;
int fsrAnalogPin11 = 11;
int fsrAnalogPin12 = 12;

//readings on each FSR. Reading of 0 = no pressure, ~900 = max pressure
int fsrReading0;
int fsrReading1;
int fsrReading2;
int fsrReading3;
int fsrReading4;
int fsrReading5;
int fsrReading6;
int fsrReading7;
int fsrReading8;
int fsrReading9;
int fsrReading10;
int fsrReading11;
int fsrReading12;

int pitchEncoding; //the sum total capturing which FSRs are active in the loop

void setup() {
  
  Serial.begin(9600); //set the transmission rate to 9600 baud
  
}

/**
 * Loops indefinitely, reading from each pin the pressure exerted on each sensor.
 * 
 * Captures the combination of active sensors in a single int according to a bit
 * representation scheme.
 * 
 * No active FSR -> 0
 * FSR 0 -> 1
 * FSR 1 -> 2
 * FSR 2 -> 4
 * FSR 3 -> 8
 * FSR 4 -> 16
 * 
 * Finally, writes the integer to serial out.
 */
void loop() {

  // Read from each of the thirteen FSRs
  fsrReading0 = analogRead(fsrAnalogPin0);
  fsrReading1 = analogRead(fsrAnalogPin1);
  fsrReading2 = analogRead(fsrAnalogPin2);
  fsrReading3 = analogRead(fsrAnalogPin3);
  fsrReading4 = analogRead(fsrAnalogPin4);
  fsrReading5 = analogRead(fsrAnalogPin5);
  fsrReading6 = analogRead(fsrAnalogPin6);
  fsrReading7 = analogRead(fsrAnalogPin7);
  fsrReading8 = analogRead(fsrAnalogPin8);
  fsrReading9 = analogRead(fsrAnalogPin9);
  fsrReading10 = analogRead(fsrAnalogPin10);
  fsrReading11 = analogRead(fsrAnalogPin11);
  fsrReading12 = analogRead(fsrAnalogPin12);

  //reset to 0
  pitchEncoding = 0;
  
  if(fsrReading0 > 700){
    pitchEncoding += 1;
  }

  if(fsrReading1 > 700){
    pitchEncoding += 2;
  }

  if(fsrReading2 > 700){
    pitchEncoding += 4;
  }

  if(fsrReading3 > 700){
    pitchEncoding += 8;
  }

  if(fsrReading4 > 700){
    pitchEncoding += 16;
  }

  if(fsrReading5 > 700){
    pitchEncoding += 32;
  }
  
  if(fsrReading6 > 700){
    pitchEncoding += 64;
  }
  
  if(fsrReading7 > 700){
    pitchEncoding += 128;
  }
  
  if(fsrReading8 > 700){
    pitchEncoding += 256;
  }

  if(fsrReading9 > 700){
    pitchEncoding += 512;
  }
  
  if(fsrReading10 > 700){
    pitchEncoding += 1024;
  }
  
  if(fsrReading11 > 700){
    pitchEncoding += 2048;
  }
  
  if(fsrReading12 > 700){
    pitchEncoding += 4096;
  }

  Serial.println(pitchEncoding);

  delay(100);
}
