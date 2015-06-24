//install the IRremote library https://github.com/shirriff/Arduino-IRremote/releases
//and connect an ir receiver (TSOP34838) to pin11, gnd and 5v

#include <IRremote.h>

IRrecv irrecv(11);
decode_results results;

void setup() {
  Serial.begin(38400);
  irrecv.enableIRIn();
}
void loop() {
  if (irrecv.decode(&results)) {
    Serial.println(results.value);
    irrecv.resume();
  }
}

