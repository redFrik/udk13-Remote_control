//tested with raspbian 2015-05-05

* sudo apt-get update
* sudo apt-get upgrade
* git clone git://github.com/ptone/pyosc.git
* cd pyosc
* sudo ./setup.py install
* cd ..
* sudo rm -r pyosc

* scp osc_receive_test.py gpio_test.py osc_to_gpio.py pi@192.168.1.54:/home/pi/
