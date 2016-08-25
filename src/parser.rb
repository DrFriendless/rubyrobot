require_relative './instructions'

PLACE_PATTERN = /^PLACE\s+(\d)\s*,\s*(\d)\s*,\s*((?:NORTH)|(?:EAST)|(?:SOUTH)|(?:WEST))$/

# Instances of these instructions are indistinguishable from each other, so create one instance we will reuse.
SINGLETON_INSTRUCTIONS = {
    :LEFT => Instruction.new(:LEFT),
    :RIGHT => Instruction.new(:RIGHT),
    :REPORT => Instruction.new(:REPORT),
    :MOVE => Instruction.new(:MOVE)
}

def parse_instruction(orig, lineno)
  s = orig.strip.upcase
  opcode =
      case s
        when 'LEFT'
          :LEFT
        when 'RIGHT'
          :RIGHT
        when 'MOVE'
          :MOVE
        when 'REPORT'
          :REPORT
        when PLACE_PATTERN
          :PLACE
        else
          raise ParseError.new("Line #{lineno}: syntax error parsing '#{orig}'")
      end
  if opcode == :PLACE
    match = PLACE_PATTERN.match(s)
    position = Position.new(match[1].to_i, match[2].to_i, match[3].intern)
    Place.new(position)
  else
    SINGLETON_INSTRUCTIONS[opcode]
  end
end

def parse_instructions(s)
  lines = s.split(/\n/)
  # no you can't have blank lines in your program!
  lines.map.with_index { |line, index| parse_instruction(line, index+1) }
end

class ParseError < Exception
end