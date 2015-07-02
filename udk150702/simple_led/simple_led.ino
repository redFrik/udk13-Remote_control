//simple example to control a led from supercollider
//use together with 'simple_led.scd'
//connect pin11 to led + resistor to gnd
void setup() {
  Serial.begin(38400);
  pinMode(11, OUTPUT);
}
void loop() {
  while (Serial.available()) {
    byte val = Serial.read();
    analogWrite(11, val); //val should be 0-255
  }
}

