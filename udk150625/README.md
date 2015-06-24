150625
======

ir remotes

ir receiving
--
first install the IRremote library from <https://github.com/shirriff/Arduino-IRremote/releases> (download the zip, extract it into your ~/Documents/Arduino/libraries folder).

then upload the [ir_receive.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150625/ir_receive/ir_receive.ino)

then connect a ir-receiver (here we use Vishay TSOP34838, 38kHz) to the arduino. connect the left most pin to 5V, the middle to GND and the right most to pin11 on the arduino.

![ir_receive](ir_receive.jpg?raw=true "ir_receive")

last open the serial monitor in arduino, set the baudrate to 9600 and try some buttons on the remote controls.

links:

* <https://github.com/shirriff/Arduino-IRremote/wiki/Hardware-setup>
* <https://arduino-info.wikispaces.com/IR-RemoteControl>
* <https://learn.sparkfun.com/tutorials/ir-communication>
* <http://www.righto.com/2009/08/multi-protocol-infrared-remote-library.html>

ir sending
--
connect an ir led to another arduino. use pin3 with a resistor (120ohm) and via the long leg of the led to gmd. like this...

![ir_send](ir_send.jpg?raw=true "ir_send")

then upload the [ir_send.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150625/ir_send/ir_send.ino)

if you open the serial monitor (for the receiver arduino) you should now see a counter posted (0-3FF in hex).

ir remote to sc
--
upload the sketch [ir_to_supercollider.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150625/ir_to_supercollider/ir_to_supercollider.ino). it is only a slight modification to the above ir_receive sketch.
and then run the code in [ir_to_supercollider.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150625/ir_to_supercollider.scd) in supercollider. modify the keys to match your remote (press remote buttons and see post window).
