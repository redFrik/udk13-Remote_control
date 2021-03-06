//use with arduino sketch 'single_led_control.ino'
//turns on the led if the fundamental pitch is somewhere between 230 and 250 Hz

SerialPort.listDevices//check the name and copy into the first line below

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
CmdPeriod.doOnce({port.close});
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
			port.put(65);
		}, {
			"stopping".postln;
			msg.postln;
			port.put(66);
		});
	}, \mic);
}
)
