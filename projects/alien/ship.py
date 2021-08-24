import pygame

class Ship: 
	"""A class to manage the ship"""
	
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
		self.image = pygame.image.load('images/ship_3.png')
		#once the image is loaded we call 'get_rect()' to access the ships surface rect attribute so we can use it later to place the ship
		self.rect = self.image.get_rect()
		
		#Start each new ship at the bottom center of the screen.
		self.rect.midbottom = self.screen_rect.midbottom
		
		#Store a decimal value for the ship's horizontal position
		self.x = float(self.rect.x)
		self.y = float(self.rect.y)
		
		#Movement flags
			#add self.moving_right attribute and set it to false initially
		self.moving_right = False
		self.moving_left = False
		self.moving_down = False
		self.moving_up = False
	
	#add update() method which moves the ship to the right in the flag is true
	def update(self):
		"""updating the ship's location based on the movement flags"""
		#update the ship's x value, not the rect
		if self.moving_right and self.rect.right < self.screen_rect.right:
			self.x += self.settings.ship_speed
		if self.moving_left and self.rect.left > self.screen_rect.left:
			self.x -= self.settings.ship_speed
		if self.moving_down and self.rect.bottom < self.screen_rect.bottom: 
			self.y += self.settings.ship_speed
		if self.moving_up and self.rect.top > self.screen_rect.top:
			self.y -= self.settings.ship_speed
	
		#update rect object from self.x
		self.rect.x = self.x
		self.rect.y = self.y

		
	def blitme(self):
		"""draw the ship at its current location"""
		self.screen.blit(self.image, self.rect)
		
	def center_ship(self):
		"""Center the ship on the screen"""
		self.rect.midbottom = self.screen_rect.midbottom
		self.x = float(self.rect.x)
		self.y = float(self.rect.y)