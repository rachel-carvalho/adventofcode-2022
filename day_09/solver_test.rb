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
    describe 'movements' do
      it 'parses movements' do
        s = Solver.new(@input)
        assert_equal 8, s.movements.count
      end

      it 'parses first movement' do
        s = Solver.new(@input)
        assert_equal :right, s.movements.first.direction
        assert_equal 4, s.movements.first.step_count
      end

      it 'parses second movement' do
        s = Solver.new(@input)
        assert_equal :up, s.movements.second.direction
        assert_equal 4, s.movements.second.step_count
      end

      it 'parses third movement' do
        s = Solver.new(@input)
        assert_equal :left, s.movements.third.direction
        assert_equal 3, s.movements.third.step_count
      end

      it 'parses fourth movement' do
        s = Solver.new(@input)
        assert_equal :down, s.movements.fourth.direction
        assert_equal 1, s.movements.fourth.step_count
      end
    end

    it 'initializes rope' do
      s = Solver.new(@input)
      assert_equal [0,0], s.short_rope.head_position
      assert_equal [0,0], s.short_rope.tail_position
      assert_equal [[0,0]], s.short_rope.tail_position_history
    end

    it 'moves rope with first instruction' do
      s = Solver.new(@input)
      s.short_rope.move!(s.movements.first)
      assert_equal [4,0], s.short_rope.head_position
      assert_equal [3,0], s.short_rope.tail_position
      assert_equal [[0,0],[0,0],[1,0],[2,0],[3,0]], s.short_rope.tail_position_history
    end

    it 'moves rope with second instruction' do
      s = Solver.new(@input)
      s.short_rope.move!(s.movements.first, s.movements.second)
      assert_equal [4,-4], s.short_rope.head_position
      assert_equal [4,-3], s.short_rope.tail_position
    end

    it 'finds unique tail positions' do
      s = Solver.new(@input)

      expected_positions = [
        [0, 0],
        [0, 0],[1, 0],[2, 0],[3, 0],
        [3, 0],[4,-1],[4,-2],[4,-3],
        [4,-3],[3,-4],[2,-4],
        [2,-4],
        [2,-4],[2,-4],[3,-3],[4,-3],
        [4,-3],
        [4,-3],[4,-3],[3,-2],[2,-2],[1,-2],
        [1,-2],[1,-2],
      ]

      tail_positions = s.tail_positions
      assert_equal expected_positions, tail_positions
    end

    it 'counts unique tail positions' do
      s = Solver.new(@input)
      assert_equal 13, s.unique_tail_position_count
    end
  end

  describe 'part 2 - rope with 10 knots' do
    before do
      @input2 = '''
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
'''.strip
    end

    it 'creates a long rope' do
      s = Solver.new(@input)
      assert_equal [[0,0]] * 10, s.long_rope.knot_positions
    end

    it 'can move long rope with first input' do
      s = Solver.new(@input)
      s.long_rope.move!(s.movements.first)
      assert_equal [4,0], s.long_rope.head_position
      assert_equal [0,0], s.long_rope.tail_position
      assert_equal [[0,0],[0,0],[0,0],[0,0],[0,0]], s.long_rope.tail_position_history
    end

    it 'can move long rope with second input' do
      s = Solver.new(@input2)
      s.long_rope.move!(s.movements.first)
      assert_equal [5,0], s.long_rope.head_position
      assert_equal [0,0], s.long_rope.tail_position
      assert_equal [[0,0]] * 6, s.long_rope.tail_position_history
    end

    it 'can move long rope with second input, second movement' do
      s = Solver.new(@input2)
      s.long_rope.move!(*s.movements[0..1])
      assert_equal [5,-8], s.long_rope.head_position
      assert_equal [0,0], s.long_rope.tail_position
      assert_equal [[0,0]] * (5 + 9), s.long_rope.tail_position_history
    end

    it 'can move long rope with second input, third movement' do
      s = Solver.new(@input2)
      s.long_rope.move!(*s.movements[0..2])
      assert_equal [-3,-8], s.long_rope.head_position
      assert_equal [1,-3], s.long_rope.tail_position
    end

    it 'counts unique tail positions for first input' do
      s = Solver.new(@input)
      assert_equal 1, s.long_rope_unique_tail_position_count
    end

    it 'counts unique tail positions for second input' do
      s = Solver.new(@input2)
      assert_equal 36, s.long_rope_unique_tail_position_count
    end
  end
end
