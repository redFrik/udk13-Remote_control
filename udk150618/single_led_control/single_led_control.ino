void setup() {
  pinMode(13, OUTPUT);  //built-in led
  Serial.begin(38400);
}

void loop() {
  while(Serial.available()) {
    byte val= Serial.read();
    if(val==65) {  //character 'A' turn on
      digitalWrite(13, 1);
    } else if(val==66) {  //character 'B' turn off
    digitalWrite(13, 0);
    }
  }
}
