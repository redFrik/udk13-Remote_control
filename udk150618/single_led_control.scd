//use with arduino sketch 'single_led_control.ino'

SerialPort.listDevices//check the name and copy into the first line below

(
var port= SerialPort("/dev/tty.usbserial-A101NB6Z", 38400, crtscts: true);//edit
CmdPeriod.doOnce({port.close});
s.waitForBoot{
	Ndef(\mic, {
		var input= SoundIn.ar;//from internal mic
		var amp= Amplitude.kr(input, 0.01, 0.1);//amplitude tracker
		SendReply.kr(Impulse.kr(60), '/mic', amp);//60 times per second
		DC.ar(0);
	}).play;
	OSCFunc({|msg|
		msg.postln;
		if(msg[3]>0.1, {
			"!!!!!!!!!!!!".postln;
			port.put(65);
		}, {
			port.put(66);
		});
	}, \mic);
}
)
