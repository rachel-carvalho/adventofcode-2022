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
    it 'counts how many trees are visible from outside' do
      s = Solver.new(@input)
      assert_equal 21, s.visible_tree_count
    end
  end

  describe 'part 2 - ?' do
  end
end
