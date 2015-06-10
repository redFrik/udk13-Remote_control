150528
======

arduino and the sc serial port

please bring an arduino if you have one


```cpp
//ascii test program
//upload and then run serial monitor
byte cnt;

void setup() {
    Serial.begin(9600);  //important number (9600, 57600)
}

void loop() {
    Serial.write(66);  //0-255  (8bit number)
    cnt = cnt + 1;
    delay(50);
}
```

arduino to sc
--

```cpp
//arduino code
void setup() {
    pinMode(6, INPUT_PULLUP);  //connects via resistor to 5v
    pinMode(7, INPUT_PULLUP);  //connects via resistor to 5v
    Serial.begin(9600);
}
void loop() {
    byte val; //8bit value (0-255)
    val = digitalRead(6);  //0 or 1
    Serial.write(65+val);  //65 or 66 (A or B)
    
    byte val2;
    val2 = digitalRead(7);
    Serial.write(67+val2);  //67 or 68 (C or D)
    delay(5);  //0.5sec wait
}
```

```
//supercollider code
SerialPort.listDevices;

(
b.free;
b= Buffer.read(s, "/Users/abc/mysounds/bell1.wav"); //edit to match a soundfile on your harddrive
p= SerialPort("/dev/tty.usbserial-A101NB79", 9600, crtscts: true);  //edit to match serial device
CmdPeriod.doOnce({p.close});//extra safety
Routine.run({
    var playing= false;
    var distorting= false;
    inf.do{
        var byte= p.read;//values 0-255
        byte.asAscii.postln;
        if(byte==65, {
            if(playing==false, {
                Ndef(\soundfile, {PlayBuf.ar(b.numChannels, b, 0.5.rrand(3.0), loop:1)}).play;
                //Ndef(\soundfile, {SinOsc.ar(XLine.ar(5000.rand, 5000.rand, 0.1))}).play;
                playing= true;
            });
        });
        if(byte==66, {
            if(playing==true, {
                Ndef(\soundfile).stop;//stop soundfile
                playing= false;
            });
        });
        if(byte==67, {
            if(distorting==false, {
                Ndef(\dist, {(Ndef.ar(\soundfile)*40).distort*0.5}).play;
                distorting= true;
            });
        });
        if(byte==68, {
            if(distorting==true, {
                Ndef(\dist).stop;
                distorting= false;
            });
        });
    };
});
)
65.asAscii.class
65.asAscii==$A

//A = play soundfile
//B = stop soundfile
//C = distort on
//D = distort off
```
