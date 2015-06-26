//to use with arduino sketches 'sc_digital_fast.ino' or 'sc_digital_faster'
//it will read 8 digital inputs - arduino pins 2-9

SerialPort.listDevices

(
var port= SerialPort("/dev/tty.usbserial-A101NAZY", 115200, crtscts: true);//edit
var functions= {|i|
	{|state| ("function index:"+i+", state:"+state).postln}
}.dup(8);
Routine.run({
	var byte, lastByte= 0;
	inf.do{
		while({byte= port.read; byte.notNil}, {
			byte= 255-byte;  //invert
			byte.asBinaryString.postln;  //debug
			8.do{|i|
				var bit1= (byte>>i)&1;
				var bit2= (lastByte>>i)&1;
				if(bit1!=bit2, {
					functions[i].value(bit1);
				});
			};
			lastByte= byte;
		});
		0.01.wait;
	};
});
CmdPeriod.doOnce({port.close});
)
