# frozen_string_literal: true
require 'active_support/all'

class Solver
  def initialize(input)
    @stack_input, @movement_input = input.split("\n\n")
  end

  def stacks
    @stacks ||= Stack.parse(@stack_input)
  end

  def single_crate_movements
    @single_crate_movements ||= Movement.parse_single_crate(@movement_input)
  end

  def move_crates_one_at_a_time!
    single_crate_movements.each do |origin, destination|
      stacks[destination].push stacks[origin].pop
    end
  end

  def top_crates
    stacks.map(&:last).join
  end
end

class Stack
  def self.parse(input)
    *lines, stack_labels = input.split("\n")
    lines.reverse!
    stack_labels.split(' ').each_with_index.map do |_, index|
      lines.map do |line|
        line[index * 4 + 1].presence
      end.compact
    end
  end
end

class Movement
  def self.parse_single_crate(input)
    input.split("\n").map do |line|
      count, origin, dest = line.scan(/\d+/)
      count.to_i.times.map { |_| [origin.to_i - 1, dest.to_i - 1] }
    end.flatten(1)
  end
end
