//install the IRremote library https://github.com/shirriff/Arduino-IRremote/releases
//and connect a ir receiver (TSOP34838)

#include <IRremote.h>

IRrecv irrecv(11);
decode_results results;

void setup() {
  Serial.begin(9600);
  irrecv.enableIRIn();
}
void loop() {
  if (irrecv.decode(&results)) {
    Serial.println(results.value, HEX);
    irrecv.resume();
  }
}

