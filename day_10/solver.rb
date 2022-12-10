# frozen_string_literal: true
require 'active_support/all'

class Solver
  attr_reader :cpu

  def initialize(input)
    @input = input
    @cpu = CPU.new
  end

  def instructions
    @instructions ||= Instruction.parse(@input.split("\n"))
  end

  def signal_strengths
    return @signal_strengths if @signal_strengths
    cpu.execute(*instructions)
    @signal_strengths = (((cpu.current_cycle - 20) / 40).ceil + 1).times.map do |index|
      cycle_number = 20 + (index * 40)
      cpu.register_value_at_cycle(cycle_number) * cycle_number
    end
  end

  def screen
    return @screen if @screen

    cpu.execute(*instructions)

    screen_width = 40
    screen_height = 6

    cpu.register_history.each_with_index.map do |x, cycle|
      screen_position = cycle % 40
      if screen_position.in?([x - 1, x, x + 1])
        '#'
      else
        '.'
      end
    end.each_slice(screen_width).to_a[0...screen_height].map do |slice|
      slice.join('')
    end.join("\n")
  end
end

class Instruction
  def self.parse(lines)
    lines.map { |line| new(*line.split(' ')) }
  end

  attr_reader :type, :argument

  def initialize(type, argument = nil)
    @type = type.to_sym
    @argument = argument.to_i
  end

  CYCLES = {
    noop: 1,
    addx: 2,
  }
  def cycles
    CYCLES[type]
  end
end

class CPU
  attr_reader :register_history

  def initialize
    @register_history = [1]
  end

  def register
    register_history.last
  end

  def current_cycle
    register_history.count
  end

  def execute(*instructions)
    instructions.each do |instruction|
      (instruction.cycles - 1).times { register_history << register }
      register_history << register + instruction.argument
    end
  end

  def register_value_at_cycle(cycle)
    register_history[cycle - 1]
  end
end
