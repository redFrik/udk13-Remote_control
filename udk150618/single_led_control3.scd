//use with arduino sketch 'single_led_control.ino'

//improved version that filters out network messages from scsynth

SerialPort.listDevices//check the name and copy into the first line below

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
CmdPeriod.doOnce({port.close});
s.waitForBoot{
	Ndef(\mic, {|thresh= 0.1|
		var input= SoundIn.ar;//from internal mic
		var amp= Amplitude.kr(input, 0.01, 0.1).lag(0.1);//amplitude tracker
		SendReply.kr(Changed.kr(amp>thresh), '/mic', amp);//only send when crossing threshold
		DC.ar(0);
	}).play;
	OSCFunc({|msg|
		if(msg[3]>0.1, {
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
