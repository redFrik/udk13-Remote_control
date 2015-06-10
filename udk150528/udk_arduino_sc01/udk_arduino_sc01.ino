//ascii test program
//upload and then run serial monitor (cmd+shift+m on osx)
byte cnt;

void setup() {
  Serial.begin(9600);  //important number (9600, 57600)
}

void loop() {
  Serial.write(cnt);  //0-255  (8bit number)
  cnt = cnt + 1;
  delay(50);
}
