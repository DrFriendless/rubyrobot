require 'test/unit/assertions'
include Test::Unit::Assertions
require_relative '../src/main'

def test_example(filename)
  text = File.open("programs/#{filename}").read
  runner = Runner.new
  runner.run(text, false)
end

assert_equal(["0,1,NORTH"], test_example("example_a.txt"))
assert_equal(["0,0,WEST"], test_example("example_b.txt"))
assert_equal(["3,3,NORTH"], test_example("example_c.txt"))