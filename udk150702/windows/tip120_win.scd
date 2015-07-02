//use together with arduino sketch 'six_pwm.ino' and processing sketch 'supercolliderToArduino_via_processing_six.pde'
//connect dc motors or solenoids


//--simple random rhythms
(
var n= NetAddr("127.0.0.1", 12000);
Routine.run({
	inf.do{
		var arr= {|i| 2.rand*255}.dup(6);  //turn som on
		n.sendMsg(\serialSix, *arr);
		0.1.wait;
		n.sendMsg(\serialSix, *0.dup(6));  //turn all off
		0.1.wait;
	};
});
)

//stop with cmd+.





//--more advanced - rhythmic patterns
(
var n= NetAddr("127.0.0.1", 12000);
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
		n.sendMsg(\serialSix, *(~seq.flop.wrapAt(cnt)*255).asInteger);
		(~speed*0.5).wait;
		n.sendMsg(\serialSix, *0.dup(6));  //turn all off
		(~speed*0.5).wait;
		cnt= cnt+1;
	};
});
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
var n= NetAddr("127.0.0.1", 12000);
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
		n.sendMsg(\serialSix, *(~seq.flop.wrapAt(cnt)*255).asInteger);
		(~speed*0.5).wait;
		n.sendMsg(\serialSix, *0.dup(6));  //turn all off
		(~speed*0.5).wait;
		cnt= cnt+1;
	};
});
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
