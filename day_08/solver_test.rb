# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @input = '''
30373
25512
65332
33549
35390
'''.strip
  end

  describe 'part 1 - how many trees are visible from outside of grid' do
    it 'parses forest' do
      s = Solver.new(@input)
      array_of_ints = [
        [3,0,3,7,3],
        [2,5,5,1,2],
        [6,5,3,3,2],
        [3,3,5,4,9],
        [3,5,3,9,0],
      ]
      assert_equal array_of_ints, s.forest.tree_heights
    end

    it 'finds visible trees' do
      s = Solver.new(@input)
      coordinates = [
        [0,0], [1,0], [2,0], [3,0], [4,0],
        [0,1], [1,1], [2,1],        [4,1],
        [0,2], [1,2],        [3,2], [4,2],
        [0,3],        [2,3],        [4,3],
        [0,4], [1,4], [2,4], [3,4], [4,4],
      ]
      assert_equal coordinates, s.forest.visible_trees
    end

    it 'counts visible trees' do
      s = Solver.new(@input)
      assert_equal 21, s.visible_tree_count
    end
  end

  describe 'part 2 - ?' do
  end
end
