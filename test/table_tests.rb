require 'test/unit/assertions'
include Test::Unit::Assertions
require_relative '../src/table'

# test that positions are sensible
assert_equal(1, Position.new(1,2,:NORTH).x)
assert_equal(2, Position.new(1,2,:NORTH).y)
assert_equal(:NORTH, Position.new(1,2,:NORTH).direction)
assert_equal(0, Position.new(0,3,:EAST).x)
assert_equal(3, Position.new(0,3,:EAST).y)
assert_equal(:EAST, Position.new(0,3,:EAST).direction)

assert_raise(InvalidPosition) { Position.new(-1,0,:NORTH) }
assert_raise(InvalidPosition) { Position.new(MAXX+1,0,:NORTH) }
assert_raise(InvalidPosition) { Position.new(0,-1,:NORTH) }
assert_raise(InvalidPosition) { Position.new(0,MAXY+1,:NORTH) }
assert_raise(InvalidDirection) { Position.new(0,0,:REPORT) }

# test that moves are sensible
# figure out the cumulative effect of a series of moves
def move_seq(directions)
  directions.
      map { |d| MOVES_FOR_DIRECTIONS[d] }.
      inject([0,0]) { |sofar, move| [sofar[0]+move.x, sofar[1]+move.y] }
end

assert_equal([0,0], move_seq([]))
assert_equal([0,0], move_seq([:NORTH, :SOUTH]))
assert_equal([0,0], move_seq([:EAST, :WEST]))
assert_equal([1,1], move_seq([:NORTH, :EAST]))
assert_equal([0,1], move_seq([:NORTH]))
assert_equal([-1,0], move_seq([:WEST]))
assert_equal([0,0], move_seq([:NORTH, :EAST, :SOUTH, :WEST]))

# test the table
# do these things to a new table and return a final report
def position_after(&block)
  t = Table.new
  yield(t)
  t.report
end

# check that the table ops work
assert_equal("0,0,NORTH", position_after { |t| t.place(Position.new(0,0,:NORTH)) })
assert_equal("1,2,EAST", position_after { |t| t.place(Position.new(1,2,:EAST)) })
assert_equal("2,2,EAST", position_after { |t| t.place(Position.new(1,2,:EAST)); t.move })
assert_equal("1,1,SOUTH", position_after { |t| t.place(Position.new(1,2,:SOUTH)); t.move })
assert_equal("1,2,NORTH", position_after { |t| t.place(Position.new(1,2,:EAST)); t.left })
assert_equal("1,2,SOUTH", position_after { |t| t.place(Position.new(1,2,:EAST)); t.right })
# without a PLACE there is no position to return from report, so it returns nil
assert_nil(position_after { |t| t })
assert_nil(position_after { |t| t.left })
assert_nil(position_after { |t| t.right })
assert_nil(position_after { |t| t.move })
# you can't even try to place the robot off the table
assert_raise(InvalidPosition) { position_after { |t| t.place(Position.new(MAXX+1,MAXY+1,:EAST)) } }
assert_raise(InvalidPosition) { position_after { |t| t.place(Position.new(-1,-1,:EAST)) } }

# quick way to create a table
def tab(x,y,direction)
  t = Table.new
  t.place(Position.new(x,y,direction))
  t
end

# test that moves work as expected including declining to fall off the table
assert_true(tab(0,0,:NORTH).move)
assert_true(tab(0,0,:EAST).move)
assert_nil(tab(0,0,:SOUTH).move)
assert_nil(tab(0,0,:WEST).move)
assert_true(tab(1,1,:SOUTH).move)
assert_true(tab(1,1,:WEST).move)