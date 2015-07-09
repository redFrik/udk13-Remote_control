150709
======

repetition

arduino & supercollider together with...

* leds
* dcmotors/solenoids
* server motor
* 433mhz radio (220v)
* ir remote
* sensors:
    shock
    light
    ultrasound
    bend

supercollider topics:

* mic (delays, effects)
* multi channel (panning)
* soundfile cutups
* filter, smooth, threshold, schmidt
* networking

arduino topics:

* voltage dividers
* serial communication (call&response)
* pwm

questions:
--
how to set the amplitude for a pdef+pbind from arduino
```
//technique one - use a variable and read it with pfunc
~myAmp= 1;
Pdef(\test, Pbind(\amp, Pfunc({~myAmp}))).play;
~myAmp= 0.1;
~myAmp= 0.5;
~myAmp= 0.9;
```

```
//technique two - use a control rate bus
a= Bus.control(s);
(
SynthDef(\myInstr, {|bus|
    var src= SinOsc.ar(500, 0, In.kr(bus)*Line.kr(1, 0, 0.1, doneAction:2));
    Out.ar(0, src!2);
}).add;
)
a.set(1);
Pdef(\test, Pbind(\instrument, \myInstr, \bus, a)).play;
a.set(0.1);
a.set(0.5);
a.set(0.9);
```

how to use ndef as an effect
```
//technique one - embedd
Ndef(\a, {LFTri.ar([500, 505], 0, Decay.ar(Impulse.ar(1), 0.3))});
Ndef(\b, {GVerb.ar(Ndef.ar(\a))}).play;
```

```
//technique two - the filter method
Ndef(\c, {LFTri.ar([500, 505], 0, Decay.ar(Impulse.ar(1), 0.3))});
Ndef(\c).filter(1, {|snd| GVerb.ar(snd)})
Ndef(\c).play;
```
