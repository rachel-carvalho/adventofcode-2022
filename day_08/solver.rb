# frozen_string_literal: true
require 'active_support/all'

class Solver
  def initialize(input)
    @input = input
  end

  def forest
    @forest ||= Forest.parse(@input.split("\n"))
  end

  def visible_tree_count
    forest.visible_trees.count
  end

  def highest_scenic_score
    forest.trees.map(&:scenic_score).max
  end
end

class Forest
  def self.parse(lines)
    new(lines.map { |line| line.chars.map(&:to_i) })
  end

  def initialize(map)
    @map = map
  end

  def tree_heights
    @tree_heights ||= trees.map(&:height).each_slice(@map.first.length).to_a
  end

  def trees
    trees_by_coordinates.flatten
  end

  def trees_by_coordinates
    @trees_by_coordinates ||= @map.each_with_index.map do |line, y|
      line.each_with_index.map do |height, x|
        Tree.new(x, y, height, self)
      end
    end
  end

  def [](x, y)
    trees_by_coordinates[y][x]
  end

  def rows
    trees_by_coordinates.count
  end

  def columns
    trees_by_coordinates.first.count
  end

  def visible_trees
    @visible_trees ||= trees.reject(&:all_tall_neighbors?).map { |t| [t.x, t.y] }
  end
end

class Tree
  attr_reader :x, :y, :height, :forest

  def initialize(x, y, height, forest)
    @x = x
    @y = y
    @height = height
    @forest = forest
  end

  def taller?(other)
    height >= other.height
  end

  def all_tall_neighbors?
    [
      find_tall_neighbor(x, y, step_y: -1),
      find_tall_neighbor(x, y, step_x: -1),
      find_tall_neighbor(x, y, step_y: 1),
      find_tall_neighbor(x, y, step_x: 1),
    ].all?
  end

  def viewing_distances
    [
      count_trees_until_tall_neighbor(x, y, step_y: -1),
      count_trees_until_tall_neighbor(x, y, step_x: -1),
      count_trees_until_tall_neighbor(x, y, step_y: 1),
      count_trees_until_tall_neighbor(x, y, step_x: 1),
    ]
  end

  def scenic_score
    viewing_distances.inject(:*)
  end

  private

  def count_trees_until_tall_neighbor(x, y, step_x: 0, step_y: 0)
    Counter.new(1).tap do |counter|
      find_tall_neighbor(x, y, step_x: step_x, step_y: step_y, counter: counter)
    end.value
  end

  def find_tall_neighbor(x, y, step_x: 0, step_y: 0, counter: nil)
    # puts counter.value if !counter.nil? && step_x == 1
    # binding.pry if !counter.nil? && step_x == 1
    if y.in?([0, forest.rows - 1]) || x.in?([0, forest.columns - 1])
      counter.value -= 1 if counter
      return
    end

    neighbor = forest[x + step_x, y + step_y]
    return neighbor if neighbor.taller?(self)

    find_tall_neighbor(neighbor.x, neighbor.y, step_x: step_x, step_y: step_y, counter: counter.tap {|c| c && c.value += 1})
  end

  Counter = Struct.new('Counter', :value)
end
