general course introduction
--------------------

* links to previous semesters... <http://redfrik.github.io/udk00-Audiovisual_Programming/>
* and dates + times for this course... <https://github.com/redFrik/udk13-Remote_control> <-save this page

supercollider
--

http://supercollider.github.io/download.html

arduino
--

http://www.arduino.cc/en/Main/Software


150423
======

433.92MHz RC power sockets

can control standard 220V power sockets remotely (≈ 30m distance).  easy and cheap to use but note: they react SLOW!

modules for arduino <http://www.exp-tech.de/shields-module/wireless/funk/315mhz-rf-link-kit>

also check maximum watt. different rc sockets can take different loads. the two different models i have have a rating of 10A and 3600W maximum. double check manual before connecting heavy motors like vacuum cleaners (sidenote: since autumn 2014 there's a law in the EU that one can only buy less that 1600W vacuum cleaners - but old models might require more).

two different models...

![bauhaus](bauhaus.jpg?raw=true "bauhaus")

![reichelt](reichelt.jpg?raw=true "reichelt")

download and install the rc-switch library (v.2.52) for arduino <https://code.google.com/p/rc-switch/>

then connect a receiver module like this...

![receiver](rc-switch_receiver.jpg?raw=true "receiver")

after that, upload the `ReceiveDemo_Advanced` sketch from rc-switch examples folder,
open serial monitor in arduino and set the baudrate to 9600.

then put in a battery in the rc remote control that came with the sockets and press some buttons. you should see data being printed in the serial monitor window.

write down the numbers you receive.

now connect the sender module like this...

![sender](rc-switch_sender.jpg?raw=true "sender")

and upload this code (edit the numbers in the code - use the ones you wrote down).

```cpp
//before running this connect the receiver and use ReceiveDemo_Advanced
//from rc-switch http://code.google.com/p/rc-switch/ to get the numbers

//for the below code connect arduino pin 10, 5v and gnd to transmitter.

#include <RCSwitch.h>

#define ON 266516  //numbers you received with ReceiveDemo_Simple - edit to match
#define OFF 266517

RCSwitch mySwitch = RCSwitch();

void setup() {
    Serial.begin(9600);
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
```


resources
=========

rc-switch arduino library <https://code.google.com/p/rc-switch/>

blog entry about rc switches <https://sui77.wordpress.com/2011/04/12/163/>

another blog entry <http://blog.rot13.org/2013/10/433-mhz-power-sockets-with-rc-switch-arduino-or-raspberry-pi.html>

ABC - Arduino Basic Connections <http://www.pighixxx.com/test/abc/>
