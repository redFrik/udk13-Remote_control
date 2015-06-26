import RPi.GPIO as GPIO
import time
import OSC
import threading

oscPort= 10000	#network port
pwmPin= 18	#connect led+resistor to this pin

server= OSC.OSCServer(('0.0.0.0', oscPort))
def oscInput(addr, tags, stuff, source):
	print str(stuff)
	pwm.ChangeDutyCycle(stuff[0])	#value should be an integer 0-100

server.addMsgHandler("/pwm", oscInput)
server_thread= threading.Thread(target= server.serve_forever)
server_thread.start()

GPIO.setmode(GPIO.BCM)
GPIO.setup(pwmPin, GPIO.OUT)
pwm= GPIO.PWM(pwmPin, 50)
pwm.start(0)

try:
	while True:
		time.sleep(1)
except KeyboardInterrupt:
	pwm.stop()
	GPIO.cleanup()
	server.close()
	server_thread.join()
