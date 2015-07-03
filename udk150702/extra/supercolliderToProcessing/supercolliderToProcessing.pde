import oscP5.*;
OscP5 oscP5;
int val;
void setup() {
  frameRate(60);
  oscP5= new OscP5(this, 10000);
}
void draw() {
}
void oscEvent(OscIn oscIn) {
  if (oscIn.checkAddrPattern("/toProcessing")) {
    if (oscIn.checkTypetag("i")) {
      val= oscIn.getInt(0);
      println(val);
    }
  }
}

