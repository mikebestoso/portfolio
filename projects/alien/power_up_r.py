import pygame
from pygame.sprite import Sprite
from random import seed
from random import randint

class PowerUp(Sprite):

	def __init__(self, ai_game):
		#is this needed?
		super().__init__() 
		self.screen = ai_game.screen
		self.settings = ai_game.settings
		
		self.screen_rect = ai_game.screen.get_rect()
		
		#temportary image until i find a better option
		self.image = pygame.image.load('images/power.png')
		self.rect = self.image.get_rect()
		
		#self.rect.midtop = self.screen_rect.midtop
		self.rect.x = randint(200, 1000)
		
		self.x = float(self.rect.x)
		self.y = float(self.rect.y)
		
	def update(self):
		"""Move power_up down the screen"""
		self.y += self.settings.power_up_speed
		self.rect.y = self.y
		
	#def power_location(self):
	#	"""Center the power_up on the screen"""
	#	self.rect.a = self.screen_rect.midtop
	#	self.x = float(self.rect.x)
	#	self.y = float(self.rect.y)
		
	def check_edges(self):
		"""Return True if power_up hits the bottom of the screen"""
		screen_rect = self.screen.get_rect()
		if self.rect.bottom <= 0:
			super().empty
			return True
			