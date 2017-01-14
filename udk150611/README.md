150611
======

control signals
--

here we will use mouse x and y position to simulate (analogue) sensor inputs.

some important topics are demonstrated that really can change the way a sensor input behaves.  using it as a switch (threshold), mixing and averaging control signals, smoothing (lag) and envelopes (lagud), differentiating to detect change, quantizing (round), delaying the signal to make it less immediate and more complex response, etc.

```supercollider
s.boot

//--control signals
{MouseX.kr(50, 5000).poll}.play //look in postwindow

{SinOsc.ar(MouseX.kr(50, 5000).poll)}.play

//--threshold

//analogue signal -> digital signal
{(MouseX.kr(0, 1)>0.75).poll}.play

{(MouseX.kr(0, 1)>0.25).poll * SinOsc.ar([400, 404])}.play

{(MouseX.kr(0, 1) + MouseY.kr(0, 1)).poll>1.5 * SinOsc.ar([400, 404])}.play

//--average

{((MouseX.kr(0, 1)+MouseY.kr(0, 1))/2).poll}.play

//--smoothing

{(MouseX.kr(0, 1)>0.75).lag(3)*SinOsc.ar([400, 404])}.play

{(MouseX.kr(0, 1)>0.75).lag(0.7)*SinOsc.ar([400, 404])}.play

{(MouseX.kr(0, 1)>0.75).lagud(0.02, 2)*SinOsc.ar([400, 404])}.play

(
{(MouseX.kr(0, 1)>0.15).lagud(0.1, 4)*SinOsc.ar([400, 404])}.play;
{(MouseX.kr(0, 1)>0.25).lagud(0.2, 5)*SinOsc.ar([500, 505])}.play;
{(MouseX.kr(0, 1)>0.35).lagud(0.3, 6)*SinOsc.ar([600, 606])}.play;
{(MouseX.kr(0, 1)>0.45).lagud(0.4, 7)*SinOsc.ar([700, 707])}.play;
{(MouseX.kr(0, 1)>0.55).lagud(0.5, 8)*SinOsc.ar([800, 808])}.play;
)

//try to replace all SinOsc with any of these...
Blip, LFTri, Saw, Pulse, Impulse

(
{(MouseX.kr(0, 1)>0.15).lagud(0.1, 4)*Impulse.ar([400, 404])}.play;
{(MouseX.kr(0, 1)>0.25).lagud(0.2, 5)*Impulse.ar([500, 505])}.play;
{(MouseX.kr(0, 1)>0.35).lagud(0.3, 6)*Impulse.ar([600, 606])}.play;
{(MouseX.kr(0, 1)>0.45).lagud(0.4, 7)*Impulse.ar([700, 707])}.play;
{(MouseX.kr(0, 1)>0.55).lagud(0.5, 8)*Impulse.ar([800, 808])}.play;
)

//--smoothing pitch

{SinOsc.ar(MouseX.kr(200, 2000, 1))}.play;  //no smooth
{SinOsc.ar(MouseX.kr(200, 2000, 1).lag(4))}.play;   //a lot of smoothing
{SinOsc.ar(MouseX.kr(200, 2000, 1).lagud(0.01, 4))}.play;   //different smooth attack and release

//--quantizing

{SinOsc.ar(MouseX.kr(200, 2000, 1).round(100))}.play

{SinOsc.ar(MouseX.kr(200, 2000, 1).round(100).lag(0.2))}.play

(
{SinOsc.ar(MouseX.kr(200, 2000, 1).round(100).lag(0.01))}.play;
{SinOsc.ar(MouseX.kr(300, 3000, 1).round(110).lag(0.1))}.play;
{SinOsc.ar(MouseX.kr(400, 4000, 1).round(120).lag(0.2))}.play;
{SinOsc.ar(MouseX.kr(500, 5000, 1).round(130).lag(0.3))}.play;
)

//adding amplitude control
{SinOsc.ar(MouseX.kr(200, 2000, 1).round(100))*MouseY.kr(0, 1)}.play

(
{SinOsc.ar(MouseX.kr(200, 2000, 1).round(100))*MouseY.kr(0, 1).lag(2)}.play;
{SinOsc.ar(MouseX.kr(300, 2000, 1).round(100))*MouseY.kr(0, 1).lag(3)}.play;
{SinOsc.ar(MouseX.kr(400, 2000, 1).round(100))*MouseY.kr(0, 1).lag(4)}.play;
{SinOsc.ar(MouseX.kr(500, 2000, 1).round(100))*MouseY.kr(0, 1).lag(5)}.play;
)

//--difference
//(good for accelerometers)
{SinOsc.ar(MouseX.kr(200, 2000, 1))*HPZ1.kr(MouseY.kr(0, 1000)).lag(0.05)}.play

{SinOsc.ar(HPZ1.kr(MouseX.kr(200, 2000, 1)*1000).lag(0.2))*HPZ1.kr(MouseY.kr(0, 1000)).lag(0.05)}.play

//HPZ1 basically takes the difference between current and previous sample (here current and previous mouse position)

//--delay

{SinOsc.ar(DelayN.kr(MouseX.kr(200, 2000, 1), 3, 3))}.play

{SinOsc.ar(DelayN.kr(MouseX.kr(200, 2000, 1), 3, 3))*DelayN.kr(MouseY.kr(0, 1), 2, 2)}.play

(
{SinOsc.ar(DelayN.kr(MouseX.kr(200, 2000, 1), 3, 3))*DelayN.kr(MouseY.kr(0, 1), 2, 2)}.play;
{SinOsc.ar(DelayN.kr(MouseX.kr(300, 2000, 1), 3, 2))*DelayN.kr(MouseY.kr(0, 1), 2, 1)}.play;
{SinOsc.ar(DelayN.kr(MouseX.kr(400, 2000, 1), 3, 1))*DelayN.kr(MouseY.kr(0, 1), 2, 0.5)}.play;
{SinOsc.ar(DelayN.kr(MouseX.kr(500, 2000, 1), 3, 0.5))*DelayN.kr(MouseY.kr(0, 1), 2, 0.25)}.play;
)

//combination
(
{SinOsc.ar(DelayN.kr(MouseX.kr(200, 2000, 1).round(100), 3, 3))*DelayN.kr(MouseY.kr(0, 1), 2, 2).lag(2)}.play;
{SinOsc.ar(DelayN.kr(MouseX.kr(300, 2000, 1), 3, 2)).round(50)*DelayN.kr(MouseY.kr(0, 1), 2, 1).lag(3)}.play;
{SinOsc.ar(DelayN.kr(MouseX.kr(400, 2000, 1), 3, 1)).round(25)*DelayN.kr(MouseY.kr(0, 1), 2, 0.5).lag(4)}.play;
{SinOsc.ar(DelayN.kr(MouseX.kr(500, 2000, 1), 3, 0.5)).round(12.5)*DelayN.kr(MouseY.kr(0, 1), 2, 0.25).lag(5)}.play;
)
```

