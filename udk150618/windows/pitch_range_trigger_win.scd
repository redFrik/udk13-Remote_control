//use with arduino sketch 'single_led_control.ino' and the 'supercolliderToArduino_via_processing' processing sketch
//turns on the led if the fundamental pitch is somewhere between 230 and 250 Hz

(
var n= NetAddr("127.0.0.1", 12000);
s.waitForBoot{
	Ndef(\mic, {
		var input= SoundIn.ar;
		var pitch= Pitch.kr(input)[0].poll;
		var trig= (pitch>230) & (pitch<250);
		SendReply.kr(Changed.kr(trig), '/mic', trig);
		DC.ar(0);
	}).play;
	OSCFunc({|msg|
		if(msg[3]==1, {
			"!!!!!!!!!!!!".postln;
			msg.postln;
			n.sendMsg("serial", 65);
		}, {
			"stopping".postln;
			msg.postln;
			n.sendMsg("serial", 66);
		});
	}, \mic);
}
)
