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
# The rest of the input is information pertaining to the rovers that have been deployed. Each rover has two lines of input. The first line gives the rover's position, and the second line is a series of instructions telling the rover how to explore the plateau.
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

def collect_plateau_input
  puts "Please enter the size of your plateau in the form <height width>.\ne.g.\n5 5"
  input = gets.chomp
  while !plateau_input_valid?(input)
    puts "Format invalid. Please try again. \n Enter the size of your plateau in
    the form <height width>. \nFor example:\n5 5"
    input = gets.chomp
  end
  input
end

def plateau_input_valid?(input)
  true
end

def collect_rover_input
  rover_input = []
  continue = true
  puts "Please enter the direction and orientation of your rover\nUse the format
  <x_coordinate y_coordinate direction>\ne.g.\n1 2 N"
  rover_input << gets.chomp
  puts "Please enter the series of instructions you'd like to give the rover"
  puts "The format should be any combination of 'L' to turn left, 'R' to turn
  right, \n and 'M' to move one square forward in the direction it is facing.\n
  This input should have no spaces"
  puts "e.x."
  puts "LMLMMRM"
  rover_input << gets.chomp

  while continue
    puts "If you'd like to add another rover, enter the direction and orientation, \n
    otherwise hit enter to deploy your rovers"
    input = gets.chomp
    if input == ""
      return rover_input
    else
      rover_input << input
      puts "Enter the instructions for your rover"
      rover_input << gets.chomp
    end
  end
end

def rover_position_valid?
  true
end

def rover_directions_valid?
  true
end

max_coords = collect_plateau_input
rover_attributes = collect_rover_input

deployment = RoverDeployment.new(max_coords, rover_attributes)
deployment.deploy_rovers
puts deployment.rover_position_strings
