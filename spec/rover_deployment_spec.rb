require_relative '../rover'
require_relative '../rover_deployment'
require 'pry'
describe RoverDeployment do
  describe "organize_attributes" do
    it "should place attributes into pairs" do
      rover_deployment = RoverDeployment.new("5 5", [])
      attrs = ["1 2 N", "LMLMLMMR", "3 3 W", "RMMLMMRMM"]
      result = [[["1", "2", "N"], "LMLMLMMR"], [["3", "3", "W"], "RMMLMMRMM"]]
      expect(rover_deployment.organize_attributes(attrs)).to eq(result)
    end
  end

  describe "rover_positions" do
    it "should list the current positions of the rovers in the deployment" do
      attrs = ["1 2 N", "LMLMLMMR", "3 3 W", "RMMLMMRMM"]
      rover_deployment = RoverDeployment.new("5 5", attrs)
      expect(rover_deployment.rover_positions).to eq([[1, 2, "N"], [3, 3, "W"]])
    end
  end

  describe "rover_position_strings" do
    it "should list the current positions of the rovers in the deployment in string form" do
      attrs = ["1 2 N", "LMLMLMMR", "3 3 W", "RMMLMMRMM"]
      rover_deployment = RoverDeployment.new("5 5", attrs)
      expect(rover_deployment.rover_position_strings).to eq(["1 2 N", "3 3 W"])
    end
  end
end
