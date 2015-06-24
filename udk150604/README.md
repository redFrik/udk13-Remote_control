150604
======

more arduino and the sc serial port

please bring an arduino if you have one

arduino to sc
--
upload the arduino code 'arduinoToSupercollider_simple.ino'.

either connect a single loose wire to A0 (to get noise input), or a potentiometer (pot) or a light sensor (ldr).

![pot](potentiometer_bb.png?raw=true "pot")

![ldr](light_sensor_bb.png?raw=true "ldr")

then run 'arduinoToSupercollider_simple1.scd' in supercollider.

also try 'arduinoToSupercollider_simple2.scd' in supercollider to control the playback speed of a soundfile.

windows
--
there is no serial port in supercollider windows. to get around that problem you can run [this](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604/windows/arduinoToSupercollider_via_processing/arduinoToSupercollider_via_processing.pde) small relay program in [Processing](http://processing.org). it is also possible to use puredata, python or maxmsp - basically any program that has a serial port and opensoundcontrol objects.
