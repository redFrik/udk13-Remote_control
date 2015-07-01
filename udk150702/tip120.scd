//use together with arduino sketch 'six_pwm.ino'
//connect dc motors or solenoids

SerialPort.listDevices//check the name and copy into the first line below

//--simple random rhythms
(
var port= SerialPort("/dev/tty.usbserial-A101NAZY", 38400, crtscts: true);//edit
Routine.run({
	inf.do{
		port.put(10);
		6.do{|i| port.put(2.rand*255)};  //turn som on
		port.put(11);
		0.1.wait;
		port.putAll([10, 0, 0, 0, 0, 0, 0, 11]);  //turn all off
		0.1.wait;
	};
});
CmdPeriod.doOnce({port.close});
)

//stop with cmd+.





//--more advanced - rhythmic patterns
(
var port= SerialPort("/dev/tty.usbserial-A101NAZY", 38400, crtscts: true);//edit
~speed= 0.15;
~seq= [
	[0, 0, 0, 1, 0, 0, 0, 1],
	[0, 0, 1, 0, 0, 1, 1, 0],
	[0, 0, 0, 0, 1, 0, 0, 0],
	[1, 0, 0, 0, 1, 0, 0, 0],
	[1, 1, 0, 0, 0, 0, 0, 0],
	[1, 0, 1, 0, 1, 0, 0, 0]
];
Routine.run({
	var cnt= 0;
	inf.do{
		port.put(10);
		port.putAll((~seq.flop.wrapAt(cnt)*255).asInteger);
		port.put(11);
		(~speed*0.5).wait;
		port.putAll([10, 0, 0, 0, 0, 0, 0, 11]);  //turn all off
		(~speed*0.5).wait;
		cnt= cnt+1;
	};
});
CmdPeriod.doOnce({port.close});
)

//edit while playing (also possible with floats 0.5 for weaker hits although note the non-linearity)
(
~seq= [
	[1, 1, 0, 1, 0, 0, 0, 1],
	[0, 0, 1, 0, 0, 1, 1, 0],
	[0, 0, 0, 0, 1, 0, 0, 0],
	[1, 0, 0, 0, 1, 0, 0, 0],
	[1, 1, 0, 0, 0, 0, 0, 0],
	[1, 0, 1, 0, 1, 0, 0, 0]
];
)

//scramble all patterns
(
~seq= ~seq.collect{|x| x.scramble};  //random order for each pattern
)

//new random rhythms (16 ticks long)
(
~seq= ~seq.collect{|x| {2.rand}!16};  //random order for each pattern
)

~speed= 0.12  //faster

//stop with cmd+.





//--extra (thanks to Rukano for idea)

Quarks.install("Bjorklund");
//recompile

(
var port= SerialPort("/dev/tty.usbserial-A101NAZY", 38400, crtscts: true);//edit
~speed= 0.15;
~seq= [
	Bjorklund(3, 8),
	Bjorklund(4, 8),
	Bjorklund(5, 8),
	Bjorklund(6, 8),
	Bjorklund(7, 8),
	Bjorklund(8, 8)
];
Routine.run({
	var cnt= 0;
	inf.do{
		port.put(10);
		port.putAll((~seq.flop.wrapAt(cnt)*255).asInteger);
		port.put(11);
		(~speed*0.5).wait;
		port.putAll([10, 0, 0, 0, 0, 0, 0, 11]);  //turn all off
		(~speed*0.5).wait;
		cnt= cnt+1;
	};
});
CmdPeriod.doOnce({port.close});
)

(
~seq= [
	Bjorklund(3, 16),
	Bjorklund(4, 16),
	Bjorklund(5, 16),
	Bjorklund(6, 16),
	Bjorklund(7, 16),
	Bjorklund(8, 16)
];
)
