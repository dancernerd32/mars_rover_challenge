class Rover
  attr_accessor :x_coord, :y_coord, :facing
  attr_reader :directions, :rover_deployment
  def initialize(x_coord, y_coord, facing, directions, rover_deployment)
    @x_coord = x_coord
    @y_coord = y_coord
    @facing = facing
    @directions = direction_list(directions)
    @rover_deployment = rover_deployment
  end

  def direction_list(directions)
    directions.split("").map do |direction|
      case direction
      when "L"
        :left
      when "R"
        :right
      when "M"
        :move
      end
    end
  end

  def turn(side)
    compass = ["N", "E", "S", "W"]
    index = compass.index(facing)
    @facing = side == :right ? compass[(index + 1) % 4] : compass[(index - 1) % 4]
  end

  def get_new_coords
    new_x_coord = case facing
    when "E"
      x_coord + 1
    when "W"
      x_coord - 1
    when "N", "S"
      x_coord
    end

    new_y_coord = case facing
    when "N"
      y_coord + 1
    when "S"
      y_coord - 1
    when "E", "W"
      y_coord
    end
    [new_x_coord, new_y_coord]
  end

  def move(new_coords)
    @x_coord = new_coords[0]
    @y_coord = new_coords[1]
  end

  def execute
    directions.each do |direction|
      case direction
      when :left, :right
        turn(direction)
      when :move
        new_coords = get_new_coords
        move(new_coords) unless will_crash?(new_coords) || will_fall?(new_coords)
      end
    end
  end

  def will_crash?(new_coords)
    rover_deployment.rovers.map{|rover| [rover.x_coord, rover.y_coord]} == new_coords
  end

  def will_fall?(new_coords)
    max_coords = rover_deployment.max_coords
    max_coords[0] < new_coords[0] || max_coords[1] < new_coords[1]
  end
end
