150625
======

ir remotes
--
first install the IRremote library from <https://github.com/shirriff/Arduino-IRremote/releases>

then upload the [ir_receive.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150626/ir_receive/ir_receive.ino)

then connect a ir-receiver (here we use Vishay TSOP34838, 38kHz) to the arduino. connect the left most pin to 5V, the middle to GND and the right most to pin11 on the arduino.

![ir_receive](ir_receive.jpg?raw=true "ir_receive")

last open the serial monitor in arduino, set the baudrate to 9600 and try some buttons on the remote controls.

links:

* <https://github.com/shirriff/Arduino-IRremote/wiki/Hardware-setup>
* <https://arduino-info.wikispaces.com/IR-RemoteControl>
* <https://learn.sparkfun.com/tutorials/ir-communication>
* <http://www.righto.com/2009/08/multi-protocol-infrared-remote-library.html>
