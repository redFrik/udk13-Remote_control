//use together with supercollider code 'servo.scd'
//connect a 5v servo motor to 5v, pin9 and gnd

#include <Servo.h>
Servo servo;
void setup() {
  Serial.begin(38400);
  servo.attach(9);
}

void loop() {
  while(Serial.available()) {
    byte val= Serial.read();
    servo.write(val); //should be 0 to 180
  }
}
