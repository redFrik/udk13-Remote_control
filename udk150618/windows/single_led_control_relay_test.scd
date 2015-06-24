//use together with an arduino and the 'supercolliderToArduino_via_processing.ino' sketch
n= NetAddr("127.0.0.1", 12000);
n.sendMsg("serial", 65);
n.sendMsg("serial", 66);
