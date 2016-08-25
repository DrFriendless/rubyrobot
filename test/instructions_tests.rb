require 'test/unit/assertions'
include Test::Unit::Assertions
require_relative '../src/instructions'

assert(valid_direction?(:NORTH))
assert(valid_direction?(:SOUTH))
assert(valid_direction?(:EAST))
assert(valid_direction?(:WEST))
assert_false(valid_direction?(:REPORT))

assert_equal(:EAST, clockwise(:NORTH))
assert_equal(:SOUTH, clockwise(:EAST))
assert_equal(:WEST, clockwise(:SOUTH))
assert_equal(:NORTH, clockwise(:WEST))

assert_equal(:WEST, anticlockwise(:NORTH))
assert_equal(:NORTH, anticlockwise(:EAST))
assert_equal(:EAST, anticlockwise(:SOUTH))
assert_equal(:SOUTH, anticlockwise(:WEST))

