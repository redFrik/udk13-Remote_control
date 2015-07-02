//use together with arduino sketch 'six_pwm.ino' and processing sketch 'supercolliderToArduino_via_processing_six.pde'

//--super simple test - pulsating leds
(
var n= NetAddr("127.0.0.1", 12000);
~speeds= [0.01, 0.02, 0.03, 0.04, 0.05, 0.06];
~curve= 2;
Routine.run({
	var cnt= 0;
	inf.do{
		var arr= {|i|
			sin(cnt*~speeds[i]).lincurve(-1, 1, 0, 255, ~curve).asInteger;
		}.dup(6);
		n.sendMsg(\serialSix, *arr);
		cnt= cnt+1;
		0.01.wait;
	};
});
)

//stop with cmd+.



