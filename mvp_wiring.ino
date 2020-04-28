/**
 * @author Stephen Robinson
 * @version April 27, 2020
 * 
 * Translates pressure from Force Sensitive Resistors on pins 0 - 6 to a serial output integer. 
 * Since I need to pass a single integer which captures the exact combination of active FSRs, each FSR is
 * mapped according to a bit representation scheme. 
 * 
 * No active FSR -> 0
 * FSR 0 -> 1
 * FSR 1 -> 2
 * FSR 3 -> 4
 * FSR 4 -> 8
 * FSR 6 -> 16
 * 
 * Each loop, the program will add the mapped number to a total called pitchEncoding which is sent at the end.
 */

int fsrAnalogPin0 = 0; //L4
int fsrAnalogPin1 = 1; //L3
int fsrAnalogPin2 = 2; //L2
int fsrAnalogPin3 = 3; //L1
int fsrAnalogPin6 = 6; //LT or Left Thumb

//readings on each FSR. Reading of 0 = no pressure, ~900 = max pressure
int fsrReading0;
int fsrReading1;
int fsrReading2;
int fsrReading3;
int fsrReading6;

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
 * FSR 3 -> 4
 * FSR 4 -> 8
 * FSR 6 -> 16
 * 
 * Finally, writes the integer to serial out.
 */
void loop() {

  // Read from each of the five FSRs
  fsrReading0 = analogRead(fsrAnalogPin0);
  fsrReading1 = analogRead(fsrAnalogPin1);
  fsrReading2 = analogRead(fsrAnalogPin2);
  fsrReading3 = analogRead(fsrAnalogPin3);
  fsrReading6 = analogRead(fsrAnalogPin6);

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

  if(fsrReading6 > 700){
    pitchEncoding += 16;
  }

  Serial.println(pitchEncoding);

  delay(100);
}
