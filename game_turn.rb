require_relative 'die'
require_relative 'player'
require_relative 'treasure_trove'

module GameTurn
    def self.take_turn(player)
        treasure = TreasureTrove.random
        player.found_treasure(treasure)
        die = Die.new
        number_rolled = die.roll
        case number_rolled
        when 1..2
            player.blam
        when 3..4
            puts  "#{player.name} was skipped."
        else
            player.w00t
        end
    end
end
