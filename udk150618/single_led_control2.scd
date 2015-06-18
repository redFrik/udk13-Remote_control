//use with arduino sketch 'single_led_control.ino'

//improved version that filters out repetitions on the serial port

SerialPort.listDevices//check the name and copy into the first line below

(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit
CmdPeriod.doOnce({port.close});
s.waitForBoot{
	var state= 0;
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
			if(state==0, {
				state= 1;
				port.put(65);
			});
		}, {
			if(state==1, {
				state= 0;
				port.put(66);
			});
		});
	}, \mic);
}
)
