//--use with arduinoToSupercollider_simple.ino
//and with
//this example controls the frequency of a sawtooth oscillator


//debug all incoming osc...
OSCFunc.trace(true);
OSCFunc.trace(false);

(
s.waitForBoot{
	Ndef(\sound).play;
	Ndef(\sound, {|freq= 400, amp= 1| BLowPass4.ar(Saw.ar([freq, freq+1].lag(0.1), amp))});
};
)

//first test that frequency and amplitude is changing
Ndef(\sound).set(\freq, 255);
Ndef(\sound).set(\freq, 680);
Ndef(\sound).set(\amp, 0.4);

//connect arduino and upload code: arduinoToSupercollider_simple.ino
//then start the relay 'arduinoToSupercollider_via_processing' sketch in processing
(
Ndef(\sound).play;
OSCFunc({|msg|
	msg.postln;
	Ndef(\sound).set(\freq, msg[1].linexp(0, 255, 100, 2000));
}, \serial);
)

//load a soundfile
b= Buffer.read(s, "/Users/Stirling/PollySounds/choir/bell/bell2.wav"); //edit

//together with the code above this should make arduino A0 control playbackrate
Ndef(\sound, {|freq= 400, amp= 1| PlayBuf.ar(b.numChannels, b, freq.lag(0.2)/200, loop:1)*amp}).play;
//experiment with different lag times (0.2) and rate scale (/200)

//mic input
Ndef(\sound, {|freq= 400, amp= 1| CombC.ar(SoundIn.ar, 1, freq.lag(0.01)/1000)}).play

Ndef(\sound).stop;
//and press cmd+. to stop the osc/serial input
