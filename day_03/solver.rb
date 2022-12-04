# frozen_string_literal: true
require 'active_support/all'

class Solver
  def initialize(input)
    @input = input
  end

  def rucksacks
    @rucksacks ||= @input.split("\n").map { |line| Rucksack.new(line) }
  end

  def groups
    @groups ||= rucksacks.each_slice(3).to_a.map { |items| Group.new(items) }
  end

  def repeated_item_priority_sum
    rucksacks.sum(&:repeated_item_priority)
  end

  def badge_priority_sum
    groups.sum(&:badge_priority)
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

class Group
  def initialize(rucksacks)
    @rucksack_contents = rucksacks.map(&:all_items)
  end

  def badge
    @badge ||= (@rucksack_contents.first & @rucksack_contents.second & @rucksack_contents.third).first
  end

  def badge_priority
    Rucksack::PRIORITIES.index(badge)
  end
end
