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
assert_equal(["2,2,NORTH"], test_example("grand_tour.txt"))
assert_equal(["3,4,WEST"], test_example("gibberish.txt"))
assert_equal(["4,1,EAST", "4,1,EAST"], test_example("charge.txt"))