require_relative "game"
require_relative "clumsy_player"

require_relative 'berserk_player'

berserker = BerserkPlayer.new("berserker", 50)

player1 = Player.new("moe")
player2 = Player.new("larry", 60)
player3 = Player.new("curly", 125)
player4 = Player.new("klutz", 105)


knuckleheads = Game.new("Knuckleheads")
knuckleheads.add_player(player4)
knuckleheads.add_player(berserker)
knuckleheads.load_players( ARGV.shift || "players.csv")
knuckleheads.play(10) do
    knuckleheads.total_points >= 2000
end
knuckleheads.print_stats

loop do
    puts "\nHow many game rounds? ('quit' to exit)"
    rounds = gets.chomp.downcase
    case rounds
    when /^\d+$/
        knuckleheads.play(rounds.to_i)
    when 'quit', 'exit'
        knuckleheads.print_stats
        break
    else
        puts "Please enter a number or 'quit'"
    end
end

knuckleheads.save_high_scores
