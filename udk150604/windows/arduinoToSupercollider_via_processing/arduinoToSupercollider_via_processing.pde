//--simple relay sketch for processing
//first upload 'arduinoToSupercollider_simple' to your arduino
//then start the supercollider patch 'arduinoToSupercollider_simple1.scd'
//last run this sketch
import oscP5.*;
import netP5.*;
import processing.serial.*;
OscP5 oscP5;
NetAddress sc;
Serial myPort;
void setup() {
  frameRate(60);
  String portName = Serial.list()[0];  //check which index on your machine
  myPort = new Serial(this, portName, 38400);  //check baudrate
  oscP5= new OscP5(this, 12000);
  sc= new NetAddress("127.0.0.1", 57120);  //ip supercollider
}
void draw() {
  if ( myPort.available() > 0) {  // If data is available,
    int val = myPort.read();         // read it and store it in val
    OscMessage msg= new OscMessage("serial");
    msg.add(val);
    oscP5.send(msg, sc);
  }
}
