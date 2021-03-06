150604
======

more arduino and the sc serial port

please bring an arduino if you have one

arduino to sc
--
upload the arduino code [arduinoToSupercollider_simple.ino](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604/arduinoToSupercollider_simple/arduinoToSupercollider_simple.ino).

either connect a single loose wire to A0 (to get noise input), or a potentiometer (pot) or a light sensor (ldr).

![pot](potentiometer_bb.png?raw=true "pot")

![ldr](light_sensor_bb.png?raw=true "ldr")

then run [arduinoToSupercollider_simple1.scd](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604/arduinoToSupercollider_simple1.scd) in supercollider.

also try [arduinoToSupercollider_simple2.scd](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604/arduinoToSupercollider_simple2.scd) in supercollider to control the playback speed of a soundfile.

note: the light sensor (ldr) needs an additional 10K resistor. read about voltage dividers [here](https://learn.sparkfun.com/tutorials/voltage-dividers)

advanced
--
to read six analog sensors at high speed and in full 10bit (0-1023) resolution, upload the [arduinoToSupercollider_advanced.ino](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604/arduinoToSupercollider_advanced/arduinoToSupercollider_advanced.ino) to an arduino, and then use the [arduinoToSupercollider_advanced.scd](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604/arduinoToSupercollider_advanced.scd) example in supercollider.

windows
--
there is no serial port in the current version of supercollider for windows. to get around that problem you can run [this](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604/windows/arduinoToSupercollider_via_processing/arduinoToSupercollider_via_processing.pde) small relay program in [Processing](http://processing.org) together with [this](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604/windows/arduinoToSupercollider_simple1_win.scd) and [this](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604/windows/arduinoToSupercollider_simple2_win.scd) sc code. it is also possible to use puredata, python or maxmsp - basically any program that has both a serial port and opensoundcontrol objects.
