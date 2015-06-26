//receive osc in python on a raspberry pi
//tested with raspbian 2015-05-05

* sudo apt-get update
* sudo apt-get upgrade
* git clone git://github.com/ptone/pyosc.git
* cd pyosc
* sudo ./setup.py install
* cd ..
* sudo rm -r pyosc

//on the laptop - this will copy over the files
* scp osc_receive_test.py gpio_test.py osc_to_gpio.py pi@192.168.1.54:/home/pi/

//back on the rpi - start the first test program with
* sudo python gpio_test.py #should fade a led (connect to pin18 with resistor)
stop with ctrl+c

* python osc_receive_test.py #should print incoming osc

corresponding supercollider code:
n= NetAddr("192.168.1.54", 10000)

//with osc_receive_test.py
n.sendMsg(\toPython, 1, 2, 3)
n.sendMsg(\toPython, "string")
n.sendMsg(\toPython, 5.43, 2.1)

* sudo python osc_to_gpio.py

//with osc_to_gpio.py (connect led + resistor for it to work)
n.sendMsg(\pwm, 100) //control brightness from 100 to 0
n.sendMsg(\pwm, 50)
n.sendMsg(\pwm, 0)
