//to use with arduino sketches 'sc_manydigital_fast.ino'
//it will read 12 digital inputs - arduino pins 2-13

SerialPort.listDevices

(
var port= SerialPort("/dev/tty.usbserial-A101NAZY", 115200, crtscts: true);//edit
var functions= {|i|
	{|state| ("function index:"+i+", state:"+state).postln}
}.dup(12);  //how many functions / how many pins
Routine.run({
	var byte, val= 0, lastVal, val2= 0, lastVal2, index= 0, res;
	inf.do{
		while({byte= port.read; byte.notNil}, {
			if(index==0, {
				lastVal= val;
				val= 255-byte;
				index= 1;
			}, {
				lastVal2= val2;
				val2= 255-byte;
				index= 0;
				res= val2<<8+val;
				res.asBinaryString(12).postln;  //debug
				8.do{|i|
					var bit1= (val>>i)&1;
					var bit2= (lastVal>>i)&1;
					if(bit1!=bit2, {
						functions[i].value(bit1);
					});
				};
				4.do{|i|
					var bit1= (val2>>i)&1;
					var bit2= (lastVal2>>i)&1;
					if(bit1!=bit2, {
						functions[i+8].value(bit1);
					});
				};
			});
		});
		0.01.wait;
	};
});
CmdPeriod.doOnce({port.close});
)
