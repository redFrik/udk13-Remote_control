n= NetAddr("127.0.0.1", 10000);

//try together with osc_receive_test.pde
n.sendMsg(\toProcessing, 1)
n.sendMsg(\toProcessing, 2)
n.sendMsg(\toProcessing, 4321)

(
Routine.run({
	100.do{|i|
		n.sendMsg(\toProcessing, i);
		0.005.wait;
	};
	"done".postln;
});
)
