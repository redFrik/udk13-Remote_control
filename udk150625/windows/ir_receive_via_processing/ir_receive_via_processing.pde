//--relay sketch for processing
//first upload 'ir_to_supercollider.ino' to your arduino
//then start the supercollider patch 'ir_to_supercollider_win.scd'
//last run this sketch

//note: you will need to install the OscP5 library
//go to sketch/import library/add library and search for OscP5
import oscP5.*;
import netP5.*;
import processing.serial.*;
OscP5 oscP5;
NetAddress sc;
Serial myPort;
int index= 0;
int state= 0;
String str= "";
void setup() {
  frameRate(60);
  println(Serial.list());
  String portName = Serial.list()[0];  //check which index on your machine
  myPort = new Serial(this, portName, 38400);  //check baudrate
  oscP5= new OscP5(this, 12000);
  sc= new NetAddress("127.0.0.1", 57120);  //ip supercollider
}
void draw() {
  while ( myPort.available () > 0) {  // while data is available,
    int val = myPort.read();         // read it and store it in val
    //println(val, index);  //debug
    if (state==0) {
      if (val==13) {
        state= 1;
      } else {
        str= str+char(val);
      }
    } else {
      if (val==10) {
        OscMessage msg= new OscMessage("/ir");
        msg.add(str);
        oscP5.send(msg, sc);
        println(str);  //debug
        state= 0;
        str= "";
      }
    }
  }
}

