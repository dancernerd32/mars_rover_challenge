# Mars Rover technical Challenge
#
# The problem below requires some kind of input. You are free to implement any mechanism for feeding input into your solution (for example, using hard coded data within a unit test). You should provide sufficient evidence that your solution is complete by, as a minimum, indicating that it works correctly against the supplied test data.
#
# We highly recommend using a unit testing framework such as JUnit or NUnit. Even if you have not used it before, it is simple to learn and incredibly useful.
#
# The code you write should be of production quality, and most importantly, it should be code you are proud of.
#
# MARS ROVERS
#
# A squad of robotic rovers are to be landed by NASA on a plateau on Mars.
#
# This plateau, which is curiously rectangular, must be navigated by the rovers so that their on board cameras can get a complete view of the surrounding terrain to send back to Earth.
#
# A rover's position is represented by a combination of an x and y co-ordinates and a letter representing one of the four cardinal compass points. The plateau is divided up into a grid to simplify navigation. An example position might be 0, 0, N, which means the rover is in the bottom left corner and facing North.
#
# In order to control a rover, NASA sends a simple string of letters. The possible letters are 'L', 'R' and 'M'. 'L' and 'R' makes the rover spin 90 degrees left or right respectively, without moving from its current spot.
#
# 'M' means move forward one grid point, and maintain the same heading.
#
# Assume that the square directly North from (x, y) is (x, y+1).
#
# Input:
#
# The first line of input is the upper-right coordinates of the plateau, the lower-left coordinates are assumed to be 0,0.
#
# The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover's position, and the second line is a series of directions telling the rover how to explore the plateau.
#
# The position is made up of two integers and a letter separated by spaces, corresponding to the x and y co-ordinates and the rover's orientation.
#
# Each rover will be finished sequentially, which means that the second rover won't start to move until the first one has finished moving.
#
# Output:
#
# The output for each rover should be its final co-ordinates and heading.
#
# Test Input:
#
# 5 5
#
# 1 2 N
#
# LMLMLMLMM
#
# 3 3 E
#
# MMRMMRMRRM
#
# Expected Output:
#
# 1 3 N
#
# 5 1 E

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
