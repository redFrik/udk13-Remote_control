//use with arduino sketch 'ir_to_supercollider.ino'

SerialPort.listDevices//check the name and copy into the first line below
(
var port= SerialPort("/dev/tty.usbserial-A101NB76", 38400, crtscts: true);//edit

~dict= (
	'F30CFF00': {" on".post},
	'FF00FF00': {" mode".post},
	'FD02FF00': {" left".post},
	'ED12FF00': {" right".post},
	'FA05FF00': {" up".post},
	'F807FF00': {" down".post},
	//edit the above and add more here to match your remote
	'0': {" repeat".post}
);
Routine.run({
	var byte, state= 0, str= "", key;
	inf.do{
		while({byte= port.read; byte.notNil}, {
			if(state==0, {
				if(byte==13, {
					state= 1;
				}, {
					str= str++byte.asAscii;
				});
			}, {
				if(byte==10, {
					key= str.asSymbol.post;
					~dict[key].value;
					"".postln;
					state= 0;
					str= "";
				});
			});
		});
		0.01.wait;
	};
});
CmdPeriod.doOnce({port.close});
)

//and while the above program is running, evaluate this...
(
s.latency= 0.05;
s.waitForBoot{
	var on= false, up= 3, fm= 6;
	Ndef(\snd, {|freq= 500, freq2= 6, amp= 0, amp2= 3| SinOsc.ar(freq, SinOsc.ar(freq2, 0, 2pi*amp2), amp.lag(0.1))!2}).play;
	~dict= (
		'F30CFF00': {
			if(on==false, {
				"on".post;
				Ndef(\snd).set(\amp, 0.5);
				on= true;
			}, {
				"off".post;
				Ndef(\snd).set(\amp, 0);
				on= false;
			});
		},
		'FF00FF00': {" mode".post; Ndef(\snd).set(\freq, 150.rrand(5000))},
		'FD02FF00': {" left".post; fm= (fm-1).max(0); Ndef(\snd).set(\freq2, fm)},
		'ED12FF00': {" right".post; fm= fm+1; Ndef(\snd).set(\freq2, fm)},
		'FA05FF00': {" up".post; up= up+1; Ndef(\snd).set(\amp2, up)},
		'F807FF00': {" down".post; up= (up-1).max(0); Ndef(\snd).set(\amp2, up)},
		'0': {" repeat".post}
	);
};
)

//you can add more keys and functions on the fly in ~dict.  just change and re-evaluate the code - do not stop with cmd+period
