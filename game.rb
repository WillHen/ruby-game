require_relative "player"
require_relative "die"
require_relative "game_turn"
require_relative "treasure_trove"

class Game
    attr_reader :title
    def initialize(title)
        @title = title
        @players = []
    end

    def load_players(from_file)
        File.readlines(from_file).each do |line|
            add_player(Player.from_csv(line))
        end
    end

    def add_player(player)
        @players << player
    end

    def high_score_entry(player)
        formatted_name = player.name.ljust(20, '.')
        "#{formatted_name} #{player.score}"
    end

    def save_high_scores(file_name="high_scores.txt")
        File.open(file_name, 'w') do |file|
            file.puts "#{@title} High Scores:"
            @players.each do |player|
                formatted_name = player.name.ljust(20, '.')
                file.puts  high_score_entry(player)
            end
        end
    end

    def play(rounds)
        treasures = TreasureTrove::TREASURES
        puts "\nThere are #{treasures.size} treasures to be found:"
        treasures.each do |treasure|
            puts "A #{treasure.name} is worth #{treasure.points} points"

        end
        1.upto(rounds) do |r|
            if block_given?
                puts "BREAK #{total_points}"
                break if yield
            end
            puts "\n Round: #{r}"
            puts "There are #{@players.length} players in #{@name}:"
            @players.each do |player|
                GameTurn.take_turn(player)
                puts player
            end
        end
    end

    def print_name_and_health(player)
        formatted_name = player.name.ljust(20, '.')
        puts "#{formatted_name} #{player.score}"
    end

    def print_stats
        strong_players, wimpy_players = @players.partition {|p| p.strong?}

        puts "#{@title} Statistics:"
        puts "\n #{strong_players.size} Strong Players:"
        strong_players.each do | p|
            print_name_and_health(p)
        end

        puts "\n #{wimpy_players.size} Wimpy Players:"
        wimpy_players.each do | p|
            print_name_and_health(p)
        end

        puts "High Scores:"
        @players.sort.each do |p|
            puts  high_score_entry(p)
        end

        @players.each do |player|
            puts "\n#{player.name}'s point total:"

            player.each_found_treasure { |treasure| puts "#{treasure.points} total #{treasure.name} points" }
            puts "#{player.points} grand total points"

        end

        puts "#{total_points} total points from treasures found"
    end

    def total_points
        points = @players.map { |player| player.points }
        points.reduce(0, :+)
    end
end
