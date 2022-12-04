# frozen_string_literal: true

class Solver
  attr_reader :rucksacks

  def initialize(input)
    @rucksacks = input.split("\n")
  end
end
