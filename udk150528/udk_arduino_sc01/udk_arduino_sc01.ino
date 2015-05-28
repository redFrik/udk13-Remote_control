//ascii test program
//upload and then run serial monitor
byte cnt;

void setup() {
  Serial.begin(9600);  //important number (9600, 57600)
}

void loop() {
  Serial.write(66);  //0-255  (8bit number)
  cnt = cnt + 1;
  delay(50);
}
