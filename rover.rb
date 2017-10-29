class Rover
  attr_accessor :x_coord, :y_coord, :facing
  attr_reader :directions
  def initialize(x_coord, y_coord, facing, directions)
    @x_coord = x_coord
    @y_coord = y_coord
    @facing = facing
    @directions = direction_list(directions)
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

  def move
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

    @x_coord = new_x_coord
    @y_coord = new_y_coord
  end

  def execute
    directions.each do |direction|
      case direction
      when :left, :right
        turn(direction)
      when :move
        move unless will_crash? || will_fall?
      end
    end
  end

  def will_crash?
    false
  end

  def will_fall?
    false
  end
end
