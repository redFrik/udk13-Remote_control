
void setup() {
  pinMode(6, INPUT_PULLUP);  //connect via resistor to 5v
  //force pin to be 5 v
  Serial.begin(9600);
}

void loop() {
  byte val; //8bit value (0-255)
  val = digitalRead(6);  //0 or 1
  Serial.write(65+val);  //65 or 66 (A or B)
  delay(500);  //0.5sec wait
}
