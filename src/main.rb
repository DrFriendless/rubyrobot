require_relative './table'
require_relative './parser'

class Runner
  def run(program)
    if program.is_a? String
      program = parse_instructions(program)
    end
    table = Table.new
    program.each { |instruction|
      execute_verbose(instruction, table)
    }
  end

  def execute_verbose(instruction, table)
    result = execute(instruction, table)
    puts result.to_s
  end

  def execute(instruction, table)
    case instruction.opcode
      when :LEFT
        result = table.left
        ExecutionResult.new((result && :EXECUTED) || :IGNORED, instruction, nil)
      when :RIGHT
        result = table.right
        ExecutionResult.new((result && :EXECUTED) || :IGNORED, instruction, nil)
      when :MOVE
        result = table.move
        ExecutionResult.new((result && :EXECUTED) || :IGNORED, instruction, nil)
      when :REPORT
        s = table.report
        ExecutionResult.new((s && :OUTPUT) || :IGNORED, instruction, s)
      when :PLACE
        result = table.place(instruction.position)
        ExecutionResult.new((result && :EXECUTED) || :IGNORED, instruction, nil)
    end
  end
end

class ExecutionResult
  def initialize(result_type, instruction, output)
    @result_type = result_type
    @instruction = instruction
    @output = output
  end

  def to_s
    case @result_type
      when :IGNORED
        "IGNORE  #{@instruction}"
      when :EXECUTED
        "EXECUTE #{@instruction}"
      when :OUTPUT
        "EXECUTE #{@instruction}\nOUTPUT  #{@output}"
    end
  end
end

if ARGV.length > 0
  ARGV.each { |filename|
    text = File.open(filename).read
    runner = Runner.new
    runner.run(text.gsub(/\n/, ";"))
  }
end