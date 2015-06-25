//use with arduino sketch 'ir_to_supercollider.ino' and the 'ir_receive_via_processing' processing sketch

(
~dict= (
	'00FF30CF': {" on".post},
	'00FF00FF': {" mode".post},
	'00FF40BF': {" left".post},
	'00FF48B7': {" right".post},
	'00FFA05F': {" up".post},
	'00FFE01F': {" down".post},
	//edit the above and add more here to match your remote
	'FFFFFFFF': {" repeat".post}
);
OSCFunc({|msg|
	var key;
	key= msg[1].asInteger.asHexString.asSymbol.post;
	~dict[key].value;
	"".postln;
}, \ir);
)

//and while the above program is running, evaluate this...
(
s.waitForBoot{
	var on= false, up= 0, fm= 6;
	Ndef(\snd, {|freq= 500, freq2= 6, amp= 0, amp2= 0| SinOsc.ar(freq, SinOsc.ar(freq2, 0, 2pi*amp2), amp.lag(0.1))!2}).play;
	~dict= (
		'00FF30CF': {
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
		'00FF00FF': {" mode".post; Ndef(\snd).set(\freq, 150.rrand(5000))},
		'00FF40BF': {" left".post; fm= (fm-1).max(0); Ndef(\snd).set(\freq2, fm)},
		'00FF48B7': {" right".post; fm= fm+1; Ndef(\snd).set(\freq2, fm)},
		'00FFA05F': {" up".post; up= up+1; Ndef(\snd).set(\amp2, up)},
		'00FFE01F': {" down".post; up= (up-1).max(0); Ndef(\snd).set(\amp2, up)},
		'FFFFFFFF': {" repeat".post}
	);
};
)

//you can add more keys and functions on the fly in ~dict.  just change and re-evaluate the code - do not stop with cmd+period
