require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

player_1 = Player.new("Josiane")
player_2 = Player.new("José")

while player_1.life_points >= 0 && player_2.life_points >= 0
    puts "Voici l'état de chaque joueur :"
        player_1.show_state
        player_2.show_state
    puts
    puts "Passons à la phase d'attaque :"
        player_1.attacks(player_2)
        if player_2.life_points <= 0
            break
        else
            player_2.attacks(player_1)    
        end
    puts
end


binding.pry