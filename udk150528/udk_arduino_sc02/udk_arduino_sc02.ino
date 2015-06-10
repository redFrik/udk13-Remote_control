//connect a wire to pin6 and then run this sketch
//when the wire is touching gnd then A or B will show in serial monitor
byte lastByte;
void setup() {
  Serial.begin(9600);
  pinMode(6, INPUT_PULLUP);
}

void loop() {
  if(digitalRead(6)==0) {
    if(lastByte!=65) {  //filter out repetitions
      Serial.write(65);  //write 'A' to serial port
      lastByte= 65;
    }
  } else {
    if(lastByte!=66) {  //filter out repetitions
      Serial.write(66);  //write 'B' to serial port
      lastByte= 66;
    }
  }
  delay(100);
}
