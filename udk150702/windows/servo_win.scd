//use together with arduino sketch 'servo.ino' and processing sketch 'supercolliderToArduino_via_processing.pde'

//--super simple test - servo sweeping full range
(
var n= NetAddr("127.0.0.1", 12000);
~speed= 0.005;
Routine.run({
	var cnt= 0;
	inf.do{
		n.sendMsg(\serial, cnt.fold(0, 180));
		cnt= cnt+1;
		~speed.wait;
	};
});
)

//stop with cmd+.


//--annoying example with sound
(
var n= NetAddr("127.0.0.1", 12000);
~speed= 0.005;
s.waitForBoot{
	Ndef(\saw, {|freq= 500, pan= 0| Pan2.ar(Saw.ar(freq.lag(0.1), SinOsc.ar(freq/2)), pan)}).play;
	Routine.run({
		var cnt= 0;
		inf.do{
			var pos= cnt.fold(0, 180);
			n.sendMsg(\serial, pos);
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
)

//stop with cmd+.
