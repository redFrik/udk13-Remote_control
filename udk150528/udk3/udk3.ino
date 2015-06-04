
void setup() {
  pinMode(6, INPUT_PULLUP);  //connects via resistor to 5v
  pinMode(7, INPUT_PULLUP);  //connects via resistor to 5v
  Serial.begin(9600);
}
void loop() {
  byte val; //8bit value (0-255)
  val = digitalRead(6);  //0 or 1
  Serial.write(65+val);  //65 or 66 (A or B)
  
  byte val2;
  val2 = digitalRead(7);
  Serial.write(67+val2);  //67 or 68 (C or D)
  delay(5);  //0.5sec wait
}
