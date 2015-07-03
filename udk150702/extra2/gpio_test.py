import RPi.GPIO as GPIO
import time

pwmPin= 18

GPIO.setmode(GPIO.BCM)
GPIO.setup(pwmPin, GPIO.OUT)
pwm= GPIO.PWM(pwmPin, 50)
cnt= 0
pwm.start(cnt)

try:
	while True:
		pwm.ChangeDutyCycle(cnt)
		cnt= (cnt+1)%100
		time.sleep(0.01)
except KeyboardInterrupt:
	pwm.stop()
	GPIO.cleanup()

