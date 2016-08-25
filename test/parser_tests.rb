require 'test/unit/assertions'
require_relative '../src/parser'
require_relative '../src/table'
include Test::Unit::Assertions

# make sure the regexp says what we think it says
assert_match(PLACE_PATTERN, 'PLACE 0,0,NORTH')
assert_match(PLACE_PATTERN, 'PLACE 0,0,EAST')
assert_match(PLACE_PATTERN, 'PLACE 0,0,SOUTH')
assert_match(PLACE_PATTERN, 'PLACE 0,0,WEST')
assert_match(PLACE_PATTERN, 'PLACE 1,2,WEST')
assert_match(PLACE_PATTERN, 'PLACE 3,4,WEST')
assert_match(PLACE_PATTERN, 'PLACE 5,6,WEST')
assert_match(PLACE_PATTERN, 'PLACE 7,8,WEST')
assert_no_match(PLACE_PATTERN, 'PLACE -7,8,WEST')
assert_no_match(PLACE_PATTERN, 'PLACE 7,8,FROG')
assert_no_match(PLACE_PATTERN, 'PLACE 9,10,WEST')
assert_no_match(PLACE_PATTERN, 'PEACE 0,0,NORTH')
assert_no_match(PLACE_PATTERN, 'PLACE0,0,NORTH')
assert_match(PLACE_PATTERN, 'PLACE 0 , 0 , NORTH')

assert_equal('0', PLACE_PATTERN.match('PLACE 0,1,NORTH')[1])
assert_equal('1', PLACE_PATTERN.match('PLACE 0,1,NORTH')[2])
assert_equal('NORTH', PLACE_PATTERN.match('PLACE 0,1,NORTH')[3])
assert_equal('WEST', PLACE_PATTERN.match('PLACE 0,1,WEST')[3])
assert_equal('SOUTH', PLACE_PATTERN.match('PLACE 0,1,SOUTH')[3])
assert_equal('EAST', PLACE_PATTERN.match('PLACE 0,1,EAST')[3])

# test parse_instruction
assert_equal(:LEFT, parse_instruction('LEFT', -1).opcode)
assert_equal(:RIGHT, parse_instruction('RIGHT', -1).opcode)
assert_equal(:RIGHT, parse_instruction('right', -1).opcode)
assert_equal(:RIGHT, parse_instruction(' right ', -1).opcode)
assert_equal(:MOVE, parse_instruction('MOVE', -1).opcode)
assert_equal(:REPORT, parse_instruction('REPORT', -1).opcode)
assert_equal(:PLACE, parse_instruction('PLACE 0,0,NORTH', -1).opcode)
assert_equal(:PLACE, parse_instruction(' PLACE 0 , 0 , NORTH ', -1).opcode)
assert_equal(:PLACE, parse_instruction('PLACE 3,4,WEST', -1).opcode)
assert_equal(:PLACE, parse_instruction('place 3,4,west', -1).opcode)

assert_raise(ParseError) { parse_instruction('', -1) }
assert_raise(ParseError) { parse_instruction('LEFF', -1) }
assert_raise(ParseError) { parse_instruction('PLACE0,0,NORTH', -1) }
assert_raise(ParseError) { parse_instruction('LEFT 0,0,NORTH', -1) }
assert_raise(InvalidPosition) { parse_instruction('PLACE 9,9,NORTH', -1) }
assert_raise(InvalidPosition) { parse_instruction('PLACE 3,6,west', -1) }

# test positions in place instructions
assert(parse_instruction('place 3,4,west', -1).is_a? Place)
assert(parse_instruction('place 3,4,west', -1).position.x == 3)
assert(parse_instruction('place 3,4,west', -1).position.y == 4)
assert(parse_instruction('place 3,4,west', -1).position.direction == :WEST)
assert(parse_instruction(' PLACE 0 , 2 , NORTH ', -1).is_a? Place)
assert(parse_instruction(' PLACE 0 , 2 , NORTH ', -1).position.x == 0)
assert(parse_instruction(' PLACE 0 , 2 , NORTH ', -1).position.y == 2)
assert(parse_instruction(' PLACE 0 , 2 , NORTH ', -1).position.direction == :NORTH)

# test the multi-line parser
assert_equal(2, parse_instructions("LEFT\n RIGHT").length)
assert_equal(1, parse_instructions("MOVE").length)
assert_equal(2, parse_instructions("place 0,0,north\n move").length)
assert_equal([:LEFT, :RIGHT, :MOVE, :REPORT, :PLACE], parse_instructions("left\n right\n move\n report\n place 0,0,east").map { |i| i.opcode })