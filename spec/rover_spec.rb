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

  describe "get_move_coords" do
    context "from [2, 2]" do
      let(:rover){Rover.new(2, 2, "N", "", rover_deployment)}

      it "should return coordinates one square north when facing north" do
        expect(rover.get_move_coords).to eq([2, 3])
      end

      it "should return coordinates one square east when facing east" do
        rover.facing = "E"
        expect(rover.get_move_coords).to eq([3, 2])
      end

      it "should return coordinates one square south when facing south" do
        rover.facing = "S"
        expect(rover.get_move_coords).to eq([2, 1])
      end

      it "should return coordinates one square west when facing west" do
        rover.facing = "W"
        expect(rover.get_move_coords).to eq([1, 2])
      end
    end

    context "from [0, 0]" do
      let(:rover){Rover.new(0, 0, "N", "", rover_deployment)}

      it "should return negative coordinates if moving south of 0 0" do
        rover.facing = "S"
        expect(rover.get_move_coords).to eq([0, -1])
      end

      it "should return negative coordinates if moving west of 0 0" do
        rover.facing = "W"
        expect(rover.get_move_coords).to eq([-1, 0])
      end
    end

    let(:rover){Rover.new(0, 0, "N", "", rover_deployment)}

    it "should not change the position of the rover" do
      expect{rover.get_move_coords}.not_to change{rover.x_coord}
      expect{rover.get_move_coords}.not_to change{rover.y_coord}
    end
  end

  describe "move" do
    let(:rover){Rover.new(0, 0, "N", "", rover_deployment)}

    it "should not move the rover if it will fall" do
      allow(rover).to receive(:will_fall?).and_return(true)
      expect{rover.move([1,2])}.not_to change{rover.x_coord}
      expect{rover.move([1,2])}.not_to change{rover.y_coord}
    end

    it "should not move the rover if it will crash" do
      allow(rover).to receive(:will_crash?).and_return(true)
      expect{rover.move([1,2])}.not_to change{rover.x_coord}
      expect{rover.move([1,2])}.not_to change{rover.y_coord}
    end

    it "should move the rover to the designated coords if it won't fall or crash" do
      allow(rover).to receive(:will_crash?).and_return(false)
      allow(rover).to receive(:will_fall?).and_return(false)
      rover.move([1,2])
      expect(rover.x_coord).to eq(1)
      expect(rover.y_coord).to eq(2)
    end
  end

  describe "will_fall?" do
    let(:rover){Rover.new(0, 0, "N", "", rover_deployment)}

    it "returns true if the new x value is negative" do
      expect(rover.will_fall?([-1, 0])).to be(true)
    end

    it "returns true if the new y value is negative" do
      expect(rover.will_fall?([0, -1])).to be(true)
    end

    it "returns true if the new x value is greater than the plateau max x value" do
      expect(rover.will_fall?([6, 5])).to be(true)
    end

    it "returns true if the new y value is greater than the plateau max y value" do
      expect(rover.will_fall?([5, 6])).to be(true)
    end

    it "returns false if the x value and y value are both on the grid" do
      x = 0
      while x <= 5
        y = 0
        while y <= 5
          expect(rover.will_fall?([x, y])).to be(false)
          y += 1
        end
        x += 1
      end
    end
  end

  describe "will_crash?" do
    let(:rover){Rover.new(0, 0, "N", "", rover_deployment)}
    before(:each) do
      rover_positions = [[0,0, "N"], [3,2, "N"], [4,4, "N"], [3,5, "N"]]

      allow(rover).to receive_message_chain(
        "rover_deployment.rover_positions").and_return(rover_positions)
    end

    it "returns true if there is a rover in the deployment at the provided position" do
      expect(rover.will_crash?([3,2])).to be(true)
    end

    it "returns false if there is no rover at that position" do
      expect(rover.will_crash?([3,3])).to be(false)
    end
  end

  describe "rove" do
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
