require 'test/unit/assertions'
require_relative '../src/table'
require_relative '../src/main'
include Test::Unit::Assertions

def test(program, expected)
  runner = Runner.new
  result = runner.run(program)
  assert_equal(expected, result)
end

test("PLACE 0,0,NORTH; REPORT", ["0,0,NORTH"])
test("PLACE 0,0,NORTH; REPORT; MOVE; REPORT", ["0,0,NORTH", "0,1,NORTH"])