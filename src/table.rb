MAXX = 4
MAXY = 4

class Table
  require_relative './instructions'

  def initialize
    @x = nil
    @y = nil
    @direction = nil
  end

  # this can't cause an error if the parameter is a real Position
  def place(position)
    @x = position.x
    @y = position.y
    @direction = position.direction
  end

  def left
    return nil unless @direction
    @direction = anticlockwise(@direction)
    true
  end

  def right
    return nil unless @direction
    @direction = clockwise(@direction)
    true
  end

  def move
    return nil unless @direction
    delta = MOVES_FOR_DIRECTIONS[@direction]
    return nil unless (@x + delta.x).between?(0, MAXX)
    return nil unless (@y + delta.y).between?(0, MAXY)
    @x += delta.x
    @y += delta.y
    true
  end

  def report
    Position.new(@x, @y, @direction).to_s
  end
end

# distances for a particular move
class Move
  def initialize(x,y)
    @x = x
    @y = y
  end

  attr_reader :x
  attr_reader :y
end

MOVES_FOR_DIRECTIONS = { :NORTH => Move.new(0, 1), :EAST => Move.new(1, 0), :SOUTH => Move.new(0, -1), :WEST => Move.new(-1, 0) }

class Position
  require_relative './instructions'

  def initialize(x, y, direction)
    raise InvalidPosition.new("X undefined") unless x
    raise InvalidPosition.new("Y undefined") unless y
    raise InvalidDirection.new("direction undefined") unless direction
    raise InvalidPosition.new("X coordinate out of range") unless x.between?(0, MAXX)
    raise InvalidPosition.new("Y coordinate out of range") unless y.between?(0, MAXY)
    raise InvalidDirection.new("Invalid direction") unless valid_direction?(direction)
    @x = x
    @y = y
    @direction = direction
  end

  def to_s
    "#{x},#{y},#{direction}"
  end

  attr_reader :x
  attr_reader :y
  attr_reader :direction
end

class InvalidPosition < Exception
end

class InvalidDirection < Exception
end