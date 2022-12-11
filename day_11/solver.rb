# frozen_string_literal: true
require 'active_support/all'

class Solver
  def initialize(input)
    @input = input
  end

  def monkeys
    @monkeys ||= Monkey.parse(@input.split("\n\n"))
  end
end

class Monkey
  def self.parse(chunks)
    chunks.map do |chunk|
      _, starting_items, operation, test, *destinations = chunk.split("\n").map do |line|
        line.split(': ').second
      end
      items = starting_items.split(', ').map(&:to_i)
      divisible = test.delete('divisible by ').to_i
      destination = destinations.map {|d| d.delete('throw to monkey ').to_i}

      new(items, parse_operation(operation), divisible, destination)
    end.tap do |all_monkeys|
      @all_monkeys = all_monkeys
    end
  end

  def self.all_monkeys
    @all_monkeys
  end

  def self.parse_operation(operation)
    operator, value = operation.split(" = old ").second.split(' ')
    value = value == 'old' ? nil : value.to_i
    [operator, value].compact
  end

  attr_reader :items, :operation, :divisible_by, :destination_monkeys

  def initialize(items, operation, divisible_by, destination)
    @items = items
    @operation = operation
    @divisible_by = divisible_by
    @destination_monkeys = destination
  end
end
