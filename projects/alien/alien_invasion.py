import sys
	#has tools needed to exit the game when the player quits 
from time import sleep
from pynput import keyboard
import pygame
	#contains functionality needed to run the game
	#used pip install to install pygame
from settings import Settings
from game_stats import GameStats
from ship import Ship
from bullet import Bullet
from bullet import Bullet_two
from bullet import Bullet_three
from alien import Alien
from power_up import PowerUp

	
class AlienInvasion:
	"""Overall class to manage game assets and behavior"""
	
	def __init__(self):
		"""Initialize the game, and create the games resources that are needed for Pygame to work properly"""
		pygame.init()
		self.settings = Settings()
		
		#create display window for graphical elements
		#self.screen makes it available in all methods in the class
			#self.screen is a surface 
				#a surface in Pygame is a part of the sccreen where a game element can be displayed
				#each element in a game is it's own surface (ex. alien or a ship are two seperate surfaces)
		self.screen = pygame.display.set_mode((0, 0), pygame.FULLSCREEN) 
			#if you don't want full screen remove pygame.FULLSCREEN and then replace (0,0) with the dimensions you want
		self.settings.screen_width = self.screen.get_rect().width
		self.settings.screen_height = self.screen.get_rect().height
		#display.set_mode() represents the entire game window
		pygame.display.set_caption("Alien Invasion")
		
		#Create an instance to store game statistics
		self.stats = GameStats(self)
		
		#import 'Ship' and make an instance of 'Ship' after the screen has been created
		self.ship = Ship(self)
		self.bullets = pygame.sprite.Group()
		self.bullets_two = pygame.sprite.Group()
		self.bullets_three = pygame.sprite.Group()
		self.aliens = pygame.sprite.Group()
		self._create_fleet()
		self.power_ups = PowerUp(self)
	
	#the game is controlled by the run_game method
	def run_game(self):
		"""Start the main loop of the game"""
		#this while loop runs continually, and contains an event loop and code that manages screen updates
		while True:
			#Watch for keyboard and mouse events
			self._check_events()
			
			if self.stats.game_active:
				self.ship.update()
				#an event is an action that a user performs while playing the game
				#to make the program respond to events we create an event loop to listen for events 
					#the program then performs appropriate tasks based on the kinds of events that occur
				self._update_bullets()
				self._update_bullets_two()
				self._update_bullets_three()
				self._update_aliens()
				self._update_power_up()
				
			self._update_screen()
			
	def _check_events(self):
		"""Respond to keypresses and mouse events"""
		for event in pygame.event.get():
		#when player clicks game window close button, a Pygame.QUIT event is detected 
			if event.type == pygame.QUIT:
				#we call sys.exit to exit the game when Pygame.QUIT is detected
				sys.exit()
			#elif block to detect if the KEYDOWN event was triggerd
			elif event.type == pygame.KEYDOWN:
				self._check_keydown_events(event)
			elif event.type == pygame.KEYUP:
				self._check_keyup_events(event)
	
	def _check_keydown_events(self, event):
		#respond to keypresses
		if event.key == pygame.K_RIGHT:
			self.ship.moving_right = True
		elif event.key == pygame.K_LEFT:
			self.ship.moving_left = True
		elif event.key == pygame.K_DOWN:
			self.ship.moving_down = True
		elif event.key == pygame.K_UP:
			self.ship.moving_up = True
		elif event.key == pygame.K_q:
			sys.exit()
		elif event.key == pygame.K_SPACE:
			self._fire_bullet()
			self._fire_bullet_two()
			self._fire_bullet_three()
					
	def _check_keyup_events(self, event):
		#respond to key releases
		if event.key == pygame.K_RIGHT:
			self.ship.moving_right = False
		elif event.key == pygame.K_LEFT:
			self.ship.moving_left = False
		elif event.key == pygame.K_DOWN:
			self.ship.moving_down = False
		elif event.key == pygame.K_UP:
			self.ship.moving_up = False
			#Move the ship to the right
				#right arrow key is represented by pygame_K_RIGHT
				#if the arrow key was pressed we move the ship to the right by increasing the value of self.ship.rect.x by 1
					#can increase self.ship.rect.x by more than 1 at a time if needed, by changing the incrimented value
	
	def _fire_bullet(self):
		"""Create a new bullet and add it to the bullets group"""
		if len(self.bullets) < self.settings.bullets_allowed:
			new_bullet = Bullet(self)
			self.bullets.add(new_bullet)
	
	def _fire_bullet_two(self):
		if len(self.bullets_two) < self.settings.bullets_allowed:
			new_bullet_two = Bullet_two(self)
			self.bullets_two.add(new_bullet_two)
	
	def _fire_bullet_three(self):
		if len(self.bullets_three) < self.settings.bullets_allowed:
			new_bullet_three = Bullet_three(self)
			self.bullets_three.add(new_bullet_three)
			
	def _update_bullets(self):
		"""Update the position of the bullets and get rid of old bullets"""
		#Update bullet position
		self.bullets.update()
		
		#Get rid of bullets that have disappeared
		for bullet in self.bullets.copy():
			if bullet.check_edges():
				self.bullets.remove(bullet)
		
		self._check_bullet_alien_collisions()
		
	def _update_bullets_two(self):
		self.bullets_two.update()
		
		for bullet_two in self.bullets_two.copy():
			if bullet_two.check_edges():
				self.bullets_two.remove(bullet_two)
		
		self._check_bullet_alien_collisions()
		
	def _update_bullets_three(self):
		self.bullets_three.update()
		
		for bullet_three in self.bullets_three.copy():
			if bullet_three.check_edges():
				self.bullets_three.remove(bullet_three)
				
		self._check_bullet_alien_collisions()
		
	def _check_bullet_alien_collisions(self):
		"""Check for bullet to alien collisions"""
		#if so, get rid of the bullet and the alien
		collisions = pygame.sprite.groupcollide(self.bullets, self.aliens, True, True)
		collisions = pygame.sprite.groupcollide(self.bullets_two, self.aliens, True, True)
		collisions = pygame.sprite.groupcollide(self.bullets_three, self.aliens, True, True)
		
		if not self.aliens:
			#Destroy existing bullets and create a new fleet
			self.bullets.empty()
			self._create_fleet()
	
	"""#Commented out '_check_bullet_two_alien_collisions' and '_check_bullet_three_alien_collisions' 
		#made collisions detect each bullet/alien collision within 'def _check_bullet_alien_collisions'
		#leaving commented out section in case issues arise moving forward and I need to revert this section
	def _check_bullet_two_alien_collisions(self):
		collisions = pygame.sprite.groupcollide(self.bullets_two, self.aliens, True, True)
		
		if not self.aliens:
			self.bullets_two.empty()
			self._create_fleet()
			
	def _check_bullet_three_alien_collisions(self):
		collisions = pygame.sprite.groupcollide(self.bullets_three, self.aliens, True, True)
		
		if not self.aliens:
			self.bullets_three.empty()
			self._create_fleet()"""
			
	def _ship_hit(self):
		"""Respond to the ship being hit by an alien"""
		if self.stats.ships_left > 0:
			#Decrement ships_left
			self.stats.ships_left -= 1
			#Get rid of remaining aliens when the player runs out of ships
			if self.stats.ships_left < 0:
				self.aliens.empty()
			#Get rid of remaining bullets
			self.bullets.empty()
			#Create a new fleet and center the ship
			self.ship.center_ship()
			#self._create_fleet()
			#Pause
			sleep(0.5)
		else:
			self.stats.game_active = False
	
	def _create_fleet(self):
		"""Create the fleet of aliens"""
		#Create an alien and find the number of aliensin a row
		#Spacing between between each alien is equal to the width of a single alien
		alien = Alien(self)
		alien_width, alien_height = alien.rect.size
		available_space_x = self.settings.screen_width - (2 * alien_width)
		number_aliens_x = available_space_x // (2 * alien_width)
		
		#Determine the number of rows of aliens that can fit onto the screen
		ship_height = self.ship.rect.height
		available_space_y = (self.settings.screen_height - (3 * alien_height) - ship_height)
		number_rows = available_space_y // (2 * alien_height)
		
		#Create the the full fleet of aliens
		for row_number in range(number_rows):	
			for alien_number in range(number_aliens_x):
				self._create_alien(alien_number, row_number)
			
			
	def _create_alien(self, alien_number, row_number):
		#Create an alien and place it in the row
		alien = Alien(self)
		alien_width, alien_height = alien.rect.size
		alien.x = alien_width + 2 * alien_width * alien_number
		alien.rect.x = alien.x
		alien.rect.y = alien.rect.height + 2 * alien.rect.height * row_number
		self.aliens.add(alien)
	
	def _check_fleet_edges(self):
		"""Respond appropriately if any aliens have reached the edge of the screen"""
		for alien in self.aliens.sprites():
			if alien.check_edges():
				self._change_fleet_direction()
				break
	
	def _check_aliens_bottom(self):
		"""Check if any alienshave reached the bottom of the screen"""
		screen_rect = self.screen.get_rect()
		for alien in self.aliens.sprites():
			if alien.rect.bottom >= screen_rect.bottom:
				#Treat this the same as if the ship got hit
				self._ship_hit()
				break
	
	def _check_power_up_bottom(self):
		screen_rect = self.screen.get_rect()
		
		#for power_ups in self.power_ups:
		if self.power_ups.rect.bottom >= screen_rect.bottom:
			self.settings.power_up_speed = 0
			print("bottom")
			
	def _change_fleet_direction(self):
		"""Drop the entire fleet and change the fleet's direction"""
		for alien in self.aliens.sprites():
			alien.rect.y += self.settings.fleet_drop_speed
		self.settings.fleet_direction *= -1
			
	def _update_aliens(self):
		"""checks if the fleet has reached an edge, then updates the position of all aliens in the fleet"""
		self._check_fleet_edges()
		self.aliens.update()
		
		#Look for alien-ship collisions
		if pygame.sprite.spritecollideany(self.ship, self.aliens):
			self._ship_hit()
			
		#Look for aliens hitting the bottom of the screen
		self._check_aliens_bottom()
		
	def _update_power_up(self):
		self.power_ups.update()
		
		self._check_power_up_bottom()
		
	def _update_screen(self):
		"""Redraws new empty screen on each pass through loop, erasing old screens so only the new screen is visible"""
		self.screen.fill(self.settings.bg_color)
		#after filling the bacground of the screen, we draw the ship on the screen by calling 'ship.blitme()'
		self.ship.blitme()
		self.power_ups.blitme()
		for bullet in self.bullets.sprites():
			bullet.draw_bullet()
		for bullet_two in self.bullets_two.sprites():
			bullet_two.draw_bullet()
		for bullet_three in self.bullets_three.sprites():
			bullet_three.draw_bullet()
		self.aliens.draw(self.screen)

		#Make the most recently drawn screen visible
		pygame.display.flip()
			
if __name__ == '__main__':
	#Make a game instance, and run the game.
	ai = AlienInvasion()
	#place run_game() in an if block that only runs if the file is called directly
	ai.run_game()
	