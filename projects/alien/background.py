import pygame
from pygame.sprite import Sprite

class Background(Sprite):
	def __init__(self, ai_game):
		#is this needed?
		super().__init__() 
		self.screen = ai_game.screen
		self.settings = ai_game.settings
		
		self.screen_rect = ai_game.screen.get_rect()
		
		#temportary image until i find a better option
		self.image = pygame.image.load('images/space.png')
		self.rect = self.image.get_rect()
		
		self.rect.midtop = self.screen_rect.midtop
		
		self.x = float(self.rect.x)
		self.y = float(self.rect.y)
	
class Background_Two:
	def __init__(self, ai_game):
		"""initialize the ship and set the starting position"""
		#set the screen to the attribute of 'Ship'
		self.screen = ai_game.screen
		self.settings = ai_game.settings
		#access the screen's attribute 'rect', using the get_rect() method and assign it to self.screen.rect
			#allows us to place the ship in the correct location on the screen
		self.screen_rect = ai_game.screen.get_rect()
		
		#Load the ship image and get its rect. Also,gives it the location of the ship image
			#this function returns a surface representing the ship, wich we assign to self.image
		self.image = pygame.image.load('images/space.png')
		#once the image is loaded we call 'get_rect()' to access the ships surface rect attribute so we can use it later to place the ship
		self.rect = self.image.get_rect()
		
	def blitme(self):
		"""draw the ship at its current location"""
		self.screen.blit(self.image, self.rect)
		