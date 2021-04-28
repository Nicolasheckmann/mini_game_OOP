class Game
    attr_accessor :human_player, :enemies_in_sight, :player_left

    def initialize(player_name)
        self.human_player = HumanPlayer.new(player_name)
        self.enemies_in_sight = []
        self.player_left = 10
    end

    def kill_player(bot_to_kill)
        enemies_in_sight.delete(bot_to_kill)
        self.player_left -= 1
    end

    def is_still_ongoing?
        human_player.life_points > 0 && player_left > 0
    end

    def show_players
        human_player.show_state
        enemies_in_sight.each { |bot| bot.show_state }
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
        enemies_in_sight.each_with_index { |bot, i| print "|> #{i+1} - "; bot.show_state; }
        puts "|                                         |"
        puts "|> q - pour quitter le jeu                |"
        puts "|                                         |"
        puts "==========================================="
        print "> "
    end

    def menu_choice(player_action)
        if player_action.to_i > 0
            if enemies_in_sight.length > player_action.to_i - 1
                puts
                human_player.attacks(enemies_in_sight[player_action.to_i - 1])
                if enemies_in_sight[player_action.to_i - 1].life_points <= 0
                    kill_player(enemies_in_sight[player_action.to_i - 1])
                end
            else
                puts "Ce SpaceBot est déjà mort !"
                puts
                self.menu_choice(gets.chomp)
            end
        elsif player_action == "a"
            puts human_player.search_weapon
        elsif player_action == "s"
            puts human_player.search_health_pack
        elsif player_action == "q"
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

    def enemies_in_sight_attack
        if enemies_in_sight.length > 0
            puts "Les SpaceBots passent à l'attaque !"
            puts
            enemies_in_sight.each do |bot|
                if bot.life_points > 0 && human_player.life_points > 0
                bot.attacks(human_player)
                end
            end
        end
    end

    def new_players_in_sight
        if player_left != enemies_in_sight.length
            random_outcome = rand(1..6)
            case random_outcome
            when 1
                puts "Aucun nouveau SpaceBot en vue..."
            when 2..4
                enemies_in_sight <<  Player.new("SpaceBot_#{rand(1..9999)}") # on push un nouveau bot dont le nom correspond au nombre d'enemis existants
                puts "1 nouveau SpaceBot en vue !"
            when 5..6
                if player_left - enemies_in_sight.length > 1
                    enemies_in_sight <<  Player.new("SpaceBot_#{rand(1..9999)}")
                    enemies_in_sight <<  Player.new("SpaceBot_#{rand(1..9999)}")
                    puts "2 nouveaux SpaceBots en vue !!!"
                else
                    enemies_in_sight <<  Player.new("SpaceBot_#{rand(1..9999)}")
                    puts "1 nouveaus SpaceBot en vue !"
                end
            end
        else
            puts "Tous les SpaceBots sont déjà en vue"
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
        puts "------->  Entrée pour continuer  <---------"
        gets
        puts
    end
end