byte lastByte;
void setup() {
  Serial.begin(9600);
  pinMode(6, INPUT_PULLUP);
}

void loop() {
  if(digitalRead(6)==0) {
    if(lastByte!=65) {
      Serial.write(65);
      lastByte= 65;
    }
  } else {
    if(lastByte!=66) {
      Serial.write(66);
      lastByte= 66;
    }
  }
  delay(100);
}
