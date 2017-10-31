require_relative '../rover'
require_relative '../rover_deployment'
require 'pry'
describe Rover do
  let(:rover_deployment){ RoverDeployment.new("5 5", []) }

  describe "turn" do
    let(:rover){Rover.new(0, 0, "N", "", rover_deployment)}

    context "with parameter 'R'" do
      it "should turn a rover originally facing north to face east" do
        rover.turn("R")
        expect(rover.facing).to eq("E")
      end

      it "should turn a rover originally facing east to face south" do
        rover.facing = "E"
        rover.turn("R")
        expect(rover.facing).to eq("S")
      end

      it "should turn a rover originally facing south to face west" do
        rover.facing = "S"
        rover.turn("R")
        expect(rover.facing).to eq("W")
      end

      it "should turn a rover originally facing west to face north" do
        rover.facing = "W"
        rover.turn("R")
        expect(rover.facing).to eq("N")
      end

      it "should not change the position of the rover" do
        expect{rover.turn("R")}.not_to change{rover.x_coord}
        expect{rover.turn("R")}.not_to change{rover.y_coord}
      end
    end

    context "with parameter 'L'" do
      it "should turn a rover originally facing north to face west" do
        rover.turn("L")
        expect(rover.facing).to eq("W")
      end

      it "should turn a rover originally facing west to face south" do
        rover.facing = "W"
        rover.turn("L")
        expect(rover.facing).to eq("S")
      end

      it "should turn a rover originally facing south to face east" do
        rover.facing = "S"
        rover.turn("L")
        expect(rover.facing).to eq("E")
      end

      it "should turn a rover originally facing east to face north" do
        rover.facing = "E"
        rover.turn("L")
        expect(rover.facing).to eq("N")
      end
    end
  end

  describe "move" do
    it "should move one coordinate north (y gets one bigger) when facing north" do
    end

    it "should move one coordinate south (y gets one smaller) when facing south" do
    end

    it "should move one coordinate east (x gets one bigger) when facing east" do
    end

    it "should move one coordinate west (x gets one smaller) when facing west" do
    end
  end

  describe "rove" do
    it "should turn to the left when told" do
      rover = Rover.new(1, 2, "N", "L", rover_deployment)
      rover.rove
      expect([rover.x_coord, rover.y_coord, rover.facing]).to eq([1, 2, "W"])
    end

    it "should give the expected output for the first rover" do
      rover = Rover.new(1, 2, "N", "LMLMLMLMM", rover_deployment)
      rover.rove
      expect([rover.x_coord, rover.y_coord, rover.facing]).to eq([1, 3, "N"])
    end

    it "should give the expected output for the second rover" do
      rover = Rover.new(3, 3, "E", "MMRMMRMRRM", rover_deployment)
      rover.rove
      expect([rover.x_coord, rover.y_coord, rover.facing]).to eq([5, 1, "E"])
    end

  end
end
