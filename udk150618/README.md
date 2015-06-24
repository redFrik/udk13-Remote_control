150618
======

analysis
--
```
//pitch tracking in supercollider
{SinOsc.ar(Pitch.kr(SoundIn.ar)[0])}.play   //[0] means grab the frequency channel of the analysis

{SinOsc.ar(Pitch.kr(SoundIn.ar)[0])!2}.play //!2 means output in both left and right channel

{DelayN.ar(SinOsc.ar(Pitch.kr(SoundIn.ar)[0]), 1, 1)!2}.play    //add a delay to hear better


{SinOsc.ar((Pitch.kr(SoundIn.ar)[0]).poll)}.play    //.poll will post the detected fundamental frequency
//male voice ~85-155Hz
//female voice ~165-255Hz
//child voice ~250-300Hz
//whistle ~800-2500Hz

{SinOsc.ar((Pitch.kr(SoundIn.ar)[0] > 1000).poll)}.play //use frequency as a threshold

a= {|freq= 200| SinOsc.ar(Pitch.kr(HPF.ar(SoundIn.ar, freq))[0])}.play  //high pass filter before tracking
a.set(\freq, 4000)
a.set(\freq, 400)
a.set(\freq, 40)
```

```
//amplitude tracking in supercollider
{SinOsc.ar(Amplitude.kr(SoundIn.ar)*400+400)}.play

{SinOsc.ar(Amplitude.kr(SoundIn.ar).poll*400+400)}.play //posting
```

sc to arduino
--

two weeks ago we did [arduino to supercollider](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150604#arduino-to-sc) - now the other direction...

upload [single_led_control.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150618/single_led_control/single_led_control.ino) to the arduino board.
then run [single_led_control.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150618/single_led_control.scd) in supercollider.

now try [single_led_control2.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150618/single_led_control2.scd) and [single_led_control3.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150618/single_led_control3.scd). version 2 and 3 are optimizations of the first version. they send less data through the serial port.

connect a led with a resistor (120ohm) to pin13 like this...

![led](led_bb.png?raw=true "led")

advanced
--
try the [pitch_range_trigger.scd](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150618/pitch_range_trigger.scd) to turn on/off the led when the fundamental pitch is in a certain range.

try to incorporate amplitude tracking and trigger the only on loud sounds.

work with lag, delay, round etc to refine the behaviour. see [control signals](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150611#control-signals) from last week.

windows
--
there is no serial port in supercollider windows. to get around that problem you can run [this](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150618/windows/supercolliderToArduino_via_processing/supercolliderToArduino_via_processing.pde) small relay program in [Processing](http://processing.org). it is also possible to use puredata, python or maxmsp - basically any program that has both a serial port and opensoundcontrol objects.
