# frozen_string_literal: true
require 'active_support/all'

class Solver
  attr_accessor :rope

  def initialize(input)
    @input = input
    @rope = Rope.new
  end

  def movements
    @movements ||= Movement.parse(@input.split("\n"))
  end

  def tail_positions
    return @tail_positions if @tail_positions
    rope.move!(*movements)
    @tail_positions = rope.tail_position_history
  end

  def unique_tail_position_count
    tail_positions.uniq.count
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
  attr_reader :head_position, :tail_position, :tail_position_history

  def initialize(head_position = [0,0], tail_position = [0,0])
    @head_position = head_position
    @tail_position = tail_position
    @tail_position_history = [tail_position.dup]
  end

  def move!(*movements)
    movements.each do |movement|
      movement.step_count.times do
        if movement.direction.in?(%i(up down))
          head_position[1] += movement.direction_increment
        else
          head_position[0] += movement.direction_increment
        end
        move_tail
      end
    end
  end

  def move_tail
    difference_x = head_position[0] - tail_position[0]
    difference_y = head_position[1] - tail_position[1]

    differences = [difference_x, difference_y].map(&:abs)
    if differences.none?(&:zero?)
      # diagonal head
      if differences.any? {|d| d == 2 }
        # move diagonally
        tail_direction_x = difference_x.negative? ? -1 : difference_x.positive? ? 1 : 0
        tail_position[0] += tail_direction_x
        tail_direction_y = difference_y.negative? ? -1 : difference_y.positive? ? 1 : 0
        tail_position[1] += tail_direction_y
      end
    elsif difference_x.abs == 2
      # horizontal
      tail_direction = difference_x.negative? ? -1 : difference_x.positive? ? 1 : 0
      tail_position[0] += tail_direction
    elsif difference_y.abs == 2
      # vertical
      tail_direction = difference_y.negative? ? -1 : difference_y.positive? ? 1 : 0
      tail_position[1] += tail_direction
    end

    tail_position_history << tail_position.dup
  end
end
