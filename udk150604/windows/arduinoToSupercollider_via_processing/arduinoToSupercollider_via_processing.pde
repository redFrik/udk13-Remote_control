//--simple relay sketch for processing
//first upload 'arduinoToSupercollider_simple' to your arduino
//then start the supercollider patch 'arduinoToSupercollider_simple1.scd'
//last run this sketch

//note: you will need to install the OscP5 library
//go to sketch/import library/add library and search for OscP5
import oscP5.*;
import netP5.*;
import processing.serial.*;
OscP5 oscP5;
NetAddress sc;
Serial myPort;
void setup() {
  frameRate(60);
  println(Serial.list());
  String portName = Serial.list()[0];  //check which index on your machine
  myPort = new Serial(this, portName, 38400);  //check baudrate
  oscP5= new OscP5(this, 12000);
  sc= new NetAddress("127.0.0.1", 57120);  //ip supercollider
}
void draw() {
  while ( myPort.available() > 0) {  // while data is available,
    int val = myPort.read();         // read it and store it in val
    OscMessage msg= new OscMessage("/serial");
    msg.add(val);
    oscP5.send(msg, sc);
  }
}
