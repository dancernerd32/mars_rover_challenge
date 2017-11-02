require 'pry'
require_relative 'rover_deployment'
require_relative 'rover'

class MarsRoverChallenge
  def initialize
  end

  def plateau_coords_text
    "Please enter the size of your plateau.\nUse the format:
    <height width>\ne.g. 5 5"
  end

  def rover_position_initial_text
    "Please enter the direction and orientation of your rover.\nUse the format:
    <x_coordinate y_coordinate direction>\ne.g. 1 2 N"
  end

  def rover_position_subsequent_text
    "If you'd like to add another rover, enter the direction and orientation,\n" +
    "otherwise hit enter to deploy your rovers."
  end

  def rover_directions_text
    "Please enter the series of directions you'd like to give the rover.\n" +
    "Use 'L' to turn left, 'R' to turn right, and 'M' to move one step forward.\n" +
    "This input should be a continuous string of letters with no spaces.\n" +
    "e.g. LMLMLMLMM"
  end

  def get_next_try_input(type)
    puts "Format invalid. Please try again."
    ask_for_input(type)
    gets.chomp
  end

  def ask_for_input(type)
    case type
    when :plateau_coords
      puts plateau_coords_text
    when :rover_position_initial
      puts rover_position_initial_text
    when :rover_position_subsequent
      puts rover_position_subsequent_text
    when :rover_directions
      puts rover_directions_text
    end
  end

  def collect_valid_input(type)
    ask_for_input(type)
    input = gets.chomp
    while !valid_input?(type, input)
      input = get_next_try_input(type)
    end
    input
  end

  def collect_rover_input
    rover_input = []
    rover_input << collect_valid_input(:rover_position_initial)
    rover_input << collect_valid_input(:rover_directions)
    while true
      input = collect_valid_input(:rover_position_subsequent)
      if input == ""
        return rover_input
      else
        rover_input << input
        rover_input << collect_valid_input(:rover_directions)
      end
    end
  end

  def valid_input?(type, input)
    case type
    when :plateau_coords
      plateau_input_valid?(input)
    when :rover_position_initial
      initial_rover_position_valid?(input)
    when :rover_position_subsequent
      subsequent_rover_position_valid?(input)
    when :rover_directions
      rover_directions_valid?(input)
    end
  end

  def plateau_input_valid?(input)
    !!/^\d+\s\d+$/.match(input)
  end

  def initial_rover_position_valid?(input)
    !!/^\d+\s\d+\s[NESW]$/.match(input)
  end

  def subsequent_rover_position_valid?(input)
    input == "" || initial_rover_position_valid?(input)
  end

  def rover_directions_valid?(input)
    !!/^[RLM]*$/.match(input)
  end

  def run
    max_coords = collect_valid_input(:plateau_coords)
    rover_attributes = collect_rover_input

    deployment = RoverDeployment.new(max_coords, rover_attributes)
    deployment.deploy_rovers
    puts deployment.rover_position_strings
  end
end
