# frozen_string_literal: true
require 'active_support/all'

class Solver
  def initialize(input)
    @input = input
  end

  def monkeys
    @monkeys ||= Monkey.parse(@input.split("\n\n"))
  end

  def play!(rounds: 1)
    rounds.times { monkeys.each(&:throw!) }
  end

  def monkey_business(rounds:)
    play!(rounds: rounds)
    first, second = monkeys.sort_by(&:inspected_item_count).reverse[0..1]
    first.inspected_item_count * second.inspected_item_count
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
      @all = all_monkeys
    end
  end

  def self.all
    @all
  end

  def self.parse_operation(operation)
    operator, value = operation.split(" = old ").second.split(' ')
    value = value == 'old' ? nil : value.to_i
    [operator, value].compact
  end

  attr_reader :items, :operation, :divisible_by, :destination_monkeys, :inspected_item_count

  def initialize(items, operation, divisible_by, destination)
    @items = items
    @operation = operation
    @divisible_by = divisible_by
    @destination_monkeys = destination
    @inspected_item_count = 0
  end

  def throw!
    items.each do |item|
      worry = item.public_send(operation.first, operation.second || item) / 3
      destination = (worry % divisible_by).zero? ? destination_monkeys.first : destination_monkeys.second
      Monkey.all[destination].items << worry
      @inspected_item_count += 1
    end
    @items = []
  end
end
