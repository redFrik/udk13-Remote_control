150507
======

first some recap of last week...

```supercollider
s.boot

Ndef(\mic, {DelayN.ar(SoundIn.ar(0), 1, 1)*SinOsc.ar(500)!2}).play

Ndef(\mic, {DelayN.ar(SoundIn.ar(0), 1, 1)*SinOsc.ar(MouseX.kr(1, 5000, 1))!2}).play

//to record a soundfile run this
s.makeWindow //and click the record button

//another option to record is to use the following commands...
s.record;
s.stopRecording;

//recorded soundfiles should end up in your home directory under Music/SuperCollider Recordings/ (on mac osx)
thisProcess.platform.recordingsDir  //run this to check where your files end up
```

the following is a variation of the delay from [last](https://github.com/redFrik/udk13-Remote_control/tree/master/udk150430#microphone-input) week.
but here we set different delay times for left and right channel (0.9 in left, 0.8 in right).
the effect is easier to hear in headphones.
```supercollider
Ndef(\pingpong, {DelayN.ar(SoundIn.ar(0), 1, [0.9, 0.8])}).play

Ndef(\pingpong, {DelayN.ar(SoundIn.ar(0), 1, [0.9, 0.8])*SinOsc.ar([500, 6000])}).play

Ndef(\pingpong, {DelayN.ar(SoundIn.ar(0), 10, [9, 8])*SinOsc.ar([500, 6000])}).play
```


```supercollider
//example with three long delay lines
s.options.memSize= 65536*4; //give more memory to sound server
s.reboot;   //restart sound server
(
Ndef(\pingpong, {DelayN.ar(SoundIn.ar(0), 10, [7, 4])*SinOsc.ar([500, 6000])}).play;
Ndef(\pingpong2, {DelayN.ar(SoundIn.ar(0), 10, [6, 8])*SinOsc.ar([550, 3000])}).play;
Ndef(\pingpong3, {DelayN.ar(SoundIn.ar(0), 10, [9, 8])*SinOsc.ar([700, 5000])}).play;
)
NdefMixer(s);   //gui for mixing delays
```


network
--

to send opensound control (osc) messages over network to other laptops, first connect to the same wifi.
then use for example [lanscan](http://www.iwaxx.com/lanscan/) for listing the ip addresses of connect laptops.

```supercollider
s.boot;
(
OSCFunc({|msg|
    msg.postln;
    Ndef(\snd, {SinOsc.ar(msg[2])*Line.ar(1, 0, 0.1)}).play;    //ping sound when message received
}, \hiho);  //receive this type of messages (could be anything - just match with sendMsg below)
)

(
n= NetAddr("192.168.2.35", 57120);  //ip address of some computer running sc on the network
n.sendMsg(\hiho, \fromFO, 3500);    //send the message
)
```

to make a little sequencer that send to many laptops in order, one can use a Routine

```supercollider
(
r= Routine({
    inf.do{
        [1, 32, 34, 35, 36, 37].do{|i|  //numbers here are last number in all ip addresses we want to send to
            var ip= "192.168.2."++i.asInteger;
            ip.postln;
            n= NetAddr(ip, 57120);
            n.sendMsg(\hiho, \fromFO, (i+30).midicps);
            0.25.wait;
        };
    };
})
)

r.play
r.stop
```

more noise
--

```supercollider
s.reboot

Ndef(\perc, {WhiteNoise.ar*SinOsc.ar(5)!2}).play
Ndef(\perc).fadeTime= 4 //4sec crossfade time (the time it takes to change to new code)

Ndef(\perc, {WhiteNoise.ar*SinOsc.ar(14)!2}).play
Ndef(\perc, {PinkNoise.ar*SinOsc.ar(12)!2}).play
Ndef(\perc, {BrownNoise.ar*SinOsc.ar(8)!2}).play
Ndef(\perc, {ClipNoise.ar*SinOsc.ar(8)!2}).play
Ndef(\perc, {GrayNoise.ar*SinOsc.ar(8)!2}).play

Ndef(\perc).fadeTime= 10

Ndef(\perc, {WhiteNoise.ar*LFSaw.ar(2)!2}).play
Ndef(\perc, {WhiteNoise.ar*LFTri.ar(2)!2}).play
Ndef(\perc, {WhiteNoise.ar*LFPulse.ar(2)!2}).play

Ndef(\perc, {SinOsc.ar(400)*LFPulse.ar(2)!2}).play
Ndef(\perc, {SoundIn.ar(0)*LFPulse.ar(2)!2}).play

//alarms!
Ndef(\perc, {LFPulse.ar(500)*LFPulse.ar(2)!2}).play
Ndef(\perc, {LFPulse.ar(600)*LFPulse.ar(3)!2}).play
Ndef(\perc, {LFPulse.ar(700)*LFPulse.ar(4)!2}).play
Ndef(\perc, {LFPulse.ar(7000)*LFPulse.ar(4)!2}).play
Ndef(\perc).stop(5) //fade out over 5sec
```

```supercollider
//play many at the same time
Ndef(\perc1, {LFPulse.ar(500)*LFPulse.ar(2)!2}).play;
Ndef(\perc2, {LFPulse.ar(600)*LFPulse.ar(3)!2}).play;
Ndef(\perc3, {LFPulse.ar(700)*LFPulse.ar(4)!2}).play;
Ndef(\perc4, {LFPulse.ar(7000)*LFPulse.ar(4)!2}).play;
NdefMixer(s);   //gui for mixing
```


```supercollider
//make a little script / composition
(
Ndef(\perc).fadeTime= 5;
Routine({
    Ndef(\perc, {LFPulse.ar(500)*LFPulse.ar(2)!2}).play;
    4.wait;
    "hier".postln;
    Ndef(\perc, {LFPulse.ar(600)*LFPulse.ar(3)!2}).play;
    5.wait;
    "now this".postln;
    Ndef(\perc, {LFPulse.ar(700)*LFPulse.ar(4)!2}).play;
    0.5.wait;
    Ndef(\perc, {LFPulse.ar(7000)*LFPulse.ar(4)!2}).play;
    "the end".postln;
    2.wait;
    Ndef(\perc).stop(3);
}).play
)
```


advanced
--

here we set up envelopes that are triggered with some low frequency oscillator.
then you have more control over the shape of the sound - also try `Env.adsr` and `Env.new` and the curve argument.

```supercollider
//more advanced envelopes (Env.perc)
Ndef(\perc, {ClipNoise.ar(1)*EnvGen.ar(Env.perc(0.01, 0.9), LFPulse.ar(4))}).play
Ndef(\perc, {SinOsc.ar(400)*EnvGen.ar(Env.perc(0.01, 0.1), LFPulse.ar(4))}).play
Ndef(\perc, {Saw.ar(400)*EnvGen.ar(Env.perc(0.01, 0.1), LFPulse.ar(4))}).play
Ndef(\perc, {Saw.ar(400)*EnvGen.ar(Env.perc(0.001, 0.2), LFPulse.ar([4, 3]))}).play
Ndef(\perc, {Saw.ar([400, 404])*EnvGen.ar(Env.adsr(0.001, 0.05, 0.4, 0.1), LFPulse.ar([4, 3]))}).play
Ndef(\perc, {Saw.ar([400, 404])*EnvGen.ar(Env([0, 1, 0], [0.1, 0.1], [4, -4]), LFPulse.ar([4, 3]))}).play
Ndef(\perc).stop
Env([0, 1, 0], [0.1, 0.1], [4, -4]).plot
Env.perc(0.1, 0.5).plot
```
