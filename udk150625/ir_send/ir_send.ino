//install the IRremote library https://github.com/shirriff/Arduino-IRremote/releases
//and connect an ir led with a 120ohm resistor to pin3 and gnd

//this will just send out an endless counter (0-1023 (or 0-3FF))

#include <IRremote.h>

IRsend irsend;
int cnt = 0;

void setup() {
}
void loop() {
  irsend.sendSony(cnt, 12); //val, bits
  cnt = cnt + 1;
  if(cnt>1023) {
    cnt= 0;
  }
  delay(50);  //speed
}
