require_relative '../rover'
require 'pry'
describe Rover do
  describe "rove" do
    it "should turn to the left when told" do
      rover = Rover.new(1, 2, "N", "L")
      rover.execute
      expect([rover.x_coord, rover.y_coord, rover.facing]).to eq([1, 2, "W"])
    end

    it "should give the expected output for the first rover" do
      rover = Rover.new(1, 2, "N", "LMLMLMLMM")
      rover.execute
      expect([rover.x_coord, rover.y_coord, rover.facing]).to eq([1, 3, "N"])
    end

    it "should give the expected output for the second rover" do
      rover = Rover.new(3, 3, "E", "MMRMMRMRRM")
      rover.execute
      expect([rover.x_coord, rover.y_coord, rover.facing]).to eq([5, 1, "E"])
    end

  end
end
