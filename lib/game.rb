class Game
    attr_accessor :human_player, :enemies

    def initialize(player_name)
        self.human_player = HumanPlayer.new(player_name)
        self.enemies = Array.new(4) { |i| Player.new("SpaceBot_#{i}") } # crée un nouvel array avec 4 bot 
    end

    def kill_player(bot_to_kill)
        enemies.delete(bot_to_kill)
    end

    def is_still_ongoing?
        human_player.life_points > 0 && enemies.any? ? true : false
    end

    def show_players
        human_player.show_state
        enemies.each { |bot| bot.show_state }
    end

    def menu
        puts "==========================================="
        puts "|Quelle action veux-tu effectuer ?        |"
        puts "|                                         |"
        puts "|> a - chercher une meilleure arme        |"
        puts "|> s - chercher à se soigner              |"
        puts "|                                         |"
        puts "|Attaquer un SpaceBot en vue :            |"
        puts "|"
        enemies.each_with_index { |bot, i| print "|> #{i} - "; bot.show_state; }
        puts "|                                         |"
        puts "|> q - pour quitter le jeu                |"
        puts "|                                         |"
        puts "==========================================="
        print "> "
    end

    def menu_choice(player_action)
        case player_action
        when "a"
            puts human_player.search_weapon
        when "s"
            puts human_player.search_health_pack
        when "0"
            if enemies.length > 0
                puts
                human_player.attacks(enemies[0])
                if enemies[0].life_points <= 0
                    kill_player(enemies[0])
                end
            else
                puts "Ce SpaceBot est déjà mort !"
                puts
                self.menu_choice(gets.chomp)
            end
        when "1" 
            if enemies.length > 1
                puts
                human_player.attacks(enemies[1])
                if enemies[1].life_points <= 0
                    kill_player(enemies[1])
                end
            else
                puts "Ce SpaceBot est déjà mort !"
                puts
                self.menu_choice(gets.chomp)
            end
        when "2" 
            if enemies.length > 2
                puts
                human_player.attacks(enemies[2])
                if enemies[2].life_points <= 0
                    kill_player(enemies[2])
                end
            else
                puts "Ce SpaceBot est déjà mort !"
                puts
                self.menu_choice(gets.chomp)
            end
        when "3" 
            if enemies.length > 3
                puts
                human_player.attacks(enemies[3])
                if enemies[3].life_points <= 0
                    kill_player(enemies[3])
                end
            else
                puts "Ce SpaceBot est déjà mort !"
                puts
                self.menu_choice(gets.chomp)
            end
        when "q"
            begin
                exit!
            rescue SystemExit
                puts "Merci d'être passé ! A la prochaine !" 
            end
        else
            puts "Ceci n'est pas une commande valide."
            puts
            self.menu_choice(gets.chomp)
        end
    end

    def enemies_attack
        if enemies.length > 0
            puts "Les SpaceBots passent à l'attaque !"
            puts
            enemies.each do |bot|
                if bot.life_points > 0 && human_player.life_points > 0
                bot.attacks(human_player)
                end
            end
        end
    end

    def end
        if human_player.life_points > 0
            puts
            puts "BRAVO! Tu as triomphé des SpaceBots !"
            puts "------====### THE END ###====------"
        else
            puts
            puts "Tu est mort... :'( et en plus, les SpaceBots dancent le Floss sur ton cadavre... "
            puts "------====### THE END ###====------"
        end
    end

    def continue?
        puts
        puts "Appuis sur entrée pour continuer"
        gets
        puts
    end
end