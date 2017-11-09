require_relative 'rover'
require 'pry'

class RoverDeployment
  attr_reader :max_coords, :rovers, :ditch_coords
  def initialize(max_coords, rover_attributes, fall_coords=nil)
    @max_coords = max_coords.split(" ").map(&:to_i)
    @ditch_coords = get_ditch_coords(ditch_coords)
    @rovers = create_rovers(rover_attributes)
  end

  def get_ditch_coords(ditch_coords)
    ditch_coords.nil? ? [] : ditch_coords.split(", ").map{|coords| coords.split(" ")
      .map(&:to_i)}
  end

  def organize_attributes(rover_attributes)
    positions = []
    directions = []
    rover_attributes.each_with_index do |attr, idx|
      if idx % 2 == 0
        positions << attr
      else
        directions << attr
      end
    end
    positions = positions.map{|position| position.split(" ")}
    positions.zip(directions)
  end


  def create_rovers(rover_attributes)
    paired_attrs = organize_attributes(rover_attributes)
    rovers = paired_attrs.map do |pair|
      x_coord = pair[0][0].to_i
      y_coord = pair[0][1].to_i
      facing = pair[0][2]
      directions = pair[1]
      Rover.new(x_coord, y_coord, facing, directions, self)
    end
    rovers
  end

  def deploy_rovers
    rovers.each do |rover|
      rover.rove
    end
  end

  def rover_positions
    rovers.map{|rover| [rover.x_coord, rover.y_coord, rover.facing]}
  end

  def rover_position_strings
    rover_positions.map{|position_array| position_array.join(" ")}
  end

end
