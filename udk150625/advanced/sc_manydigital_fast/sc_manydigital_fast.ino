//reading digital pins 2-13
int val, lastVal, val2, lastVal2;
void setup() {
  Serial.begin(115200);
  DDRD |= B11111100;  //pins 2-7 as output
  DDRB |= B00111111;  //pins 8-13 as output
  PORTD |= B11111100; //pins 2-7 internal pullup
  PORTB |= B00111111; //pins 8-13 internal pullup
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
  val2 = PINB >> 2 & 1;
  val2 += ((PINB >> 3 & 1) * 2);
  val2 += ((PINB >> 4 & 1) * 4);
  val2 += ((PINB >> 5 & 1) * 8);
  if ((val != lastVal) || (val2 != lastVal2) ) {
    Serial.write(val);
    Serial.write(val2);
    lastVal = val;
    lastVal2 = val2;
  }
}

