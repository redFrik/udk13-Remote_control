byte lastByte, lastByte2;
void setup() {
  pinMode(6, INPUT_PULLUP);  //connects via resistor to 5v
  pinMode(7, INPUT_PULLUP);  //connects via resistor to 5v
  Serial.begin(9600);
}
void loop() {
  byte val; //8bit value (0-255)
  val = digitalRead(6);  //0 or 1
  if (lastByte != val) {
    Serial.write(65 + val); //65 or 66 (A or B)
    lastByte = val;
  }

  byte val2;
  val2 = digitalRead(7);
  if (lastByte2 != val2) {
    Serial.write(67 + val2); //67 or 68 (C or D)
    lastByte2 = val2;
  }
  delay(5);  //5 millisecond wait
}
