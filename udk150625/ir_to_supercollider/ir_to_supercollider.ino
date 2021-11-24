//install the IRremote library (v3.x) https://github.com/shirriff/Arduino-IRremote/releases
//and connect an ir receiver (TSOP34838) to pin11, gnd and 5v

#define IR_RECEIVE_PIN 11
#include <IRremote.hpp>

void setup() {
  Serial.begin(38400);
  IrReceiver.begin(IR_RECEIVE_PIN, DISABLE_LED_FEEDBACK);
}
void loop() {
  if (IrReceiver.decode()) {
    Serial.println(IrReceiver.decodedIRData.decodedRawData, HEX);
    IrReceiver.resume();
  }
}
