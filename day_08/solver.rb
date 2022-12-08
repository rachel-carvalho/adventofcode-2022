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
end

class Forest
  def self.parse(lines)
    new(lines.map { |line| line.chars.map(&:to_i) })
  end

  attr_reader :tree_heights

  def initialize(tree_heights)
    @tree_heights = tree_heights
  end

  def visible_trees
    return @visible_trees if @visible_trees

    @visible_trees = []
    tree_heights.each_with_index do |line, y|
      line.each_with_index do |height, x|
        @visible_trees << [x, y] unless all_tall_neighbors?(x, y, height)
      end
    end

    @visible_trees
  end

  private

  def all_tall_neighbors?(x, y, height)
    [
      find_tall_neighbor_north(x, y, height),
      find_tall_neighbor_south(x, y, height),
      find_tall_neighbor_west(x, y, height),
      find_tall_neighbor_east(x, y, height),
    ].all?
  end

  def find_tall_neighbor_north(x, y, height)
    return if y.zero?
    neighbor_y = y - 1
    return [x, neighbor_y] if tree_heights[neighbor_y][x] >= height

    find_tall_neighbor_north(x, neighbor_y, height)
  end

  def find_tall_neighbor_south(x, y, height)
    return if y == tree_heights.count - 1
    neighbor_y = y + 1
    return [x, neighbor_y] if tree_heights[neighbor_y][x] >= height

    find_tall_neighbor_south(x, neighbor_y, height)
  end

  def find_tall_neighbor_west(x, y, height)
    return if x.zero?
    neighbor_x = x - 1
    return [neighbor_x, y] if tree_heights[y][neighbor_x] >= height

    find_tall_neighbor_west(neighbor_x, y, height)
  end

  def find_tall_neighbor_east(x, y, height)
    return if x == tree_heights.first.count - 1
    neighbor_x = x + 1
    return [neighbor_x, y] if tree_heights[y][neighbor_x] >= height

    find_tall_neighbor_east(neighbor_x, y, height)
  end
end
