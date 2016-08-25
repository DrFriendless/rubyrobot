require 'test/unit/assertions'
require_relative '../src/table'
require_relative '../src/main'
include Test::Unit::Assertions

def test(program, expected)
  runner = Runner.new
  result = runner.run(program, false)
  assert_equal(expected, result)
end

# basic test that anything at all works
test("PLACE 0,0,NORTH\n REPORT", ["0,0,NORTH"])

# test move
test("PLACE 0,0,NORTH\n REPORT\n MOVE\n REPORT", ["0,0,NORTH", "0,1,NORTH"])
# test right
test("PLACE 0,0,NORTH\n RIGHT\n REPORT", ["0,0,EAST"])
# test left
test("PLACE 0,0,NORTH\n LEFT\n REPORT", ["0,0,WEST"])
# test multiple PLACEs
test("PLACE 0,0,NORTH\n PLACE 1,1,WEST\n REPORT", ["1,1,WEST"])

# test that left, right, move, report are ignored if the robot is not on the table
test("LEFT\nPLACE 0,0,NORTH\n REPORT", ["0,0,NORTH"])
test("RIGHT\nPLACE 0,0,NORTH\n REPORT", ["0,0,NORTH"])
test("MOVE\nPLACE 0,0,NORTH\n REPORT", ["0,0,NORTH"])
test("REPORT\nPLACE 0,0,NORTH\n REPORT", ["0,0,NORTH"])

#
assert_raise(ParseError) { test("NONSENSE", []) }
assert_raise(ParseError) { test("LEFT\n ", []) }
assert_raise(ParseError) { test("PLACE 10,10,EAST", []) }