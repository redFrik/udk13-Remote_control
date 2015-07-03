import time
import OSC
import threading

server= OSC.OSCServer(('0.0.0.0', 10000))

def oscInput(addr, tags, stuff, source):
	print str(stuff)

server.addMsgHandler("/toPython", oscInput)
server_thread= threading.Thread(target= server.serve_forever)
server_thread.start()

try:
	while True:
		time.sleep(1)
except KeyboardInterrupt:
	pass

server.close()
server_thread.join()
