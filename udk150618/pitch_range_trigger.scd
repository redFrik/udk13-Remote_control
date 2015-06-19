//use with arduino sketch 'single_led_control.ino'

//improved version that filters out network messages from scsynth

SerialPort.listDevices//check the name and copy into the first line below

(
var port= SerialPort("/dev/tty.usbserial-A101NB6Z", 38400, crtscts: true);//edit
CmdPeriod.doOnce({port.close});
s.waitForBoot{
	Ndef(\mic, {|thresh= 0.1|
		var input= SoundIn.ar;
		var pitch= Pitch.kr(input)[0];
		var trig= (pitch>438) & (pitch<444);
		SendReply.kr(Changed.kr(trig), '/mic', trig);
		DC.ar(0);
	}).play;
	OSCFunc({|msg|
		if(msg[3]==1, {
			"!!!!!!!!!!!!".postln;
			msg.postln;
			port.put(65);
		}, {
			"stopping".postln;
			msg.postln;
			port.put(66);
		});
	}, \mic);
}
)
{SinOsc.ar(440)}.play
n.sendMsg(\toprocessing, 65);
n.sendMsg(\toprocessing, 66);
