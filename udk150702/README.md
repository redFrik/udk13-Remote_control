150702
======

actuators (leds, solenoids, motors etc)

led
--
let us begin by fading in and out a single led from supercollider.

connect the led together with a resistor (100 to 1K) to pin 11 like this...

![simple_led](simple_led.jpg?raw=true "simple_led")

note the orientation of the led. the short leg / marking should go via the resistor to ground (gnd). you can also put the resistor 'before' the led, but still the shorter led leg should go to gnd.

then upload the arduino sketch [simple_led.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150702/simple_led/simple_led.ino) and try the supercollider code in [simple_led.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150702/simple_led.scd).

play with the curvature example and see how different the led can behave.

leds
--
to control more leds connect six leds using the same resistor+led setup for each of the pwm-enabled (~) arduino output pins (3, 5, 6, 9, 10, 11).

upload the arduino sketch [six_pwm.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150702/six_pwm/six_pwm.ino) and try the supercollider code in [six_pwm.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150702/six_pwm.scd).

dc motors
--
note: never connect anything that draws more than 40mA directly to the arduino output pins. that means basically nothing more than one or two leds per pin.

to connect motor, lamps, solenoids and other devices that need more than 40mA current and higher voltage than 5V, you will need some kind of driver circuit - one per arduino output pin. there are cheap modules to buy or you can build your own using mosfets or transistors.

the transistors tip120 (also tip121, tip122, tip29a etc) are very easy to use. see [here](https://www.instructables.com/Use-Arduino-with-TIP120-transistor-to-control-moto/).
additionally you will only need a 1K resistor and a flyback 1N4001 diode (also 1N4002...1N4007).

connect a dc motor like this... (choose any pin with a ~ mark)

![tip120](tip120.jpg?raw=true "tip120")

use VIN and middle tip120 pin for the dc motor wires. note the polarity of the diode.

note: if you are using a bigger motor (like in the picture) and need more than 5v to drive it, connect a wall adapter with 9vdc or 12vdc to the arduino jack (also like in the picture).

now again try the six_pwm code from above. instead of fade leds the motor speed will vary. the polarity (+/-) of the dc motor does not matter here.

note: dc motors can be recognised as they only have two wires. there are also stepper and servo motors but they have more wires.

servo motors
--
connect 5V, pin9 and gnd to a servo.

upload the arduino sketch [servo.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150702/servo/servo.ino) and try the supercollider code in [servo.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150702/servo.scd).

![servo](servo.jpg?raw=true "servo")

more info [here](https://learn.adafruit.com/adafruit-arduino-lesson-14-servo-motors?view=all)

advanced - many leds
--
six pwm channels is the maximum on the standard arduino. to get more one can either use softpwm (flipping digital pins on/off very fast in your code), buy a special pwm module like [adafruit 24channel pwm](https://www.adafruit.com/product/1429) or a cheaper pwm chip like the [tlc5940](https://tronixstuff.com/2013/10/21/tutorial-arduino-tlc5940-led-driver-ic/).

extra
--
to send osc commands from supercollider to [processing](https://www.processing.org) look at [supercolliderToProcessing.pde](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150702/extra/supercolliderToProcessing/supercolliderToProcessing.pde) and [supercolliderToProcessing.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150702/extra/supercolliderToProcessing.scd)

extra2
--
in the folder [extra2](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150702/extra2/) there are some python examples that show how to receive osc commands and control gpio pins on a raspberry pi. see the file readme.txt for more information.
