SerialPort.listDevices;

(
b.free;
b= Buffer.read(s, "~/PollySounds/choir/bell/bell1.wav".standardizePath);
p= SerialPort("/dev/tty.usbserial-A101NB6Z", 9600, crtscts: true);
CmdPeriod.doOnce({p.close});//extra safety
Routine.run({
	var playing= false;
	var distorting= false;
	inf.do{
		var byte= p.read;//values 0-255
		byte.asAscii.postln;
		if(byte==65, {
			if(playing==false, {
				Ndef(\soundfile, {PlayBuf.ar(b.numChannels, b, 0.5.rrand(3.0), loop:1)}).play;
				//Ndef(\soundfile, {SinOsc.ar(XLine.ar(5000.rand, 5000.rand, 0.1))}).play;
				playing= true;
			});
		});
		if(byte==66, {
			if(playing==true, {
				Ndef(\soundfile).stop;//stop soundfile
				playing= false;
			});
		});
		if(byte==67, {
			if(distorting==false, {
				Ndef(\dist, {(Ndef.ar(\soundfile)*40).distort*0.5}).play;
				distorting= true;
			});
		});
		if(byte==68, {
			if(distorting==true, {
				Ndef(\dist).stop;
				distorting= false;
			});
		});
	};
});
)

//A = play soundfile
//B = stop soundfile
//C = distort on
//D = distort off
