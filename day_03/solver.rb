# frozen_string_literal: true

class Solver
  attr_reader :rucksacks

  def initialize(input)
    @rucksacks = input.split("\n").map { |line| Rucksack.new(line) }
  end

  def repeated_item_priority_sum
    rucksacks.sum(&:repeated_item_priority)
  end
end

class Rucksack
  attr_reader :all_items, :first_compartment, :second_compartment

  def initialize(all_items)
    @all_items = all_items.split('')
    @first_compartment, @second_compartment = @all_items.each_slice(all_items.length / 2).to_a
  end

  def repeated_item
    @repeated_item ||= (first_compartment & second_compartment).first
  end

  PRIORITIES = ['0', *('a'..'z'), *('A'..'Z')].freeze

  def repeated_item_priority
    PRIORITIES.index(repeated_item)
  end
end
