import pygame

class PowerUp:

	def __init__(self, ai_game):
		#is this needed?
		super().__init__() 
		self.screen = ai_game.screen
		self.settings = ai_game.settings
		
		self.screen_rect = ai_game.screen.get_rect()
		
		#temportary image until i find a better option
		self.image = pygame.image.load('images/ship.bmp')
		self.rect = self.image.get_rect()
		
		self.rect.midtop = self.screen_rect.midtop
		
		self.x = float(self.rect.x)
		self.y = float(self.rect.y)
		
	def update(self):
		"""Move power_up down the screen"""
		self.y += self.settings.power_up_speed
		self.rect.y = self.y
		
	def blitme(self):
		"""draw the power up at its current location"""
		self.screen.blit(self.image, self.rect)
		
	def power_location(self):
		"""Center the ship on the screen"""
		self.rect.midtop = self.screen_rect.midtop
		self.x = float(self.rect.x)
		self.y = float(self.rect.y)
		
	def check_edges(self):
		"""Return True if alien is at the screens edge"""
		screen_rect = self.screen.get_rect()
		if self.rect.bottom <= 0:
			return True