//optimized version
//see https://www.arduino.cc/en/Reference/PortManipulation
int val, lastVal;
void setup() {
  Serial.begin(115200);
  DDRD |= B11111100;  //pins 2-7 as output
  DDRB |= B00000011;  //pins 8-9 as output
  PORTD |= B11111100; //pins 2-7 internal pullup
  PORTB |= B00000011; //pins 8-9 internal pullup
}
void loop() {
  val = PIND >> 2 & 1;
  val += ((PIND >> 3 & 1) * 2);
  val += ((PIND >> 4 & 1) * 4);
  val += ((PIND >> 5 & 1) * 8);
  val += ((PIND >> 6 & 1) * 16);
  val += ((PIND >> 7 & 1) * 32);
  val += ((PINB & 1) * 64);
  val += ((PINB >> 1 & 1) * 128);
  if (val != lastVal) {
    Serial.write(val);
    lastVal = val;
  }
}

