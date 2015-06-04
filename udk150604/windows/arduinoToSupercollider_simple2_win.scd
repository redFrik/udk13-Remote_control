//--use with arduinoToSupercollider_simple.ino
//this example controls the playback speed of a soundfile

(
s.waitForBoot{
	b.free;
	b= Buffer.read(s, "/Applications/SuperCollider344/sounds/chaos.aiff");//edit
	s.sync;
	Ndef(\file).play;
	Ndef(\file, {|rate= 1| Splay.ar(PlayBuf.ar(b.numChannels, b.bufnum, rate, loop:1))});
};
)

//Ndef(\file).set(\rate, 1.5)

//connect arduino and upload code: arduinoToSupercollider_simple.ino
//then start the relay 'arduinoToSupercollider_via_processing' sketch in processing
(
Ndef(\sound).play;
OSCFunc({|msg|
	msg.postln;
	Ndef(\file).set(\rate, msg[1].linlin(0, 255, 0.25, 4));
}, \serial);
)
