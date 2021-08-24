from time import sleep
import threading


def printFromThread(condition_var):
	condition_var.acquire()
	print("t1 acquired cv")
	sleep(5)
	condition_var.notify_all()
	print("t1 notify using cv")
	condition_var.release()
	
def printFromThread2(condition_var):
	condition_var.acquire()		
	print("t2 acquired cv")
	value = condition_var.wait(10)
	if(value):
		print("the t2 thread was notified by t1!")
		condition_var.release()
	else:
		print("Timeout on wait, never got notified")
	
	
if __name__ == '__main__':
	# condition object
	cond = threading.Condition()

	t2 = threading.Thread(target =printFromThread2, args=(cond,))
	t2.start()
	
	t1 = threading.Thread(target=printFromThread,args=(cond,))
	t1.start()
	t1.join()
	t2.join()
