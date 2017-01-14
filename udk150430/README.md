150430
======

download and install [supercollider](http://supercollider.github.io/download.html). pick either the stable version 3.6.6 or the latest 3.7 - both will work for our purposes.

simple tones
--

```supercollider
s.boot  //always run this first (to start the sound server)

1+1

2+2

4+4

Ndef(\first, {SinOsc.ar([400, 404])}).play
//stop the sound with cmd+.

//beating frequencies
Ndef(\first, {SinOsc.ar([400, 403])}).play

Ndef(\first, {SinOsc.ar([400, 402])}).play

Ndef(\first, {SinOsc.ar([400, 399])}).play
//notice how you replace the sound

//playing more sounds at the same time...
Ndef(\first, {SinOsc.ar([220, 222])}).play

Ndef(\second, {SinOsc.ar([300.5, 303])}).play

Ndef(\third, {SinOsc.ar([700, 707])}).play

Ndef(\fourth, {SinOsc.ar([603, 606])}).play

NdefMixer(s) //here you can mix and start/stop your sounds
```

now you have a simple sine tone synthesizer with gui control.
save the code in a with a .scd file extension and the next time you need to do some pads/drones just open the file and start exploring / tuning / modifying.

to record your sounds to a soundfile...

```supercollider
s.makeWindow    //click 'record' to start recording a soundfile
//click again to stop.
```
the resulting aiff file will end up in your home / music / supercollider recordings folder (on mac osx)

to run a lot of code at the same time add `()` around it and and `;` in the end of each line. this is called a 'block' of code.
```supercollider
(
Ndef(\third, {SinOsc.ar([700, 707])}).play;
Ndef(\fourth, {SinOsc.ar([703, 708])}).play;
)
```

the part of the code that looks like this... `SinOsc.ar([400, 404])` means play a sine tone with frequency 400Hz in left speaker, and another sine tone on with 404Hz in the right. connect headphones and start playing around with different beating frequencies.

microphone input
--

note: turn down computer volume before trying the next examples. it will feedback.
if you don't get any sound input double check that you have the built-in microphone selected under system preferences / audio / input.

```supercollider
Ndef(\mic, { SoundIn.ar!2 } ).play  //!2 means duplicate the sound (in both speakers)

Ndef(\mic, { DelayN.ar(SoundIn.ar, 1, 1)!2 }).play  //one second delay - note how SoundIn is 'inside' the DelayN

//ring modulation (multiply two sounds together)
Ndef(\mic, { DelayN.ar(SoundIn.ar, 1, 1) * SinOsc.ar(500)!2 }).play    //classic robotic effect - try changing freqency (500)

Ndef(\mic, { DelayN.ar(SoundIn.ar, 1, 1) * SinOsc.ar(5)!2 }).play       //also try with a much lower frequency - tremolo?
```

remote sc server
--

above you played all sound on your default local server `s` (compare `s.boot`), in supercollider you can also play sound on other remote servers if you know the network address (IP).
to test the code below you will need two or more computers running supercollider connected to the same network (same wifi for example).

```supercollider
s.options.maxLogins= 10 //number of allowed connections
s.reboot    //and reboot your local server

//find out the IP address of the other computer (osx - see under system preferences / network)

f= Server(\f, NetAddr("192.168.43.132", 57110)).makeWindow  //here add the ip of the other computer
f.boot
//f.initTree
Ndef(\noise9999 -> \f, { WhiteNoise.ar(0.2) }).play
Ndef(\noise9999 -> \f).stop

Ndef(\noise9999 -> \f).clear    //completely remove the sound

c= Server(\c, NetAddr("192.168.43.91", 57110)).makeWindow  //another computer
Ndef(\saw -> \c, {Saw.ar}).play //another sound
Ndef(\saw -> \c).stop
```

the gui for remote servers should look like this...

![remote_server](remote_server.png?raw=true "remote_server")

advanced
--

to reduce sample rate and bit resolution you can use the Latch ugen (sample and hold) in combination with the .round method.
```supercollider
Ndef(\bitCrusher, {Latch.ar(SinOsc.ar(400), Impulse.ar(5000)).round(0.001)!2}).play
s.scope

//with mic input and mouse x/y control
Ndef(\bitCrusher, {Latch.ar(DelayN.ar(SoundIn.ar, 1, 1), Impulse.ar(MouseX.kr(500, 10000).poll)).round(MouseY.kr(0, 0.1))!2}).play
```

so here the sine wave is both down sampled (sample rate) and rounded off in resolution (number of bits).

![bitCrusher](bitCrusher.png?raw=true "bitCrusher")

resources
=========

a gentle introduction to supercollider <https://ccrma.stanford.edu/~ruviaro/texts/A_Gentle_Introduction_To_SuperCollider.pdf>

Eli Fieldsteel's youtube tutorials <https://www.youtube.com/playlist?list=PLPYzvS8A_rTaNDweXe6PX4CXSGq4iEWYC>

David Cottle's computer music <http://www.mat.ucsb.edu/275/CottleSC3.pdf>
