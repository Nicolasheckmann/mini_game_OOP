require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "+++++++++++++++++++++++++++++++++++++++++++"
puts "|Bienvenue dans **GLADIATORSxSPACEBOTS**  |"
puts "|Un seul but :         SURVIVRE !         |"
puts "+++++++++++++++++++++++++++++++++++++++++++"
puts
puts "Comment veux-tu que ton Gladiateur s'appelle?"
print "> "
player_name = gets.chomp
my_game = Game.new(player_name)
puts 
while my_game.is_still_ongoing?
    my_game.continue?
    my_game.show_players
    my_game.continue?
    my_game.menu
    my_game.menu_choice(gets.chomp)
    my_game.continue?
    my_game.enemies_attack
end
my_game.end
binding.pry