//before running this connect the receiver and use ReceiveDemo_Advanced
//from rc-switch http://code.google.com/p/rc-switch/ to get the numbers

//for the below code connect arduino pin 10, 5v and gnd to transmitter.

#include <RCSwitch.h>

#define ON 5574933  //numbers you received with ReceiveDemo_Simple - edit to match
#define OFF 5574932

RCSwitch mySwitch = RCSwitch();

void setup() {
    mySwitch.enableTransmit(10);  //arduino pin
    mySwitch.setPulseLength(183); //pulselength - edit to match
    mySwitch.setProtocol(1);      //1 or 2 - edit to match

    mySwitch.send(OFF, 24);      //24 is length - edit to match
}
void loop() {
    delay(2000);
    mySwitch.send(ON, 24);
    delay(2000);
    mySwitch.send(OFF, 24);
}
