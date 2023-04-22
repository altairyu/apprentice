require 'debug'

require_relative 'blackjack_controller'

game = BlackjackController.new
game.start
game.loop_player_turn
game.loop_dealer_turn
game.show_final_scores
game.show_result
game.end_game
