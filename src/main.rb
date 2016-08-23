require_relative './table'
require_relative './parser'

class Runner
  def run(program)
    if program.is_a? String
      program = parse_instructions(s)
    end
    table = Table.new
    program.each { |instruction|
      execute_verbose(instruction, table)
    }
  end

  def execute_verbose(instruction, table)

  end
end