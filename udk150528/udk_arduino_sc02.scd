SerialPort.listDevices;

(
p= SerialPort("/dev/tty.usbserial-A101NB79", 9600, crtscts: true);
CmdPeriod.doOnce({p.close});//extra safety
Routine.run({
	inf.do{
		var byte= p.read;//values 0-255
		byte.asAscii.postln;
	};
});
)


//A = play soundfile
//B = stop soundfile
//C = distort on
//D = distort off
