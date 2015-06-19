//relay sketch to use supercollider and arduino
//this creates a bridge between osc and serial

/*
//supercollider example code - test with single_led_control.ino
n= NetAddr("127.0.0.1", 12000);
n.sendMsg("serial", 65);
n.sendMsg("serial", 66);
*/

import processing.serial.*;
import oscP5.*;
OscP5 oscP5;
Serial myPort;
int val;
void setup() {
  size(200, 200);
  frameRate(60);
  println(Serial.list());
  String portName = Serial.list()[0];  //check which index on your machine
  myPort = new Serial(this, portName, 38400);  //check that baudrate matches in arduino code
  oscP5= new OscP5(this, 12000);  //check which osc port you send to in supercollider
}
void draw() {}
void oscEvent(OscIn oscIn) {
  if(oscIn.checkAddrPattern("serial")) {
    if(oscIn.checkTypetag("i")) {
      myPort.write(oscIn.getInt(0));
    }
  }
}
