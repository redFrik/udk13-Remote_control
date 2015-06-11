150611
======

control signals

```
//supercollider code with mouse x/y as controller
s.boot

Ndef(\mx, {SinOsc.ar(MouseX.kr(100, 1000, 1))}).play
Ndef(\mx, {SinOsc.ar(DelayN.ar(MouseX.kr(100, 1000, 1), 1, 1))}).play
Ndef(\mx, {SinOsc.ar(CombN.ar(MouseX.kr(100, 1000, 1), 1, 1, 5))}).play
Ndef(\mx, {SinOsc.ar(Lag3.kr(MouseX.kr(100, 1000, 1), 3))}).play
Ndef(\mx).stop

Ndef(\mxy, {SinOsc.ar(Lag3.kr(MouseX.kr(100, 1000, 1), 1))*SinOsc.ar(Lag3.kr(MouseY.kr(1, 50, 1), 4))}).play
Ndef(\mxy, {SinOsc.ar(Lag3.kr(MouseX.kr(100, 1000, 1), 1))*LFTri.ar(Lag3.kr(MouseY.kr(1, 50, 1), 4))}).play
Ndef(\mxy, {SinOsc.ar(Lag3.kr(MouseX.kr(100, 1000, 1), 1))*LFSaw.ar(Lag3.kr(MouseY.kr(1, 50, 1), 4))}).play
Ndef(\mxy, {SinOsc.ar(Lag3.kr(MouseX.kr(100, 1000, 1), 1))*LFPulse.ar(Lag3.kr(MouseY.kr(1, 50, 1), 4))}).play
Ndef(\mxy).stop

//--
//move the mouse to a place and leave it still for a while - then move it again
Ndef(\mxy2, {Splay.ar(SinOsc.ar(Lag3.kr(MouseX.kr(100, 1000, 1), [1, 2, 3]))*LFPulse.ar(Lag3.kr(MouseY.kr(1, 50, 1), [3, 2, 1])))}).play

//this one moves around by itself
Ndef(\mxy2, {Splay.ar(SinOsc.ar(Lag3.kr(LFNoise2.kr(0.1!3).round(0.5)*50+100, [1, 2, 3]))*LFPulse.ar(Lag3.kr(LFNoise2.kr(0.1!3).round(0.5)*2+[3, 4, 5])))}).play

//same but with added low pass filters
Ndef(\mxy2, {Splay.ar(BLowPass4.ar(Saw.ar(Lag3.kr(LFNoise2.kr(0.1!3).round(0.5)*50+100, [1, 2, 3])), 5000)*BLowPass4.ar(LFPulse.ar(Lag3.kr(LFNoise2.kr(0.1!3).round(0.5)*2+[3, 4, 5]))), [100, 200, 300])}).play

Ndef(\mxy2).stop
```
