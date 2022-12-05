# frozen_string_literal: true

require_relative '../test_helper'
require_relative './solver'

describe Solver do
  before do
    @input = \
      "    [D]    \n" \
      "[N] [C]    \n" \
      "[Z] [M] [P]\n" \
      " 1   2   3 \n" \
      "\n" \
      "move 1 from 2 to 1\n" \
      "move 3 from 1 to 3\n" \
      "move 2 from 2 to 1\n" \
      "move 1 from 1 to 2"
  end

  describe 'part 1 - find which crates end up on top of the stacks' do
    it 'parses 3 stacks' do
      s = Solver.new(@input)
      assert_equal 3, s.stacks.count
    end

    it 'parses stack contents' do
      s = Solver.new(@input)
      assert_equal ['Z', 'N'], s.stacks.first
      assert_equal ['M', 'C', 'D'], s.stacks.second
      assert_equal ['P'], s.stacks.third
    end

    it 'parses 7 movements' do
      s = Solver.new(@input)
      assert_equal 7, s.movements.count
      assert_equal [1, 0], s.movements.first
      assert_equal [0, 2], s.movements.second
      assert_equal [0, 2], s.movements.third
      assert_equal [0, 2], s.movements.fourth
      assert_equal [1, 0], s.movements.fifth
      assert_equal [1, 0], s.movements[5]
      assert_equal [0, 1], s.movements[6]
    end

    it 'executes movements' do
      s = Solver.new(@input)
      updated_stacks = s.execute_moves
      assert_equal ['C'], updated_stacks.first
      assert_equal ['M'], updated_stacks.second
      assert_equal ['P', 'D', 'N', 'Z'], updated_stacks.third
    end

    it 'finds top crate for each stack' do
      s = Solver.new(@input)
      assert_equal 'CMZ', s.move_and_find_top_crates
    end
  end
end
