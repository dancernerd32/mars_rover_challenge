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

  describe "create_rovers" do
    it "should create rovers from attributes" do

    end
  end

  describe "deploy_rovers" do
    it "should move rovers one at a time"
  end

  describe "rover_positions" do
    it "should list the current positions of the rovers in the deployment"
  end

  describe "rover_position_strings" do
    it "should list the current positions of the rovers in the deployment in string form"
  end
end
