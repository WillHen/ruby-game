require_relative 'player'
require_relative 'treasure_trove'

describe Player do

    before  do
        @initial_health = 150
        @player = player = Player.new("larry", @initial_health)
    end

    it "has a capitalized name" do

        expect(@player.name).to eq("Larry")
    end

    it "has an initial health" do
        expect(@player.health).to eq(150)

    end

    it "has a string representation" do
        @player.found_treasure(Treasure.new(:hammer, 50))
        @player.found_treasure(Treasure.new(:hammer, 50))

        @player.to_s.should == "I'm Larry with health = 150, points = 100, and score = 250."
    end

    it "computes a score as the sum of its health and total treasure points" do
        @player.found_treasure(Treasure.new(:hammer, 50))
        expect(@player.score).to eq(150+50)
    end

    it "increases health by 15 when w00ted" do
        @player.w00t
        expect(@player.health).to eq(@initial_health + 15)

    end

    it "computes points as the sum of all treasure points" do
        @player.points.should == 0

        @player.found_treasure(Treasure.new(:hammer, 50))

        @player.points.should == 50

        @player.found_treasure(Treasure.new(:crowbar, 400))

        @player.points.should == 450

        @player.found_treasure(Treasure.new(:hammer, 50))

        @player.points.should == 500
    end

    it "computes a score as the sum of its health and points" do
        @player.found_treasure(Treasure.new(:hammer, 50))
        @player.found_treasure(Treasure.new(:hammer, 50))

        @player.score.should == 250
    end

    it "decreases health by 10 when blammed" do
        @player.blam
        expect(@player.health).to eq(@initial_health -10)
    end

    it "yields each found treasure and its total points" do
        @player.found_treasure(Treasure.new(:skillet, 100))
        @player.found_treasure(Treasure.new(:skillet, 100))
        @player.found_treasure(Treasure.new(:hammer, 50))
        @player.found_treasure(Treasure.new(:bottle, 5))
        @player.found_treasure(Treasure.new(:bottle, 5))
        @player.found_treasure(Treasure.new(:bottle, 5))
        @player.found_treasure(Treasure.new(:bottle, 5))
        @player.found_treasure(Treasure.new(:bottle, 5))

        yielded = []
        @player.each_found_treasure do |treasure|
            yielded << treasure
        end

        yielded.should == [
            Treasure.new(:skillet, 200),
            Treasure.new(:hammer, 50),
            Treasure.new(:bottle, 25)
        ]
    end

    it "should create a player for a string input" do
        expect(@player.from_csv("colin,10").name).to eq('Colin')
    end

    context "with a health greater than 100" do
        before do
            @player = player = Player.new("larry", 150)
        end

        it "is strong" do
            expect(@player).to be_strong
        end
    end

    context "with a health less than 100" do
        before do
            @player = player = Player.new("larry", 90)
        end

        it "is wimpy" do
            expect(@player).to_not be_strong
        end
    end
end
