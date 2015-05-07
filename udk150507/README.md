150507
======

```
OSCFunc({|msg|
    msg.postln;
}, \hiho)

n= NetAddr("127.0.0.1", 57120)
n.sendMsg(\hiho, 1, 2, 3)
```

polly
--

code for testing beaglebone black boxes.

```
n= NetAddr("pollyws14bbb.local", 57120);

/*
n.sendMsg(\input, \micamp, 0)
*/

//--say
n.sendMsg(\input, \say, \extra)
n.sendMsg(\input, \say, \goodbye)
n.sendMsg(\input, \say, \hello)
n.sendMsg(\input, \say, \name)
n.sendMsg(\input, \say, \play)
n.sendMsg(\input, \say, \sibling)
n.sendMsg(\input, \say, \there)

//--scene
n.sendMsg(\input, \test, \scene, \allt)
n.sendMsg(\input, \test, \scene, \arvo)
n.sendMsg(\input, \test, \scene, \bad)
n.sendMsg(\input, \test, \scene, \bakvendtland)
n.sendMsg(\input, \test, \scene, \bemankan)
n.sendMsg(\input, \test, \scene, \boogie)
n.sendMsg(\input, \test, \scene, \byssa)
n.sendMsg(\input, \test, \scene, \cry)
n.sendMsg(\input, \test, \scene, \disco)
n.sendMsg(\input, \test, \scene, \drive)
n.sendMsg(\input, \test, \scene, \dyren)
n.sendMsg(\input, \test, \scene, \edderkopp)
n.sendMsg(\input, \test, \scene, \euphoria)
n.sendMsg(\input, \test, \scene, \factory)
n.sendMsg(\input, \test, \scene, \fairy)
n.sendMsg(\input, \test, \scene, \fields)
n.sendMsg(\input, \test, \scene, \fox)
n.sendMsg(\input, \test, \scene, \gimme)
n.sendMsg(\input, \test, \scene, \gregor)
n.sendMsg(\input, \test, \scene, \heartbreak)
n.sendMsg(\input, \test, \scene, \hello)
n.sendMsg(\input, \test, \scene, \help)
n.sendMsg(\input, \test, \scene, \himmelen)
n.sendMsg(\input, \test, \scene, \honky)
n.sendMsg(\input, \test, \scene, \johnny)
n.sendMsg(\input, \test, \scene, \lonesome)
n.sendMsg(\input, \test, \scene, \mamma)
n.sendMsg(\input, \test, \scene, \marabous)
n.sendMsg(\input, \test, \scene, \mikkel)
n.sendMsg(\input, \test, \scene, \norah)
n.sendMsg(\input, \test, \scene, \purple)
n.sendMsg(\input, \test, \scene, \river)
n.sendMsg(\input, \test, \scene, \sabel)
n.sendMsg(\input, \test, \scene, \skin)
n.sendMsg(\input, \test, \scene, \spiegel)
n.sendMsg(\input, \test, \scene, \submarine)
n.sendMsg(\input, \test, \scene, \trollmor)
n.sendMsg(\input, \test, \scene, \wake)
n.sendMsg(\input, \test, \scene, \woodland)

//--tune
n.sendMsg(\input, \test, \tune, \tune1)
n.sendMsg(\input, \test, \tune, \tune2)
n.sendMsg(\input, \test, \tune, \tune3)
n.sendMsg(\input, \test, \tune, \tune4)
n.sendMsg(\input, \test, \tune, \tune5)
n.sendMsg(\input, \test, \tune, \tune6)

//--choir
n.sendMsg(\input, \test, \choir, \anemon)
n.sendMsg(\input, \test, \choir, \bell)
n.sendMsg(\input, \test, \choir, \casserole)
n.sendMsg(\input, \test, \choir, \chimes)
n.sendMsg(\input, \test, \choir, \congas)
n.sendMsg(\input, \test, \choir, \cowbell)
n.sendMsg(\input, \test, \choir, \cyklop)
n.sendMsg(\input, \test, \choir, \disco1)
n.sendMsg(\input, \test, \choir, \disco2)
n.sendMsg(\input, \test, \choir, \disco3)
n.sendMsg(\input, \test, \choir, \dog1)
n.sendMsg(\input, \test, \choir, \dog2)
n.sendMsg(\input, \test, \choir, \duck1)
n.sendMsg(\input, \test, \choir, \duck2)
n.sendMsg(\input, \test, \choir, \duck3)
n.sendMsg(\input, \test, \choir, \dykarklocka)
n.sendMsg(\input, \test, \choir, \elephant)
n.sendMsg(\input, \test, \choir, \flower1)
n.sendMsg(\input, \test, \choir, \flower2)
n.sendMsg(\input, \test, \choir, \flower3)
n.sendMsg(\input, \test, \choir, \flower4)
n.sendMsg(\input, \test, \choir, \flower5)
n.sendMsg(\input, \test, \choir, \flower6)
n.sendMsg(\input, \test, \choir, \flower7)
n.sendMsg(\input, \test, \choir, \fox)
n.sendMsg(\input, \test, \choir, \frog)
n.sendMsg(\input, \test, \choir, \harmonica)
n.sendMsg(\input, \test, \choir, \hat)
n.sendMsg(\input, \test, \choir, \lamb)
n.sendMsg(\input, \test, \choir, \maracas1)
n.sendMsg(\input, \test, \choir, \maracas2)
n.sendMsg(\input, \test, \choir, \mic)
n.sendMsg(\input, \test, \choir, \monkey)
n.sendMsg(\input, \test, \choir, \ping)
n.sendMsg(\input, \test, \choir, \pong)
n.sendMsg(\input, \test, \choir, \sheep)
n.sendMsg(\input, \test, \choir, \simfena)
n.sendMsg(\input, \test, \choir, \spider)
n.sendMsg(\input, \test, \choir, \starfish)
n.sendMsg(\input, \test, \choir, \tiger)
n.sendMsg(\input, \test, \choir, \train1)
n.sendMsg(\input, \test, \choir, \train2)
n.sendMsg(\input, \test, \choir, \train3)
n.sendMsg(\input, \test, \choir, \troll)
```
