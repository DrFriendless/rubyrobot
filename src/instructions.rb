# distances for a particular move
class Move
  def initialize(x,y)
    @x = x
    @y = y
  end

  attr_reader :x
  attr_reader :y
end

class Instruction
  def initialize(opcode)
    raise "Invalid opcode" unless VALID_OPCODES.include?(opcode)
    @opcode = opcode
  end

  attr_reader :opcode
end

class Place < Instruction
  def initialize(position)
    super(:PLACE)
    @position = position
  end

  attr_reader :position
end

VALID_OPCODES = [ :PLACE, :MOVE, :LEFT, :RIGHT, :REPORT ]

MOVES_FOR_DIRECTIONS = { :NORTH => Move.new(0, 1), :EAST => Move.new(1, 0), :SOUTH => Move.new(0, -1), :WEST => Move.new(-1, 0) }

def valid_direction?(dir)
  MOVES_FOR_DIRECTIONS[dir] != nil
end
