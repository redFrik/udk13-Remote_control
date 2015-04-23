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

the values should fluctuate and then go to 0 when you touch the A0 wire (it is acting like an antenna picking up noise and that you ground by touching it)

150423
======

today's topic: 433.92MHz RC power sockets

makes it easy to control standard 220V power sockets remotely (≈ 30m distance).  cheap and easy to use but note: they react SLOW! often it takes more than a second after sending the command that the socket relay reacts and turns the power on/off.
also note that this techniques is insecure and very easy to hack.

i have used two different models. one bought at bauhaus and the other, home easy, online at [reichelt](http://www.reichelt.de/ELRO-HE808S/3/index.html?&ACTION=3&LA=446&ARTICLE=135910&artnr=ELRO+HE808S&SEARCH=ELRO+HE808S).

![bauhaus](bauhaus.jpg?raw=true "bauhaus")

![reichelt](reichelt.jpg?raw=true "reichelt")

prices vary and there are many different manufacturers and models. check maximum wattage before buying. different rc sockets can take different loads. the two different models i have have a rating of 10A and 3600W maximum. so double check the manual before connecting heavy motors like vacuum cleaners (sidenote: since autumn 2014 there's a law in the EU that one can only buy less that 1600W vacuum cleaners - but old models might require more).

to control these sockets from your computer you also need a sender and receiver module. again there are different versions (some with very long range).
i have these cheap modules and they work well with arduino: <http://www.exp-tech.de/shields-module/wireless/funk/315mhz-rf-link-kit>

to use these modules i'd recommend to download and install the rc-switch library (v.2.52) for arduino <https://code.google.com/p/rc-switch/>

connect a receiver module like this...

![receiver](rc-switch_receiver.jpg?raw=true "receiver")

after that, upload the `ReceiveDemo_Simple` sketch from rc-switch examples folder,
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

#define ON0 5574933 //numbers you received with ReceiveDemo_Simple - edit to match
#define OFF0 5574932

RCSwitch mySwitch = RCSwitch();

void setup() {
    mySwitch.enableTransmit(10);    //arduino pin10
    mySwitch.setPulseLength(183);   //pulselength - edit to match but 183 is most common
    //mySwitch.setProtocol(1);      //1 or 2 - edit to match
    mySwitch.send(OFF0, 24);        //turn off at startup
}
void loop() {
    delay(2000);
    mySwitch.send(ON0, 24);
    delay(2000);
    mySwitch.send(OFF0, 24);
}
```

if it works you should hear and see the relay going on and off with a delay of 2 seconds.

touch antenna light example
--

arduino code...

```cpp
//use ReceiveDemo_Advanced from rc-switch http://code.google.com/p/rc-switch/ to get the code

//pin 10 to transmitter + 5v and gnd

#include <RCSwitch.h>

#define ON0 5574933     //edit
#define OFF0 5574932    //edit

RCSwitch mySwitch = RCSwitch();

void setup() {
    Serial.begin(9600);
    mySwitch.enableTransmit(10);
    mySwitch.setPulseLength(183);
    mySwitch.send(OFF0, 24);
}
void loop() {
    Serial.println(analogRead(A0));
    if(analogRead(A0)==0 || (analogRead(A0)==1023)) {
        mySwitch.send(ON0, 24);
    } else {
        mySwitch.send(OFF0, 24);
    }
    delay(50);
}
```

upload this code and connect a bare wire to A0. touch it to turn on the light.

pitch control light example
--

arduino code...

```cpp
//pin 10 to transmitter + 5v and gnd

#include <RCSwitch.h>

#define ON0 5574933     //edit
#define OFF0 5574932    //edit

RCSwitch mySwitch = RCSwitch();

void setup() {
    Serial.begin(9600);
    mySwitch.enableTransmit(10);
    mySwitch.setPulseLength(183);
    mySwitch.send(OFF0, 24);
}
void loop() {
    if(Serial.available()) {
        int val= Serial.read();
        if(val==65) {   //65 is ascii character A
            mySwitch.send(ON0, 24);
        } else if(val==66) {    //66 is ascii character B
            mySwitch.send(OFF0, 24);
        }
    }
    delay(50);
}
```


supercollider code...

```
SerialPort.listDevices

a= SerialPort("/dev/tty.usbserial-A101NAZV", 9600, crtscts: true)
a.put(65)//relay with light on
a.put(66)//relay with light off

(
{
    var freq= Pitch.kr(SoundIn.ar())[0];    //pitch track microphone
    SendReply.kr(Impulse.kr(1), '/freq', freq); //send pitch 1/sec
    SinOsc.ar(freq, 0, [0, 0.1]);   //play soft in right speaker
}.play
)

(
OSCFunc({|msg|
    msg[3].postln;
    if(msg[3]>1000 && (msg[3]<1100), { //pitch within 1000-1100hz
        "turn light on".postln;
        a.put(65);
    }, {
        "turn light off".postln;
        a.put(66);
    });
}, \freq)
)
```

resources
=========

rc-switch arduino library <https://code.google.com/p/rc-switch/>

blog entry about rc switches <https://sui77.wordpress.com/2011/04/12/163/>

another blog entry <http://blog.rot13.org/2013/10/433-mhz-power-sockets-with-rc-switch-arduino-or-raspberry-pi.html>

ABC - Arduino Basic Connections <http://www.pighixxx.com/test/abc/>
