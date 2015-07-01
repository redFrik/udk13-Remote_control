//--incoming serial format:
// pwm: 10 nn nn nn nn nn nn 11 (byte 1-6= pwm channels 0-5)

byte pwmPins[] = {3, 5, 6, 9, 10, 11};  //pins marked with ~
byte val, index;
byte input[] = {0, 0, 0, 0, 0, 0};      //for pwm serial data

void setup() {
  Serial.begin(38400);
  index = 0;

  //--setup pwm
  for (byte i = 0; i < 6; i++) {
    pinMode(pwmPins[i], OUTPUT);
  }

  //--startup blink
  for (byte j = 0; j < 3; j++) {
    for (byte i = 0; i < 6; i++) {
      analogWrite(pwmPins[i], 127);
      delay(50);
      analogWrite(pwmPins[i], 0);
    }
  }
}

void loop() {
  while (Serial.available()) {
    val = Serial.read();
    if (index == 0) {
      if (val == 10) {
        index = 1;
      }
    } else if (index < 7) {
      input[index - 1] = val;
      index++;
    } else {
      if (val == 11) {
        for (byte i = 0; i < 6; i++) {
          analogWrite(pwmPins[i], input[i]);
        }
      } else {
        //read error
      }
      index = 0;
    }
  }
}

