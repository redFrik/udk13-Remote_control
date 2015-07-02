//use together with arduino sketch 'servo.ino'

SerialPort.listDevices//check the name and copy into the first line below

//--super simple test - servo sweeping full range
(
var port= SerialPort("/dev/tty.usbserial-A101NAZY", 38400, crtscts: true);//edit
~speed= 0.005;
Routine.run({
	var cnt= 0;
	inf.do{
		port.put(cnt.fold(0, 180));
		cnt= cnt+1;
		~speed.wait;
	};
});
CmdPeriod.doOnce({port.close});
)

//stop with cmd+.


//--annoying example with sound
(
var port= SerialPort("/dev/tty.usbserial-A101NAZY", 38400, crtscts: true);//edit
~speed= 0.005;
s.waitForBoot{
	Ndef(\saw, {|freq= 500, pan= 0| Pan2.ar(Saw.ar(freq.lag(0.1), SinOsc.ar(freq/2)), pan)}).play;
	Routine.run({
		var cnt= 0;
		inf.do{
			var pos= cnt.fold(0, 180);
			port.put(pos);
			Ndef(\saw).set(\freq, pos.linexp(0, 180, 100, 1000), \pan, pos.linlin(0, 180, -1, 1));
			if(cnt%200==0, { //how often to consider the below random choices
				if(0.1.coin, {  //some chance of jumping to random position
					cnt= 180.rand.postln;
					("jumping to:"+cnt).postln;
				}, {
					if(0.1.coin, {  //some chance of pausing
						0.1.rrand(2).wait;
					}, {
						if(0.1.coin, {  //some chance of new speed
							~speed= 0.015.rand;
							("new speed:"+~speed).postln;
						});
					});
				});
			});
			cnt= cnt+1;
			~speed.wait;
		};
	});
};
CmdPeriod.doOnce({port.close});
)

//stop with cmd+.
