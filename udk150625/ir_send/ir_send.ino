//install the IRremote library (v3.x) https://github.com/shirriff/Arduino-IRremote/releases
//and connect an ir led with a 120ohm resistor to pin3 and gnd

//this will just send out an endless counter 0-127 (0x00-0x7F) on addres 12 (0x0C)
//using the sony protocol with 7 command bits and 5 address bits

#define IR_SEND_PIN 3
#include <IRremote.hpp>

int cnt = 0;

void setup() {
  IrSender.begin(IR_SEND_PIN, DISABLE_LED_FEEDBACK);
}
void loop() {
  IrSender.sendSony(12, cnt, 0); //address, command, repeats
  //IrSender.sendNEC(12, cnt, 0);  //another common protocol
  cnt = cnt + 1;
  if (cnt > 127) {
    cnt = 0;
  }
  delay(50);  //speed
}