now with arduino
--

use the arduino code from last week.

* upload [arduinoToSupercollider_simple.ino](https://github.com/redFrik/udk13-Remote_control/blob/master/udk150604/arduinoToSupercollider_simple/arduinoToSupercollider_simple.ino)

* connect a lightsensor with a 10K resistor to pin A0 (voltage divider)

* run the code below in supercollider

* change the Ndef(\sound) line and play with different techniques

```supercollider
SerialPort.listDevices//check the name and copy into the first line below
(
var port= SerialPort("/dev/tty.usbserial-A101NB6Z", 38400, crtscts: true);//edit
    Ndef(\sound, {|mx| SinOsc.ar(mx.lag(0.1, 3))}).play;    //here try round, delay, lag, hpz1 etc
    Routine.run({
        var byte;
        inf.do{
            while({byte= port.read; byte.notNil}, {
                byte.postln;
                Ndef(\sound).set(\mx, byte.linexp(0, 255, 100, 2000));
            });
            0.01.wait;
        };
    });
    CmdPeriod.doOnce({port.close});
)
```

advanced
--
to increase your supercollider server memory, run the following code each time you start up (or put it in your startup.scd file)
```supercollider
s.options.memSize= 8192*8;
s.reboot;
```

this will let you allocate more delays.

how to read the mouse within a pbind
--
```supercollider
(
~mxbus= Bus.control(s, 1);
{Out.kr(~mxbus.index, MouseX.kr(200, 2000, 1)); DC.ar(0)}.play;

Pbind(\dur, 0.2, \freq, Pfunc({~mxbus.getSynchronous.postln})).play
)
```

extra
--

```supercollider
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
