150430
======

some simple synthdef sounds to play with...
```
(
    SynthDef(\bass, {|amp= 0.5, freq= 50, rq= 0.1, atk= 0.01, rel= 0.1, cur= -4, gate= 1|
    var snd= Saw.ar(freq*[1, 1.01]);
    var env= EnvGen.ar(Env.asr(atk, 1, rel, cur), gate, doneAction:2);
    var filt= BPF.ar(snd*env*10, freq, rq);
    Out.ar(0, filt);
}).add;
SynthDef(\bd, {|amp= 0.5, freq= 50, rq= 0.1, atk= 0.001, rel= 0.1, cur= -4|
    var snd= SinOsc.ar(50*[1, 1.001], 0.5*pi);
    var env= EnvGen.ar(Env.perc(atk, rel, 1, cur), doneAction:2);
    Out.ar(0, snd*env);
}).add;
SynthDef(\sn, {|amp= 0.5, freq= 5000, atk= 0.01, rel= 0.1, cur= -4|
    var snd= ClipNoise.ar(amp!2);
    var env= EnvGen.ar(Env.perc(atk, rel, 1, cur), doneAction:2);
    var filt= LPF.ar(snd*env*10, freq)*SinOsc.ar(freq);
    Out.ar(0, filt);
}).add;
SynthDef(\hat, {|amp= 0.5, freq= 5000, rq= 0.1, atk= 0.01, rel= 0.1, cur= -4|
    var snd= ClipNoise.ar(amp!2);
    var env= EnvGen.ar(Env.perc(atk, rel, 1, cur), doneAction:2);
    var filt= BPF.ar(snd*env*10, freq, rq);
    Out.ar(0, filt);
}).add;
)
```


resources
=========

a gentle introduction to supercollider <https://ccrma.stanford.edu/~ruviaro/texts/A_Gentle_Introduction_To_SuperCollider.pdf>
Eli Fieldsteel's youtube tutorials <https://www.youtube.com/playlist?list=PLPYzvS8A_rTaNDweXe6PX4CXSGq4iEWYC>
