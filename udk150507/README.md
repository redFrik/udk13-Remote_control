150507
======

```
OSCFunc({|msg|
msg.postln;
}, \hiho)


n= NetAddr("127.0.0.1", 57120)
n.sendMsg(\hiho, 1, 2, 3)
```
