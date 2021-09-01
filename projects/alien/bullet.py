import pygame
from pygame.sprite import Sprite

class Bullet(Sprite):
	"""A class to manage bullets fired from the ship"""
	
	def __init__(self, ai_game):
		"""Create a bullet object at the ships current location"""
		super().__init__()
		self.screen = ai_game.screen
		self.settings = ai_game.settings
		self.color = self.settings.bullet_color
		
		#Create a bullet rect at (0, 0) and then set the correct position
		#here we create the bullet's rect attribute
			#the bullets are not images, so they are created from scratch
			#bullets need (x, y) locations of the top left of the rect. starts (0,0)
				#bullets locations depend on ship location
		self.rect = pygame.Rect(0, 0, self.settings.bullet_width, self.settings.bullet_height)
		#set bullet midtop attribute to match the ships midtop attribute
			#this will allow the bullets to emerge from from the top of the ship
				#makes it look like the bullets are being fired from the ship
		self.rect.midtop = ai_game.ship.rect.midtop
		
		#Store the bullets position as a decimal point (store decimal valuefor the bullet's y-coordinate)
		self.y = float(self.rect.y)
		
	def update(self):
		"""Move bullets up the screen"""
		#Update the decimal position of the bullet.
			#update method controls bullet location on the screen, which corresponds to a decreasing y-coordinate value
			#to update the position we subtract the amount stored in settings.bullet_speed from self.y
		self.y -= self.settings.bullet_speed
		#Update the rect position
		#we then use the value of self.y to set the value of self.rect.y
		self.rect.y = self.y
		
	def draw_bullet(self):
		"""Draw the bullets onto thee screen"""
		#when drawing a bullet, we call bullet_ddraw()
			#the draw.rect() function fills the part of the screen defined by the bullet's rect with the color stored in self.color
		pygame.draw.rect(self.screen, self.color, self.rect)
		
	def check_edges(self):
		"""Return True if alien is at the screens edge"""
		screen_rect = self.screen.get_rect()
		if self.rect.top <= 0:
			return True
		
class Bullet_two(Sprite):
	"""A class to manage bullets fired from the ship"""
	
	def __init__(self, ai_game):
		"""Create a bullet object at the ships current location"""
		super().__init__()
		self.screen = ai_game.screen
		self.settings = ai_game.settings
		self.color = (255, 0, 0)
		
		#Create a bullet rect at (0, 0) and then set the correct position
		#here we create the bullet's rect attribute
			#the bullets are not images, so they are created from scratch
			#bullets need (x, y) locations of the top left of the rect. starts (0,0)
				#bullets locations depend on ship location
		self.rect = pygame.Rect(0, 0, self.settings.bullet_width, self.settings.bullet_height)
		#set bullet midtop attribute to match the ships midtop attribute
			#this will allow the bullets to emerge from from the top of the ship
				#makes it look like the bullets are being fired from the ship
		self.rect.topleft = ai_game.ship.rect.topleft
		
		#Store the bullets position as a decimal point (store decimal valuefor the bullet's y-coordinate)
		self.x = float(self.rect.x)
		self.y = float(self.rect.y)
		
	def update(self):
		"""Move bullets up the screen"""
		#Update the decimal position of the bullet.
			#update method controls bullet location on the screen, which corresponds to a decreasing y-coordinate value
			#to update the position we subtract the amount stored in settings.bullet_speed from self.y
		self.x -= self.settings.bullet_speed
		self.y -= self.settings.bullet_speed
		#Update the rect position
		#we then use the value of self.y to set the value of self.rect.y
		self.rect.x = self.x
		self.rect.y = self.y
		
	def draw_bullet(self):
		"""Draw the bullets onto thee screen"""
		#when drawing a bullet, we call bullet_ddraw()
			#the draw.rect() function fills the part of the screen defined by the bullet's rect with the color stored in self.color
		pygame.draw.rect(self.screen, self.color, self.rect)
		
	def check_edges(self):
		"""Return True if alien is at the screens edge"""
		screen_rect = self.screen.get_rect()
		if self.rect.left <= 0 or self.rect.top <= 0:
			return True
		
class Bullet_three(Sprite):
	"""A class to manage bullets fired from the ship"""
	
	def __init__(self, ai_game):
		"""Create a bullet object at the ships current location"""
		super().__init__()
		self.screen = ai_game.screen
		self.settings = ai_game.settings
		self.color = (0, 102, 255)
		
		#Create a bullet rect at (0, 0) and then set the correct position
		#here we create the bullet's rect attribute
			#the bullets are not images, so they are created from scratch
			#bullets need (x, y) locations of the top left of the rect. starts (0,0)
				#bullets locations depend on ship location
		self.rect = pygame.Rect(0, 0, self.settings.bullet_width, self.settings.bullet_height)
		#set bullet midtop attribute to match the ships midtop attribute
			#this will allow the bullets to emerge from from the top of the ship
				#makes it look like the bullets are being fired from the ship
		self.rect.topright = ai_game.ship.rect.topright
		
		#Store the bullets position as a decimal point (store decimal valuefor the bullet's y-coordinate)
		self.x = float(self.rect.x)
		self.y = float(self.rect.y)
		
	def update(self):
		"""Move bullets up the screen"""
		#Update the decimal position of the bullet.
			#update method controls bullet location on the screen, which corresponds to a decreasing y-coordinate value
			#to update the position we subtract the amount stored in settings.bullet_speed from self.y
		self.x += self.settings.bullet_speed
		self.y -= self.settings.bullet_speed
		#Update the rect position
		#we then use the value of self.y to set the value of self.rect.y
		self.rect.x = self.x
		self.rect.y = self.y
		
	def draw_bullet(self):
		"""Draw the bullets onto thee screen"""
		#when drawing a bullet, we call bullet_ddraw()
			#the draw.rect() function fills the part of the screen defined by the bullet's rect with the color stored in self.color
		pygame.draw.rect(self.screen, self.color, self.rect)
		
	def check_edges(self):
		"""Return True if alien is at the screens edge"""
		screen_rect = self.screen.get_rect()
		if self.rect.right >= screen_rect.right or self.rect.top <= 0:
			return True