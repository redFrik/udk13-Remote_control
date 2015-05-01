150430
======

download and install [supercollider](http://supercollider.github.io/download.html). pick either the stable version 3.6.6 or the latest 3.7 - both will work for our purposes.

simple tones
--

```
s.boot  //always run this first (to start the sound server)

1+1

2+2

4+4

Ndef(\first, {SinOsc.ar([400, 404])}).play
//stop the sound with cmd+.

//beating frequencies
Ndef(\first, {SinOsc.ar([400, 403])}).play

Ndef(\first, {SinOsc.ar([400, 402])}).play

Ndef(\first, {SinOsc.ar([400, 398])}).play
//notice how you replace the sound

//playing more sounds at the same time...
Ndef(\first, {SinOsc.ar([220, 222])}).play

Ndef(\second, {SinOsc.ar([300.5, 303])}).play

Ndef(\third, {SinOsc.ar([700, 707])}).play

Ndef(\fourth, {SinOsc.ar([703, 708])}).play

NdefMixer(s)

s.makeWindow

//and click 'record' to start recording a soundfile
//click again to stop

//stop sound with cmd+. (or alt+. on windows)

//run a lot of code at the same time.  add () and ;
//this is called a 'block' of code
(
Ndef(\third, {SinOsc.ar([700, 707])}).play;
Ndef(\fourth, {SinOsc.ar([703, 708])}).play;
)
```

microphone input
--

```
Ndef(\mic, { SoundIn.ar!2 } ).play  //!2 means duplicate the sound (in both speakers)

Ndef(\mic, { DelayN.ar(SoundIn.ar, 1, 1)!2 }).play

//ring modulation (multiply two sounds together)
Ndef(\mic, { DelayN.ar(SoundIn.ar, 1, 1) * SinOsc.ar(500)!2 }).play    //classic robotic effect

Ndef(\mic, { DelayN.ar(SoundIn.ar, 1, 1) * SinOsc.ar(5)!2 }).play       //much slower
```

remote sc server
--

just like you played sound on you local server (s - compare s.boot), you can play at other servers if you know the network address (IP) of the server.
to test the code below you will need two or more computers running supercollider connected to the same network (same wifi for example).

```
s.reboot    //reboot your local server

//find out the ip of the other computer (osx - see under system preferences / network)

f= Server(\f, NetAddr("192.168.43.132", 57110)).makeWindow  //here add the ip of the other computer
f.boot
f.initTree
Ndef(\noise9999 -> \f, { SinOsc.ar(1700) }).play
Ndef(\noise9999 -> \f, { SinOsc.ar(1700) }).stop



c= Server(\c, NetAddr("192.168.43.91", 57110))  //another computer
Ndef(\saw -> \c, {Saw.ar}).play
c.makeWindow
```




resources
=========

a gentle introduction to supercollider <https://ccrma.stanford.edu/~ruviaro/texts/A_Gentle_Introduction_To_SuperCollider.pdf>

Eli Fieldsteel's youtube tutorials <https://www.youtube.com/playlist?list=PLPYzvS8A_rTaNDweXe6PX4CXSGq4iEWYC>
