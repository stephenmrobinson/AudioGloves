/**
 * Translates pressure from Force Sensitive Resistors on pins 0 - 4 to a serial output integer
 */

int fsrAnalogPin0 = 0; //LT or Left Thumb
int fsrAnalogPin1 = 1; //L1 or Left Finger 1
int fsrAnalogPin2 = 2; //L2
int fsrAnalogPin3 = 3; //L3
int fsrAnalogPin4 = 4; //L4
int fsrAnalogPin6 = 6; //L5

int fsrReading0;
int fsrReading1;
int fsrReading2;
int fsrReading3;
int fsrReading6;

int pitchEncoding;

void setup() {
  
  Serial.begin(9600);
  
}

void loop() {

//  if (analogRead(fsrAnalogPin0) > 700){
//    Serial.write(1);
//  } else if(analogRead(fsrAnalogPin1 > 700)){
//    Serial.write(2);
//  }else {
//    Serial.write(0);
//  }

//  if (analogRead(fsrAnalogPin0) > 700){
//    Serial.println(1);
//  }
//  
//  if(analogRead(fsrAnalogPin1 > 700)){
//    Serial.println(2);
//  }

  fsrReading0 = analogRead(fsrAnalogPin0);
  fsrReading1 = analogRead(fsrAnalogPin1);
  fsrReading2 = analogRead(fsrAnalogPin2);
  fsrReading3 = analogRead(fsrAnalogPin3);
  fsrReading6 = analogRead(fsrAnalogPin6);

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

//  if(fsrReading0 > 700) {
//    Serial.println("1");
//  }
//
//  if(fsrReading1 > 700){
//    Serial.println("2");
//  }
//
//  if(fsrReading2 > 700){
//    Serial.println("3");
//  }
//
//  if(fsrReading1 <700 & fsrReading0 < 700 & fsrReading2 < 0){
//    Serial.println("0");
//  }
//  Serial.println(fsrReading0);
//  //Serial.print(" Pin 1 = ");
//  Serial.println(fsrReading1);
//  Serial.println(fsrReading2);






  delay(100);

}
