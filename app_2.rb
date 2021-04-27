require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts "+++++++++++++++++++++++++++++++++++++++++++"
puts "|Bienvenue dans **GLADIATORSxSPACEBOTS**  |"
puts "|Un seul but :         SURVIVRE !         |"
puts "+++++++++++++++++++++++++++++++++++++++++++"

puts "Comment veux-tu que ton Gladiateur s'appelle?"
print "> "
player_name = gets.chomp

player = HumanPlayer.new(player_name) # On crée le joueur humain et on stock l'instance dans la var player

enemies = []

bot_1 = Player.new("Josiane")
bot_2 = Player.new("José")

enemies << bot_1 << bot_2


while player.life_points > 0 && (bot_1.life_points > 0 || bot_2.life_points > 0) # tant que player est vivant et que l'un ou l'autre des bot vivant
    puts
    puts "Voici l'état de ton Gladiateur :"
        player.show_state
    puts
    puts "Quelle action veux-tu effectuer ?"
    puts
    puts "> a - chercher une meilleure arme"
    puts "> s - chercher à se soigner"
    puts
    puts "Attaquer un SpaceBot en vue :"
    puts
    print "> 0 - "
    "#{bot_1.show_state}"
    print "> 1 - "
    "#{bot_2.show_state}"
    puts

    player_action = gets.chomp
    puts
    case player_action
    when "a"
        puts player.search_weapon
        puts
        puts "Appuis sur entrée pour continuer"
        gets
        puts
    when "s"
        puts player.search_health_pack
        puts
        puts "Appuis sur entrée pour continuer"
        gets
        puts
    when "0"
        player.attacks(bot_1)
        puts
        puts "Appuis sur entrée pour continuer"
        gets
        puts
    when "1"
        player.attacks(bot_2)
        puts
        puts "Appuis sur entrée pour continuer"
        gets
        puts
    when "q"
        break
    else
        puts "Ceci n'est pas une commande valide. Je n'accepte que les a, s, 0 ou 1."
        puts
        puts "Appuis sur entrée pour continuer"
        gets
        puts
    end

    puts "Les SpaceBots passent à l'attaque !"
    enemies.each do |bot|
        if bot.life_points > 0
        bot.attacks(player)
        end
    end
    puts
    puts "Appuis sur entrée pour continuer"
    gets
    puts
end



if player.life_points > 0
    puts "BRAVO! Tu as triomphé des SpaceBots !"
else
    puts "Tu est mort... :'( et en plus, les SpaceBots dancent le Floss sur ton cadavre... "
end

puts
puts "La partie est finie !"


binding.pry