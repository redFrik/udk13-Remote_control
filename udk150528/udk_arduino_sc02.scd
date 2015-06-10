
SerialPort.listDevices;

(
p= SerialPort("/dev/tty.usbserial-A101NB6Z", 9600, crtscts: true);//edit to match your port name
CmdPeriod.doOnce({p.close});//extra safety
Routine.run({
	inf.do{
		var byte= p.read;//values 0-255
		byte.asAscii.postln;
	};
});
)
