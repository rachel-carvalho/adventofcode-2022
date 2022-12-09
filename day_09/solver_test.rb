# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @input = '''
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
'''.strip
  end

  describe 'part 1 - unique positions taken by tail' do
    it 'parses movements' do
      s = Solver.new(@input)
      assert_equal 8, s.movements.count
    end

    it 'parses first movement' do
      s = Solver.new(@input)
      assert_equal :right, s.movements.first.direction
      assert_equal 4, s.movements.first.steps
    end

    it 'parses second movement' do
      s = Solver.new(@input)
      assert_equal :up, s.movements.second.direction
      assert_equal 4, s.movements.second.steps
    end

    it 'parses third movement' do
      s = Solver.new(@input)
      assert_equal :left, s.movements.third.direction
      assert_equal 3, s.movements.third.steps
    end

    it 'parses fourth movement' do
      s = Solver.new(@input)
      assert_equal :down, s.movements.fourth.direction
      assert_equal 1, s.movements.fourth.steps
    end

    it 'initializes rope' do
      s = Solver.new(@input)
      assert_equal [0,0], s.rope.head_position
      assert_equal [0,0], s.rope.tail_position
    end

    it 'moves rope with first instruction' do
      s = Solver.new(@input)
      s.rope.move(s.movements.first)
      assert_equal [4,0], s.rope.head_position
      assert_equal [3,0], s.rope.tail_position
    end

    it 'moves rope with second instruction' do
      s = Solver.new(@input)
      s.rope.move(s.movements.first, s.movements.second)
      assert_equal [4,-4], s.rope.head_position
      assert_equal [4,-3], s.rope.tail_position
    end

    it 'finds unique tail positions' do
      s = Solver.new(@input)

      expected_positions = [
                      [2,-4],[3,-4],
                             [3,-3],[4,-3],
        [0,-2],[1,-2],[2,-2],[3,-2],[4,-2],
                                    [4,-1],
        [0, 0],[1, 0],[2, 0],[3, 0],
      ].sort_by{|i|[i.last, i.first]}

      tail_positions = s.tail_positions.uniq.sort_by{|i|[i.last, i.first]}
      assert_equal expected_positions, tail_positions
    end

    it 'counts unique tail positions' do
      s = Solver.new(@input)
      assert_equal 13, s.unique_tail_positions_count
    end
  end

  describe 'part 2 - ?' do
  end
end
