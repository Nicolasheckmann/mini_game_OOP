class Player
    attr_accessor :name, :life_points

    def initialize(name)
        self.name = name
        self.life_points = 10
    end

    def show_state
        puts "#{name} a #{life_points} points de vie"
    end

    def gets_damaged(damage_received)
        self.life_points -= damage_received
        if life_points <= 0
            puts
            puts "#{name} a été tué !"
        end
    end

    def attacks(player_to_attack)
        puts "#{name} attaque #{player_to_attack.name}"
        damage_done = compute_damage
        puts "Pour #{damage_done} points de dégâts !"
        player_to_attack.gets_damaged(damage_done) #le joueur attaqué se prends les dommages
    end

    def compute_damage
        rand(1..6)
    end
end

class HumanPlayer < Player
    attr_accessor :weapon_level

    def initialize(name)
        super(name)
        self.life_points = 100
        self.weapon_level = 1
    end

    def show_state
        puts "#{name} a #{life_points} points de vie et une arme de niveau #{weapon_level}"
        puts
    end

    def compute_damage
        super * weapon_level
    end

    def search_weapon
        new_weapon_level = rand(1..6)
        puts "Tu as trouvé une arme de niveau #{new_weapon_level} !"
        puts
        if new_weapon_level > weapon_level
            self.weapon_level = new_weapon_level
            "Cette arme est meilleure que celle équipée actuellement : tu la prends !"
        else
            "Malheureusement, l'arme que tu as trouvée n'est pas mieux que ton arme actuelle..."
        end           
    end

    def search_health_pack
        random_outcome = rand(1..6)
        case random_outcome
        when 1
            "Tu n'as rien trouvé..."
        when 2..5
            life_points <= 50 ? self.life_points += 50 : self.life_points = 100 # rends des PV dans la limite des 100 du départ
            "Bravo, tu as trouvé un pack de +50 points de vie !"
        when 6
            life_points <= 20 ? self.life_points += 80 : self.life_points = 100 # rends des PV dans la limite des 100 du départ
            "Waow, tu as trouvé un pack de +80 points de vie !"
        end
    end
end