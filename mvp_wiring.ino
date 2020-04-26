/**
 * Translates pressure from Force Sensitive Resistors on pins 0 - 4 to a serial output integer
 */

int fsrAnalogPin0 = 0; //LT or Left Thumb
int fsrAnalogPin1 = 1; //L1 or Left Finger 1
int fsrAnalogPin2 = 2; //L2
int fsrAnalogPin3 = 3; //L3
int fsrAnalogPin4 = 4; //L4

int fsrReading0;
int fsrReading1;

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
  //Serial.print("Analog readings--- Pin 0 = ");

  if(fsrReading0 > 700) {
    Serial.println("1");
  }

  if(fsrReading1 > 700){
    Serial.println("2");
  }

  if(fsrReading1 <700 & fsrReading0 < 700){
    Serial.println("0");
  }
//  Serial.println(fsrReading0);
//  //Serial.print(" Pin 1 = ");
//  Serial.println(fsrReading1);





  delay(100);

}
