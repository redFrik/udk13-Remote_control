general course introduction
--------------------

* links to previous semesters... <http://redfrik.github.io/udk00-Audiovisual_Programming/>
* and dates + times for this course... <https://github.com/redFrik/udk13-Remote_control> <-save this page

supercollider
--

a system mainly for making synthetic sound. but can do a lot of other things as well. includes features like MIDI, OSC, Serial etc. that we will use to talk to hardware and other software.

http://supercollider.github.io/download.html

first supercollider test code...
```
1+1+5

s.boot

{SinOsc.ar(MouseX.kr(140, 4000))}.play;
{SinOsc.ar(MouseX.kr(240, 4000))}.play;
{SinOsc.ar(MouseX.kr(340, 4000))}.play;
{SinOsc.ar(MouseX.kr(440, 4000))}.play;
{SinOsc.ar(MouseX.kr(540, 4000))}.play;
{SinOsc.ar(MouseX.kr(640, 4000))}.play;
```

select the line you would like to run and select 'Evaluate Selection, Line or Region' under the Language menu.

arduino
--

a simple language + a hardware standard for simple electronics. can get input from many kinds of sensors and control many types of things.

http://www.arduino.cc/en/Main/Software

first arduino test code...
```cpp
void setup() {
    Serial.begin(9600);
}
void loop() {
    Serial.println(analogRead(A0));
    delay(20);  //update rate in milliseconds
}
```
upload this code, connect a bare wire to A0 and then open serial monitor. set baudrate to 9600.

you should see something like this...

![first_test_arduino](first_test_arduino.png?raw=true "first_test_arduino")

the values should fluctuate and then go to 0 when you touch the A0 wire (it is acting like an antenna that you ground)

150423
======

433.92MHz RC power sockets

can control standard 220V power sockets remotely (≈ 30m distance).  easy and cheap to use but note: they react SLOW! often it takes more than a second after sending the command that the socket relay reacts and turns the power on/off.

i have used two different models. one gought at bauhaus and the other online at reichelt.

![bauhaus](bauhaus.jpg?raw=true "bauhaus")

![reichelt](reichelt.jpg?raw=true "reichelt")

prices vary and there are many different manufacturers and models. check maximum wattage before buying. different rc sockets can take different loads. the two different models i have have a rating of 10A and 3600W maximum. so double check the manual before connecting heavy motors like vacuum cleaners (sidenote: since autumn 2014 there's a law in the EU that one can only buy less that 1600W vacuum cleaners - but old models might require more).

to control these sockets from your computer you also need a sender and receiver module. again there are different versions (some with very long range).
i have these cheap modules and they work well with arduino: <http://www.exp-tech.de/shields-module/wireless/funk/315mhz-rf-link-kit>

these modules are also easier to use if you download and install the rc-switch library (v.2.52) for arduino <https://code.google.com/p/rc-switch/>

connect a receiver module like this...

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
