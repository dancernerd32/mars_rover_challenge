class Rover
  attr_accessor :x_coord, :y_coord, :facing
  attr_reader :directions, :rover_deployment
  def initialize(x_coord, y_coord, facing, directions, rover_deployment)
    @x_coord = x_coord
    @y_coord = y_coord
    @facing = facing
    @directions = directions.split("")
    @rover_deployment = rover_deployment
  end

  def turn(side)
    compass = ["N", "E", "S", "W"]
    index = compass.index(facing)
    @facing = side == "R" ? compass[(index + 1) % 4] : compass[(index - 1) % 4]
  end

  def get_move_coords
    case facing
    when "E"
      [x_coord + 1, y_coord]
    when "W"
      [x_coord - 1, y_coord]
    when "N"
      [x_coord, y_coord + 1]
    when "S"
      [x_coord, y_coord - 1]
    end
  end

  def move(new_coords)
    unless will_crash?(new_coords) || will_fall?(new_coords)
      @x_coord = new_coords[0]
      @y_coord = new_coords[1]
    end
  end

  def rove
    directions.each do |direction|
      case direction
      when "L", "R"
        turn(direction)
      when "M"
        new_coords = get_move_coords
        move(new_coords)
      end
    end
  end

  def will_crash?(new_coords)
    rover_deployment.rover_positions
      .map{|position| [position[0], position[1]]}
      .include?(new_coords)
  end

  def will_fall_in_ditch?(new_coords)
    rover_deployment.ditch_coords.include?(new_coords)
  end

  def will_fall_off_plateau?(new_coords)
    max_coords = rover_deployment.max_coords
    max_coords[0] < new_coords[0] || max_coords[1] < new_coords[1] ||
    new_coords[0] < 0 || new_coords[1] < 0
  end


  def will_fall?(new_coords)
    will_fall_off_plateau?(new_coords) || will_fall_in_ditch?(new_coords)
  end
end
