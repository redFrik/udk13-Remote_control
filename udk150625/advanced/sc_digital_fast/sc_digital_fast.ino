int val, lastVal;
void setup() {
  Serial.begin(115200);
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  pinMode(5, INPUT_PULLUP);
  pinMode(6, INPUT_PULLUP);
  pinMode(7, INPUT_PULLUP);
  pinMode(8, INPUT_PULLUP);
  pinMode(9, INPUT_PULLUP);
}
void loop() {
  val = digitalRead(2);
  val = val + (digitalRead(3) * 2);
  val = val + (digitalRead(4) * 4);
  val = val + (digitalRead(5) * 8);
  val = val + (digitalRead(6) * 16);
  val = val + (digitalRead(7) * 32);
  val = val + (digitalRead(8) * 64);
  val = val + (digitalRead(9) * 128);
  if (val != lastVal) {
    Serial.write(val);
    lastVal = val;
  }
}

