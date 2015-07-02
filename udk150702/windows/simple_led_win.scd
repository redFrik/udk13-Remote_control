//use together with arduino sketch 'simple_led.ino' and processing sketch 'supercolliderToArduino_via_processing.pde'

//--super simple test - pulsating led
(
var n= NetAddr("127.0.0.1", 12000);
Routine.run({
	var cnt= 0;
	inf.do{
		n.sendMsg(\serial, cnt);
		cnt= cnt+1;
		if(cnt>255, {
			cnt= 0;
		});
		0.005.wait;
	};
});
)

//stop with cmd+.


//--more advanced - with speed and curvature control
(
var n= NetAddr("127.0.0.1", 12000);
~speed= 0.005;
~curve= 0;
Routine.run({
	var cnt= 0;
	inf.do{
		n.sendMsg(\serial, cnt.lincurve(0, 255, 0, 255, ~curve).asInteger);
		cnt= cnt+1;
		if(cnt>255, {
			cnt= 0;
		});
		~speed.wait;
	};
});
)

//change these while the above program is running
~speed= 0.0075 //a bit slower
~speed= 0.0025 //faster
~speed= 0.005 //default
~curve= 4 //mapping gives different character
~curve= -4
~curve= 9
~curve= -9
~curve= 0 //default

//stop with cmd+.


//--even more advanced - fade in and out with different curvatures
(
var n= NetAddr("127.0.0.1", 12000);
~speed= 0.005;
~curveIn= 0;
~curveOut= 0;
Routine.run({
	var cnt= 0;
	inf.do{
		if(cnt<=255, {
			n.sendMsg(\serial, cnt.lincurve(0, 255, 0, 255, ~curveIn).asInteger);
		}, {
			if(cnt<=511, {
				n.sendMsg(\serial, cnt.lincurve(256, 511, 255, 0, ~curveOut).asInteger);
			}, {
				cnt= 0; //must be 512 - reset counter
			});
		});
		cnt= cnt+1;
		~speed.wait;
	};
});
)

//change these while the above program is running
~speed= 0.0025 //faster
~curveIn= 4 //mapping gives different character
~curveOut= -4
~curveIn= -9
~curveOut= -9
~curveIn= 0; ~curveOut= 0; //default

//stop with cmd+.


//--sound example1 - siren
(
s.waitForBoot{
	var n= NetAddr("127.0.0.1", 12000);
	~speed= 0.005;
	~curveIn= 0;
	~curveOut= 0;
	Ndef(\siren, {|freq= 400| Pan2.ar(Saw.ar(freq), SinOsc.kr(3))}).play;
	Routine.run({
		var cnt= 0;
		var fval;
		inf.do{
			if(cnt<=255, {
				fval= cnt.lincurve(0, 255, 0, 255, ~curveIn);
			}, {
				if(cnt<=511, {
					fval= cnt.lincurve(256, 511, 255, 0, ~curveOut);
				}, {
					cnt= 0; //must be 512 - reset counter
				});
			});
			n.sendMsg(\serial, fval.asInteger);
			Ndef(\siren).set(\freq, fval.linexp(0, 255, 100, 1000));
			cnt= cnt+1;
			~speed.wait;
		};
	});
};
)

~speed= 0.0025 //faster
~curveIn= 4 //mapping gives different character
~curveOut= -4

//stop with cmd+.
