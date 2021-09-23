class GameStats:
	"""Track statistics of Alien Invasion"""
	
	def __init__(self, ai_game):
		"""initializing statistics"""
		self.settings = ai_game.settings
		self.reset_stats()
		#Start Alien Invasion in an active state
		self.game_active = True
		
	def reset_stats(self):
		"""initialize stats that can change during the games duration"""
		self.ships_left = self.settings.ship_limit