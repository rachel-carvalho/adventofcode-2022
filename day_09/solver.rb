# frozen_string_literal: true
require 'active_support/all'

class Solver
  attr_accessor :short_rope, :long_rope

  def initialize(input)
    @input = input
    @short_rope = Rope.new
    @long_rope = Rope.new(knot_count: 10)
  end

  def movements
    @movements ||= Movement.parse(@input.split("\n"))
  end

  def tail_positions
    return @tail_positions if @tail_positions
    short_rope.move!(*movements)
    @tail_positions = short_rope.tail_position_history
  end

  def unique_tail_position_count
    tail_positions.uniq.count
  end

  def long_rope_tail_positions
    return @long_rope_tail_positions if @long_rope_tail_positions
    long_rope.move!(*movements)
    @long_rope_tail_positions = long_rope.tail_position_history
  end

  def long_rope_unique_tail_position_count
    long_rope_tail_positions.uniq.count
  end
end

class Movement
  DIRECTIONS = {
    'U' => :up,
    'D' => :down,
    'L' => :left,
    'R' => :right,
  }

  def self.parse(lines)
    lines.map do |line|
      dir, count = line.split(' ')
      new(DIRECTIONS[dir], count.to_i)
    end
  end

  attr_reader :direction, :step_count

  def initialize(direction, step_count)
    @direction = direction
    @step_count = step_count
  end

  DIRECTION_INCREMENTS = {
    up: -1,
    left: -1,
    down: 1,
    right: 1,
  }

  def direction_increment
    DIRECTION_INCREMENTS[direction]
  end
end

class Rope
  attr_reader :tail_position_history, :knot_positions

  def initialize(knot_count: 2)
    @knot_positions = knot_count.times.map {|_| [0,0]}
    @tail_position_history = [tail_position.dup]
  end

  def head_position
    knot_positions.first
  end

  def tail_position
    knot_positions.last
  end

  def move!(*movements)
    movements.each do |movement|
      movement.step_count.times do
        if movement.direction.in?(%i(up down))
          head_position[1] += movement.direction_increment
        else
          head_position[0] += movement.direction_increment
        end
        knot_positions.each_with_index do |knot, index|
          next if index.zero?
          drag_knot(knot, knot_positions[index - 1])
        end
        tail_position_history << tail_position.dup
      end
    end
  end

  def drag_knot(knot, reference_knot)
    difference_x = reference_knot[0] - knot[0]
    difference_y = reference_knot[1] - knot[1]

    differences = [difference_x, difference_y].map(&:abs)
    if differences.none?(&:zero?)
      # diagonal reference
      if differences.any? {|d| d == 2 }
        # move diagonally
        direction_x = difference_x.negative? ? -1 : difference_x.positive? ? 1 : 0
        knot[0] += direction_x
        direction_y = difference_y.negative? ? -1 : difference_y.positive? ? 1 : 0
        knot[1] += direction_y
      end
    elsif difference_x.abs == 2
      # horizontal
      direction = difference_x.negative? ? -1 : difference_x.positive? ? 1 : 0
      knot[0] += direction
    elsif difference_y.abs == 2
      # vertical
      direction = difference_y.negative? ? -1 : difference_y.positive? ? 1 : 0
      knot[1] += direction
    end
  end
end
