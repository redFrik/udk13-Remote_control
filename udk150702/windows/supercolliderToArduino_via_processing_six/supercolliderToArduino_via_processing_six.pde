//relay sketch to use supercollider and arduino
//this creates a bridge between osc and serial

/*
//supercollider example code
 n= NetAddr("127.0.0.1", 12000);
 n.sendMsg("serial", 65, 66, 67, 68, 69, 70);
 n.sendMsg("serial", 165, 166, 167, 168, 169, 170);
 */

import processing.serial.*;
import oscP5.*;
OscP5 oscP5;
Serial myPort;
int val;
void setup() {
  frameRate(60);
  println(Serial.list());
  String portName = Serial.list()[0];  //check which index on your machine
  myPort = new Serial(this, portName, 38400);  //check that baudrate matches in arduino code
  oscP5= new OscP5(this, 12000);  //check which osc port you send to in supercollider
}
void draw() {
}
void oscEvent(OscIn oscIn) {
  if (oscIn.checkAddrPattern("/serialSix")) {
    if (oscIn.checkTypetag("iiiiii")) {
      myPort.write(10);
      for (byte i= 0; i<6; i++) {
        int val= oscIn.getInt(i);
        //println(val);  //debug - remove when all is working
        myPort.write(val);
      }
      myPort.write(11);
    }
  }
}

