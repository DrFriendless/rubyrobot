MAXX = 4
MAXY = 4

class Table
  def initialize
    @x = nil
    @y = nil
    @direction = nil
  end

  def place(position)
    @x = position.x
    @y = position.y
    @direction = position.direction
  end

  def report
    Position.new(@x, @y, @direction)
  end
end

class Position
  require_relative './instructions'

  def initialize(x, y, direction)
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