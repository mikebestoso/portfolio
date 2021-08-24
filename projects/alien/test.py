import pygame
import threading
import time
from random import seed
from random import randint

def __init__(self, ai_game):
		#is this needed?
		super().__init__() 
		self.screen = ai_game.screen
		self.settings = ai_game.settings
		
"""
class Random:
	def new_one():
		#seed(2)

		for value in range(10):
			value = randint(1, 1200)
			print(value)

if __name__ == '__main__':
	new_one()

class Ticks:	
	def tick():
		while z<5:
			ticks = pygame.time.get_ticks()
			pygame.time.wait(500)
			print(ticks)
			z += 1
"""
"""	
class myThread(threading.Thread):
	def __init__(self, threadID, name, counter):
		threading.Thread.__init__(self)
		self.threadID = threadID
		self.name = name
		self.counter = counter
	
	def run(self):
		print "Starting " + self.name
		print_time(self.name, self.counter)
		print "Exiting " + self.name
"""
class Tick:		
	def tick(self):
		event_id = 30
		power_up = PowerUp(self)
		power_up_width, power_up_height = power_up.rect.size
		pygame.time.set_timer(event_id, 2000, True)
		
		while True:
			if pygame.event.get(event_id):
				self.power_ups.add(power_up)
				break
