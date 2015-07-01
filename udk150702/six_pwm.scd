//use together with arduino sketch 'six_pwm.ino'

SerialPort.listDevices//check the name and copy into the first line below

//--super simple test - pulsating leds
(
var port= SerialPort("/dev/tty.usbserial-A101NAZY", 38400, crtscts: true);//edit
~speeds= [0.01, 0.02, 0.03, 0.04, 0.05, 0.06];
~curve= 2;
Routine.run({
	var cnt= 0;
	inf.do{
		port.put(10);
		6.do{|i|
			port.put(sin(cnt*~speeds[i]).lincurve(-1, 1, 0, 255, ~curve).asInteger);
		};
		port.put(11);
		cnt= cnt+1;
		0.01.wait;
	};
});
CmdPeriod.doOnce({port.close});
)

//stop with cmd+.



