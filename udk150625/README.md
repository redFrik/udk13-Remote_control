150625
======

ir remotes

ir receiving
--
first install the IRremote library from <https://github.com/shirriff/Arduino-IRremote/releases> (download the zip, extract it into your ~/Documents/Arduino/libraries folder).

then upload the [ir_receive.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150625/ir_receive/ir_receive.ino)

then connect an ir-receiver (here we use Vishay TSOP34838, 38kHz) to the arduino. connect the left most pin to pin11, the middle to GND and the right most to 5V on the arduino.

![ir_receive](ir_receive.jpg?raw=true "ir_receive")

last open the serial monitor in arduino, set the baudrate to 9600 and try some buttons on the remote controls.

links:

* <https://github.com/shirriff/Arduino-IRremote/wiki/Hardware-setup>
* <https://arduino-info.wikispaces.com/IR-RemoteControl>
* <https://learn.sparkfun.com/tutorials/ir-communication>
* <http://www.righto.com/2009/08/multi-protocol-infrared-remote-library.html>

ir sending
--
connect an ir led to another arduino. use pin3 with a resistor (120ohm) and connect via the long leg of the led to GND. like this...

![ir_send](ir_send.jpg?raw=true "ir_send")

then upload the [ir_send.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150625/ir_send/ir_send.ino)

if you open the serial monitor (for the receiver arduino) you should now see a counter being posted (0-3FF in hex). you will also see some errors if you increase the distance (the sony ir protocol should really send each number three times).

ir remote to sc
--
upload the sketch [ir_to_supercollider.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150625/ir_to_supercollider/ir_to_supercollider.ino) (it is only a slight modification to the above ir_receive sketch).
and then run the code in [ir_to_supercollider.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150625/ir_to_supercollider.scd). modify the keys to match your remote by pressing the remote buttons and look in the post window for key codes.

windows
--
there is no serial port in the current version of supercollider for windows. to get around that problem you can run [this](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150625/windows/ir_receive_via_processing/ir_receive_via_processing.pde) small relay program in [Processing](http://processing.org) together with [this](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150625/windows/ir_to_supercollider_win.scd) sc code. it is also possible to use puredata, python or maxmsp - basically any program that has both a serial port and opensoundcontrol objects.

advanced
--
to read 8 digital inputs very fast try this sc code [sc_digital_fast.scd](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150625/advanced/sc_digital_fast.scd) together with [sc_digital_fast.ino](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150625/advanced/sc_digital_fast/sc_digital_fast.ino) arduino sketch or the even faster [sc_digital_faster.ino](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150625/advanced/sc_digital_faster/sc_digital_faster.ino)

and to read 12 digital inputs try [sc_manydigital_fast.scd](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150625/advanced/sc_manydigital_fast.scd) together with arduino sketch [sc_manydigital_fast.ino](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150625/advanced/sc_manydigital_fast/sc_manydigital_fast.ino)
