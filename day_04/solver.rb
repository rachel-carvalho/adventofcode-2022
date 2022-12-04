# frozen_string_literal: true

class Solver
  def initialize(input)
    @input = input
  end

  def pairs
    @pairs ||= @input.split("\n").map { |line| Pair.new(line) }
  end

  def fully_overlapping_pair_count
    pairs.count(&:fully_overlap?)
  end

  def overlapping_pair_count
    pairs.count(&:overlap?)
  end
end

class Pair
  attr_reader :first_section_range, :second_section_range

  def initialize(input)
    @first_section_range, @second_section_range = input.split(',').map do |elf|
      lower_bound, upper_bound = elf.split('-')
      lower_bound.to_i..upper_bound.to_i
    end
  end

  def fully_overlap?
    first_section_range.cover?(second_section_range) || second_section_range.cover?(first_section_range)
  end

  def overlap?
    return @overlap unless @overlap.nil?

    @overlap = (first_section_range.to_a & second_section_range.to_a).any?
  end
end
