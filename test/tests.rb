require_relative '../src/table.rb'

def test(program, expected)
end

test("PLACE 0,0,NORTH; REPORT", Position.new(0, 0, :NORTH))