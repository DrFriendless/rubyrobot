class Instruction
  def initialize(opcode)
    raise "Invalid opcode" unless VALID_OPCODES.include?(opcode)
    @opcode = opcode
  end

  attr_reader :opcode

  def to_s
    opcode.to_s
  end
end

class Place < Instruction
  def initialize(position)
    super(:PLACE)
    @position = position
  end

  attr_reader :position

  def to_s
    "#{opcode} #{@position.x},#{@position.y},#{@position.direction}"
  end
end

VALID_OPCODES = [ :PLACE, :MOVE, :LEFT, :RIGHT, :REPORT ]

DIRECTION_IN_ORDER = [ :NORTH, :EAST, :SOUTH, :WEST ]

def valid_direction?(dir)
  DIRECTION_IN_ORDER.include?(dir)
end

def clockwise(dir)
  return nil unless valid_direction?(dir)
  i = DIRECTION_IN_ORDER.index(dir)
  i = (i + 1) % DIRECTION_IN_ORDER.length
  DIRECTION_IN_ORDER[i]
end

def anticlockwise(dir)
  return nil unless valid_direction?(dir)
  i = DIRECTION_IN_ORDER.index(dir)
  i = (i + DIRECTION_IN_ORDER.length - 1) % DIRECTION_IN_ORDER.length
  DIRECTION_IN_ORDER[i]
end
